class CompaniesController < ApplicationController

  before_action :set_company, only: [:show, :edit, :update, :deny, :approve]
  before_action :authenticate_super!, only: [:edit, :update]
  before_action :authenticate_mod!, only: [:approve, :deny]

  def index
    @pagy, @companies = pagy(Company.where(approved: true), items: 6)
  end

  def show
  end

  def edit
  end

  def update
    if @company.update(company_params)
      set_flash_message(:success, 'Updated Company')
      redirect_to edit_company_path(@company)
    else
      set_flash_message(:error, @company.errors.full_messages)
      render :edit
    end
  end

  def new
    @company = Company.new
  end

  def create
    # TODO
  end

  def approve
    @company.update(approved: true, denied: false)
    set_flash_message(:success, 'Company Approved')
    redirect_back fallback_location: root_path
  end

  def deny
    @company.update(approved: false, denied: true)
    set_flash_message(:success, 'Company Denied')
    redirect_back fallback_location: root_path
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
    )
  end
  def set_company
    @company = Company.find_by(id: params[:id])
    if @company.nil?
      flash[:notice] = 'Cannot Find Company'
      redirect_back fallback_location: root_path
    end
  end

end
