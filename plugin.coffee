uglify = require 'uglify-js'
CleanCSS = require 'clean-css'
fs = require 'fs'
path = require 'path'

module.exports = (env, callback) ->

  class MinifyFile extends env.ContentPlugin
    constructor: (@filepath) ->

    getFilename: ->
      @filepath.relative.replace /\.minify\.json$/, ''

    getView: -> (env, locals, contents, templates, callback) ->
      filepath = @filepath
      fileType = @getFilename().split('.').pop()
      env.logger.verbose "Minify: Loading Minify config from #{@filepath.relative}"
      
      fs.readFile @filepath.full, (error, buffer) ->
        if error
          callback error
        else
          options = JSON.parse buffer.toString()
          basePath = path.normalize path.dirname filepath.full
          
          env.logger.verbose "Minify: Loading scripts from #{basePath}"
          pathList = (path.join(basePath, item) for item in options.input)
              
          try
            if fileType is 'js'
              result = uglify.minify pathList, {compress: false}
              callback null, Buffer result.code
            else if fileType is 'css'
              # Use provided settings, if any, and define the root path:
              options.settings = options.settings or env.config.minify?.css
              if options.settings
                options.settings.root = basePath
              else
                options.settings = {root: basePath}
                
              result = new CleanCSS(options.settings).minify options.input
              callback null, Buffer result.styles
          catch error
            callback error

  MinifyFile.fromFile = (filepath, callback) ->
    callback null, new MinifyFile filepath

  env.registerContentPlugin 'minify', '**/*.*.minify.json', MinifyFile
  callback()
