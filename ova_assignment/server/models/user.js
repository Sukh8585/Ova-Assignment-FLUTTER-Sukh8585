const mongoose = require('mongoose');

const friendRequestSchema = new mongoose.Schema({
senderId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
},
status: {
    type: String,
    enum: ['pending', 'accepted', 'rejected'],
    default: 'pending',
},
sentAt: {
    type: Date,
    default: Date.now,
},
respondedAt: Date,
});

const userSchema = new mongoose.Schema({
username: {
    type: String,
    required: true,
    unique: true,
},
password: {
    type: String,
    required: true,
},
displayName: {
    type: String,
    required: true,
    unique: true,
},
email : {
    type: String,
    required : true,
    trim: true,
    require: true
},
  profilePicture: String, // URL to the image
// friendsList: [{
//     type: mongoose.Schema.Types.ObjectId,
//     ref: 'User',
// }],
// friendRequests: [friendRequestSchema],
}, { timestamps: true });

const user = mongoose.model('user', userSchema);

module.exports = user;
