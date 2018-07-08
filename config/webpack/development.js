const environment = require('./environment')
const webpack = require('webpack')

environment.plugins.append(
  'EnvironmentPlugin',
  new webpack.EnvironmentPlugin({
    NODE_ENV: 'development',
    ROOT_URL: 'http://localhost:3000/'
  })
)

module.exports = environment.toWebpackConfig()
