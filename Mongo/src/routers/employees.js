const express = require("express");
const router = new express.Router();
const Employee = require("../models/employees");
const auth_employee = require("../middleware/auth_employee");
const auth = require("../middleware/auth");

router.post("/employees", async (req, res) => {
  const employee = new Employee(req.body);
  try {
    await employee.save();
    const token = await employee.generateAuthToken();
    res.status(201).send({ employee, token });
  } catch (e) {
    res.status(400).send(e);
  }
});

router.post("/employees/login", async (req, res) => {
  try {
    const employee = await Employee.findByCredentials(
      req.body.Identity,
      req.body.password
    );
    const token = await employee.generateAuthToken();
    res.send({ employee, token });
  } catch (e) {
    res.status(400).send();
  }
});

router.get("/employees/me", auth_employee, async (req, res) => {
  res.send(req.employee);
});

router.get("/employees", async (req, res) => {
  try {
    const employee = await Employee.find({});
    res.send(employee);
  } catch (e) {
    res.status(500).send();
  }
});

router.get("/employees/:name", async (req, res) => {
  try {
    const employee = await Employee.find({ name: req.params.name });
    res.send(employee);
  } catch (e) {
    res.status(500).send();
  }
});

router.post("/employees/logoutAll", auth_employee, async (req, res) => {
  try {
    req.employee.tokens = [];
    await req.employee.save();
    res.send();
  } catch (e) {
    res.status(500).send();
  }
});

router.delete("/employees/:id", async (req, res) => {
  try {
    const employee = await Employee.findByIdAndDelete(req.params.id);

    if (!employee) {
      return res.status(404).send();
    }

    res.send(employee);
  } catch (e) {
    res.status(500).send();
  }
});

module.exports = router;
