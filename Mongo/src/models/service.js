const mongoose = require("mongoose");

const Service = mongoose.model("Service", {
  name: {
    type: String,
    required: true,
  },
  photos: {
    type: Array,
  },
  service_status: {
    type: String,
    default: "جاري مراجعة الطلب",
  },
  service_date: {
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

module.exports = Service;
