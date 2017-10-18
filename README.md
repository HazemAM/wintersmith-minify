# wintersmith-minify

A CSS ([clean-css](https://github.com/jakubpawlowicz/clean-css)) and JavaScript ([UglifyJS](https://github.com/mishoo/UglifyJS2)) minifier plugin for [Wintersmith](https://github.com/jnordberg/wintersmith).


Installation
------------

The plugin is not published on NPM yet as it's in an early-stage. If you want to use the plugin now, you could add it as a Git submodule, import it using the Git URI, or make a local fork.


Usage
-----

1.  Create a file with this name pattern:
    
    ```shell
    <output>.<filetype>.minify.json
    ```
    
    Where:
    
      * `<output>` is the name of the minified file.
        
      * `<filetype>` is the file extension (either `js` or `css` for now).


2.  In this file, make a list of the files you want to minify in an `input` property.
    
    For instance, in `bundle.js.minify.json`:
    
    ```json
    {
      "input": [
          "other-script.js",
          "../src/main.js"
      ]
    }
    ```
    And in `bundle.css.minify.json`:
    
    ```json
    {
      "input": [
          "normalize.css",
          "../src/main.css"
      ]
    }
    ```
    
    **Side note:** If you want your source files not to be included and accessible in Wintersmith builds, you must place them outside the `contents` folder.


3.  Put every `*.*.minify.json` file in the path you want your minified file to be in, e.g. `contents/script/bundle.js.minify.json`, and `contents/style/bundle.css.minify.json`.


4.  Use the minified file in your project without the postfix, e.g.:
    ```html
    <link rel="stylesheet" href="style/bundle.css"/>
    <script src="script/bundle.js"></script>
    ```


License
-------

&copy; Copyright 2017 Hazem AbuMostafa.

This project is subject to the [Apache License, Version 2.0](http://apache.org/licenses/LICENSE-2.0.html).
