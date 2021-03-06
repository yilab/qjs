{KeyError}  = require '../../../lib/errors'
System      = require '../../../lib/system'
TupleType   = require '../../../lib/type/tuple_type'
{numType}   = require '../../spec_helpers'

should      = require 'should'

describe 'System#fetch', ->

  system = new System

  beforeEach ->
    system = new System
    system.addType(numType)

  subject = (name) -> system.fetch(name)

  describe 'with an existing type name', ->
    it 'should return the type', ->
      subject("numType").should.equal(numType)

  describe 'with a non existing type name and no callback', ->
    name = "noSuchOne"

    lambda = -> subject(name)

    it 'should raise an error', ->
      should(lambda).throw()

      err = try
        lambda()
      catch e
        e

      err.should.be.an.instanceof KeyError
      err.message.should.match /noSuchOne/

  describe 'with a non existing type name and a callback', ->
    lambda = ->
      system.fetch("noSuchOne", -> "bar")

    it 'should call the callback', ->
      lambda().should.equal("bar")
