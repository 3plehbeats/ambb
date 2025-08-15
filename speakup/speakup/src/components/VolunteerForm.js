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
