import React from "react";
import { Link } from "react-router-dom";

export default function NavBar() {
  return (
    <nav style={{ background: "green", padding: "10px", color: "white" }}>
      <h2>Speak Up</h2>
      <ul style={{ listStyle: "none", display: "flex", gap: "10px" }}>
        <li><Link to="/" style={{ color: "white" }}>Home</Link></li>
        <li><Link to="/about" style={{ color: "white" }}>About</Link></li>
        <li><Link to="/team" style={{ color: "white" }}>Team</Link></li>
        <li><Link to="/gallery" style={{ color: "white" }}>Gallery</Link></li>
        <li><Link to="/volunteer" style={{ color: "white" }}>Volunteer</Link></li>
        <li><Link to="/contact" style={{ color: "white" }}>Contact</Link></li>
      </ul>
    </nav>
  );
}
