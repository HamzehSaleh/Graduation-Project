const mongoose = require("mongoose");
const validator = require("validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const employeeSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trime: true,
  },

  Identity: {
    type: String,
    required: true,
    unique: true,
    trim: true,
  },

  jobTitle: {
    type: String,
    default: "موظف",
    trim: true,
  },

  password: {
    type: String,
    required: true,
    trim: true,
  },

  email: {
    type: String,
    default: "employee@kahrabai.com",
    validate(value) {
      if (!validator.isEmail(value)) {
        throw new Error("invalid employee email ");
      }
    },
  },

  phoneNumber: {
    type: String,
  },

  tokens: [
    {
      token: {
        type: String,
        required: true,
      },
    },
  ],
});

employeeSchema.methods.toJSON = function () {
  const employee = this;
  const employeeObject = employee.toObject();
  delete employeeObject.tokens;
  return employeeObject;
};

employeeSchema.methods.generateAuthToken = async function () {
  const employee = this;
  const token = jwt.sign(
    { _id: employee._id.toString() },
    "thisisme new course"
  );

  employee.tokens = employee.tokens.concat({ token });
  await employee.save();
  return token;
};

employeeSchema.statics.findByCredentials = async (Identity, password) => {
  const employee = await Employee.findOne({ Identity });

  if (!employee) {
    throw new Error("unable to login");
  }

  const isMatch = await bcrypt.compare(password, employee.password);

  if (!isMatch) {
    throw new Error("Unable to login ");
  }

  return employee;
};

employeeSchema.pre("save", async function (next) {
  const employee = this;
  if (employee.isModified("password")) {
    employee.password = await bcrypt.hash(employee.password, 8);
  }

  next();
});

const Employee = mongoose.model("Employee", employeeSchema);

module.exports = Employee;
