class Admin::UsersController < ApplicationController
  before_filter :restrict_access
  before_filter :admin_only

    def index
      @users = User.all
    end

end
