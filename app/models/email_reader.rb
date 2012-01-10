require 'darts'

class EmailReader
  attr_reader :filename
  
  def self.from_file(filename)
    _f = File.open(filename,'r')
    if _f
      _input = _f.read
      _f.close
    end
    raise "No Data found #{filename}" unless _input
    EmailReader.new(_input)
  end

  def initialize(_data)
    @filename = nil
    @input = _data
    parse!
  end

  def games
    @games.sort do |a,b|
      Time.parse(a[:date]) <=> Time.parse(b[:date])
    end
  end

  def to_csv
    lines = []
    lines << "Date;Game;Player;" + Darts::header(games.first).join(";")
    games.each do |game|
      [game[:player_1],game[:player_2]].each do |player|
        line = []
        line << Time.parse(game[:date]).strftime("%Y-%m-%d %H:%M")
        line << game[:player_1].to_s.humanize + " vs. " + game[:player_2].to_s.humanize
        line << player.to_s.humanize
        game[player].each do |k,v|
          line << v.to_s.gsub(/[\(\)%]/,'')
        end
        lines << line.join(";")
      end
    end
    lines.join("\n")
  end

  def length
    @input.length
  end

private
  def parse!
    @parser ||= Darts::Parser.new(@input)
    @games  ||= @parser.games
  end
end