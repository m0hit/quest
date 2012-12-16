handlers = 
   add_header: (options) ->
      options.headers['Xx-Test-Header']= options.test_header

add_handler_plugin = handlers: handlers
module.exports = add_handler_plugin
