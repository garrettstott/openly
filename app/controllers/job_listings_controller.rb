class JobListingsController < ApplicationController

  before_action :set_company, only: [:company]

  def index
    @jobs = JobListing.all
  end

  def company
    @jobs = @company.job_listings
  end

  private

  def set_company
    @company = Company.find_by(name: params[:company_name])
  end

end
