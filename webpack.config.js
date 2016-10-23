/* jshint node: true */
var path = require('path');
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = {
  context: path.join(__dirname),
  entry: ['babel-plugin-transform-object-assign', './lib/index.js'],

  output: {
    path: path.join(__dirname) + '/dist',
    filename: 'rdpicker.js',
    libraryTarget: 'umd',
    library: 'Rdpicker'
  },

  externals: {
   'react': 'var React',
   'react-dom': 'var ReactDOM',
   'react/addons': 'var React',
   'moment': 'var moment'
  },

  module: {
    loaders: [
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract("style-loader", "css-loader!sass-loader")
      },
      {
        test: /\.cjsx$/,
        exclude: /(node_modules|bower_components)/,
        loaders: ["babel?plugins=transform-object-assign", "coffee", "cjsx"],
      },
      { test: /\.coffee$/,   loader: "coffee-loader"}
    ]
  },
  // Use the plugin to specify the resulting filename (and add needed behavior to the compiler)
  plugins: [
    new ExtractTextPlugin("rdpicker.css")
  ]
};
