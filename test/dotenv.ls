require! {
  path
  fs

  chai
  'gulp-util': gutil
  sinon
  'sinon-chai': sinon-chai

  '../lib/dotenv': dotenv
}

test = it

chai.use(sinon-chai)
expect = chai.expect


describe \dotenv ->
  test 'should transform empty .env file' (done) ->
    file = new gutil.File( contents: new Buffer('') )
    stream = dotenv(file)
    on-data = sinon.spy ->
      console.log it
      expect(it.contents.to-string()).to.equal('{}')
    on-error = sinon.spy(console.error)

    stream
      .on \data, on-data
      .on \error, on-error
      .on \end ->
        expect(on-data).to.have.been.called-once
        expect(on-error).to.not.have.been.called
        done()

    stream.end(file)

  # ---------------------------------------------------------------------------

  test 'should transform null file' (done) ->
    file = new gutil.File()
    stream = dotenv()
    on-data = sinon.spy ->
      console.log it
      expect(it.is-null()).to.be.true
    on-error = sinon.spy(console.error)

    stream
      .on \data, on-data
      .on \error, on-error
      .on \end ->
        expect(on-data).to.have.been.called-once
        expect(on-error).to.not.have.been.called
        done()

    stream.end(file)

  # ---------------------------------------------------------------------------

  test 'should transform .env file' (done) ->
    file = new gutil.File(
      path: path.join(__dirname, '.env')
      cwd: process.cwd
      base: __dirname
      contents: fs.read-file-sync(path.join(__dirname, '.env'))
    )
    stream = dotenv(file)

    on-data = sinon.spy ->
      console.log it
      expect(it.contents.to-string()).to.equal('{"FOO":"foo","BAR":"1","BAZ":""}')
    on-error = sinon.spy(console.error)

    stream
      .on \data, on-data
      .on \error, on-error
      .on \end ->
        expect(on-data).to.have.been.called-once
        expect(on-error).to.not.have.been.called
        done()

    stream.end(file)
