-- Before we fixed it, unit stats were shared across all players.
-- Therefore we prune all such achievements (easier to just exclude the ones not affected)
delete from player_achievements where id not in (
    'c6e6039f-c543-424e-ab5f-b34df1336e81',
    'd5c759fe-a1a8-4103-888d-3ba319562867',
    '6a37e2fc-1609-465e-9eca-91eeda4e63c4',
    'bd12277a-6604-466a-9ee6-af6908573585',
    '805f268c-88aa-4073-aa2b-ea30700f70d6'
)