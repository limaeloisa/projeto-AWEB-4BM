from flask import Flask, render_template, request, redirect, url_for, flash
from mysql.connector import connect, Error

app = Flask(__name__)

# Conectar ao banco de dados
def conectar_bd():
    try:
        cnx = connect(
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
    letras = []
    if cnx:
        cursor = cnx.cursor(dictionary=True)  # <-- importante
        cursor.execute("SELECT * FROM letras ORDER BY data_criacao DESC")
        letras = cursor.fetchall()
        cursor.close()
        cnx.close()
    return render_template('index.html', letras=letras)

# Adicionar letra
@app.route('/letra/nova')
def nova_letra():
    return render_template('nova_letra.html')

@app.route('/salvar-letra', methods=['POST'])
def salvar_letra():
    titulo = request.form['titulo']
    artista = request.form['artista']
    letra = request.form['letra']
    
    cnx = conectar_bd()
    if cnx:
        cursor = cnx.cursor()
        cursor.execute(
            "INSERT INTO letras (titulo, artista, letra) VALUES (%s, %s, %s)",
            (titulo, artista, letra)
        )
        cnx.commit()
        cursor.close()
        cnx.close()
        flash('Letra adicionada!', 'success')
        return redirect(url_for('index'))
    
    flash('Erro ao adicionar', 'danger')
    return redirect(url_for('nova_letra'))

# Ver letra
@app.route('/letra/<int:id>')
def ver_letra(id):
    cnx = conectar_bd()
    letra = None
    if cnx:
        cursor = cnx.cursor()
        cursor.execute("SELECT * FROM letras WHERE id = %s", (id,))
        letra = cursor.fetchone()
        cursor.execute("UPDATE letras SET visualizacoes = visualizacoes + 1 WHERE id = %s", (id,))
        cnx.commit()
        cursor.close()
        cnx.close()
    
    if not letra:
        return "Letra não encontrada", 404
    
    return render_template('ver_letra.html', letra=letra)

# Editar letra
@app.route('/letra/<int:id>/editar')
def editar_letra(id):
    cnx = conectar_bd()
    letra = None
    if cnx:
        cursor = cnx.cursor()
        cursor.execute("SELECT * FROM letras WHERE id = %s", (id,))
        letra = cursor.fetchone()
        cursor.close()
        cnx.close()
    
    if not letra:
        return "Letra não encontrada", 404
    
    return render_template('editar_letra.html', letra=letra)

@app.route('/atualizar-letra/<int:id>', methods=['POST'])
def atualizar_letra(id):
    titulo = request.form['titulo']
    artista = request.form['artista']
    letra = request.form['letra']
    
    cnx = conectar_bd()
    if cnx:
        cursor = cnx.cursor()
        cursor.execute(
            "UPDATE letras SET titulo = %s, artista = %s, letra = %s WHERE id = %s",
            (titulo, artista, letra, id)
        )
        cnx.commit()
        cursor.close()
        cnx.close()
        flash('Letra atualizada!', 'success')
        return redirect(url_for('ver_letra', id=id))
    
    return redirect(url_for('editar_letra', id=id))

# Deletar letra
@app.route('/letra/<int:id>/deletar', methods=['POST'])
def deletar_letra(id):
    cnx = conectar_bd()
    if cnx:
        cursor = cnx.cursor()
        cursor.execute("DELETE FROM letras WHERE id = %s", (id,))
        cnx.commit()
        cursor.close()
        cnx.close()
        flash('Letra deletada!', 'success')
    
    return redirect(url_for('index'))

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
