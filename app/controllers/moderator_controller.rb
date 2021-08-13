class ModeratorController < ApplicationController

  before_action :authenticate_mod!

  def index
  end

end
