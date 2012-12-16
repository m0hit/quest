quest  = require "#{__dirname}/../index"
assert = require 'assert'
_ = require 'underscore'


describe 'quest', ->
  safe_err = (err) ->
    err = new Error err if err? and err not instanceof Error
    err
  _.each ['https', 'http'], (protocol) ->
    describe protocol, ->
      it 'checks if header_plugin is used', (done) ->
        @timeout 20000
        header_plugin = require "#{__dirname}/header_plugin"
        options = 
           method: 'get'
           uri: "#{protocol}://httpbin.org/headers"
           json: true
           test_header: 'troll header'

        quest.use header_plugin
        quest options, (err, resp, body) ->
          assert not err, "Has error #{err}"
          assert.equal resp.statusCode, 200, "Status code should be 200, is #{resp.statusCode}"
          assert body?.headers?['Xx-Test-Header'], options.test_header
          done safe_err err
