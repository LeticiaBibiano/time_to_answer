class AdminsBackoffice::AdminsController < AdminsBackofficeController

  before_action :check_password, only: [:update]
  before_action :set_admin_id, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.all.page(params[:page]).per(5)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_adm_permited)
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Administrador cadastrado com sucesso!"
    else 
      render :new
    end    
  end

  def edit
    
  end

  def update       
    if @admin.update(params_adm_permited)
      redirect_to admins_backoffice_admins_path, notice: "Administrador atualizado com sucesso!"
    else 
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Administrador removido!"
    else 
      render :index
    end
  end

  private

  def params_adm_permited
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def set_admin_id
    @admin = Admin.find(params[:id])
  end

  def check_password
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)    
    end
  end

end
