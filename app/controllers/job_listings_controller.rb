class JobListingsController < ApplicationController

  def index
  end

  def company
    @company = Company.find_by(name: params[:company_name])
    @jobs = @company.job_listings
  end

end
