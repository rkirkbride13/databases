TRUNCATE TABLE artists RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES ('ABBA', 'Pop');

INSERT INTO albums (title, release_year, artist_id) VALUES ('Surfer Rosa', '1988', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Super Trooper', '1980', '2');