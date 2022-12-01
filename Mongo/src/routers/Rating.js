const express = require("express");
const router = new express.Router();
const Rating = require("../models/Rating");

router.post("/rating", async (req, res) => {
  const rate = new Rating(req.body);
  try {
    await rate.save();
    res.status(201).send({ rate });
  } catch (e) {
    res.status(400).send(e);
  }
});

router.get("/rating", async (req, res) => {
  try {
    const rate = await Rating.find({});
    res.send(rate);
  } catch (e) {
    res.status(500).send();
  }
});

router.delete("/rating/:id", async (req, res) => {
  try {
    const rate = await Rating.findByIdAndDelete(req.params.id);

    if (!rate) {
      return res.status(404).send();
    }

    res.send(rate);
  } catch (e) {
    res.status(500).send();
  }
});

module.exports = router;
