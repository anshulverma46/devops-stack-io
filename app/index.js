const express = require('express')
const app = express()
const port = 3000

const { MongoClient } = require("mongodb");
const url = "mongodb://localhost:27017";

const client = new MongoClient(url, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });

app.get('/hello/:name?', async (req, res) => {
  let name = req.params.name ? req.params.name : "stranger";
  if(name !== "stranger") {
    const doc = { "name": name, "printedAt":  new Date()};
    try {
      await client.connect();
      const result = await client.db("names").collection("printed_names").insertOne(doc);
      console.log(
          `${result.insertedCount} documents were inserted with the _id: ${result.insertedId}`,
        );      
    } catch (error) {
        console.error(error);
    }
    res.send('Hello '+ name +'!');
  } else {
      console.log("Strangers are strangers, why bother to store?!");
  }
})

app.listen(port, () => {
  console.log(`Hello app listening at http://localhost:${port}`)
})