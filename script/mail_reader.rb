#!/usr/bin/env ruby

# script/mailman_server
#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require File::expand_path("../../config/mailconfig.rb", __FILE__)
require File::expand_path("../../lib/darts.rb", __FILE__)
require "mailman"

Mailman.config.poll_interval = 15 if ENV['RAILS_ENV'] != 'production'
Mailman.config.logger = Logger.new("log/mailman.log")
Mailman.config.pop3 = {
  server: MAILSERVER[:server], 
  port: MAILSERVER[:port], 
  ssl: MAILSERVER[:ssl],
  username: MAILSERVER[:user],
  password: MAILSERVER[:password]
}

Mailman::Application.run do
  default do
    begin
      Mailman.logger.info "PROCESSING MAIL FROM #{message.from}"

      _message = [ "","",
          "From " + message.from.first + " " + message.date.to_s, 
          "From: " + message.from.first,
          "Subject: " + message.subject,
          "Date: " + message.date.to_s,
          ""].join("\n")
      _body = ""
      message.parts.each do |p|
        Mailman.logger.info "MESSAGE PART " + p.inspect + "\n"
        if p.content_type =~ /text\/plain/
          _body << p.body.decoded
        else
          Mailman.logger.info "IGNORING PART " + p.inspect
        end
      end
      _body += message.body.decoded if _body.blank?
      _message += _body

      parser = EmailReader.new(_message)
      if parser.games.first 
        _uploader_id = Digest::MD5.hexdigest(parser.games.first[:from])
        _upload_id   = Digest::MD5.hexdigest(parser.games.first[:from] + parser.games.first[:date] + parser.to_csv)
        parser.games.each_with_index do |game,idx|
          player_a = Player.find_or_create_by_name_and_uploader_id( name: game[:player_1].to_s.humanize,
                                             uploader_id: _uploader_id )
          player_b = Player.find_or_create_by_name_and_uploader_id( name: game[:player_2].to_s.humanize,
                                             uploader_id: _uploader_id )
          game_a = player_a.games.find_or_create_by_upload_id(upload_id: _upload_id)
          game_b = player_b.games.find_or_create_by_upload_id(upload_id: _upload_id)
          [ [game_a, game[:player_1]],
            [game_b, game[:player_2]]
          ].each do |_game,player|
            _game.update_attributes(
              {
                game: game[:player_1].to_s.humanize + " vs. " + game[:player_2].to_s.humanize,
                sets: game[player]['Sets'],
                legs: game[player]['Legs'],
                best_winning_leg: game[player]['Best Winning Leg'].to_i,
                three_dart_average: game[player]['3 Dart Average'].to_f,
                highest_checkout: game[player]['Highest Checkout'].to_i,
                highest_throw: game[player]['Highest Throw'].to_i,
                doubles_hit: game[player]['Doubles Hit'].gsub(/[\(\)\%]/,'').to_i,
                count_180: game[player]['count_180'.to_sym].to_i,
                count_140: game[player]['count_140'.to_sym].to_i,
                count_100: game[player]['count_100'.to_sym].to_i,
                count_60:  game[player]['count_60'.to_sym].to_i
              }
            )
          end
        end
      else
        Mailman.logger.info "COULD NOT INTERPRET MAIL #{message.inspect}"
        Mailman.logger.info "INTERPRETER MESSAGE WAS #{_message.inspect}"
      end
    rescue Exception => e
      Mailman.logger.error "Exception occurred while receiving message:\n#{message}"
      Mailman.logger.error [e, *e.backtrace].join("\n")
    end
  end
end
