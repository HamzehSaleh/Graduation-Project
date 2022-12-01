const mongoose = require("mongoose");

const chargingPointsSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  lat: {
    type: String,
    required: true,
  },
  long: {
    type: String,
    required: true,
  },
  openingTime: {
    type: String,
    default: "09:00 صباحا",
  },
  closingTime: {
    type: String,
    default: "05:00 مساءا",
  },
  days: {
    type: String,
    default: "سبت احد اثنين ثلاثاء اربعاء خميس",
  },
});

chargingPointsSchema.methods.toJSON = function () {
  const point = this;
  const pointObject = point.toObject();
  return pointObject;
};

const chargingPoint = mongoose.model("chargingPoint", chargingPointsSchema);
module.exports = chargingPoint;
