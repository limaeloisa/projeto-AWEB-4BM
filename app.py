from flask import Flask, render_template, request, flash, redirect, url_for
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

# Conectar ao banco de dados
def conectar_bd():
    try:
        cnx = mysql.connector.connect(
            user='root',
            password='1406',
            host='127.0.0.1',
            database='sistemablog'
        )
        return cnx
    except Error as e:
        print("Erro ao conectar:", e)
        return None

# Página inicial
@app.route('/')
def index():
    cnx = conectar_bd()
    posts = []
    if cnx:
        cursor = cnx.cursor(dictionary=True)
        cursor.execute("SELECT * FROM posts WHERE ativo = TRUE ORDER BY criado_em DESC")
        posts = cursor.fetchall()
        cursor.close()
        cnx.close()
    return render_template('index.html', posts=posts)

# Detalhes do post
@app.route('/post/<slug>')
def detalhe(slug):
    cnx = conectar_bd()
    post = None
    if cnx:
        cursor = cnx.cursor(dictionary=True)
        cursor.execute("SELECT p.*, c.nome as categoria FROM posts p LEFT JOIN categorias c ON p.categoria_id = c.id WHERE p.slug = %s AND p.ativo = TRUE", (slug,))
        post = cursor.fetchone()
        cursor.close()
        cnx.close()
    
    if not post:
        return render_template('404.html'), 404
    
    return render_template('detalhe.html', post=post)

# Páginas por categoria
@app.route('/historia')
def historia():
    cnx = conectar_bd()
    posts = []
    if cnx:
        cursor = cnx.cursor(dictionary=True)
        cursor.execute("SELECT p.*, c.nome as categoria FROM posts p LEFT JOIN categorias c ON p.categoria_id = c.id WHERE c.nome = 'história' AND p.ativo = TRUE ORDER BY p.criado_em DESC", ())
        posts = cursor.fetchall()
        cursor.close()
        cnx.close()
    return render_template('historia.html', posts=posts, titulo='História')

@app.route('/lendas')
def lendas():
    cnx = conectar_bd()
    posts = []
    if cnx:
        cursor = cnx.cursor(dictionary=True)
        cursor.execute("SELECT p.*, c.nome as categoria FROM posts p LEFT JOIN categorias c ON p.categoria_id = c.id WHERE c.nome = 'lendas' AND p.ativo = TRUE ORDER BY p.criado_em DESC", ())
        posts = cursor.fetchall()
        cursor.close()
        cnx.close()
    return render_template('lendas.html', posts=posts, titulo='Lendas')

@app.route('/turismo')
def turismo():
    cnx = conectar_bd()
    posts = []
    if cnx:
        cursor = cnx.cursor(dictionary=True)
        cursor.execute("SELECT p.*, c.nome as categoria FROM posts p LEFT JOIN categorias c ON p.categoria_id = c.id WHERE c.nome = 'turismo' AND p.ativo = TRUE ORDER BY p.criado_em DESC", ())
        posts = cursor.fetchall()
        cursor.close()
        cnx.close()
    return render_template('turismo.html', posts=posts, titulo='Turismo')

@app.route('/cultura')
def cultura():
    cnx = conectar_bd()
    posts = []
    if cnx:
        cursor = cnx.cursor(dictionary=True)
        cursor.execute("SELECT p.*, c.nome as categoria FROM posts p LEFT JOIN categorias c ON p.categoria_id = c.id WHERE c.nome = 'cultura' AND p.ativo = TRUE ORDER BY p.criado_em DESC", ())
        posts = cursor.fetchall()
        cursor.close()
        cnx.close()
    return render_template('cultura.html', posts=posts, titulo='Cultura')

@app.route('/pau-brasil')
def pau_brasil():
    cnx = conectar_bd()
    posts = []
    if cnx:
        cursor = cnx.cursor(dictionary=True)
        cursor.execute("SELECT p.*, c.nome as categoria FROM posts p LEFT JOIN categorias c ON p.categoria_id = c.id WHERE c.nome = 'pau-brasil' AND p.ativo = TRUE ORDER BY p.criado_em DESC", ())
        posts = cursor.fetchall()
        cursor.close()
        cnx.close()
    return render_template('pau-brasil.html', posts=posts, titulo='Pau Brasil')

# Sobre
@app.route('/sobre')
def sobre():
    return render_template('sobre.html')

# 404
@app.errorhandler(404)
def nao_encontrado(error):
    return render_template('404.html'), 404

if __name__ == '__main__':
    app.run(debug=True)
