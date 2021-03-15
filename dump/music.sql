DROP TABLE sungby;
DROP TABLE song;
DROP TABLE artist;
DROP TABLE album;
DROP TABLE studio;
DROP TABLE musician;


REM ARTIST TABLE CREATION

CREATE TABLE artist(
	artist_id NUMBER(5) CONSTRAINT artist_id_pk PRIMARY KEY,
	artist_name VARCHAR2(30) CONSTRAINT artist_name_uk UNIQUE
	);

REM STUDIO TABLE CREATION

CREATE TABLE studio(
	studio_name VARCHAR2(30) CONSTRAINT name_pk PRIMARY KEY,
	address VARCHAR2(50),
	phone NUMBER(10)
	);

REM MUSICIAN TABLE CREATION

CREATE TABLE musician(
	musician_id NUMBER(5) CONSTRAINT musician_id_pk PRIMARY KEY,
	musician_name VARCHAR2(30),
	birthplace VARCHAR2(30)
	);

REM ALBUM TABLE CREATION

CREATE TABLE album(
	album_id NUMBER(5) CONSTRAINT album_id_pk PRIMARY KEY,
	album_name VARCHAR2(30),
	rel_year DATE CONSTRAINT year_gt_1945 CHECK (EXTRACT(YEAR FROM(rel_year)) >= 1945),
	no_of_tracks NUMBER(2) CONSTRAINT no_of_tracks_nn NOT NULL,
	studio VARCHAR(30),
	album_genre CHAR(3) CONSTRAINT album_genre_chk CHECK(album_genre IN('CAR','DIV','MOV','POP')),
	musician NUMBER(5) CONSTRAINT musician_fk REFERENCES musician(musician_id) ON DELETE CASCADE,
	CONSTRAINT studio_fk FOREIGN KEY(studio) REFERENCES studio(studio_name) ON DELETE CASCADE
	);

REM SONG TABLE CREATION

CREATE TABLE song(
	album_id NUMBER(5), 
	track_no NUMBER(2),
	song_name VARCHAR2(30),
	song_length NUMBER(4,2),
	song_genre VARCHAR2(3) CONSTRAINT song_genre_chk CHECK(song_genre IN ('PHI','REL','LOV','DEV','PAT')),
	CONSTRAINT song_pk PRIMARY KEY (album_id, track_no),
	CONSTRAINT album_fk FOREIGN KEY(album_id) REFERENCES album(album_id) ON DELETE CASCADE,
	CONSTRAINT song_pat_length CHECK (song_length > 7 AND song_genre IN ('PAT') OR song_genre in ('PHI', 'REL', 'LOV', 'DEV') )
	);

REM SUNGBY TABLE CREATION

CREATE TABLE sungby(
	track_no NUMBER(5),
	album_id NUMBER(5),
	artist_id NUMBER(5),
	record_date DATE,
	CONSTRAINT artist_id_fk FOREIGN KEY (artist_id) REFERENCES artist(artist_id) ON DELETE CASCADE,
	CONSTRAINT track_no_album_id_fk FOREIGN KEY (track_no, album_id) REFERENCES song(track_no, album_id) ON DELETE CASCADE,
	CONSTRAINT sungby_pk PRIMARY KEY (album_id , artist_id, track_no)
	);
    

INSERT INTO artist VALUES (1, 'Joe');
INSERT INTO artist VALUES (2, 'Ame');
INSERT INTO artist VALUES (3, 'Bigil');

INSERT INTO musician VALUES (1, 'Rahman', 'Chennai');
INSERT INTO musician VALUES (2, 'Eminem', 'America');
INSERT INTO musician VALUES (3, 'Emily', 'UK');

INSERT INTO studio VALUES ('AVM' , 'Chennai', 1234567890);
INSERT INTO studio VALUES ('2D', 'Hyderabad' , 1111111111);
INSERT INTO studio VALUES ('3D', 'Delhi', 3333333333);

