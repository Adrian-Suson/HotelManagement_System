// db.js
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

const db = mysql.createPool(process.env.MYSQL_PUBLIC_URL);

export default db;
