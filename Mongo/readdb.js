const mongodb = require("mongodb");
const MongoClient = mongodb.MongoClient;
const ObjectID = mongodb.ObjectID;
const ConnectionURL = "mongodb://127.0.0.1:27017";
const databaseName = "task-manager";

MongoClient.connect(
  ConnectionURL,
  { useNewUrlParser: true },
  (error, client) => {
    if (error) {
      return console.log("Unable to connect to database!");
    }
    const db = client.db(databaseName);

    // db.collection("users").findOne({ name: "test" }, (error, user) => {
    //   if (error) {
    //     return console.log("error");
    //   }
    //   console.log(user);
    // });

    db.collection("users")
      .find({ age: "27" })
      .toArray((error, users) => {
        console.log(users);
      });
  }
);
