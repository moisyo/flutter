var fs = require('fs');
 
 function getline (filename){
    
    var data = fs.readFileSync(filename,'UTF-8');
    var res = data.split('\n').length;
    console.log(res);
        
    return res;
 }
 module.exports = getline;