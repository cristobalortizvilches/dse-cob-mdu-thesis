rm(list = ls())

library(readxl)
library(tidyverse)


########################################################################################################################################################

#ELSOC 2016
load("/Users/benjaminmunozrojas/Dropbox/6_COES/3_Encuestas_COES/2_ELSOC/5_Bases_de_Datos/1_Ensamblaje_Ola_2016/2_Bases_de_Datos_Resultantes/ELSOC_W01_v3.20_R.RData")

#ELSOC 2017
load("/Users/benjaminmunozrojas/Dropbox/6_COES/3_Encuestas_COES/2_ELSOC/5_Bases_de_Datos/2_Ensamblaje_Ola_2017/2_Bases_de_Datos_Resultantes/ELSOC_W02_v2.20_R.RData")

#ELSOC 2018
load("/Users/benjaminmunozrojas/Dropbox/6_COES/3_Encuestas_COES/2_ELSOC/5_Bases_de_Datos/3_Ensamblaje_Ola_2018/2_Bases_de_Datos_Resultantes/ELSOC_W03_v1.10_R.RData")

#CIT
cit <- readxl::read_excel(path = "Datos_CIT_2016.xlsx", sheet = "Datos_CIT_2016", na = "NA",col_types = "numeric")


########################################################################################################################################################
#COMBINAR BASES DE DATOS

#Renombrar identificador
cit %>% dplyr::rename(idencuesta = folio) -> cit

#Corregir folio
cit$idencuesta <- ifelse(cit$idencuesta == 13113012, 13113015, cit$idencuesta)


#ELSOC 2016
elsoc_2016a <- dplyr::left_join(x = elsoc_2016, y = cit, by = "idencuesta")

#ELSOC 2017
elsoc_2017a <- dplyr::left_join(x = elsoc_2017, y = cit, by = "idencuesta")

#ELSOC 2018
elsoc_2018a <- dplyr::left_join(x = elsoc_2018, y = cit, by = "idencuesta")


########################################################################################################################################################
#GUARDAR BASES DE DATOS

save(elsoc_2016a, file = "ELSOC_W01_CIT_v3.20_R.RData")
save(elsoc_2017a, file = "ELSOC_W02_CIT_v2.20_R.RData")
save(elsoc_2018a, file = "ELSOC_W03_CIT_v1.10_R.RData")

