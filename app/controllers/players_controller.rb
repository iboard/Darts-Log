class PlayersController < ApplicationController
  def index
    @players = Player.order("name asc").includes(:games)
  end

  def show
    @player = Player.find(params[:id])
  end

end
