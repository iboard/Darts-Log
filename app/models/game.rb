class Game < ActiveRecord::Base
  belongs_to :player

  default_scope order("games.created_at desc, upload_id asc, sets desc, legs desc")
end
