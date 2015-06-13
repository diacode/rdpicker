# rdpicker - React Date Picker

Rdpicker is a simple and lightway React component to select dates (datepicker). It's already being used in production by [Gudog](https://gudog.co.uk), however it's still under heavy development.

## Features

* Two selection modes: single and multiple (for non consecutive dates)
* Dialog mode for mobile devices
* Easy internationalization
* Customizable with SCSS variables.

## Dependencies

Rdpicker depends on the following packages:

* [React.js](https://facebook.github.io/react/)
* [moment.js](http://momentjs.com/)

Note these packages are not included in the final javascript file ('./dist/rdpicker'), you'll need to include them yourself.

## Development

* Development server `npm run dev`.
* Build `npm run build`;

Source code is written in CoffeeScript with [coffee-react](https://github.com/jsdf/coffee-react) and [webpack](http://webpack.github.io/docs/).

## TODO

* Bower package
* Document properties
* Live demo
* Tests !_!
