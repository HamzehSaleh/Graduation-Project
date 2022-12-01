const jwt = require("jsonwebtoken");
const Employee = require("../models/employees");

const auth_employee = async (req, res, next) => {
  try {
    const token = req.header("Authorization").replace("Bearer ", "");
    const decoded = jwt.verify(token, "thisisme new course");

    console.log(decoded._id);

    const employee = await Employee.findOne({
      _id: decoded._id,
      "tokens.token": token,
    });

    if (!employee) {
      throw new Error("employee auth faild");
    }
    req.token = token;
    req.employee = employee;
    next();
  } catch (e) {
    res.status(401).send({ error: "Please authenticateeee" });
  }
};

module.exports = auth_employee;
