# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths << Rails.root.join('lib/assets')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.

#/app/assets
Rails.application.config.assets.precompile += %w( admins_backoffice.js admins_backoffice.scss
                                                  users_backoffice.js users_backoffice.scss 
                                                  admins_devise.js admins_devise.scss )

#/lib/assets
Rails.application.config.assets.precompile += %w( sb-admin-2.js sb-admin.css
                                                  gentelella.js 
                                                  gentelella.min.css gentelella.min.js
                                                  img.jpg )

#/vendor/assets
# Rails.application.config.assets.precompile += %w( jquery-2.2.4/dist/jquery.jsist/jquery.js )
                                                 
