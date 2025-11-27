import express from "express";
import axios from "axios";
import ChatMessage from "../models/ChatMessage.js";

const router = express.Router();

router.post("/", async (req, res) => {
  const { message } = req.body;

  try {

    const funnyPrompt = `
User: "${message}"
FunnyBot:
`;
    await ChatMessage.create({ sender: "user", text: message });

    const response = await axios.post(
  "http://127.0.0.1:11434/api/generate",
  {
    model: "llama3",
    prompt: funnyPrompt,
    stream: false
  }
);


    const reply = response.data.response;


    await ChatMessage.create({ sender: "bot", text: reply });

    return res.json({ reply });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: "Bot error" });
  }
});

router.get("/history", async (req, res) => {
  const messages = await ChatMessage.find().sort({ createdAt: 1 });
  res.json(messages);
});

export default router;
