#Big Data na Prática - Temperatura Média nas Cidades Brasileiras

# Dataset:
# Berkeley Earth
# http://berkeleyearth.org/data
# TemperaturasGlobais.csv

# Instalando e Carregando Pacotes
install.packages('readr')
install.packages('data.table')
library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(data.table)
library(dtplyr)

# Carregando os dados (Usando um timer para comparar o tempo de carregamento )

#Usando read.csv2()
system.time(read.csv2("~/estudo/R/Capitulo 3/TemperaturasGlobais.csv"))

#Usando read.table()
system.time(read.table("~/estudo/R/Capitulo 3/TemperaturasGlobais.csv"))

# Unsao fread()
?fread
system.time(fread("~/estudo/R/Capitulo 3/TemperaturasGlobais.csv"))

df = fread("~/estudo/R/Capitulo 3/TemperaturasGlobais.csv")

# Criando subsets dos dados carregados
cidadesBrasil = subset(df, Country == 'Brazil')
cidadesBrasil = na.omit(cidadesBrasil)
head(cidadesBrasil)
nrow(df)
nrow(cidadesBrasil)
dim(cidadesBrasil)

# Preparação e Organização

# Convertendo as Datas
cidadesBrasil$dt = as.POSIXct(cidadesBrasil$dt, format='%Y-%m-%d')
cidadesBrasil$Month = month(cidadesBrasil$dt)
cidadesBrasil$Year = year(cidadesBrasil$dt)
(cidadesBrasil$City)

# Carregando os subsets

# Cabo Frio
cf = subset(cidadesBrasil, City == 'Cabo Frio')
cf = subset(cf, Year %in% c(1796,1846,1896,1946,1996,2012))

# Arraruama
arr = subset(cidadesBrasil, City == 'Araruama')
arr = subset(arr, Year %in% c(1796,1846,1896,1946,1996,2012))

# Macaé
mae = subset(cidadesBrasil, City == 'Macaé')
mae = subset(mae, Year %in% c(1796,1846,1896,1946,1996,2012))

# Construindo os Plots
p_cf = ggplot(cf, aes(x = (Month), y= AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE, fill = NA, size = 2)+
  theme_light(base_size = 20)+
  xlab('MÊS')+
  ylab('Temperatura Média')+
  scale_color_discrete('')+
  ggtitle('Temperatura Média ao longo dos anos em Cabo Frio')+
  theme(plot.title = element_text(size = 18))



p_arr = ggplot(arr, aes(x = (Month), y= AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE, fill = NA, size = 2)+
  theme_light(base_size = 20)+
  xlab('MÊS')+
  ylab('Temperatura Média')+
  scale_color_discrete('')+
  ggtitle('Temperatura Média ao longo dos anos em Araruama')+
  theme(plot.title = element_text(size = 18))



p_mae = ggplot(mae, aes(x = (Month), y= AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE, fill = NA, size = 2)+
  theme_light(base_size = 20)+
  xlab('MÊS')+
  ylab('Temperatura Média')+
  scale_color_discrete('')+
  ggtitle('Temperatura Média ao longo dos anos em Macaé')+
  theme(plot.title = element_text(size = 18))



# Plotando
p_mae
p_arr
p_cf
