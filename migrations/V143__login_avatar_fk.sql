-- Add a single "currently selected avatar" reference on the login table.
-- The legacy `avatars.selected` flag is kept (and still user-writable) for
-- backwards compatibility; the API mirrors both sides on writes and exposes a
-- reconciler to repair any drift.

ALTER TABLE login
  ADD COLUMN avatar_id int(11) unsigned DEFAULT NULL,
  ADD CONSTRAINT fk_login_avatar
    FOREIGN KEY (avatar_id) REFERENCES avatars_list (id)
    ON DELETE SET NULL ON UPDATE CASCADE;

-- Backfill from the legacy selected flag.
UPDATE login l
  JOIN avatars a ON a.idUser = l.id AND a.selected = 1
SET l.avatar_id = a.idAvatar;
