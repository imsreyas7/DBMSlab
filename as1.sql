REM ********************************************************************
REM 		UCS 1412 - DATABASE LAB | IV SEMESTER
REM 		EX : 1 DDL QUERIES FOR MUSIC STORE
REM 									
REM ********************************************************************


DROP TABLE sungby;
DROP TABLE song;
DROP TABLE album;
DROP TABLE artist;
DROP TABLE studio;
DROP TABLE musician;


REM ARTIST TABLE CREATION

CREATE TABLE artist(
	artist_id 	NUMBER(5)
	CONSTRAINT artist_id_pk PRIMARY KEY,
	artist_name 	VARCHAR2(30) 
	CONSTRAINT artist_name_uk UNIQUE
	);

DESC artist;

REM STUDIO TABLE CREATION

CREATE TABLE studio(
	studio_name 	VARCHAR2(30)
	CONSTRAINT name_pk PRIMARY KEY,
	address		VARCHAR2(50),
	phone 		NUMBER(10)
	);

DESC studio;

REM MUSICIAN TABLE CREATION

CREATE TABLE musician(
	musician_id 	NUMBER(5) 
	CONSTRAINT musician_id_pk PRIMARY KEY,
	musician_name 	VARCHAR2(30),
	birthplace 	VARCHAR2(30)
	);

DESC musician;

REM ALBUM TABLE CREATION

CREATE TABLE album(
	album_id 	NUMBER(5) 
	CONSTRAINT album_id_pk PRIMARY KEY,
	album_name 	VARCHAR2(30),
	rel_year DATE 
	CONSTRAINT year_gt_1945 CHECK (EXTRACT(YEAR FROM(rel_year)) >= 1945),
	no_of_tracks 	NUMBER(2) 
	CONSTRAINT no_of_tracks_nn NOT NULL,
	studio 		VARCHAR(30),
	album_genre 	CHAR(3) 
	CONSTRAINT album_genre_chk CHECK(album_genre IN('CAR',	'DIV',	'MOV',	'POP')),
	musician 	NUMBER(5) 
	CONSTRAINT musician_fk REFERENCES musician(musician_id),
	CONSTRAINT studio_fk FOREIGN KEY(studio) REFERENCES studio(studio_name)
	);

DESC album;

REM SONG TABLE CREATION

CREATE TABLE song(
	album_id 	NUMBER(5), 
	track_no 	NUMBER(2),
	song_name 	VARCHAR2(30),
	song_length 	NUMBER(4,2),
	song_genre 	VARCHAR2(3) 
	CONSTRAINT song_genre_chk CHECK(song_genre IN ('PHI',	'REL',	'LOV',	'DEV',	'PAT')),
	CONSTRAINT song_pk PRIMARY KEY (album_id, track_no),
	CONSTRAINT album_fk FOREIGN KEY(album_id) REFERENCES album(album_id),
	CONSTRAINT song_pat_length CHECK (song_genre NOT IN ('PAT') OR song_length>7)
	);

DESC song;

REM SUNGBY TABLE CREATION

CREATE TABLE sungby(
	album_id 	NUMBER(5),
	track_no 	NUMBER(5),
	artist_id 	NUMBER(5),
	record_date 	DATE,
	CONSTRAINT artist_id_fk FOREIGN KEY (artist_id) REFERENCES artist(artist_id),
	CONSTRAINT album_id_track_no_fk FOREIGN KEY (album_id, track_no) REFERENCES song(album_id, track_no),
	CONSTRAINT sungby_pk PRIMARY KEY (album_id , artist_id, track_no)
	);

DESC sungby;   

REM ********************************************************************
REM 					INSERTION OF VALUES
REM ********************************************************************

INSERT INTO artist VALUES	(1, 
							'Joe'
							);

INSERT INTO artist VALUES	(2,
							'Ame'
							);

INSERT INTO artist VALUES	(3, 	
							'Vishal'
							);

INSERT INTO artist VALUES	(4, 	
							'Vikram'
							);

