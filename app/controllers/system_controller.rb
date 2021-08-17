class SystemController < ApplicationController

  before_action :authenticate_uber!

  before_action :set_class_records, except: [:index, :dashboard]
  before_action :set_statuses, except: [:index, :dashboard]
  before_action :set_status, except: [:index, :dashboard]
  before_action :set_records, except: [:index, :dashboard]

  def index
    records = User.where(admin: true)
    @mods = records.where(role: 'mod')
    @supers = records.where(role: 'super')
    @ubers = records.where(role: 'uber')
  end

  def companies
  end

  def chiefs
  end

  def reviews
  end

  def users
  end

  def dashboard
    @data = Company.system_user_graph_data
  end

  private

  def set_class_records
    case action_name
    when 'companies'
      @class_records = Company.all
    when 'reviews'
      @class_records = Review.all
    when 'chiefs'
      @class_records = Chief.all
    when 'users'
      @class_records = User.all
    end
  end

  def set_status
    @status = params[:status] || 'Approved'
  end

  def set_statuses
    @statuses = %w(Approved Awaiting Denied)
  end

  def set_records
    case @status
    when 'Approved'
      @pagy, @records = pagy(@class_records.where(approved: true))
    when 'Awaiting'
      @pagy, @records = pagy(@class_records.where(approved: false, denied: false))
    when 'Denied'
      @pagy, @records = pagy(@class_records.where(denied: true))
    end
  end
end
