require! {
  chai: {expect}
}

test = it


describe \index ->
  test 'should require lib/dotenv' ->
    expect(require('../')).to.equal(require('../lib/dotenv'))
