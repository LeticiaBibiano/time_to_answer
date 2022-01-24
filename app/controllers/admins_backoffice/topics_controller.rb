class AdminsBackoffice::TopicsController < AdminsBackofficeController

  before_action :set_topic_id, only: [:edit, :update, :destroy]

  def index
    @topics = Topic.all.order(:description).page(params[:page]).per(5)
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params_topic_permited)
    if @topic.save
      redirect_to admins_backoffice_topics_path, notice: "Tópico/Assunto cadastrado com sucesso!"
    else 
      render :new
    end    
  end

  def edit    
  end

  def update       
    if @topic.update(params_topic_permited)
      redirect_to admins_backoffice_topics_path, notice: "Tópico/Assunto atualizado com sucesso!"
    else 
      render :edit
    end
  end

  def destroy
    if @topic.destroy
      redirect_to admins_backoffice_topics_path, notice: "Tópico/Assunto removido!"
    else 
      render :index
    end
  end

  private

  def params_topic_permited
    params.require(:topic).permit(:description)
  end

  def set_topic_id
    @topic = Topic.find(params[:id])
  end

end
