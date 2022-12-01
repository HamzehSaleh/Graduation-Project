const mongoose = require("mongoose");

const Porblem = mongoose.model("Problem", {
  name: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    default: "لا يوجد تفاصيل",
  },
  problem_type: {
    type: String,
  },
  photo: {
    type: String,
    default:
      "https://raw.githubusercontent.com/mohammadmubaslat/myImages/main/noImage.png",
  },
  problem_status: {
    type: String,
    default: "جاري مراجعة الشكوى",
  },
  problem_date: {
    type: String,
  },
  lat: {
    type: Number,
  },
  long: {
    type: Number,
  },
  ownerName: {
    type: String,
  },
  owner: {
    type: mongoose.Schema.Types.String,
    required: true,
    ref: "User",
  },
});

module.exports = Porblem;
