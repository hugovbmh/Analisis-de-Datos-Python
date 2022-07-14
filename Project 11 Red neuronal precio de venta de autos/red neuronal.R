# red neuronal con RStudio para predecir el precio de venta de autos
# Establecer la carpeta donde se encuentra el .csv 
# setwd('D:/Users/hugov/Downloads')
# Importar el csv
carro <- read.csv("CAR_DETAILS_DEKHO.csv")
View(carro)
#carro$name
# factorizando la columna name y fuel (categoricas)
name_unico <- factor(carro$name)
fuel_unico <- factor(carro$fuel)
# convirtiendo los factores en numeros y reemplazando al dataframe carro$name
carro$name <- as.numeric(name_unico)
carro$fuel <- as.numeric(fuel_unico)
#eliminando columnas sin usar
carro$seller_type <- NULL
carro$transmission <- NULL
carro$owner <- NULL

data <- carro

# Importar la librería neuralnet para la red neuronal
library(neuralnet)
set.seed(42)  # Establece la semilla aleatoria para asegurar reproducibilidad
View(data)

maxs <- apply(data, 2, max) # Máximo valor de las variables
mins <- apply(data, 2, min) # Mínimo valor de las variables
scaled <- as.data.frame(scale(data, center=mins, scale=maxs-mins))

# Entrenamiento de la red neuronal
ann <- neuralnet(selling_price ~ year + km_driven + fuel, data=scaled, hidden = c(2,3), threshold=0.01)

plot(ann, rep="best")
