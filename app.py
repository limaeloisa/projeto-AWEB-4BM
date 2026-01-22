from flask import Flask, render_template, request, redirect, url_for, session
import os
import mysql.connector

app = Flask(__name__)
app.secret_key = 'chave_simples'
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

#Rotas do blog

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/sobre')
def sobre():
    return render_template('sobre.html')

@app.route('/lendas')
def lendas():
    lendas_usuario = executar_sql(
        """SELECT id, title AS titulo, content AS conteudo,
                  author AS autor, date AS data_publicacao, image AS imagem
           FROM posts ORDER BY date DESC""",
        todos=True
    )
    return render_template('lendas.html', user_legends=lendas_usuario)


@app.route('/detalhe/<int:legenda>')
def detalhe(legenda):
    lenda = executar_sql(
        'SELECT * FROM posts WHERE id = %s',
        (legenda,),
        um=True
    )

    if not lenda:
        return render_template('404.html'), 404

    return render_template('detalhe.html', legend=lenda)



@app.route('/add', methods=['GET', 'POST'])
def adicionar():
    if 'usuario_id' not in session:
        return redirect(url_for('login'))

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
            return render_template('add.html', error='Uma lenda com este título já existe.')

        executar_sql(
            'INSERT INTO posts (title, content, author, date, image) VALUES (%s, %s, %s, %s, %s)',
            (titulo, conteudo, autor, data_publicacao, nome_imagem)
        )

        return redirect(url_for('lendas'))

    return render_template('add.html')



@app.route('/delete/<int:id>')
def excluir(id):
    if 'usuario_id' not in session:
        return redirect(url_for('login'))

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

@app.route('/cadastro', methods=['GET', 'POST'])
def cadastro():
    if request.method == 'POST':
        nome = request.form['nome']
        email = request.form['email']
        senha = request.form['senha']

        existente = executar_sql(
            'SELECT id FROM usuarios WHERE email = %s',
            (email,),
            um=True
        )

        if existente:
            return render_template('cadastro.html', erro='Email já cadastrado')

        executar_sql(
            'INSERT INTO usuarios (nome, email, senha) VALUES (%s, %s, %s)',
            (nome, email, senha)
        )

        return redirect(url_for('login'))

    return render_template('cadastro.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        senha = request.form['senha']

        usuario = executar_sql(
            'SELECT * FROM usuarios WHERE email = %s AND senha = %s',
            (email, senha),
            um=True
        )

        if usuario:
            session['usuario_id'] = usuario['id']
            session['usuario_nome'] = usuario['nome']
            return redirect(url_for('lendas'))
        else:
            return render_template('login.html', erro='Login inválido')

    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('lendas'))


@app.errorhandler(404)
def pagina_nao_encontrada(e):
    return render_template('404.html'), 404



if __name__ == '__main__':
    app.run(debug=True)
