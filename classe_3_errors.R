liver = read.csv('indian_liver_patient.csv')
liver$Dataset = as.factor(liver$Dataset)

#### Errors clàssics ####

  
#Relacionats amb subsetting:
  
liver_dones = liver[liver$Gender=Female]
# Error: unexpected '=' in "liver_dones = liver[liver$Gender="

liver_dones = liver[liver$Gender == Female]
# Error in `[.data.frame`(liver, liver$Gender == Female) : object 'Female' not found

liver_dones = liver[liver$Gender == "Female"]
# Error in `[.data.frame`(liver, liver$Gender == "Female") : undefined columns @ selected

liver_dones = liver[liver$Gender == "Female",]

# Relacionats amb arguments de funcions:

t_student = t.test(liver$Gender)
# Calling var(x) on a factor x is deprecated and will become an error.

t_student = t.test(liver$Total_Bilirubin, liver$Gender)
# error molt semblant, però ara: missing value where TRUE/FALSE needed

?t.test

# Veiem que el segon argument també és un non-emtpy numeric vector, o sigui que 
# espera dues mostres per comparar-les, però si mirem més amunt també podem posar
# una fórmula, per tant:

t_student = t.test(liver$Total_Bilirubin ~ liver$Gender)

lm(liver$Age~liver$Total_Bilirubin)
model = lm(liver$Dataset~., data=liver)

# Error in terms.formula(formula, data = data) : 
# '.' in formula and no 'data' argument
# Ens hem oblidat de posar el dataframe

model = lm(Gender~., data=liver)

#Warning messages:
# 1: In model.response(mf, "numeric") :
#   using type = "numeric" with a factor response will be ignored
# 2: In Ops.factor(y, z$residuals) : ‘-’ not meaningful for factors

# o bé: Error in quantile.default(resid) : factors are not allowed quan fem 
# summary(model)
  
  
# bàsicament ens està dient que compte perquè estem fent una regressió lineal
# amb una variable depenent categòrica... Hem de passar a regressió logística:

model = glm(liver$Dataset~., data=liver, family = "binomial")

# Fent operacions

mean(liver$Dataset)
sd(liver$Dataset)
# NA
# és un factorial, per tant no podem fer ni mitja ni la desviació estàndard

# Dibuixant potser?

plot(Total_Bilirubin, Alkaline_Phosphotase)
# Error in plot(Total_Bilirubin, Alkaline_Phosphotase) : 
# object 'Total_Bilirubin' not found
#Molt fàcil, ens hem oblidat de dir-li de quin dataframe ha de treure les dades

plot(Total_Bilirubin, Alkaline_Phosphotase, data=liver)
# vaja, sembla que la funció plot no deix tenir un valor data, ho haurem de fer
# de la forma llarga: 

plot(liver$Total_Bilirubin, liver$Alkaline_Phosphotase)

# a vegades no estem al directori que toca, aleshores surt:

# Error in file(file, "rt") : cannot open the connection

# setwd('correct_path')

# o a vegades no he carregat la llibreria...

forest = randomForest(Dataset~., data=liver)

# Error in randomForest(Dataset ~ ., data = liver) : 
# could not find function "randomForest"

# No troba la funció perquè li he de carregar la llibreria, això es pot fer 
# de dues manesr equivalents, un cop carregada la tindré durant tota la sessió
# si tanco la sessió l'hauré de tornar a carregar.

require(randomForest)
library(randomForest) 

# Error in library(randomForest) : there is no package called ‘ggvis’

# Sembla que no tinc la llibreria, és molt fàcil instal·larla:

install.packages('randomForest')

# Ara ja sí que la podré carregar:

require(randomForest)

# I aplico la funció:
  
forest = randomForest(Dataset~., data=liver)
# Error in na.fail.default(list(Dataset = c(1L, 1L, 1L, 1L, 1L, 1L, 1L,  : 
#                                             missing values in object

# Però sembla que encara ho hem de suar una mica més
# a veure què diu l'stack overflow...
forest = randomForest(Dataset~., data=liver, na.action=na.exclude)

# Ha passat que teníem NAs al nostre dataframe, i a randomForest no li han agradat.
# En la comanda de dalt li hem dit que les traiés, però hem de pensar bé què fem

# Per començar mirem on són i si n'hi ha gaires. Una manera és fer:

summary(liver)

# Veiem doncs que a la columna d'Albumin_and_Globulin_Ratio hi ha 4 nans

# Tenim diverses opcions:

# Podem eliminar els casos (els pacients) que tenen algun NA:

nou_liver = liver[complete.cases(liver),]
forest = randomForest(Dataset~., data=nou_liver)

# Podem eliminar les columnes on hi ha NAs (en aquest cas no té gaire sentit, 
# però en casos on hi ha columnes amb mols NAs sí que en té):

nou_liver = liver[,-10]
forest = randomForest(Dataset~., data=nou_liver)

# Opció més difícil: podem imputar les dades
# El millor paquet d'R per fer-ho és el mice:
pairs(heart)

#### Missings en R ####

# Els missings estan representats pel caràcter especial NA

# NA és un caràcter curiós, per exemple:
# NA = c(1,2,3)
2 == 2
"hola" == "hola"
NA == NA

#nova_liver = liver[liver$Age!=NA, ]

# Maneres de trobar els nans en la nostra base de dades:

is.na(NA)
!is.na(NA)

is.na(liver) # és la funció especial per trobar nans

sum(is.na(liver))
summary(liver) 

# Si tenim una base de dades molt gran i el summary és massa, podem fer
# un petit loop per trobar els número de missings de cada columa

for (i in 1:ncol(liver)){
  if (sum(is.na(liver[,i]))>0){
    print(colnames(liver)[i])
    print(sum(is.na(liver[,i])))
  }
}

# Maneres d'interactuar amb els nans:

mean(liver$Age)
mean(liver$Albumin_and_Globulin_Ratio)
?na.omit

mean(liver$Albumin_and_Globulin_Ratio, na.rm = TRUE)
mean(na.omit(liver$Albumin_and_Globulin_Ratio))



#### Com netejar una base de dades ####

# Opció 1:

# treure els casos que tenen nans (és el que fa l'spss per defecte)
nou_liver = na.omit(liver)
complete.cases(liver)
nou_liver = liver[complete.cases(liver),]

# jo ho faig quan hi ha entrades amb un número exagerat de missings

# Opció 2: 

# treure variables en les que hi ha molts missings (jo ho faig segur)
# a partir del 40-50%, fins i tot baixant fins al 15% si la variable
# no és molt important

# Opció 3: intermig dels dos: treure alguns pacients i algunes variables

# Opció 4: combinar les opcions anteriors amb la imputació de missings:

#### Imputació de missings ####

# OPCIÓ ABSOLUTAMENT PROHIBIDA (en la majoria de casos): reemplaçar els NA amb 0:

liver$Albumin_and_Globulin_Ratio[!complete.cases(liver$Albumin_and_Globulin_Ratio)]=0
forest = randomForest(Dataset~., data=liver)

# Opció poc recomanable: reemplaçar els NA amb la mitja:
m = mean(liver$Albumin_and_Globulin_Ratio, na.rm = TRUE)
liver$Albumin_and_Globulin_Ratio[!complete.cases(liver)] = m
forest = randomForest(Dataset~., data=liver)

#install.packages('mice')
require(mice)

miced = mice(liver, method = 'rf') # mètode basat en arbres trees
nou_liver = complete(miced)
forest = randomForest(Dataset~., data=nou_liver)

# centenars d'altres implacables, insensibles i inespearts errors que inexorablement
# us amargaran les vostres primeres sessions d'R 


