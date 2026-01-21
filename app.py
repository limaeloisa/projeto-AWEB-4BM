from flask import Flask, render_template, request, redirect, url_for
import os
import mysql.connector

app = Flask(__name__)

app.config['FOLDER_UPLOADS'] = os.path.join(app.root_path, 'static', 'uploads')
def executar_sql(sql, params=None, um=False, todos=False):
    conexao = mysql.connector.connect(
        host='localhost',
        user='root',
        password='1406',
        database='sistemablog'
    )

    cursor = conexao.cursor(dictionary=True)
    cursor.execute(sql, params or ())

    resultado = None
    if um:
        resultado = cursor.fetchone()
    elif todos:
        resultado = cursor.fetchall()

    conexao.commit()
    cursor.close()
    conexao.close()

    return resultado

@app.route('/')
def index():
    return render_template('index.html')


@app.route('/lendas')
def lendas():
    lendas_usuario = executar_sql(
        """SELECT id, title AS titulo, content AS conteudo,
                  author AS autor, date AS data_publicacao, image AS imagem
           FROM posts ORDER BY date DESC""",
        todos=True
    )
    return render_template('lendas.html', user_legends=lendas_usuario)


@app.route('/detalhe/<legenda>')
def detalhe(legenda):
    lenda = executar_sql(
        'SELECT * FROM posts WHERE title LIKE %s',
        ('%' + legenda + '%',),
        um=True
    )

    if not lenda:
        return render_template('404.html'), 404

    return render_template('detalhe.html', legenda=legenda, legend=lenda)


@app.route('/add', methods=['GET', 'POST'])
def adicionar():
    if request.method == 'POST':
        titulo = request.form['titulo']
        conteudo = request.form['conteudo']
        autor = request.form['autor']
        data_publicacao = request.form['data_publicacao']
        imagem = request.files.get('imagem')

        nome_imagem = None
        if imagem and imagem.filename:
            nome_imagem = imagem.filename
            imagem.save(os.path.join(app.config['FOLDER_UPLOADS'], nome_imagem))

        existente = executar_sql(
            'SELECT id FROM posts WHERE title = %s',
            (titulo,),
            um=True
        )

        if existente:
            return render_template(
                'add.html',
                error='Uma lenda com este título já existe.'
            )

        executar_sql(
            'INSERT INTO posts (title, content, author, date, image) VALUES (%s, %s, %s, %s, %s)',
            (titulo, conteudo, autor, data_publicacao, nome_imagem)
        )

        return redirect(url_for('lendas'))

    return render_template('add.html')


@app.route('/delete/<int:id>')
def excluir(id):
    lenda = executar_sql(
        'SELECT image FROM posts WHERE id = %s',
        (id,),
        um=True
    )

    if lenda and lenda['image'] and not lenda['image'].startswith('http'):
        caminho = os.path.join(app.config['FOLDER_UPLOADS'], lenda['image'])
        if os.path.exists(caminho):
            os.remove(caminho)

    executar_sql('DELETE FROM posts WHERE id = %s', (id,))
    return redirect(url_for('lendas'))


@app.errorhandler(404)
def pagina_nao_encontrada(e):
    return render_template('404.html'), 404


if __name__ == '__main__':
    app.run(debug=True)
