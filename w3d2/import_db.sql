-- IF EXISTS for all of the drops
DROP TABLE users;
DROP TABLE questions;
DROP TABLE replies;
DROP TABLE question_follows;
DROP TABLE question_likes;

CREATE TABLE users (
  id integer primary key autoincrement,
  fname string NOT NULL, -- VARCHAR(255)
  lname string NOT NULL -- VARCHAR(255)
);

INSERT INTO users (fname, lname) VALUES ('Jenny', 'Heath');
INSERT INTO users (fname, lname) VALUES ('Eric', 'Ashmore');
INSERT INTO users (fname, lname) VALUES ('CJ', 'Avilla');

CREATE TABLE questions (
  id integer primary key autoincrement,
  title string NOT NULL, -- VARCHAR(255)
  body string NOT NULL, -- TEXT
  author_id integer NOT NULL references users(id)
);

INSERT INTO questions (title, body, author_id) VALUES ('SQL question', 'How do you create a join table?', 1);
INSERT INTO questions (title, body, author_id) VALUES ('Sour patch', 'Where are all the sour patch parents?', 2);
-- INSERT INTO questions (title, body, author_id) VALUES ('Snickers', 'Do we really have to write another question?', 2);

CREATE TABLE question_follows (
  id integer primary key autoincrement,
  user_id integer NOT NULL references questions(id),
  question_id integer NOT NULL references users(id)
);

INSERT INTO question_follows (user_id, question_id) VALUES (1, 2);
INSERT INTO question_follows (user_id, question_id) VALUES (2, 2);
INSERT INTO question_follows (user_id, question_id) VALUES (2, 1);

CREATE TABLE replies (
  id integer primary key autoincrement,
  question_id integer NOT NULL references questions(id),
  parent_id integer references replies(id),
  user_id integer NOT NULL references users(id),
  body string NOT NULL -- TEXT
);

INSERT INTO replies (question_id, parent_id, user_id, body) VALUES (2, NULL, 2, 'CJ ate them');
INSERT INTO replies (question_id, parent_id, user_id, body) VALUES (2, 1, 1, 'Eric ate them');

CREATE TABLE question_likes (
  id integer primary key autoincrement,
  user_id integer NOT NULL references users(id),
  question_id integer NOT NULL references questions(id)
);

INSERT INTO question_likes (user_id, question_id) VALUES (1, 2);
INSERT INTO question_likes (user_id, question_id) VALUES (2, 2);
INSERT INTO question_likes (user_id, question_id) VALUES (2, 1);
