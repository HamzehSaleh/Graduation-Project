const mongoose = require("mongoose");

const Consump = mongoose.model("Consump", {
  allConsump: {
    type: Array,
  },
  minMonth: {
    type: String,
  },
});

module.exports = Consump;
