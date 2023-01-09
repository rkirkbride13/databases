TRUNCATE TABLE albums RESTART IDENTITY;
TRUNCATE TABLE artists RESTART IDENTITY;


INSERT INTO albums (title, release_year, artist_id) VALUES ('Surfer Rosa', '1988', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Super Trooper', '1980', '2');

INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES ('ABBA', 'Pop');