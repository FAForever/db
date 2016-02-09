UPDATE `achievement_definitions` set
    revealed_icon_url = CONCAT('http://content.faforever.com/achievements/', id, '.png'),
    unlocked_icon_url = CONCAT('http://content.faforever.com/achievements/', id, '.png');