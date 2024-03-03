const jwt = require("jsonwebtoken");
//recieving the token
const auth = async (req, res, next) => {
  try {
    //storing the token in a variable
    const token = req.header("x-auth-token");

    //checking if the token is there or not
    if (!token) {
      //returning 401 status code as it is unauthorized user
      return res.status(401).json({ msg: "no auth token , access denied " });
    }
    const isValid = jwt.verify(token, "passwordkey");
    if (!isValid)
      return res.status(401).json({ msg: "token verification failed" });
    //storing id and token of verified user to use later so that everytime we dont have to find the user first and the use 
    //its details but now we can just call req.user and req.token to get that stuff 
    //it can be used in the next callback function after middleware
    req.user = isValid.id;
    req.token = token;

    //next means to call the next call back function after the middleware authentication
    next();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

module.exports = auth;
