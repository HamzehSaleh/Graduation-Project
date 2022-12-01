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
      return console.log("unable to connect !!");
    }
    const db = client.db(databaseName);
    // db.collection("users")
    //   .updateOne(
    //     {
    //       _id: new ObjectID("6251f0fb6e3f5f0934b9126d"),
    //     },
    //     {
    //       //   $set: {
    //       //     name: "update",
    //       //   },
    //       $inc: {
    //         age: 2,
    //       },
    //     }
    //   )
    //   .then((result) => {
    //     console.log(result);
    //   })
    //   .catch((error) => {
    //     console.log(error);
    //   });

    db.collection("tasks")
      .updateMany(
        {
          duration: 5,
        },
        {
          $set: {
            duration: 6,
          },
        }
      )
      .then((result) => {
        console.log(result);
      })
      .catch((error) => {
        console.log(error);
      });
  }
);
