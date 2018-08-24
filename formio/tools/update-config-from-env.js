'use strict';

/**
 * This tool parses the environment variable `FORMIO_DEFAULT_JSON` as a JSON object, then deeply merges it with the
 * contents of `formio/config/default.json` overriding pre-existing properties.
 */

const process = require('process');
const fs = require('fs');
const jsonfile = require('jsonfile');
const deepmerge = require('deepmerge');
// const jsonUpdate = require('json-update');

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

const targetFile = '../config/default.json';

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

if (!process.env.FORMIO_DEFAULT_JSON) {
  console.warn('Environment variable `FORMIO_DEFAULT_JSON` is undefined or empty.');
  process.exit(0);
}

if (!fs.existsSync(targetFile)) {
  console.error('Target config file not found: ', targetFile);
  process.exit(0);
}

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

var envJson;

try {
  console.log('Parsing environment variable `FORMIO_DEFAULT_JSON`', process.env.FORMIO_DEFAULT_JSON);
  envJson = JSON.parse(process.env.FORMIO_DEFAULT_JSON);
}
catch(e) {
  console.warn('Error while parsing environment variable `FORMIO_DEFAULT_JSON`', e);
  process.exit(0);
}

// console.log('JSON-parsed `FORMIO_DEFAULT_JSON`', envJson);

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //

let fileJson = jsonfile.readFileSync(targetFile);
let mergeResult = deepmerge(fileJson, envJson);

let writeOptions = { spaces: 2 };
jsonfile.writeFileSync(targetFile, mergeResult, writeOptions);

// console.log(`Merged configurations have been successfully written to ${targetFile}`);

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // //
