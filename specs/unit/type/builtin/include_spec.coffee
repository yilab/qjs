BuiltinType = require '../../../../lib/type/builtin_type'
{TypeError} = require '../../../../lib/errors'
should      = require 'should'

describe "BuiltinType#include", ->

  type = new BuiltinType(Number)

  subject = (arg) -> type.include(arg)

  describe 'when not included', ->
    subject("12").should.be.false

  describe 'when included', ->
    subject(12).should.be.true
