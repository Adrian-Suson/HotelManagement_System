// initializeDb.js
import bcrypt from "bcrypt";
import dotenv from "dotenv";
import db from "./db.js";
import fs from "fs/promises";
import path from "path";
import { fileURLToPath } from "url";

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const initializeApp = async () => {
  try {
    // Path to the SQL file
    const sqlPath = path.join(__dirname, "../../../hotel_management.sql");

    // Read the SQL file
    const sql = await fs.readFile(sqlPath, "utf8");

    // Execute the SQL to create tables
    const connection = await db.getConnection();
    const statements = sql.split(';').filter(s => s.trim().length > 0);
    for (const statement of statements) {
      await connection.execute(statement.trim());
    }
    connection.release();

    console.log("Database tables created or verified.");

    const adminUserId = process.env.ADMIN_USER_ID ?? "admin-000000";
    const adminUser = process.env.ADMIN_USERNAME ?? "admin";
    const adminPassword = process.env.USER_PASSWORD ?? "admin123";
    const adminRole = process.env.USER_ROLE ?? "admin";
    const adminEmail = process.env.ADMIN_EMAIL ?? `${adminUser}@example.com`;

    if (!process.env.USER_PASSWORD) {
      console.warn("Warning: USER_PASSWORD environment variable is not set. Using default password.");
    }

    // Check if the admin user exists and create one if not
    const [users] = await db.query("SELECT * FROM users WHERE userId = ?", [adminUserId]);
    if (users.length === 0) {
      const hashedPassword = await bcrypt.hash(adminPassword, 10);
      await db.query(
        "INSERT INTO users (userId, username, password, role) VALUES (?, ?, ?, ?)",
        [adminUserId, adminUser, hashedPassword, adminRole]
      );

      // Create default profile for the admin user
      await db.query(
        "INSERT INTO user_profile (user_id, first_name, last_name, email, phone_number, address, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [
          adminUserId,
          "Admin",
          "User",
          `${adminUser}@example.com`,
          "123-456-7890",
          "123 Admin St",
          "default_profile.jpg",
        ]
      );

      console.log("Admin user and profile created.");
    } else {
      console.log("Admin user already exists.");
    }
  } catch (error) {
    console.error("Error setting up the database and admin user:", error);
  }
};

// Initialize the application
initializeApp();
