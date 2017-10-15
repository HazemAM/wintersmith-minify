uglify = require 'uglify-js'
fs = require 'fs'
path = require 'path'

module.exports = (env, callback) ->

  class MinifyJsFile extends env.ContentPlugin
    constructor: (@filepath) ->

    getFilename: ->
      @filepath.relative.replace /\.minify\.json$/, ''

    getView: -> (env, locals, contents, templates, callback) ->
      filepath = @filepath
      env.logger.verbose "MinifyJS: Loading MinifyJS config from #{@filepath.relative}"
      
      fs.readFile @filepath.full, (error, buffer) ->
        if error
          callback error
        else
          options = JSON.parse buffer.toString()
          basePath = path.normalize path.dirname filepath.full
          
          env.logger.verbose "MinifyJS: Loading scripts from #{basePath}"
          pathList = (path.join(basePath, item) for item in options.input)
            
          minifyInput = {}
          for item, i in options.input
            minifyInput[item] = fs.readFileSync pathList[i], 'utf8'
              
          try
            result = uglify.minify minifyInput
            callback null, Buffer result.code
          catch error
            callback error

  MinifyJsFile.fromFile = (filepath, callback) ->
    callback null, new MinifyJsFile filepath

  env.registerContentPlugin 'minifyjs', '**/*.js.minify.json', MinifyJsFile
  callback()
