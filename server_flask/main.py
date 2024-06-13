from flask import Flask, request
from PIL import Image
import tensorflow as tf
import numpy as np

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    file = request.files['file']
    img = Image.open(file.stream)
    
    img_resized = img.resize((150, 150))
    if len(img_resized.getdata()) == 3 * 150 * 150:
        img_rgb = img_resized
    else:
        img_rgb = img_resized.convert("RGB")
    
    img_tensor = np.array(img_rgb)
    img_tensor = img_tensor / 255.
    img_tensor = np.expand_dims(img_tensor, axis=0)
    
    model = tf.keras.models.load_model('meu_modelo.h5')
    prediction = model.predict(img_tensor)
    
    return {'prediction': float(prediction[0][0])}

if __name__ == '__main__':
    app.run(debug=True)