INSERT INTO album VALUES (1,'Jazzy Music', '19-JUL-2000',5,'AVM','POP',1);
INSERT INTO album VALUES (2,'Movie Music', '22-OCT-2000',7,'2D','MOV',2);
INSERT INTO album VALUES (3,'Diverse Music', '11-MAY-1950',3,'3D','DIV',3);

INSERT INTO song VALUES (1,1,'Bigilu Bigilu', 7.25, 'PAT');
INSERT INTO song VALUES (2,2,'Verithanam', 3.50, 'LOV');
INSERT INTO song VALUES (3,3,'Agni Siragey', 4.25, 'PHI');

INSERT INTO sungby VALUES (1,1,1,'19-JUL-2000');
INSERT INTO sungby VALUES (2,2,2,'22-OCT-2000');
INSERT INTO sungby VALUES (3,3,3,'11-MAY-1950');

SELECT * FROM artist;
SELECT * FROM musician;
SELECT * FROM studio;
SELECT * FROM album;
SELECT * FROM song;
SELECT * FROM sungby;


REM 10)It is necessary to represent the gender of an artist in the table
ALTER TABLE artist ADD gender CHAR(1);

REM 11)The first few words of the lyrics constitute the song name. 
REM The song name do not accommodate some of the words (in lyrics).
ALTER TABLE song MODIFY song_name VARCHAR2(50);

REM 12)The phone number of each studio should be different.
ALTER TABLE studio ADD CONSTRAINT ph_uk UNIQUE(phone);

REM 13)An artist who sings a song for a particular track of an album can not be recorded
REM without the record_date.

ALTER TABLE sungby MODIFY (record_date NOT NULL);

REM 14)It was decided to include the genre NAT for nature songs.

ALTER TABLE song DROP CONSTRAINT song_genre_chk;
ALTER TABLE song DROP CONSTRAINT song_pat_length;
ALTER TABLE song ADD CONSTRAINT song_genre_chk CHECK(song_genre IN ('PHI','REL','LOV','DEV','PAT','NAT'));
ALTER TABLE song ADD CONSTRAINT song_pat_length CHECK(song_length > 7  AND song_genre IN ('PAT') OR song_genre IN ('PHI','REL','LOV','DEV','NAT'));

REM 15)Due to typo­error, there may be a possibility of false information. Hence while 
REM deleting the song information, make sure that all the corresponding information are 
REM also deleted.

REM Problem already taken care of while adding ON DELETE CASCADE constraint to the FOREIGN KEYS


REM Violating Constraints
INSERT INTO artist VALUES (4, 'Bigil','M');
INSERT INTO artist VALUES (1, 'Chinnarasu', 'M');

INSERT INTO musician VALUES (2, 'Rahman', 'Madurai');

INSERT INTO studio VALUES ('AVM', 'Kodambakkam', 00000000000);
INSERT INTO studio VALUES ('4D', 'Bangalore' , 1111111111);

INSERT INTO album VALUES(4,'Rock Music', '19-JUL-1944',2,'AVM','DIV',3);
INSERT INTO album VALUES(4,'Rock Music', '19-JUL-1946',2,'AVM','QQQ',3);
INSERT INTO album VALUES(4,'Rock Music', '19-JUL-1947',2,'AVM','DIV',6);

INSERT INTO sungby VALUES(5,5,5,'19-JUL-2000');
INSERT INTO sungby(track_no, album_id, artist_id) VALUES(2,1,3);

INSERT INTO song VALUES(5,5,'Mental Manadhil', 4.00, 'REL');
INSERT INTO song VALUES(2,2,'Mental Manadhil', 4.00, 'NAT');
INSERT INTO song VALUES(2,3,'Mental Manadhil', 4.30, 'PAT');
INSERT INTO song VALUES(2,4,'Mental Manadhil', 4.00, 'NAY');