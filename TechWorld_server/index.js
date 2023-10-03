// const { initializeApp } = require('firebase-admin/app');

const express = require('express');
const app = express();
PORT = 5000
const route = require('./routes');
const morgan = require('morgan');
app.use(morgan('combined'))

app.use(express.urlencoded({
  extended: true
}))

app.use(express.json())

route(app)


app.listen(PORT, () => console.log(`Server is running on port: http://localhost:${PORT}`))