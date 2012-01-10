class PlayersController < ApplicationController
  def index
    @players = Player.order("name asc")
  end

  def show
    @player = Player.find(params[:id])
  end

end
