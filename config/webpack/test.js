process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
  jasmineRequire: 'jasmine-core/lib/jasmine-core/jasmine.js',
}))

module.exports = environment.toWebpackConfig()
