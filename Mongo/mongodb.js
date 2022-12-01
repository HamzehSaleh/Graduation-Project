// CRUD => create, read, update, delete

const mongodb = require("mongodb");
const MongoClient = mongodb.MongoClient;
const ObjectID = mongodb.ObjectID;

//const {MongoClient , ObjectID} = require('mongodb')  this line is similar to line 4 and 5

const ConnectionURL = "mongodb://127.0.0.1:27017";
const databaseName = "task-manager";

// const id = new ObjectID();
// console.log(id);
// console.log(id.getTimestamp());

MongoClient.connect(
  ConnectionURL,
  { useNewUrlParser: true },
  (error, client) => {
    if (error) {
      return console.log("unable to connect to the database");
    }

    const db = client.db(databaseName);

    db.collection("users").insertOne(
      {
        // _id: id,
        name: "test",
        age: 55,
      },
      (error, result) => {
        if (error) {
          return console.log("unable to insert user");
        }
        console.log(result.ops);
      }
    );

    // db.collection("users").insertMany(
    //   [
    //     {
    //       name: "roaa",
    //       age: 21,
    //     },
    //     {
    //       name: "hamooz",
    //       age: 34,
    //     },
    //   ],
    //   (error, result) => {
    //     if (error) {
    //       return console.log("unable to insert data");
    //     }
    //     console.log(result.ops);
    //   }
    // );

    // db.collection("tasks").insertMany(
    //   [
    //     {
    //       title: "رقم واحد",
    //       duration: 3,
    //     },
    //     {
    //       title: "رقم واحد",
    //       duration: 4,
    //     },
    //     {
    //       title: "رقم واحد",
    //       duration: 5,
    //     },
    //   ],
    //   (error, result) => {
    //     if (error) {
    //       return console.log("unable to insert data");
    //     }
    //     console.log(result.ops);
    //   }
    // );
  }
);
