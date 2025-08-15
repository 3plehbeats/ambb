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
      subject: `Contact Form Submission from ${name}`,
      text: message
    });

    res.status(200).json({ message: "Email sent successfully" });
  } catch (err) {
    res.status(500).json({ message: "Error sending email", error: err.message });
  }
};
