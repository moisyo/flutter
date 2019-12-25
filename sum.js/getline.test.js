const getline = require('./getline.js');

test('pass the txt and get return of the num of lines',
()=>{
expect(getline('line.txt')).toBe(3);
});