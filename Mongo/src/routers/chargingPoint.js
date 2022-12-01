const express = require("express");
const router = new express.Router();
const chargingPoint = require("../models/chargingPoint");

router.post("/chargingPoint", async (req, res) => {
  const point = new chargingPoint(req.body);
  try {
    await point.save();
    res.status(201).send({ point });
  } catch (e) {
    res.status(400).send(e);
  }
});

router.get("/chargingPoint", async (req, res) => {
  try {
    const point = await chargingPoint.find({});
    res.send(point);
  } catch (e) {
    res.status(500).send();
  }
});

router.get("/chargingPoint/:lat", async (req, res) => {
  try {
    const point = await chargingPoint.find({ lat: req.params.lat });
    if (!point) {
      return res.status(404).send();
    }
    console.log(point);
    res.send(point);
  } catch (e) {
    res.status(500).send();
  }
});

router.delete("/chargingPoint/:id", async (req, res) => {
  try {
    const point = await chargingPoint.findByIdAndDelete(req.params.id);

    if (!point) {
      return res.status(404).send();
    }

    res.send(point);
  } catch (e) {
    res.status(500).send();
  }
});

module.exports = router;
