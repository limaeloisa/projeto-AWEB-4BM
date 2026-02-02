comandos usados no banco:

SHOW DATABASES;
CREATE DATABASE sistemablog;
USE sistemablog;

CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    author VARCHAR(150) NOT NULL,
    date DATE NOT NULL,
    image VARCHAR(255) NOT NULL
);

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100)
);

SELECT * FROM usuarios;
SELECT * FROM posts;

----------------------------------
bootstrap navbar:
https://getbootstrap.com/docs/5.0/components/navbar/

bootstrap cards:
https://getbootstrap.com/docs/5.0/components/card/

bootstrap head:
https://getbootstrap.com/docs/5.0/examples/