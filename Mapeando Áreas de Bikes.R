# Mapeando Áreas de Bikes

library(ggmap)
library(ggplot2)
 
# Gerando o dataframe
df2 <- read.csv("paris.txt", sep = ",", header = T) 
str(df)
dim(df)

# Criando o mapa
paris <- c(left = 2.2241, bottom = 48.8156, right = 2.4699, top = 48.9021)
mapa <- get_stamenmap(paris, zoom = 13, maptype = "toner-lite")
ggmap(mapa)

# Unindo mapa e camada de dados
ggmap(mapa) +
  geom_point(data = df2, aes(x = longitude, y = latitude, 
                             size = available_bike_stands, 
                             color = available_bike_stands), 
                             alpha = .9, na.rm = T) +
  scale_color_gradient(low = "#33CC33", high = "#003300", name = "Número de Bikes Disponíveis") +
  scale_size(range=c(1,11) , guide="none") + 
  ggtitle("Número de Bikes Disponíveis em Paris") +
  theme(text = element_text(family = "Trebuchet MS", color = "#666666")) +
  theme(plot.title = element_text( size = 32, face = "bold", hjust = 0, vjust = .5))