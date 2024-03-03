const express = require("express");
//intinalising express.router so that i dont have to create diiferent apps for listening
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const user = require("../models/user");
const jwt = require('jsonwebtoken');
const auth = require("../middlewares/auth");
//auth page request
authRouter.post("/api/sign", async (req, res) => {
  //get the data from client and add it in data base
  //client will send data in this formatt {name : "name" , email : "email" , password : "password"}
  //we can store that data like this
const { username, email, password  } = req.body;
  //we need to do authentication first before storing the data in database
  //it is different form firebase where it does everything
  //this helps us to check if a user exist or not
const existinguser = await user.findOne({ email });

try {
    if (existinguser) {
    return res.status(400).json({
        msg: "user already exists!",
    });
    }
    
    //hashing the password first to make it more secure using bcryptjs
    const hashedpass = await bcryptjs.hash(password, 8);
    
    let User = new user({
      email,
      password: hashedpass,
      username,
      displayName: username
    });
    
    User = await User.save();

    res.json(User);
    
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
  //return data to user sucessful or not
});
//creating the login part
authRouter.post("/api/login" , async (req , res)=>{
  try{
    //storing the email and password that the user send 
    const {email , password} = req.body ; 
    //checking if the same email is registered or not 
  
    const existinguser = await user.findOne({email});
    if(!existinguser){
    return res.status(400).json({
        "error" : "user does not exist !! please register"
      })
    }
    //checking of the password matches or not 
    const isokay  = await bcryptjs.compare(password , existinguser.password);
    if(!isokay){
      return res.status(400).json({
        "error":"wrong password!!!"});
    }
    //generating a jsonwebtoken to verify  the user is not a hacker 
  const token =  jwt.sign({id:existinguser.id} , 'passwordkey' );
  //sending the response and it will also add token to the user part 
  //using _doc helps us to clean user data and only get the data that we need 
  //try using with and without doc to see the difference 
  return res.json({token , ...existinguser._doc});
  
    
    
  }
 catch(e){
  res.status(500).json({ error: e.message });
 }
})

//for checking if the token is valid or not
authRouter.post("/tokenIsvalid" , async (req , res)=>{
  try {
    //getting the token from the front end it is stored in header 
    const token = req.header('x-auth-token');
    //verifying if the token is empty or not if empty just returning false
    if(!token) return res.json(false);
    //checking if the token is same as we have in the database using the key that we used while creating the token
   const isValid =  jwt.verify(token , 'passwordkey')
   if(!isValid) return res.json(false);
  //now we need to check if the token given is also a valid user or not 
  //we can do that by using the user.id that we passed in while creating the jwt token in line 60
  
    const existinguser = await user.findById(isValid.id);
  //if user does not exist return
    if(!existinguser) return res.json(false);
   //if user does exist send true 
    return res.json(true);
    
  } catch (e) {
    res.status(500).json({error:e.message});
  }
})
//get user data using auth as middleware
//it will authorize the user first and then give the data back
authRouter.get('/' , auth , async (req,res)=>{
  const existinguser = await user.findById(req.user);
res.json({...existinguser._doc , token:req.token})
})
//exporting module using express so that it can be used in other files
module.exports = authRouter;
