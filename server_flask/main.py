from flask import Flask, request, jsonify
from PIL import Image
import numpy as np
import tensorflow as tf

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    # Verificar se o arquivo de imagem foi enviado
    if 'file' not in request.files:
        return jsonify({"error": "No file part"}), 400
    
    file = request.files['file']
    if file.filename == '':
        return jsonify({"error": "No selected file"}), 400
    
    # Abrir a imagem e redimensioná-la
    img = Image.open(file.stream)
    img_resized = img.resize((150, 150))
    
    # Converter a imagem para RGB e para um array NumPy
    if len(img_resized.getdata()) == 3 * 150 * 150:
        img_rgb = img_resized
    else:
        img_rgb = img_resized.convert("RGB")
    img_tensor = np.array(img_rgb)
    img_tensor = img_tensor / 255.
    img_tensor = np.expand_dims(img_tensor, axis=0)
    
    # Carregar o modelo e fazer a previsão
    model = tf.keras.models.load_model('meu_modelo.h5')
    prediction = model.predict(img_tensor)
    
    # Retornar a previsão
    return jsonify({"prediction": float(prediction[0][0])})

if __name__ == '__main__':
    app.run(debug=True)
