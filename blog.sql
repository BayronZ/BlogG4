-- Requerimientos
\c mrcoco
DROP DATABASE blog;
-- 1. Crear base de datos llamada blog.
CREATE DATABASE blog;
\c blog
-- 2. Crear las tablas indicadas de acuerdo al modelo de datos.
CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    email VARCHAR(59) NOT NULL UNIQUE
);

\copy usuario FROM 'usuarios.csv' csv header;

CREATE TABLE post(
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL REFERENCES usuario(id),
    título VARCHAR(100)NOT NULL UNIQUE,
    fecha DATE NOT NULL
);

\copy post FROM 'post.csv' csv header;
SELECT * FROM post;

CREATE TABLE comentario(
    id SERIAL PRIMARY KEY,
    post_id INT NOT NULL REFERENCES post(id),
    usuario_id INT NOT NULL REFERENCES usuario(id),
    texto VARCHAR(30) NOT NULL,
    fecha DATE NOT NULL
);

\copy comentario FROM 'comentarios.csv' csv header;
SELECT * FROM comentario;
-- 3. Insertar los siguientes registros.
-- 4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT usuario.email, post.id, post.título
FROM usuario
JOIN post
ON usuario.id = post.usuario_id
WHERE usuario.id = 5;
-- 5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados
-- por el usuario con email usuario06@hotmail.com.
SELECT usuario.email, comentario.id, comentario.texto
FROM usuario
JOIN comentario
ON usuario.id = comentario.usuario_id
WHERE usuario.email != 'usuario06@hotmail.com';

-- 6. Listar los usuarios que no han publicado ningún post.
SELECT *
FROM usuario
LEFT JOIN post
ON usuario.id = post.usuario_id
WHERE post.usuario_id IS NULL;
-- 7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen
-- comentarios).

-- 8. Listar todos los usuarios que hayan publicado un post en Junio.
