module Darts

  def self.header(game)
    header = []
    player = game[:player_1]
    data   = game[player]
    data.each do |k,v|
      if k == "Score Table"
        header << "180"
        header << "140"
        header << "100"
        header << "60"
      else
        header << k.to_s.humanize
      end
    end
    header
  end

  class Parser
    def initialize(_input)
      @lines = _input.split(/\n/).map(&:strip)
      parse!
    end

    def games
      @games
    end

  private
    # Sets - 26g 0, nil 0
    # Legs - 26g 1, nil 0
    # 3 Dart Average - 26g 24.4%, nil 0.3%
    # Doubles Hit - 26g 1/75 (1%), nil 0/74 (0%)
    # Highest Checkout - 26g 2, nil 0
    # Highest Throw - 26g 75, nil 18
    # 26g Score Table - 0x180s, 0x140s, 0x100s, 3x60s
    # nil Score Table - 0x180s, 0x140s, 0x100s, 0x60s
    # Best Winning Leg - 26g 112 darts, nil 0 darts
    def parse!
      filter_lines
      @games = []
      @lines.each do |line|
        if line =~ /^From / || (!@game && line =~ /^From:/)
          start_new_game(line)
        else
          append_to_game(line) if @game
        end
      end
      finish_game
    end

  protected
    def append_to_game(line)
      @game[:data] ||= []
      if line =~ /^From / || line =~ /From:/
        @game[:from] = line.gsub(/^From /,'').split(/ /)[1]
      elsif line =~ /^Subject:/
        @game[:subject] = line.gsub(/^Subject: /,'')
      elsif line =~ /^Date:/
        @game[:date] = line.gsub(/^Date: /,'')
      elsif line =~ /Score Table/
        append_score_table(line)
      else
        _label, _data = line.split(/ \- /).map(&:strip)
        unless _label.nil? || _label.blank?
          _data.split(/,/).map(&:strip).each do |player| 
            _player,_record = case _label
            when 'Doubles Hit'
              [player.split(/ /)[0..-3].join(" "),
               player.split(/ /)[-1]]
            when 'Best Winning Leg'
              [player.split(/ /)[0..-3].join(" "),
              player.split(/ /)[-2]]
            else
              [player.split(/ /)[0..-2].join(" "),
              player.split(/ /)[-1].gsub(/%$/,'')]
            end
            @game[:player_1] ||= _player.underscore.to_sym
            if @game[:player_1] != _player.underscore.to_sym
              @game[:player_2] ||= _player.underscore.to_sym
            end
            @game[_player.underscore.to_sym] ||= {}
            @game[_player.underscore.to_sym][_label] = _record
          end
        end
      end
    end

    def start_new_game(line)
      finish_game
      @game = { from: line.split(/ /)[1], date: Time.now.to_s, 
         from_id: Digest::MD5.hexdigest(line.downcase.split(/ /)[1].strip),
         data: {} }
    end

    def finish_game
      return unless @game
      @games << @game
      @game = nil
    end

    def append_score_table(line)
      _data = line.split(/ Score Table -/).map(&:strip)
      player = _data[0]
      d = _data[1].split(/,/).map(&:strip)
      label = %W(180 140 100 60)
      d.map!{|x| x.gsub(/x[124068]+s/,'')}.each_with_index do |v,i|
        @game[player.underscore.to_sym] ||= {}
        @game[player.underscore.to_sym][label[i].to_sym]= d[i]
      end
    end

    def filter_lines
      @lines = @lines.select do |line| 
        (line =~ /^From / || line =~ /^From: / ||
         line =~ /^Subject:/ ||
         line =~ /^Date:/ ||
         line =~ /^Sets/ ||
         line =~ /^Legs/ ||
         line =~ /^3 Dart Average/ ||
         line =~ /^Doubles Hit/ ||
         line =~ /^Highest Checkout/ ||
         line =~ /^Highest Throw/ ||
         line =~ /Score Table \-/ ||
         line =~ /^Best Winning Leg/) &&
        line !~ /\<html/i
      end
    end
  end
end


