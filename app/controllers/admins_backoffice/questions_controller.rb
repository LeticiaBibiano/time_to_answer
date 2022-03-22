class AdminsBackoffice::QuestionsController < AdminsBackofficeController

  before_action :set_question_id, only: [:edit, :update, :destroy]
  before_action :get_topics, only: [:new, :edit]

  def index
    # Making Question recognize topics {.include(:topic)}
    @topic_form = TopicForm.new(form_params)
    if @topic_form.valid?
      @questions =
        Question
          .includes(:topic)
          .where(conditions_hash)
          .where(conditions_date)
          .where("description LIKE '%#{form_params[:description]}%'")
          .order(:description)
          .page(params[:page])
          .per(5)
    else
      @questions =
        Question
          .includes(:topic)
          .order(:description)
          .page(params[:page])
          .per(5)
      flash[:notice] = 'Campos inválidos. Tente novamente'
      render :index
    end
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
    params.require(:question).permit(:description, :topic_id,
      answer_attributes: [:id, :description, :correct, :_destroy])
  end

  def set_question_id
    @question = Question.find(params[:id])
  end

  def get_topics
    @topics = Topic.all
  end

  def conditions_hash
    {}.tap do |hash|
      hash[:topic_id] = form_params[:topic_id] if form_params[:topic_id].present?
    end
  end

  def conditions_date
    conditions = []
    conditions << "created_at >= '#{form_params[:initial_date].to_date}'" if form_params[:initial_date].present?
    conditions << "created_at <= '#{form_params[:final_date].to_date}'" if form_params[:final_date].present?
    conditions.join(' AND ')
  end

  def form_params
    params.fetch(:topic_form, {})
  end
end

