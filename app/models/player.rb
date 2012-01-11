class Player < ActiveRecord::Base
  has_many :games, :dependent => :destroy

  def three_dart_average
    self.games.average(:three_dart_average)
  end
end
