SELECT u.user_id, u.first_name, u.last_name, count(r.room_id)
FROM   users u
JOIN   castles c ON u.user_id = c.user_id
JOIN   rooms r ON c.castle_id = r.castle_id
GROUP  BY u.user_id, u.first_name, u.last_name, c.castle_id