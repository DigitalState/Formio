# DEPRECATED: Use [Lodash's unset method](https://lodash.com/docs#unset) instead

This module will still work but I will no longer maintain it since lodash implements it.

# delete-property [![Build Status](https://travis-ci.org/rahatarmanahmed/delete-property.svg?branch=master)](https://travis-ci.org/rahatarmanahmed/delete-property)
Deletes a deeply nested object property. Returns true if successfully deleted. Returns false if property doesn't exist or if the passed in argument is not an object.

## Installing
`npm install delete-property`

## Example usage
```js
var deleteProperty = require('delete-property');
var obj = {
    n: {
        p: {
            m: true
        }
    }  
};

var deleteNPM = deleteProperty('n.p.m');
console.log(deleteNPM(obj)); // true
console.log(obj.n.p.hasOwnProperty('m')); // false

// Tryin to delete something that ain't exist? You rascal..

var deleteSuckIt = deleteProperty('suck.it');
console.log(deleteSuckIt(obj)) // false
console.log(deleteSuckIt(undefined)) // false
console.log(deleteSuckIt(null)) // false
console.log(deleteSuckIt(69)) // false
console.log(deleteSuckIt('god damn it')) // false
```
