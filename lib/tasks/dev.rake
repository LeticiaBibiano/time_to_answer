namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    %x(rails db:drop)
    %x(rails db:create)
    %x(rails db:migrate)
    %x(rails dev:add_default_admin)
    %x(rails dev:add_extra_admin)
    %x(rails dev:add_default_user)
  end

  desc "Add default administrator"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: '123admin',
      password_confirmation: '123admin'
    )
  end

  desc "Add extra admins"
  task add_extra_admin: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Add default user"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: '123user',
      password_confirmation: '123user'
    )
  end

end
