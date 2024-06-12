import pandas as pd
import json
from tensorflow.keras.preprocessing.image import ImageDataGenerator

# Função para converter JSON para DataFrame
def json_to_df(json_file_path):
    with open(json_file_path, 'r') as file:
        data = json.load(file)
    
    # Acessa a lista de anotações dentro do objeto 'annotations'
    annotations_list = data['annotations']
    
    # Cria um DataFrame a partir da lista de anotações
    df = pd.DataFrame(annotations_list)
    return df

# Ler o arquivo JSON
annotations_json = 'dataset/annotations.json'
annotations = json_to_df(annotations_json)

# Visualizar as anotações
print(annotations.head())

# Embaralhar as anotações
annotations = annotations.sample(frac=1).reset_index(drop=True)

# Criar um ImageDataGenerator para carregar imagens a partir das anotações
datagen = ImageDataGenerator(rescale=1./255, validation_split=0.1)

# Definir um gerador de treinamento e validação
train_generator = datagen.flow_from_dataframe(
    dataframe=annotations,
    directory='dataset/images',
    x_col='filename',
    y_col='capacity',
    target_size=(150, 150),
    batch_size=32,
    class_mode='raw',
    subset='training'
)

validation_generator = datagen.flow_from_dataframe(
    dataframe=annotations,
    directory='dataset/images',
    x_col='filename',
    y_col='capacity',
    target_size=(150, 150),
    batch_size=32,
    class_mode='raw',
    subset='validation'
)

from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Conv2D, MaxPooling2D, Flatten, Dense

# Construir o modelo
model = Sequential([
    Conv2D(32, (3, 3), activation='relu', input_shape=(150, 150, 3)),
    MaxPooling2D(pool_size=(2, 2)),
    Conv2D(64, (3, 3), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Conv2D(128, (3, 3), activation='relu'),
    MaxPooling2D(pool_size=(2, 2)),
    Flatten(),
    Dense(512, activation='relu'),
    Dense(1) 
])

model.compile(optimizer='adam', loss='mean_squared_error', metrics=['mae'])

# Treinar o modelo
history = model.fit(
    train_generator,
    epochs=50,
    validation_data=validation_generator,
)

# Avaliar o modelo
loss, mae = model.evaluate(validation_generator)
print(f"Loss: {loss}")
print(f"Mean Absolute Error: {mae}")

# Salvar o modelo treinado
model.save('meu_modelo.h5')
