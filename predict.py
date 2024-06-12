from PIL import Image
import tensorflow as tf
import numpy as np

# Carrega o modelo treinado
model = tf.keras.models.load_model('meu_modelo.h5')

# Carrega a imagem usando a biblioteca PIL (Pillow)
image_path = 'dataset/image000.jpeg'
img = Image.open(image_path)

# Redimensiona a imagem para o tamanho esperado pelo modelo
img_resized = img.resize((150, 150))

# Converte a imagem para RGB se necessário
if len(img_resized.getdata()) == 3 * 150 * 150:
    img_rgb = img_resized
else:
    img_rgb = img_resized.convert("RGB")

# Converte a imagem para tensão e redimensiona para o formato esperado pelo modelo
img_tensor = np.array(img_rgb)
img_tensor = img_tensor / 255.  # Normaliza a imagem
img_tensor = np.expand_dims(img_tensor, axis=0)  # Adiciona uma dimensão extra para o batch

# Realiza a previsão
prediction = model.predict(img_tensor)

# Imprime a previsão
print(f"A previsão para a imagem é: {prediction[0][0]}")
