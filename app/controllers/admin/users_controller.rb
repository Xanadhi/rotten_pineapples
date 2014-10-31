class Admin::UsersController < ApplicationController
  before_filter :restrict_access
  before_filter :admin_only

    def index
      @users = User.order("firstname").page(params[:page]).per(5)
    end

    def new
      @user = User.new
    end

    def create
      params[:admin] == 1 ? params[:admin] = true : false
    
      @user = User.new(user_params)

      if @user.save
        redirect_to admin_users_path, notice: "You've created a user called #{@user.firstname}."
      else
        render :new
      end
    end

    def show
      @user = User.find(params[:id])
    end

    def edit
    end

    def destroy
    end


    protected

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
    end

end
