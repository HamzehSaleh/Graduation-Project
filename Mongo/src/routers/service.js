const express = require("express");
const router = new express.Router();
const Service = require("../models/service");
const auth = require("../middleware/auth");

router.post("/services", auth, async (req, res) => {
  const service = new Service({
    ...req.body,
    owner: req.user._id,
  });

  try {
    await service.save();
    res.status(201).send(service);
  } catch (e) {
    res.status(400).send(e);
  }
});

router.get("/allServices", async (req, res) => {
  try {
    const service = await Service.find({});

    const count = service.length;
    var i;
    for (i = 0; i < count; i++) {
      await service[i].populate("owner").execPopulate();
      service[i].ownerName = service[i].owner.name;
    }

    res.send(service);
  } catch (e) {
    res.status(500).send();
  }
});

router.get("/adminServiceId/:id", async (req, res) => {
  try {
    const service = await Service.findOne({
      _id: req.params.id,
    });
    if (!service) {
      return res.status(404).send();
    }

    await service.populate("owner").execPopulate();
    service.ownerName = service.owner.name;

    res.send(service);
  } catch (e) {
    res.status(500).send();
  }
});

module.exports = router;
