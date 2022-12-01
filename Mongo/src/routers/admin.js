const express = require("express");
const router = new express.Router();
const Admin = require("../models/admin");

router.post("/admin", async (req, res) => {
  const admin = new Admin(req.body);
  try {
    await admin.save();
    res.status(201).send(admin);
  } catch (e) {
    res.status(400).send(e);
  }
});

router.post("/admin/login", async (req, res) => {
  try {
    const admin = await Admin.findByCredentials(
      req.body.Identity,
      req.body.password
    );
    res.send(admin);
  } catch (e) {
    console.log(e);
    res.status(400).send(e);
  }
});

// router.patch("/admin/update/:id", async (req, res) => {
//   const updates = Object.keys(req.body);
//   const allowedUpdates = ["password"];
//   const isValidOperation = updates.every((update) => {
//     return allowedUpdates.includes(update);
//   });
//   if (!isValidOperation) {
//     return res.status(404).send();
//   }
//   try {
//     const admin = await Admin.findOneAndUpdate(req.params.id, req.body, {
//       new: true,
//       runValidators: true,
//     });
//     if (!admin) {
//       return res.status(404).send();
//     }
//     res.send(admin);
//   } catch (e) {
//     res.status(400).send(e);
//   }
// });

router.patch("/admin/update/:identity", async (req, res) => {
  const updates = Object.keys(req.body);
  const allowedUpdates = ["password"];
  const isValidOperation = updates.every((update) => {
    return allowedUpdates.includes(update);
  });
  if (!isValidOperation) {
    return res.status(404).send();
  }
  try {
    const admin = await Admin.findOneAndUpdate(req.params.identity, req.body, {
      new: true,
      runValidators: true,
    });
    if (!admin) {
      return res.status(404).send();
    }
    res.send(admin);
  } catch (e) {
    res.status(400).send(e);
  }
});

module.exports = router;
