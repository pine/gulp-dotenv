require! {
  dotenv
  through2: through
}


transform = (chunk, enc, cb) !->
  if chunk.is-null()
    @push chunk
    return cb()

  payload = dotenv.parse(chunk.contents.to-string())
  file = chunk.clone()
  file.contents = new Buffer(JSON.stringify(payload))

  @push file
  cb()


module.exports = -> through.obj transform
