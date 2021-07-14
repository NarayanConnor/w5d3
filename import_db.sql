-- let's make a tableee
PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL,
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL

    FOREIGN KEY  (author_id) REFERENCES users(id)
);


CREATE TABLE question_follows (
    
    list INTEGER PRIMARY KEY
    --question_follows INTEGER
    user_q_follows INTEGER
    


    --FOREIGN KEY (question_follows) REFERENCES users(id)
    FOREIGN KEY (user_q_follows) REFERENCES questions(id)

);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    reply_Q INTEGER NOT NULL,
    reply_OWN INTEGER NOT NULL,
    reply_PAR INTEGER ,
    body TEXT NOT NULL,

    FOREIGN KEY (reply_Q) REFERENCES questions(id)
    FOREIGN KEY (reply_OWN) REFERENCES users(id)
    FOREIGN KEY (reply_PAR) REFERENCES replies(id)
);

CREATE TABLE question_likes (
    user_like BOOLEAN,
    user INTEGER NOT NULL,
    question INTEGER NOT NULL,

    FOREIGN KEY (user) REFERENCES questions(id)
    FOREIGN KEY (question) REFERENCES users(id)

);



INSERT INTO 
    users (fname,lname)
VALUES
    ('Mace','Windu')
    ('Obiwan','Kenobi'),
    ('Darth','Vader');

INSERT INTO
    questions (title,body,author_id)
VALUES
    ('Batlle tactics on mustafar','Did you know i had the high ground?', (SELECT id FROM users WHERE fname = 'Obiwan' AND lname = 'Kenobi'));

INSERT INTO
    question_follows(user_q_follows)
VALUES
    ((SELECT id FROM users WHERE fname = 'Obiwan' AND lname = 'Kenobi')),
    ((SELECT id FROM users WHERE fname = 'Darth' AND lname = 'Vader')),
    ((SELECT id FROM users WHERE fname = 'Mace' AND lname = 'Windu')),

