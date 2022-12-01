const express = require("express");
const router = new express.Router();
const Consump = require("../models/consump");

router.post("/consump", async (req, res) => {
  const consump = new Consump(req.body);

  try {
    await consump.save();

    res.status(201).send(consump);
  } catch (e) {
    res.status(400).send(e);
  }
});

module.exports = router;
