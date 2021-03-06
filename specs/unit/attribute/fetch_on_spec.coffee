Attribute = require '../../../lib/support/attribute'
should    = require 'should'
{
  ArgumentError
, KeyError
}         = require '../../../lib/errors'
{intType} = require '../../spec_helpers'

describe "Attribute#fetchOn", ->

  attr = new Attribute('red', intType)
  subject = (arg, cb) -> attr.fetchOn(arg, cb)

  describe 'with an object that does not support fetch', ->
    arg = 12

    lambda = -> subject(arg)

    should(lambda).throw()

    try
      lambda()
    catch e
      e.should.be.an.instanceof(ArgumentError)
      e.message.should.equal("Object expected, got Number")

  describe 'with a valid object', ->
    arg = "red": 233
    subject(arg).should.equal(233)

  describe 'when the key is missing and no callback', ->
    arg = { other: 123 }
    lambda = -> subject(arg)

    should(lambda).throw()

    try
      lambda()
    catch e
      e.should.be.an.instanceof(KeyError)

  describe 'when the key is missing and a callback is present', ->
    arg = other: 123

    subject(arg, -> "none").should.equal("none")
