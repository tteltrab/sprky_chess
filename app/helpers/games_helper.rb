module GamesHelper
  def player_email_from_id(player_id)
    player = Player.find(player_id)
    player.email
  end
end
