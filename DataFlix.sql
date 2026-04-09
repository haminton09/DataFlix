CREATE TABLE movies (
    id VARCHAR2(20) PRIMARY KEY,
    title VARCHAR2(255),
    release_year NUMBER,
    runtime_minutes NUMBER
);

CREATE TABLE people (
    id VARCHAR2(20) PRIMARY KEY,
    name VARCHAR2(255),
    birth_year NUMBER
);

CREATE TABLE movie_participation (
    movie_id VARCHAR2(20),
    person_id VARCHAR2(20),
    role VARCHAR2(50),
    CONSTRAINT pk_movie_participation PRIMARY KEY (movie_id, person_id),
    CONSTRAINT fk_mp_movie FOREIGN KEY (movie_id) REFERENCES movies(id),
    CONSTRAINT fk_mp_person FOREIGN KEY (person_id) REFERENCES people(id)
);

CREATE TABLE genres (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100)
);

CREATE TABLE movie_genres (
    movie_id VARCHAR2(20),
    genre_id NUMBER,
    CONSTRAINT pk_movie_genres PRIMARY KEY (movie_id, genre_id),
    CONSTRAINT fk_mg_movie FOREIGN KEY (movie_id) REFERENCES movies(id),
    CONSTRAINT fk_mg_genre FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE ratings (
    movie_id VARCHAR2(20) PRIMARY KEY,
    average_rating NUMBER(3,1),
    vote_count NUMBER,
    CONSTRAINT fk_ratings_movie FOREIGN KEY (movie_id) REFERENCES movies(id)
);

CREATE TABLE releases (
    movie_id VARCHAR2(20) PRIMARY KEY,
    release_date DATE,
    is_new NUMBER(1),
    CONSTRAINT fk_releases_movie FOREIGN KEY (movie_id) REFERENCES movies(id)
);

CREATE TABLE recommendations (
    id NUMBER PRIMARY KEY,
    movie_id VARCHAR2(20),
    score NUMBER(5,2),
    reason VARCHAR2(100),
    CONSTRAINT fk_recommendations_movie FOREIGN KEY (movie_id) REFERENCES movies(id)
);

CREATE TABLE lists (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    description VARCHAR2(255)
);

CREATE TABLE lists (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    description VARCHAR2(255)
);

CREATE TABLE list_items (
    list_id NUMBER,
    movie_id VARCHAR2(20),
    position NUMBER,
    CONSTRAINT pk_list_items PRIMARY KEY (list_id, movie_id),
    CONSTRAINT fk_li_list FOREIGN KEY (list_id) REFERENCES lists(id),
    CONSTRAINT fk_li_movie FOREIGN KEY (movie_id) REFERENCES movies(id)
);

CREATE TABLE trends (
    movie_id VARCHAR2(20),
    trend_date DATE,
    ranking NUMBER,
    CONSTRAINT pk_trends PRIMARY KEY (movie_id, trend_date),
    CONSTRAINT fk_trends_movie FOREIGN KEY (movie_id) REFERENCES movies(id)
);

CREATE INDEX idx_movies_title ON movies(title);
CREATE INDEX idx_ratings_score ON ratings(average_rating);
CREATE INDEX idx_trends_date ON trends(trend_date);
CREATE INDEX idx_recommendations_score ON recommendations(score);
