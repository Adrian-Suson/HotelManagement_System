import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";
import dotenv from "dotenv";
import path from "path";
import { fileURLToPath } from "url";
import { networkInterfaces } from "os";
import userRoutes from "./routes/userRoutes.js";
import guestRoutes from "./routes/guestRoutes.js";
import roomRoutes from "./routes/roomsRoutes.js";
import reservationRoutes from "./routes/reservationsRoutes.js";
import stayRecordRoutes from "./routes/stayRecordRoute.js";
import historyRoutes from "./routes/historyRoutes.js";
import discountRoutes from "./routes/discountRoutes.js";
import aboutUsRoutes from "./routes/aboutUs.js";
import advertisementsRoutes from "./routes/advertisements.js";
import seviceRoutes from "./routes/services.js";
import "./config/initializeDb.js";

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();



// Middleware
app.use(express.json());
app.use(helmet({
  strictTransportSecurity: false,
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      connectSrc: ["'self'", "https://hotelmanagement-system-pn82.onrender.com:3000"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", "data:", "https:"],
    },
  },
}));
app.use(helmet.crossOriginResourcePolicy({ policy: "cross-origin" }));
app.use(morgan("common"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cors());

// Serve public app with correct MIME types
app.use(express.static(path.join(__dirname, "..", "public"), {
  setHeaders: (res, path) => {
    if (path.endsWith('.css')) {
      res.setHeader('Content-Type', 'text/css; charset=utf-8');
    } else if (path.endsWith('.js')) {
      res.setHeader('Content-Type', 'application/javascript; charset=utf-8');
    }
  }
}));

// API Routes
app.use("/api", userRoutes);
app.use("/api", roomRoutes);
app.use("/api", reservationRoutes);
app.use("/api", stayRecordRoutes);
app.use("/api", guestRoutes);
app.use("/api", historyRoutes);
app.use("/api", discountRoutes);
app.use("/api", aboutUsRoutes);
app.use("/api", advertisementsRoutes);
app.use("/api", seviceRoutes);

// Static file serving
app.use(
  "/api/assets",
  express.static(path.join(__dirname, "..", "assets", "Rooms"))
);
app.use(
  "/api/id_picture",
  express.static(path.join(__dirname, "..", "assets", "id_pictures"))
);
app.use(
  "/api/profile_pictures",
  express.static(path.join(__dirname, "..", "assets", "ProfilePic"))
);
app.use(
  "/api/advertisements",
  express.static(path.join(__dirname, "..", "assets", "Advertisements"))
);
app.use("/api/Logo", express.static(path.join(__dirname, "..", "assets", "Logo")));

app.get("*", (req, res) => {
  if (req.path.startsWith("/api")) {
    return res.status(404).json({ message: "API route not found" });
  }
  res.sendFile(path.join(__dirname, "..", "public", "index.html"));
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
