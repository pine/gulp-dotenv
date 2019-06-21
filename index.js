'use strict'

const dotenv = require('dotenv')
const through = require('through2')


function transform(chunk, enc, cb) {
  if (chunk.isNull()) {
    this.push(chunk)
    return cb()
  }

  const payload = dotenv.parse(chunk.contents.toString())
  const file = chunk.clone()
  file.contents = Buffer.from(JSON.stringify(payload))

  this.push(file)
  cb()
}

module.exports = () => through.obj(transform)
