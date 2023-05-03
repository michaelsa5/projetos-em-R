# Mapeando Areas de Crimes

install.packages('ggmap')
install.packages('ggplot2')
library(ggmap)
library(ggmap)


# Criando Dataframe
df <- read.csv('crimes.txt')
head(df)
str(df)
dim(df)

df$crime_category = as.factor(df$crime_category)



seattle <- c(left = -122.436, bottom = 47.495, right = -122.224, top = 47.734)
mapa <- get_stamenmap(seattle, zoom = 13, maptype = "toner-lite")
ggmap(mapa)

# Mapeando os dados
ggmap(mapa) + geom_point(data = df, aes(x = Longitude, y = Latitude))

# Mapeando os dados e ajustando a escala
ggmap(mapa) + geom_point(data = df, aes(x = Longitude, y = Latitude),
                         color = 'dark green', alpha = .03, size = 1.1)

# Mapeando os dados e definindo uma camada de intensidade
ggmap(mapa) +
  stat_density2d(data = df, aes(x = Longitude, y = Latitude, 
                                color = ..density.., 
                                size = ifelse(..density..<= 1,0,..density..), 
                                alpha = ..density..), geom = "tile",contour = F) +
  scale_color_continuous(low = "orange", high = "red", guide = "none") +
  scale_size_continuous(range = c(0, 3), guide = "none") +
  scale_alpha(range = c(0,.5), guide = "none") +
  ggtitle("Crimes em Seattle") +
  theme(plot.title = element_text(family = "Trebuchet MS", size = 36, face = "bold", hjust = 0, color = "#777777"))

