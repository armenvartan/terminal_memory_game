DROP TABLE IF EXISTS scores;

CREATE TABLE scores (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user VARCHAR,
  score INTEGER NOT NULL,
  game_mode VARCHAR,
  timer INTEGER,
  created_at DATETIME DEFAULT current_timestamp
);
