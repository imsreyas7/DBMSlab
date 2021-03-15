drop table SungBy;
drop table Artist;
drop table Song;
drop table Album;
drop table Studio;
drop table Musician;

REM create musician;
CREATE TABLE Musician 
(
	Mus_ID NUMBER(3) CONSTRAINT id_pk PRIMARY KEY,
	Mus_name VARCHAR2(25) CONSTRAINT name_null NOT NULL,
	Mus_birthplace VARCHAR2(25) 
);

REM create studio;
CREATE TABLE Studio
(
	Studio_name VARCHAR2(25) CONSTRAINT std_name_pk PRIMARY KEY,
	Studio_addr VARCHAR2(30) ,
	Studio_Phone NUMBER(10)
);

REM create album;
CREATE TABLE Album
(
	album_name VARCHAR2(25) CONSTRAINT album_null NOT NULL,
	album_ID NUMBER(3) CONSTRAINT a_id_pk PRIMARY KEY,
	year_of_release NUMBER(4) CONSTRAINT Album_release_check CHECK ( year_of_release > 1945),
	no_of_tracks NUMBER(3) CONSTRAINT no_of_tracks_null NOT NULL,
	stud_name VARCHAR2(25) CONSTRAINT stud_fk REFERENCES Studio(Studio_name) ,
	album_genre VARCHAR2(20) CONSTRAINT al_genre_restriction CHECK (album_genre in ('CAR','DIV','MOV','POP')),
	musician_id NUMBER(3) CONSTRAINT mus_id_fk REFERENCES Musician(Mus_ID)  
);

REM cretae song;
CREATE TABLE Song
(
	alb_ID NUMBER(3) CONSTRAINT a_id_fk REFERENCES Album(album_ID) ,
	track_no NUMBER(3) ,
	Song_name VARCHAR2(25) CONSTRAINT sname_null NOT NULL,
	Song_len NUMBER(3) ,
	Song_genre VARCHAR2(25) CONSTRAINT song_genre_restriction CHECK(Song_genre in ('PHI','REL','LOV','DEV','PAT')),
	CONSTRAINT song_alid_track_pk PRIMARY KEY (alb_ID,track_no),
	CONSTRAINT song_len_check_7 CHECK(Song_len >= 7 AND Song_genre='PAT') 
);


REM create artist;
CREATE TABLE Artist
(
	artist_ID NUMBER(3) CONSTRAINT art_id_pk PRIMARY KEY,
	artist_name VARCHAR2(25) CONSTRAINT art_name_null NOT NULL
);

REM create sungby
CREATE TABLE SungBy
(
	al_ID NUMBER(3) ,
	ar_ID NUMBER(3) CONSTRAINT ar_id_fk REFERENCES Artist(artist_ID),
	track NUMBER(3) ,
	recording_date DATE,
	CONSTRAINT al_id_fk FOREIGN KEY (al_ID,track) REFERENCES Song(alb_ID,track_no) ,
	CONSTRAINT Sung_by_pk PRIMARY KEY (al_ID,ar_ID,track)
);

REM populating tables

INSERT INTO studio VALUES ('AVM' , 'Chennai', 1234567890);
INSERT INTO studio VALUES ('2D', 'Hyderabad' , 1111111111);
INSERT INTO studio VALUES ('3D', 'Delhi', 3333333333);

INSERT INTO artist VALUES (1, 'Joe');
INSERT INTO artist VALUES (2, 'Ame');
INSERT INTO artist VALUES (3, 'Bigil');

INSERT INTO musician VALUES (1, 'Rahman', 'Chennai');
INSERT INTO musician VALUES (2, 'Eminem', 'America');
INSERT INTO musician VALUES (3, 'Emily', 'UK');

INSERT INTO album VALUES (1,'Jazzy Music', '19-JUL-2000',5,'AVM','POP',1);
INSERT INTO album VALUES (2,'Movie Music', '22-OCT-2000',7,'2D','MOV',2);
INSERT INTO album VALUES (3,'Diverse Music', '11-MAY-1950',3,'3D','DIV',3);

INSERT INTO song VALUES (1,1,'Bigilu Bigilu', 8, 'PAT');
INSERT INTO song VALUES (2,2,'Verithanam', 11, 'LOV');
INSERT INTO song VALUES (3,3,'Agni Siragey', 9, 'PHI');

INSERT INTO sungby VALUES (1,1,1,'19-JUL-2000');
INSERT INTO sungby VALUES (2,2,2,'22-OCT-2000');
INSERT INTO sungby VALUES (3,3,3,'11-MAY-1950');

SELECT * FROM artist;
SELECT * FROM musician;
SELECT * FROM studio;
SELECT * FROM album;
SELECT * FROM song;
SELECT * FROM sungby;


	


