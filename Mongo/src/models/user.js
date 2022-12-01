const mongoose = require("mongoose");
const validator = require("validator");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const Problem = require("./problems");
const Service = require("./service");

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  Identity: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    validate(value) {
      if (!validator.isNumeric(value)) {
        throw new Error("Identity is invalid");
      }
    },
  },
  password: {
    type: String,
    required: true,
    trim: true,
    minLength: 7,
    validate(value) {
      if (value.toLowerCase().includes("password")) {
        throw new Error('password cannot contain "password"');
      }
    },
  },

  email: {
    type: String,
    default: "user@kahrabai.com",
    validate(value) {
      if (!validator.isEmail(value)) {
        throw new Error("invalid user email ");
      }
    },
  },

  phoneNumber: {
    type: String,
    validate(value) {
      if (!validator.isNumeric(value)) {
        throw new Error("Invalid supscription number is invalid");
      }
    },
  },

  sub_Number: {
    type: String,
    default: "0",
    validate(value) {
      if (!validator.isNumeric(value)) {
        throw new Error("Invalid supscription number is invalid");
      }
    },
  },
  cunsump: {
    type: Array,
    default: [
      800.0, 800.0, 800.0, 800.0, 800.0, 800.0, 800.0, 800.0, 800.0, 800.0,
      800.0, 800.0,
    ],
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

userSchema.virtual("myServices", {
  ref: "Service",
  localField: "_id",
  foreignField: "owner",
});

userSchema.virtual("myProblems", {
  ref: "Problem",
  localField: "_id",
  foreignField: "owner",
});

userSchema.methods.toJSON = function () {
  const user = this;
  const userObject = user.toObject();
  delete userObject.tokens;
  return userObject;
};

userSchema.methods.generateAuthToken = async function () {
  const user = this;
  const token = jwt.sign({ _id: user._id.toString() }, "thisisme new course");

  user.tokens = user.tokens.concat({ token });
  await user.save();
  return token;
};

userSchema.statics.findByCredentials = async (Identity, password) => {
  const user = await User.findOne({ Identity });

  if (!user) {
    throw new Error("unable to login");
  }

  const isMatch = await bcrypt.compare(password, user.password);

  if (!isMatch) {
    throw new Error("Unable to login ");
  }

  return user;
};

userSchema.pre("save", async function (next) {
  const user = this;
  if (user.isModified("password")) {
    user.password = await bcrypt.hash(user.password, 8);
  }

  next();
});

userSchema.pre("remove", async function (next) {
  const user = this;
  Problem.deleteMany({
    owner: user._id,
  });

  next();
});

userSchema.pre("remove", async function (next) {
  const user = this;
  Service.deleteMany({
    owner: user._id,
  });

  next();
});

const User = mongoose.model("User", userSchema);

module.exports = User;
