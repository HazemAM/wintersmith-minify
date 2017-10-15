# wintersmith-minifyjs
An [uglify-js](https://github.com/mishoo/UglifyJS2) plugin for [Wintersmith](https://github.com/jnordberg/wintersmith).

Installation
------------

**Warning:** Early-stage developement. Even repository name could change!

The plugin is not published on NPM yet as the name is not final. If you want to use the plugin in this early stage, you could add it as a Git submodule, import it using the Git URI, or make a local fork.

Usage
-----

1.  Create a file with this pattern:
    
    ```
    <output>.js.minify.json
    ```
    
    Where `<output>` is the name of the minified file.


2.  In this file, make a list of the files you want to minify in an `input` property, e.g.:
    
    ```json
    {
      "input": [
          "script-x.js",
          "../directory/script-y.js"
      ]
    }
    ```
    
    **Side note:** If you want your source files not to be included and accessible in Wintersmith builds, you must place them outside the `contents` folder.


3.  Put the `*.minify.json` file in the path you want your minified file to be in, e.g. `contents/assets/bundle.js.minify.json`.


4.  Use the minified file in your project without the postfix, e.g.:
    ```html
    <script src="assets/bundle.js"></script>
    ```
