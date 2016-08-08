-- First, set a default date for all maps
update map_version set create_time = '2013-01-01 00:00:00', update_time = '2013-01-01 00:00:00';

-- Then, set creation_time and update_time of maps to when the map was first played.
-- Maps that do not have an entry in game_stats keep the default date.
update map_version v
    join (select min(startTime) as startTime,
                 mapId
            from game_stats
           group by mapId
          ) as r
       on r.mapId = v.id
  set  v.create_time = r.startTime, v.update_time = r.startTime;