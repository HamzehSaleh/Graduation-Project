const { Schema } = require("mongoose");
const mongoose = require("mongoose");
const validator = require("validator");
const jwt = require("jsonwebtoken");

const RatingSchema = new mongoose.Schema({
  index: {
    type: Number,
    required: true,
  },
  note: {
    type: String,
    default: "لا يوجد ملاحظات",
  },
});

RatingSchema.methods.toJSON = function () {
  const rate = this;
  const rateObject = rate.toObject();
  return rateObject;
};

const Rating = mongoose.model("Rating", RatingSchema);
module.exports = Rating;
