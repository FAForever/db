-- Before we fixed it, unit stats were shared across all players.
-- Therefore we prune all such events (easier to just exclude the ones not affected)
delete from player_events where id not in (
    'cfa449a6-655b-48d5-9a27-6044804fe35c',
    '4a929def-e347-45b4-b26d-4325a3115859'
)