const express = require('express');
const mongoose = require('mongoose');
const authRouter = require('./routes/auth');

//KFnquce0q1e4yz3A

const port =  process.env.port|| 3000; 
const db = "mongodb+srv://sukhmanjeetsingh7:KFnquce0q1e4yz3A@cluster0.xemn9iq.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
const app = express();

app.use(express.json()); 
app.use(authRouter);
mongoose.connect(db)
.then(()=>{
console.log('connect success!!');
})
.catch((e)=>{
    console.log(e);
    console.log('bsdk kuch glt likha h 🤣');
})

app.listen( port ,"0.0.0.0" ,()=>{
    console.log('started');
    })
    