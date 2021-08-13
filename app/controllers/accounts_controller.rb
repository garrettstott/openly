class AccountsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_uber!, only: [:admin_show]

  def show
    @user = current_user
  end

  def admin_show
    @user = User.find_by(id: params[:id])
    render :show
  end
end
