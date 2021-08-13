class ChiefsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_mod!, only: [:approve, :deny]
  before_action :set_chief, except: [:new]
  before_action :set_company, only: [:new]
  
  def show
  end

  def new
    @chief = @company.chiefs.new
  end

  def create
    @chief = Chief.new(chief_params)
    if @chief.save
      set_flash_message(:success, ["Thank you for creating new Leadership for #{@chief.company.name}!", 'Leadership Submitted For Approval'])
      redirect_to company_path(@chief.company)
    else
      set_flash_message(:error, @chief.errors.full_messages)
      redirect_back fallback_location: root_path
    end
  end

  def approve
    @chief.update(approved: true, denied: false)
    set_flash_message(:success, 'Chief Approved')
    redirect_back fallback_location: root_path
  end

  def deny
    @chief.update(approved: false, denied: true)
    set_flash_message(:success, 'Chief Denied')
    redirect_back fallback_location: root_path
  end

  private

  def set_chief
    @chief = Chief.find_by(id: params[:id])
    # TODO handle not found
  end

  def set_company
    @company = Company.find_by(id: params[:company_id])
  end

  def chief_params
    params.require(:chief).permit(
      :title,
      :company_id,
      :first_name,
      :last_name,
      :created_by
    )
  end
end
