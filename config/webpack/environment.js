const { environment } = require('@rails/webpacker')
const customConfig = require('./custom.js');
const webpack = require('webpack');

environment.plugins.append(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    // jQuery: 'jquery-2.2.4/dist/jquery.jsist/jquery',
    Popper: ['popper.js', 'default']
  })
);
environment.config.merge(customConfig);

module.exports = environment
