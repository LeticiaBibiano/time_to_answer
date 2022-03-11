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


  desc "Adiciona perguntas e respostas"
  task add_answers_and_questions: :environment do
    Topic.all.each do |topic|
      rand(5..10).times do |i|
        params = create_questions_params(topic)
        answers_array = params[:question][:answers_attributes]
        add_answers(answers_array)
        Question.create!(params[:question])
      end
    end
  end

  private

  def create_questions_params(topic = Topic.all.sample)
    { question: {
      description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
      topic: topic,
      answers_attributes: []
      }
    }
  end

  def create_answer_params(correct = false)
    { description: Faker::Lorem.sentence, correct: correct }
  end

  def add_answers(answers_array = [])
    rand(2..5).times do |j|
      answers_array.push(create_answer_params)
    end
  end
end
