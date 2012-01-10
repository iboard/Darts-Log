class GamesController < ApplicationController
  
  def index
    if params[:player_id]
      @player = Player.find(params[:player_id])
      @games = @player.games.all
    else
      @games = Game.all
    end
    respond_to do |format|
        format.html {}
        format.csv {
          send_data games_to_csv, :filename => 'darts.csv', :dipatch => :download
        }
      end
  end

private
  def games_to_csv
    _columns=[:sets,:legs,:doubles_hit,:three_dart_average,:highest_throw,:highest_checkout,:count_180,:count_140,:count_100,:count_60]
    "Game-UID;Date;Game;" + _columns.map{|c| c.to_s.humanize }.join(";") + "\n" +
    @games.map { |game| 
      _record = [
        game.upload_id,
        game.created_at.strftime("%Y-%m-%d %H:%M"),
        game.game,
        game.player.name
      ]
      _columns.each do |key|
        _record << game.send(key).to_s
      end
      _record.join(";")
    }.join("\n")
  end
end
