class AdminsBackoffice::QuestionsController < AdminsBackofficeController

  before_action :set_question_id, only: [:edit, :update, :destroy]
  before_action :get_topics, only: [:new, :edit]

  def index
    # Making Question recognize topics {.include(:topic)}
    @questions = Question.includes(:topic).order(:description).page(params[:page]).per(5)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params_question_permited)
    if @question.save
      redirect_to admins_backoffice_questions_path, notice: "Pergunta cadastrado com sucesso!"
    else 
      render :new
    end    
  end

  def edit    
  end

  def update       
    if @question.update(params_question_permited)
      redirect_to admins_backoffice_questions_path, notice: "Pergunta atualizado com sucesso!"
    else 
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to admins_backoffice_questions_path, notice: "Pergunta removida!"
    else 
      render :index
    end
  end

  private

  def params_question_permited
    params.require(:question).permit(:description, :topic_id)
  end

  def set_question_id
    @question = Question.find(params[:id])
  end

  def get_topics
    @topics = Topic.all
  end

end

