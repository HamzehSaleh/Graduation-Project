const express = require("express");
const router = new express.Router();
const bcrypt = require("bcryptjs");
const User = require("../models/user");
const auth = require("../middleware/auth");
const {
  sendWelcomeEmail,
  sendCancelationEmail,
  ForgetPassEmail,
} = require("../Emails/account");

router.post("/users", async (req, res) => {
  const user = new User(req.body);
  try {
    await user.save();
    // sendWelcomeEmail(user.email, user.name);
    const token = await user.generateAuthToken();
    res.status(201).send({ user, token });
  } catch (e) {
    res.status(400).send(e);
  }
});

router.post("/users/login", async (req, res) => {
  try {
    const user = await User.findByCredentials(
      req.body.Identity,
      req.body.password
    );
    const token = await user.generateAuthToken();
    res.send({ user, token });
  } catch (e) {
    res.status(400).send(e);
  }
});

router.post("/users/logout", auth, async (req, res) => {
  try {
    req.user.tokens = req.user.tokens.filter((token) => {
      return token.token !== req.token;
    });

    await req.user.save();

    res.send();
  } catch (e) {
    res.status(500).send();
  }
});

router.post("/users/logoutAll", auth, async (req, res) => {
  try {
    req.user.tokens = [];
    await req.user.save();
    res.send();
  } catch (e) {
    res.status(500).send();
  }
});

router.get("/users/me", auth, async (req, res) => {
  res.send(req.user);
});

router.patch("/users/me", auth, async (req, res) => {
  const updates = Object.keys(req.body);
  const allowedUpdates = [
    "name",
    "password",
    "email",
    "phoneNumber",
    "sub_Number",
    "cunsump",
  ];
  const isValidOperation = updates.every((update) => {
    return allowedUpdates.includes(update);
  });

  if (!isValidOperation) {
    return res.status(400).send({ error: "invalid update" });
  }

  try {
    updates.forEach((update) => (req.user[update] = req.body[update]));
    await req.user.save();
    res.send(req.user);
  } catch (e) {
    res.status(400).send();
  }
});

router.delete("/users/me", auth, async (req, res) => {
  try {
    // const user = await User.findByIdAndDelete(req.user._id);

    // if (!user) {
    //   return res.status(404).send();
    // }

    await req.user.remove();

    res.send(req.user);
  } catch (e) {
    res.status(500).send();
  }
});

router.patch("/users/update/:id", async (req, res) => {
  const updates = Object.keys(req.body);
  const allowedUpdates = [
    "name",
    "password",
    "email",
    "phoneNumber",
    "sub_Number",
    "cunsump",
  ];
  const isValidOperation = updates.every((update) => {
    return allowedUpdates.includes(update);
  });
  if (!isValidOperation) {
    return res.status(404).send();
  }
  try {
    const user = await User.findOneAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true,
    });
    if (!user) {
      return res.status(404).send();
    }
    res.send(user);
  } catch (e) {
    res.send(e);
  }
});

//////////////// for the admin to delete users ///////////////
router.delete("/users/:id", async (req, res) => {
  try {
    // sendCancelationEmail(req.user.email, req.user.name);
    const user = await User.findByIdAndDelete(req.params.id);

    if (!user) {
      return res.status(404).send();
    }

    res.send(user);
  } catch (e) {
    res.status(500).send();
  }
});

////////////////// for the admin to view users data ///////////////
router.get("/users/:id", async (req, res) => {
  const _id = req.params.id;
  try {
    const user = await User.findById(_id);
    if (!user) {
      return res.status(404).send();
    }
    res.send(user);
  } catch (e) {
    res.status(500).send;
  }
});

router.patch("/usersIdentity/:identity", async (req, res) => {
  const updates = Object.keys(req.body);
  // console.log(updates);

  try {
    const user = await User.findOne(req.params.identity);
    // console.log(user);
    updates.forEach((update) => (user[update] = req.body[update]));
    await req.user.save();
    res.send(req.user);
  } catch (e) {
    res.status(400).send();
  }

  // const user = await User.findOneAndUpdate(req.params.identity, req.body);
  // newPass = user.password;
  // newPass = await bcrypt.hash(newPass, 8);

  // const user2 = await User.findOneAndUpdate(req.params.identity, {
  //   password: newPass,
  // });

  // // //   if (!user) {
  // // //     return res.status(404).send();
  // // //   }
  // // await user2.save();
  // res.send(user2);
  // // } catch (e) {
  // //   res.status(500).send;
  // // }
});

router.post("/usersSendEmail/:email", async (req, res) => {
  console.log(req.params.email);
  let r = (Math.random() + 1).toString(36).substring(3);
  console.log(r);
  ForgetPassEmail(req.params.email, " ?????? ????????", r);
});

////////////////////// read all users //////////////////
router.get("/users", async (req, res) => {
  try {
    const users = await User.find({});
    res.send(users);
  } catch (e) {
    res.status(500).send;
  }
});

module.exports = router;
