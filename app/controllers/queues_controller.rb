class QueuesController < ApplicationController

  before_action :authenticate_mod!
  before_action :set_queue_types, only: [:index]
  before_action :set_queue_variables, only: [:index]
  before_action :set_queue_partial, only: [:index]

  def index
    items = @klass.get_queue_items
    @total = items.count
    @pagy, @items = pagy(items, items: 30)
  end

  private

  def set_queue_types
    @review_types = ['Review Queue', 'Company Queue', 'Chief Queue']
  end

  def set_queue_variables
    @queue_type = params[:queue_type] || @review_types.first.parameterize.underscore
    @selected_queue = @queue_type.titleize
    @klass = @selected_queue.split(' ').first.constantize
  end

  def set_queue_partial
    @review_types.each do |review_type|
      if review_type == @selected_queue
        @partial = "queues/queue/#{@queue_type}"
      end
    end
  end
end
