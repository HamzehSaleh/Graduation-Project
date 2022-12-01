const mongoose = require("mongoose");

const adminSchema = new mongoose.Schema({
  name: {
    type: String,
  },
  Identity: {
    type: String,
  },
  password: {
    type: String,
  },
});

adminSchema.statics.findByCredentials = async (Identity, password) => {
  const admin = await Admin.findOne({ Identity });

  if (password != admin.password) {
    throw new Error("unable to login");
  }

  if (!admin) {
    throw new Error("unable to login");
  }

  return admin;
};
const Admin = mongoose.model("Admin", adminSchema);

module.exports = Admin;
