const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  'window.jQuery': 'jquery',
  Popper: ['popper.js', 'default'],
  moment: 'moment'
}))

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
  jasmineRequire: 'jasmine-core/lib/jasmine-core/jasmine.js',
}))

module.exports = environment
environment.resolvedModules.append('project root', '.');