INSERT INTO artist VALUES	(5, 	
							'Aaron'
							);


INSERT INTO musician VALUES	(1, 
							'Rahman',
							'Chennai'
							);

INSERT INTO musician VALUES	(2, 
							'Eminem',
							'America'
							);


INSERT INTO musician VALUES	(3,
							'Emily',
							'UK'
							);
	
INSERT INTO musician VALUES	(4,
							'Aaron',
							'UK'
							);

INSERT INTO musician VALUES	(5,
							'Weron',
							'UK'
							);


INSERT INTO studio VALUES	('AVM',
							'Chennai',
							1234567890
							);
INSERT INTO studio VALUES	('2D', 	
							'Hyderabad',
							1111111111
							);

INSERT INTO studio VALUES	('3D',
							'Delhi',
							3333333333
							);

INSERT INTO studio VALUES	('4D',
							'Rome',
							2222222222
							);

INSERT INTO studio VALUES	('5D', 	
							'Delhi', 	
							4444444444
							);


INSERT INTO album VALUES	(1,
							'Jazzy Music', 		
							'19-JUL-2000',	
							5,	
							'AVM',	
							'POP',	
							1
							);

INSERT INTO album VALUES	(2,	
							'Movie Music', 		
							'22-OCT-2000',	
							7,	
							'2D',	
							'MOV',	
							2
							);

INSERT INTO album VALUES	(3,	
							'Diverse Music', 	
							'11-MAY-1950',	
							3,	
							'3D',	
							'DIV',	
							3
							);

INSERT INTO album VALUES	(4,	
							'New Music', 		
							'14-MAY-1975',	
							6,	
							'4D',	
							'DIV',	
							4
							);

INSERT INTO album VALUES	(5,	
							'Old Music', 		
							'29-JUN-1980',	
							3,	
							'5D',	
							'DIV',	
							5
							);


INSERT INTO song VALUES	(1,	
						1,	
						'Song11', 	
						7.25, 	
						'PAT'
						);

INSERT INTO song VALUES	(2,	
						1,	
						'Song12', 	
						8.25, 	
						'PAT'
						);

INSERT INTO song VALUES	(1,	
						2,	
						'Song21', 	
						4.50, 	
						'PHI'
						);

INSERT INTO song VALUES	(2,	
						2,	
						'Song22', 	
						3.50, 	
						'LOV'
						);

INSERT INTO song VALUES	(1,	
						3,	
						'Song31', 	
						4.25, 	
						'PHI'
						);

INSERT INTO song VALUES	(3,	
						3,	
						'Song33', 	
						4.25, 	
						'PHI'
						);


INSERT INTO sungby VALUES	(1,	
							1,	
							1,	
							'19-JUL-2000'
							);

INSERT INTO sungby VALUES	(1,	
							1,	
							2,	
							'22-OCT-2000'
							);

INSERT INTO sungby VALUES	(1,
							2,	
							1,	
							'11-MAY-1950'
							);

INSERT INTO sungby VALUES	(2,	
							2,	
							1,	
							'08-FEB-1950'
							);

INSERT INTO sungby VALUES	(2,	
							2,	
							2,	
							'21-FEB-1950'
							);

INSERT INTO sungby VALUES	(3,	
							3,	
							3,	
							'21-FEB-1950'
							);



REM ********************************************************************
REM 						TABLE CONTENTS
REM ********************************************************************
SELECT * FROM artist;
SELECT * FROM musician;
SELECT * FROM studio;
SELECT * FROM album;
SELECT * FROM song;
SELECT * FROM sungby;


REM ********************************************************************
REM 					VIOLATING SOME CONSTRAINTS
REM ********************************************************************


INSERT INTO song VALUES	(2,	
						3,	
						'Song23',	 
						4.30, 	
						'PAT'
						);

INSERT INTO song VALUES	(2,	
						4,	
						'Song24',	 
						4.00, 	
						'REL'
						);

SELECT * FROM song;
SELECT * FROM sungby;

