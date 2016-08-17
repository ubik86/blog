class StatsController < ApplicationController
  before_action :set_stats
  before_action :authenticate_user!

  def index
  end

  def show
  end


  private
  def set_stats
    @stats = {
      yearly: '',
      monthly: ''
    }
  end
end
