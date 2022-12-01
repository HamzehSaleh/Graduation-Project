const express = require("express");
const Problem = require("../models/problems");
const router = new express.Router();
const auth = require("../middleware/auth");

router.post("/problems", auth, async (req, res) => {
  const problem = new Problem({
    ...req.body,
    owner: req.user._id,
  });
  try {
    problem.name = req.body.name;
    problem.description = req.body.description;
    problem.problem_type = req.body.problem_type;
    problem.photo = req.body.photo;
    problem.problem_status = req.body.problem_status;
    problem.problem_date = req.body.problem_date;
    problem.lat = req.body.lat;
    problem.long = req.body.long;

    await problem.save();
    res.status(201).send(problem);
  } catch (e) {
    res.status(400).send(e);
  }
});

router.patch("/problem/update/:id", async (req, res) => {
  const updates = Object.keys(req.body);
  const allowedUpdates = ["problem_status"];
  const isValidOperation = updates.every((update) => {
    return allowedUpdates.includes(update);
  });
  if (!isValidOperation) {
    return res.status(404).send();
  }
  try {
    const problem = await Problem.findOneAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true,
    });
    if (!problem) {
      return res.status(404).send();
    }
    res.send(problem);
  } catch (e) {}
});

router.get("/problems", auth, async (req, res) => {
  try {
    await req.user.populate("myProblems").execPopulate();
    res.send(req.user.myProblems);
  } catch (e) {
    res.status(500).send();
  }
});

router.get("/allproblems", async (req, res) => {
  try {
    const problems = await Problem.find({});

    const count = problems.length;
    var i;
    for (i = 0; i < count; i++) {
      await problems[i].populate("owner").execPopulate();
      problems[i].ownerName = problems[i].owner.name;
    }

    res.send(problems);
  } catch (e) {
    res.status(500).send();
  }
});

router.get("/problems/:id", auth, async (req, res) => {
  try {
    const problem = await Problem.findOne({
      _id: req.params.id,
      owner: req.user._id,
    });
    if (!problem) {
      return res.status(404).send();
    }

    res.send(problem);
  } catch (e) {
    res.status(500).send();
  }
});

router.get("/adminProblemId/:id", async (req, res) => {
  try {
    const problem = await Problem.findOne({
      _id: req.params.id,
    });
    if (!problem) {
      return res.status(404).send();
    }

    res.send(problem);
  } catch (e) {
    res.status(500).send();
  }
});

router.delete("/problems/:id", async (req, res) => {
  try {
    const problem = await Problem.findOneAndDelete({
      _id: req.params.id,
      // owner: req.user._id,
    });
    if (!problem) {
      return res.status(404).send();
    }
    res.send(problem);
  } catch (e) {
    res.status(500).send();
  }
});

module.exports = router;
