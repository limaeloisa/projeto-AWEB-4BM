from flask import Flask, render_template, request, redirect, url_for
import os
import mysql.connector

app = Flask(__name__)

UPLOAD_FOLDER = 'static/uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def get_db():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='1406',
        database='sistemablog'
    )

def init_db():
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute('''CREATE TABLE IF NOT EXISTS posts (
        id INT AUTO_INCREMENT PRIMARY KEY,
        title TEXT,
        content TEXT,
        author TEXT,
        date TEXT,
        image TEXT
    )''')
    conn.commit()
    cursor.close()
    conn.close()

init_db()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/lendas')
def lendas():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT id, title as titulo, content as conteudo, author as autor, date as data_publicacao, image as imagem FROM posts ORDER BY date DESC')
    user_legends = cursor.fetchall()
    cursor.close()
    conn.close()
    return render_template('lendas.html', user_legends=user_legends)

@app.route('/detalhe/<legenda>')
def detalhe(legenda):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT * FROM posts WHERE title LIKE %s', ('%' + legenda + '%',))
    legend = cursor.fetchone()
    cursor.close()
    conn.close()
    if legend:
        return render_template('detalhe.html', legenda=legenda, legend=legend)
    else:
        return render_template('404.html'), 404

@app.route('/add', methods=['GET', 'POST'])
def add():
    if request.method == 'POST':
        title = request.form['titulo']
        content = request.form['conteudo']
        author = request.form['autor']
        date = request.form['data_publicacao']
        image = request.files.get('imagem')
        image_filename = None
        if image and image.filename:
            image_filename = image.filename
            image.save(os.path.join(app.config['UPLOAD_FOLDER'], image_filename))
        conn = get_db()
        cursor = conn.cursor()
        # Verificar se já existe uma lenda com o mesmo título
        cursor.execute('SELECT id FROM posts WHERE title = %s', (title,))
        existing_legend = cursor.fetchone()
        if existing_legend:
            cursor.close()
            conn.close()
            return render_template('add.html', error='Uma lenda com este título já existe.')
        cursor.execute('INSERT INTO posts (title, content, author, date, image) VALUES (%s, %s, %s, %s, %s)',
                       (title, content, author, date, image_filename))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('lendas'))
    return render_template('add.html')

@app.route('/delete/<int:id>')
def delete(id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute('SELECT image FROM posts WHERE id = %s', (id,))
    legend = cursor.fetchone()
    if legend and legend['image'] and not legend['image'].startswith('http'):
        image_path = os.path.join(app.config['UPLOAD_FOLDER'], legend['image'])
        if os.path.exists(image_path):
            os.remove(image_path)
    cursor.execute('DELETE FROM posts WHERE id = %s', (id,))
    conn.commit()
    cursor.close()
    conn.close()
    return redirect(url_for('lendas'))

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

if __name__ == '__main__':
    app.run(debug=True)
