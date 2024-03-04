const express = require('express');
const findUserrouter = express.Router();
const auth = require('../middlewares/auth');
const user = require('../models/user');

findUserrouter.get('/api/find-new-friends' , auth , async (req , res)=>{
    try {
        const username = req.headers.username;
        let users = await user.find({ _id: { $ne: req.user } , username: { $regex: username, $options: 'i' } });
    
        res.json(users);
    } catch (error) {
        res.status(500).json({message : error.message});
    }
})

findUserrouter.post('/api/send-request' , auth , async (req , res) => {
    try {
       
        const {sendto } = req.body ; 
        if(sendto == req.user){
          return  res.status(500).json({message : "eroor"});
            
        }
        const recieverId = await user.findByIdAndUpdate( sendto , {$push: {
            friendRequests:{
                senderId: req.user
            }
        }},{new : true});
        
        const User = await user.findByIdAndUpdate( req.user , {$push: {
            sendRequests:{
                requestedUserId: recieverId
            }
        }},{new : true});
       
        res.json(User);
    } catch (error) {
        res.statusCode(500).json({message : error});
    }
} )

module.exports = findUserrouter;