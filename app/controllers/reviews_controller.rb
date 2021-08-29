class ReviewsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_mod!, only: [:show, :approve, :deny]
  before_action :set_company, only: [:new, :create]
  before_action :set_review, except: [:new, :create]

  def show
  end

  def new
    @review = Review.new(
      company_id: @company.id,
      user_id: current_user.id,
      chief_id: params[:chief_id]
    )
    set_ratings
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      set_flash_message(:success, ['Thank you for your review!', 'Your review has been submitted for approval.'])
      if @review.chief.present?
        redirect_to chief_path(@review.chief)
      else
        redirect_to company_path(@review.company)
      end
    else
      set_flash_message(:error, @review.errors.full_messages)
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      set_flash_message(:success, ['Thank you for your review!', 'Your review has been submitted for approval.'])
      render :edit
    else
      set_flash_message(:error, @review.errors.full_messages)
      render :edit
    end
  end

  def approve
    @review.update(approved: true, denied: false)
    set_flash_message(:success, 'Review Approved')
    redirect_to review_path(@review)
  end

  def deny
    np = note_params
    if np && np[:message].present?
      note = @review.notes.new(note_params)
      if note.style == 'denial_reason'
        @review.update(denied: true, approved: false)
        set_flash_message(:success, 'Review Denied')
        redirect_to review_path(@review)
      else
        set_flash_message(:error, 'Please use "Denial Reason" for the note')
        render :show
      end
    else
      set_flash_message(:error, 'Please include a note for your denial')
      render :show
    end
  end

  private

  def note_params
    params.require(:review).require(:note).permit(
      :message,
      :style
    )
  end

  def review_params
    params.require(:review).permit(
      :message,
      :company_id,
      :user_id,
      :chief_id,
      ratings_attributes: [:score, :id, :style]
    )
  end

  def set_review
    @review = Review.find_by(id: params[:id])
    if @review.nil?
      flash[:notice] = 'Cannot Find Review'
      redirect_back fallback_location: root_path
    end
  end

  def set_company
    @company = Company.find_by(id: params[:company_id])
    if @company.nil?
      flash[:notice] = 'Cannot Find Company'
      redirect_back fallback_location: root_path
    end
  end

  def set_ratings
    Rating.styles.values.each do |style|
      @review.ratings << Rating.new(
        style: style,
        score: 1,
      )
    end
  end
end
