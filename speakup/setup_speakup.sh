
#!/bin/bash
# Speak Up React + Node.js App Setup Script
# Author: ChatGPT ���������

PROJECT_NAME="speakup"
API_DIR="api"
SRC_DIR="$PROJECT_NAME/src"
COMP_DIR="$SRC_DIR/components"

echo "��� Creating Speak Up project..."

# 1️⃣ Create React app
npx create-react-app $PROJECT_NAME
cd $PROJECT_NAME

# 2️⃣ Install dependencies
npm install react-router-dom react-image-lightbox nodemailer

# 3️⃣ Create backend API directory
mkdir $API_DIR

# 4️⃣ Create Vercel config
cat <<EOL > vercel.json
{
  "version": 2,
  "builds": [
    { "src": "package.json", "use": "@vercel/static-build" },
    { "src": "api/*.js", "use": "@vercel/node" }
  ],
  "routes": [
    { "src": "/api/(.*)", "dest": "/api/\$1" },
    { "src": "/.*", "dest": "/index.html" }
  ]
}
EOL

# 5️⃣ Create .env.example
cat <<EOL > .env.example
EMAIL_USER=youremail@gmail.com
EMAIL_PASS=yourapppassword
TO_EMAIL=recipient@example.com
EOL

# 6️⃣ Create NavBar component
mkdir -p $COMP_DIR
cat <<EOL > $COMP_DIR/NavBar.js
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
EOL

# 7️⃣ Create Footer component
cat <<EOL > $COMP_DIR/Footer.js
import React from "react";

export default function Footer() {
  return (
    <footer style={{ background: "green", color: "white", textAlign: "center", padding: "10px" }}>
      <p>© 2025 Speak Up - Fighting for the Rights of Nigerians</p>
    </footer>
  );
}
EOL

# 8️⃣ Create HomePage
cat <<EOL > $COMP_DIR/HomePage.js
import React from "react";

export default function HomePage() {
  return (
    <div>
      <h1>Welcome to Speak Up</h1>
      <p>We are a Nigerian political NGO committed to defending human rights, promoting justice, and amplifying the voices of citizens.</p>
    </div>
  );
}
EOL

# 9️⃣ Create AboutPage
cat <<EOL > $COMP_DIR/AboutPage.js
import React from "react";

export default function AboutPage() {
  return (
    <div>
      <h1>About Us</h1>
      <p>Speak Up is a Nigerian NGO fighting tirelessly for the protection of civil liberties, the eradication of corruption, and the empowerment of citizens.</p>
      <h2>Our Vision</h2>
      <p>A just, free, and democratic Nigeria where every citizen's rights are respected.</p>
      <h2>Our Mission</h2>
      <p>To advocate for human rights, hold leaders accountable, and create a platform for the voices of Nigerians to be heard.</p>
    </div>
  );
}
EOL

# ��� Create TeamPage
cat <<EOL > $COMP_DIR/TeamPage.js
import React from "react";

export default function TeamPage() {
  return (
    <div>
      <h1>Our Team</h1>
      <p>Meet the passionate activists behind Speak Up.</p>
      <ul>
        <li>Jane Doe - Founder & Lead Activist</li>
        <li>John Smith - Legal Advisor</li>
        <li>Mary Johnson - Community Outreach Coordinator</li>
      </ul>
    </div>
  );
}
EOL

# 1️⃣1️⃣ Create Gallery with Lightbox
cat <<EOL > $COMP_DIR/Gallery.js
import React, { useState } from "react";
import "react-image-lightbox/style.css";
import Lightbox from "react-image-lightbox";

