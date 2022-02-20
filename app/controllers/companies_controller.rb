class CompaniesController < ApplicationController

  include Pagy::Backend
  helper Pagy::Frontend

  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_super!, only: [:edit, :update]
  before_action :authenticate_mod!, only: [:approve, :deny]
  before_action :authenticate_uber!, only: [:destroy]
  before_action :set_company, only: [:show, :edit, :update, :deny, :approve]
  before_action :sort_reviews, only: [:show, :approve, :deny]

  def index
    @pagy, @companies = pagy(Company.where(approved: true), items: 6)
  end

  def show
    @data = Darwinable.calculate_company(@company) unless request.format.to_s.include?('turbo-stream')
    @pagy, @reviews = pagy(@reviews, items: 6)
    respond_to do |f|
      f.turbo_stream
      f.html
    end
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
    @company = Company.new(company_params)
    if @company.save
      set_flash_message(:success, 'Created Company')
      redirect_to company_path(@company)
    else
      set_flash_message(:error, @company.errors.full_messages)
      render :new
    end
  end

  def approve
    @company.update(approved: true, denied: false)
    set_flash_message(:success, 'Company Approved')
    redirect_to company_path(@company, format: :html)
  end

  def deny
    @company.update(approved: false, denied: true)
    set_flash_message(:success, 'Company Denied')
    redirect_to company_path(@company, format: :html)
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :about,
      :employee_count,
      :founded,
      :industry,
      :website,
      :created_by
    )
  end

  def set_company
    @company = Company.find_by(id: params[:id])
    if @company.nil?
      flash[:notice] = 'Cannot Find Company'
      redirect_back fallback_location: root_path
    end
  end

  def sort_reviews
    @sort = params[:sort]
    if @sort
      Rails.cache.write(:company_reviews_sort, @sort)
    else
      @sort = Rails.cache.read(:company_reviews_sort)
    end
    case @sort
    when 'old_to_new'
      @reviews = @company.approved_reviews.order(created_at: :desc)
    when 'new_to_old'
      @reviews = @company.approved_reviews.order(created_at: :asc)
    when 'highest_rated'
      @reviews = @company.approved_reviews.order(overall_rating: :desc)
    when 'most_helpful'
      @reviews = @company.approved_reviews.order(thumbs: :desc)
    else
      @sort = 'new_to_old'
      # Default new_to_old
      @reviews = @company.approved_reviews.order(created_at: :asc)
    end
  end

end
