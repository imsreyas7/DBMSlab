ALTER TABLE Artist
ADD (gender char(1));


ALTER TABLE Song
DROP CONSTRAINT sname_null;

ALTER TABLE Song
MODIFY (Song_name VARCHAR2(70) CONSTRAINT sname_null NOT NULL);



ALTER TABLE Studio
ADD CONSTRAINT ph_un
UNIQUE (Studio_Phone);



ALTER TABLE SungBy
MODIFY (recording_date DATE CONSTRAINT rdate_null NOT NULL);



ALTER TABLE Song
DROP CONSTRAINT song_genre_restriction;

ALTER TABLE Song
MODIFY (Song_genre VARCHAR2(25) CONSTRAINT song_genre_restriction CHECK (Song_genre in ('PHI','REL','LOV','DEV','PAT','NAT')) );


ALTER TABLE SungBy
DROP CONSTRAINT al_id_fk;

ALTER TABLE SungBy
ADD CONSTRAINT al_id_fk FOREIGN KEY (al_ID,track) REFERENCES Song(alb_ID,track_no) ON DELETE CASCADE;