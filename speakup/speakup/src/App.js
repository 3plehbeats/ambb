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