export default function Gallery() {
  const images = [
    "/images/protest1.jpg",
    "/images/protest2.jpg",
    "/images/protest3.jpg",
    "/images/community1.jpg",
    "/images/community2.jpg",
    "/images/community3.jpg"
  ];

  const [photoIndex, setPhotoIndex] = useState(0);
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <h1>Gallery</h1>
      <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: "10px" }}>
        {images.map((img, index) => (
          <img
            key={index}
            src={img}
            alt={\`Gallery \${index}\`}
            style={{ width: "100%", cursor: "pointer", borderRadius: "5px" }}
            onClick={() => { setPhotoIndex(index); setIsOpen(true); }}
          />
        ))}
      </div>
      {isOpen && (
        <Lightbox
          mainSrc={images[photoIndex]}
          nextSrc={images[(photoIndex + 1) % images.length]}
          prevSrc={images[(photoIndex + images.length - 1) % images.length]}
          onCloseRequest={() => setIsOpen(false)}
          onMovePrevRequest={() => setPhotoIndex((photoIndex + images.length - 1) % images.length)}
          onMoveNextRequest={() => setPhotoIndex((photoIndex + 1) % images.length)}
        />
      )}
    </div>
  );
}
EOL

# 1️⃣2️⃣ Create VolunteerForm
cat <<EOL > $COMP_DIR/VolunteerForm.js
import React, { useState } from "react";

export default function VolunteerForm() {
  const [form, setForm] = useState({ name: "", email: "", message: "" });

  const handleSubmit = async (e) => {
    e.preventDefault();
    const res = await fetch("/api/volunteer", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(form)
    });
    const data = await res.json();
    alert(data.message);
  };

  return (
    <form onSubmit={handleSubmit}>
      <h1>Volunteer with Speak Up</h1>
      <input type="text" placeholder="Your Name" onChange={(e) => setForm({...form, name: e.target.value})} required />
      <input type="email" placeholder="Your Email" onChange={(e) => setForm({...form, email: e.target.value})} required />
      <textarea placeholder="Why do you want to volunteer?" onChange={(e) => setForm({...form, message: e.target.value})} required></textarea>
      <button type="submit">Submit</button>
    </form>
  );
}
EOL

# 1️⃣3️⃣ Create ContactForm
cat <<EOL > $COMP_DIR/ContactForm.js
import React, { useState } from "react";

export default function ContactForm() {
  const [form, setForm] = useState({ name: "", email: "", message: "" });

  const handleSubmit = async (e) => {
    e.preventDefault();
    const res = await fetch("/api/contact", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(form)
    });
    const data = await res.json();
    alert(data.message);
  };

  return (
    <form onSubmit={handleSubmit}>
      <h1>Contact Speak Up</h1>
      <input type="text" placeholder="Your Name" onChange={(e) => setForm({...form, name: e.target.value})} required />
      <input type="email" placeholder="Your Email" onChange={(e) => setForm({...form, email: e.target.value})} required />
      <textarea placeholder="Your Message" onChange={(e) => setForm({...form, message: e.target.value})} required></textarea>
      <button type="submit">Send</button>
    </form>
  );
}
EOL

# 1️⃣4️⃣ Create App.js with Router
cat <<EOL > $SRC_DIR/App.js
import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import NavBar from "./components/NavBar";
import Footer from "./components/Footer";
import HomePage from "./components/HomePage";
import AboutPage from "./components/AboutPage";
import TeamPage from "./components/TeamPage";
import Gallery from "./components/Gallery";
import VolunteerForm from "./components/VolunteerForm";
import ContactForm from "./components/ContactForm";

function App() {
  return (
    <Router>
      <NavBar />
      <main style={{ padding: "20px" }}>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/about" element={<AboutPage />} />
          <Route path="/team" element={<TeamPage />} />
          <Route path="/gallery" element={<Gallery />} />
          <Route path="/volunteer" element={<VolunteerForm />} />
          <Route path="/contact" element={<ContactForm />} />
        </Routes>
      </main>
      <Footer />
    </Router>
  );
}

export default App;
EOL

# 1️⃣5️⃣ Create backend API files
cat <<EOL > $API_DIR/contact.js
const nodemailer = require("nodemailer");

module.exports = async (req, res) => {
  if (req.method !== "POST") {
    return res.status(405).json({ message: "Method not allowed" });
  }

  const { name, email, message } = req.body;
  if (!name || !email || !message) {
    return res.status(400).json({ message: "All fields are required" });
  }

  try {
    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: { user: process.env.EMAIL_USER, pass: process.env.EMAIL_PASS }
    });

    await transporter.sendMail({
      from: email,
      to: process.env.TO_EMAIL,
      subject: \`Contact Form Submission from \${name}\`,
      text: message
    });

    res.status(200).json({ message: "Email sent successfully" });
  } catch (err) {
    res.status(500).json({ message: "Error sending email", error: err.message });
  }
};
EOL

cat <<EOL > $API_DIR/volunteer.js
const nodemailer = require("nodemailer");

module.exports = async (req, res) => {
  if (req.method !== "POST") {
    return res.status(405).json({ message: "Method not allowed" });
  }

  const { name, email, message } = req.body;
  if (!name || !email || !message) {
    return res.status(400).json({ message: "All fields are required" });
  }

  try {
    const transporter = nodemailer.createTransport({
      service: "gmail",
      auth: { user: process.env.EMAIL_USER, pass: process.env.EMAIL_PASS }
    });

    await transporter.sendMail({
      from: email,
      to: process.env.TO_EMAIL,
      subject: \`Volunteer Form Submission from \${name}\`,
      text: message
    });

    res.status(200).json({ message: "Volunteer form submitted successfully" });
  } catch (err) {
    res.status(500).json({ message: "Error sending email", error: err.message });
  }
};
EOL

echo "✅ Speak Up app created successfully."
echo "��� Run 'npm run build' and deploy to Vercel."

