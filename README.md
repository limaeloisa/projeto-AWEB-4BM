# 🌊 Pureza - Site Turístico com Banco de Dados para projeto final da matéria Autoria Web.
Um site informativo sobre o município fictício de Pureza com **histórias, lendas, turismo e cultura**, desenvolvido com **Flask** e **MySQL**.
#Scripts mais utilizados:

SHOW DATABASES;
USE sistemablog;
-- adicionar categorias
SELECT * FROM categorias;
INSERT INTO categorias (id, nome) VALUES (1, 'História');
INSERT INTO categorias (id, nome) VALUES (2, 'Lendas');
INSERT INTO categorias (id, nome) VALUES (3, 'Turismo');
INSERT INTO categorias (id, nome) VALUES (4, 'Cultura');
INSERT INTO categorias (id, nome) VALUES (5, 'Pau Brasil');

-- EXEMPLO de como adicionar um post: POST NA CATEGORIA HISTÓRIA
INSERT INTO posts (titulo, slug, descricao, conteudo, imagem, categoria_id, autor_id, criado_em, ativo) 
VALUES (
  'Fundação de Pureza',
  'fundacao-de-pureza',
  'Conheça a história da fundação do município de Pureza e seus primeiros habitantes.',
  '<h2>A Fundação de Pureza</h2>
<p>Pureza foi fundada em meados do século XIX, nascendo de uma pequena comunidade de agricultores e criadores de gado.</p>
<p>O município ganhou seu nome por sua água cristalina e seu caráter puro, refletindo os valores da comunidade.</p>
<h3>Os Primeiros Anos</h3>
<p>Nos primeiros anos, a economia era baseada principalmente na agricultura e na pecuária. A população era pequena, mas unida.</p>',
  'https://via.placeholder.com/600x400?text=Fundacao+Pureza',
  1,
  1,
  NOW(),
  TRUE
);
-- Adicionar os autores
SELECT * FROM autores;
INSERT INTO autores (id, nome, email)
VALUES (1, 'Eloisa Lima', 'mariaeloisaaxr@gmail.com');
INSERT INTO autores (id, nome, email)
VALUES (2, 'Giovanna Oliveira', 'o.giovanna@escolar.ifrn.edu.br');
INSERT INTO autores (id, nome, email)
VALUES (3, 'Saul Reis', 'reis.s@escolar.ifrn.edu.br');

-- Verificar os dados inseridos:
SELECT p.id, p.titulo, p.slug, c.nome as categoria, p.criado_em, p.ativo
FROM posts p
LEFT JOIN categorias c ON p.categoria_id = c.id
ORDER BY p.criado_em DESC;

