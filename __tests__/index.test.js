'use strict'

const path = require('path')
const fs = require('fs')

const gutil = require('gulp-util')

const dotenv = require('..')


test('should transform empty .env file', done => {
  const file = new gutil.File({ contents: Buffer.from('') })
  const stream = dotenv()

  let onDataCalledCount = 0
  let onErrorCalledCount = 0
  stream
    .on('data', data => {
      console.log(data)
      expect(data.contents.toString()).toBe('{}')
      onDataCalledCount++
    })
    .on('error', err => {
      console.error(err)
      onErrorCalledCount++
    })
    .on('end', () => {
      expect(onDataCalledCount).toBe(1)
      expect(onErrorCalledCount).toBe(0)
      done()
    })

  stream.end(file)
})


test('should transform null file', done => {
  const file = new gutil.File()
  const stream = dotenv()

  let onDataCalledCount = 0
  let onErrorCalledCount = 0
  stream
    .on('data', data => {
      console.log(data)
      expect(data.isNull()).toBeTruthy()
      onDataCalledCount++
    })
    .on('error', err => {
      console.error(err)
      onErrorCalledCount++
    })
    .on('end', () => {
      expect(onDataCalledCount).toBe(1)
      expect(onErrorCalledCount).toBe(0)
      done()
    })

  stream.end(file)
})


test('should transform .env file', done => {
  const file = new gutil.File({
    path: path.join(__dirname, '.env'),
    cwd: process.cwd,
    base: __dirname,
    contents: fs.readFileSync(path.join(__dirname, '.env')),
  })
  const stream = dotenv()

  let onDataCalledCount = 0
  let onErrorCalledCount = 0
  stream
    .on('data', data => {
      console.log(data)
      expect(data.contents.toString()).toBe('{"FOO":"foo","BAR":"1","BAZ":""}')
      onDataCalledCount++
    })
    .on('error', err => {
      onErrorCalledCount++
      console.error(err)
    })
    .on('end', () => {
      expect(onDataCalledCount).toBe(1)
      expect(onErrorCalledCount).toBe(0)
      done()
    })

  stream.end(file)
})
