from flask import Flask, render_template, request, redirect, url_for, flash, session
from mysql.connector import connect, Error

app = Flask(__name__)
app.secret_key = "chave_secreta"

# Função para conectar ao banco
def ConectarBD():
    try:
        cnx = connect(
            user='root',
            password='labinfo',
            host='127.0.0.1',
            database='pygreen2'
        )
        return cnx
    except Error as e:
        print("Erro ao conectar no banco:", e)
        return None

@app.route('/')
def index():
    cnx = ConectarBD()
    posts = []
    if cnx:
        cursor = cnx.cursor()
        cursor.execute("SELECT * FROM Posts WHERE Status='Publicado' ORDER BY Data_Publicacao DESC")
        posts = cursor.fetchall()
        cursor.close()
        cnx.close()
    categorias = buscar_categorias()
    return render_template('index.html', posts=posts, categorias=categorias)

def buscar_categorias():
    cnx = ConectarBD()
    categorias = []
    if cnx:
        cursor = cnx.cursor()
        cursor.execute("SELECT * FROM Categorias")
        categorias = cursor.fetchall()
        cursor.close()
        cnx.close()
    return categorias

if __name__ == '__main__':
    app.run(debug=True)