REM REMOVAL OF EXISTING RECORD
DELETE FROM song WHERE album_id = 1 AND track_no = 1;


SELECT * FROM song;
SELECT * FROM sungby;


INSERT INTO sungby VALUES	(5,	
							5,	
							5,	
							'19-JUL-2000'
							);

UPDATE 	sungby 
SET 	album_id = 5 
WHERE	track_no = 1 AND artist_id = 1;
REM FOREIGN KEY CONSTRAINT VIOLATION

UPDATE 	sungby
SET 	track_no = 2
WHERE 	album_id = 1 AND artist_id = 1;
REM PRIMARY KEY CONSTRAINT VIOLATION

UPDATE 	sungby
SET 	album_id = 2 
WHERE 	track_no = 1 AND artist_id = 1;
REM INSERTED BECAUSE SUCH AN ALBUM_ID, TRACK_NO COMBINATION EXISTS IN THE SONG TABLE WITHOUT ANY EXISTING REFERENCES IN THE SUNGBY TABLE


REM REMOVAL OF EXISTING RECORD
DELETE FROM song where album_id = 2;


REM CHECKING THE RELATIONSHIP BETWEEN THE VARIOUS FOREIGN KEY-PRIMARY KEY OF CORRESPONDING RELATIONS
DELETE FROM album where album_id = 1;
DELETE FROM album where album_id = 5;

DELETE FROM song where album_id = 3;

REM REMOVAL OF EXISTING RECORD
DELETE FROM song where album_id = 1;

REM REMOVAL OF EXISTING RECORD
DELETE FROM sungby where album_id = 3;

REM REMOVAL OF EXISTING RECORD
DELETE FROM song where album_id = 3;



REM ********************************************************************
REM 					ALTER TABLE QUERIES
REM ********************************************************************

REM 10)It is necessary to represent the gender of an artist in the table

ALTER TABLE artist ADD gender CHAR(1);

INSERT INTO artist VALUES	(6, 	
							'Vikraman'
							);

REM 11)The first few words of the lyrics constitute the song name. 
REM The song name do not accommodate some of the words (in lyrics).

ALTER TABLE song MODIFY song_name VARCHAR2(50);


REM 12)The phone number of each studio should be different.

ALTER TABLE studio ADD CONSTRAINT ph_uk UNIQUE(phone);

INSERT INTO studio VALUES	('6D', 	
							'Bangalore', 	
							1111111111
							);

REM 13)An artist who sings a song for a particular track of an album can not be recorded
REM without the record_date.

ALTER TABLE sungby MODIFY (record_date NOT NULL);

INSERT INTO sungby	(track_no, 
					album_id, 
					artist_id) 
			VALUES	(3,	
					3,	
					3
					);

REM 14)It was decided to include the genre NAT for nature songs.

ALTER TABLE song DROP CONSTRAINT song_genre_chk;

ALTER TABLE song ADD CONSTRAINT song_genre_chk 
CHECK(song_genre IN ('PHI',	'REL',	'LOV',	'DEV',	'PAT',	'NAT'));

INSERT INTO song VALUES(4,	3,	'Song43', 	4.00, 	'NAT');

REM 15)Due to typo error, there may be a possibility of false information. Hence while 
REM deleting the song information, make sure that all the corresponding information are 
REM also deleted.

ALTER TABLE sungby DROP CONSTRAINT album_id_track_no_fk;

ALTER TABLE sungby ADD	CONSTRAINT album_id_track_no_fk 
						FOREIGN KEY(album_id, track_no) 
						REFERENCES song(album_id, track_no) ON DELETE CASCADE;


SELECT * FROM song;
SELECT * FROM sungby;

REM REMOVAL OF EXISTING RECORD, TO CHECK THE EFFECT OF ON DELETE CASCADE
DELETE FROM song WHERE album_id = 1 AND track_no = 1;

SELECT * FROM song;
SELECT * FROM sungby;


REM ********************************************************************
REM 					END OF SCRIPT FILE
REM ********************************************************************