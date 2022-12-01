const express = require("express");
require("./db/mongoose");
const userRouter = require("./routers/user");
const employeeRouter = require("./routers/employees");
const chargingPointRouter = require("./routers/chargingPoint");
const RatingRouter = require("./routers/Rating");
const ProblemsRouter = require("./routers/problems");
const ServicesRouter = require("./routers/service");
const ConsumpRouter = require("./routers/consump");
const AdminRouter = require("./routers/admin");
const Porblem = require("./models/problems");
const User = require("./models/user");
var cors = require("cors");

const app = express();
app.use(cors());
const port = process.env.PORT || 3080;

// app.use((req, res, next) => {
//   if (req.method === "GET") {
//     res.send("GET req is disapled");
//   } else {
//     next();
//   }
// });

// app.use((req, res, next) => {
//   res.status(503).send("site is currently down , Check back soon!");
// });

app.use(express.json());
app.use(userRouter);
app.use(employeeRouter);
app.use(chargingPointRouter);
app.use(RatingRouter);
app.use(ProblemsRouter);
app.use(ServicesRouter);
app.use(ConsumpRouter);
app.use(AdminRouter);

app.listen(port, () => {
  console.log("server is up on port " + port);
});

const main = async () => {
  // const problem = await Porblem.findOne({ _id: "6270da48a1651901459e9a31" });
  // console.log(problem);
  // await problem.populate("owner").execPopulate();
  const user = await User.findByIdAndUpdate(
    { _id: "62754d209df0795c86682aed" },
    { name: "hamzeh" }
  );
  console.log(user);

  // console.log(problem.owner.name);

  // const u = await User.findById(t);
  // console.log(u.name);
};

// main();
