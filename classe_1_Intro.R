##### Intro #####

# Aquesta classe està basada en les classes de Trevor Hastie i Rob Tibshirani (Stanford University)
# i en el llibre An Introduction to Statistical Learning with Applications in R

# Podeu trobar les classes aquí:
# https://www.r-bloggers.com/in-depth-introduction-to-machine-learning-in-15-hours-of-expert-videos/
# I el llibre està penjat gratuïtament aquí: http://www-bcf.usc.edu/~gareth/ISL/
# Dee totes les que hi ha farem:
# Lab: Introduction to R del capítol 2
# Lab: Linear Regression 
# Lab: Logistic Regression  dels capítols 3 i 4)
# Lab: Forward Stepwise Selection and Model Selection Using Validation Set (tema 6)
# Lab: Model Selection Using Cross-Validation (tema 6)
# Evidentment també són útils les parts teòriques relacionades amb les pràctiques dels vídeos

# La part de test d'hipòtesi no la cobreixen, aquesta està basada en el llibre:
# Statistics, An introduction using R, de Michael J. Crawley i que podeu trobar a la biblio


# Tant en els llibres com en els vídeos hi ha moltíssima més informació de la que farem 
# en el curs i és un lloc fantàstic pels que vulguin ampliar.

# Un altre llibre que us pot interessar és "Discovering Statistics Using R", de Andy Field i altres
# És potser una mica intimidant per aprendre, però és un molt bon compendi i un lloc d'on treure llibreries útils

# Llocs on treure informació sobre llibreries, tutorials o demanar ajuda:

# Tutorials: https://www.statmethods.net/index.html, https://www.r-bloggers.com
# Documentació: https://cran.r-project.org/manuals.html
# LLibreries: exemple: https://cran.r-project.org/web/packages/lme4/lme4.pdf
# Demanar ajuda: https://stackoverflow.com (prgramar en R)
# Demanar ajuda: https://stats.stackexchange.com/ (estadística)

# Per qualsevol altra cosa, google.


    #####################################

############## Introducció a R ####################

    ####################################


###### Escalars, vectors i operacions simples #####

a = 3
x = c(1,9,3,4) # c ve de concatenar, és de les opeacions més útils
y = seq(0,1,100) # creem un vector a través de l'operació seqüència
?seq #mirem què és això de l'opearció seqüència

y = seq(from=0, to=1, length = 100)


a = seq(from = 1, to =5, length=4)

a/x # podem fer operacions de forma simple
a+x
a^x

b = c(1,2,3)*10

a/b
a+b # alerta pequè ha tret un warning, no un error, 
# i ha sumat l'últim una altra vegada amb el primer

# això es queda presentat, però no es guarda en memòria, si volem crear nou element:

c = a/x # no el mostra a la consola, però el guarda a l'environment

sqrt(12)
sin(3)
?sin
pi

bools = c(TRUE, FALSE, FALSE, TRUE) # tipus lògic

noms = c("pepet", "marieta", "un altre nom") # tipus caràcter

coses = c("una paraula", 2, FALSE, NA) # força tot menys NA a caràcter
coses

llista = list("una paraula", 2, FALSE, NA) # la llista admet diferents formats
llista

# les llistes no se solen utilitzar gaire (a vegades s'utilitzem com a diccionari)

coses[1]
llista[[1]]


##### Subsetting #####

vec = seq(from=0, to=10, length=20)
vec

vec[1]
vec[17]
vec[17:20]
length(vec[17:20])

vec[c(1,2,10:15,20)]

vec[-9]
vec[10:15]
vec[-10:15] # alerta amb aquest, s'ha de fer:

vec[-c(10:15)]

matriu = matrix(seq(1,12),4,3) 

# sempre, primer element són files i el segon són columnes

matriu[1,1]
matriu[2,1]
matriu[1,2]

matriu[1:2,2:3]
matriu[1:2,c(1,3)] # puc concatenar dins de la selecció

matriu[-1,1:2] # puc fer servir negatius, com abans

matriu[,1:2] # si no poso res m'agafa totes les columnes
matriu[3,] # o totes les files

nou_vector = matriu[2,]

##### Directori #####

ls()

rm(y)

rm(list = ls())

##### Gràfics #####

a = seq(1,10) # seqüència d'1 a 10
b = runif(10) # 10 números aleatoris trets d'una distribució uniforme de 0 a 1
c = rnorm(10) # 10 números aleatoris trets d'una distribució normal de 0 a 1

# scatter plots

plot(a,b)
plot(a,c)

plot(a, b, xlab="eix x", ylab = "eix y", col ="red")

plot(a, b, xlab="eix x", ylab = "eix y", col ="red", type='b')

plot(a, b, xlab="eix x", ylab = "eix y", col ="red", type='b', pch ="*")


# histogrames
hist(a)
hist(b)
hist(c)

hist(rnorm(mean=0, sd=1, n=10000), main="histograma")

# això són les coses bàsiques que es poden fer en R

####### Dataframes #########

# anem a coses més complicades, com ara tereballar amb dataframes

# per interactuar amb l'exterior, primer hem de saber on som

setwd('~path')

liver = read.csv('indian_liver_patient.csv')

# ALERTA: en castellà se sol guardar en tsv, no csv! 

liver = read.csv('indian_cast.csv') # error!

?read.csv # -> mirem les opcions de read.csv

liver = read.csv('indian_cast.csv', sep=";", dec = ",")


View(liver) # també es pot clicar al símbol blau al costat del nom a l'environment

# This data set contains 416 liver patient records and 167 non liver patient records collected from North East of Andhra Pradesh, India.
# The "Dataset" column is a class label used to divide groups into liver patient (liver disease) or not (no disease). 
# This data set contains 441 male patient records and 142 female patient records.
# 
# Any patient whose age exceeded 89 is listed as being of age "90".
# 
# Columns:
#   
# Age of the patient
# Gender of the patient
# Total Bilirubin
# Direct Bilirubin
# Alkaline Phosphotase
# Alamine Aminotransferase
# Aspartate Aminotransferase
# Total Protiens
# Albumin
# Albumin and Globulin Ratio
# Dataset: field used to split the data into two sets (patient with liver disease, or no disease)

colnames(liver)
dim(liver)
class(liver)
str(liver)

liver$Dataset
liver[,c(1,3)]
head(liver[,c(1,3)])

tail(liver[,c("Age","Dataset")])

liver[1:10,c("Age","Dataset")]

# canviar tipus de variable, funcions as.factor, as.numeric, as.character

liver$Dataset = as.factor(liver$Dataset)

str(liver)

# liver$Dataset = as.numeric(as.character(liver$Dataset)) # a vegades s'ha de fer així

summary(liver)

plot(Age, Albumin_and_Globulin_Ratio) # error

attach(liver) # no és molt convenient de fer servir

plot(Age, Albumin_and_Globulin_Ratio)
plot(Dataset, Age)

plot(Gender, Total_Bilirubin)

pairs(liver)

liver$prova = rnorm(nrow(liver))
plot(Age, prova) # no és a attach!!

attach(liver) # hem matat els noms d'abans, d'aquí el warning
plot(Age, prova)
hist(Age)

detach(liver)


# manipulació de dades

liver$prova = liver$prova+liver$Total_Bilirubin

liver$bins = ifelse(liver$prova>5,1,ifelse(liver$prova>2,2,3))

liver = liver[,-12]
liver$bins = NULL

liver$prova = liver$Direct_Bilirubin*2.3

liver_dones = liver[liver$Gender=="Female",] # alerta amb la coma!!!

liver_bili = liver[liver$Total_Bilirubin>5,]

liver_bili = liver[(liver$Total_Bilirubin>1 &liver$Total_Bilirubin<5),]

colnames(liver)[ncol(liver)-1] = "malaltia"

levels(liver$malaltia) = c("no malalt", "malalt")

liver_malalt = liver[liver$malaltia=="malalt",]

# si volem canviar el tipus de moltes columnes:

cols = c(1,5,6,7) # cols = c(1,5:7)

for (i in cols){
  liver[,i] = as.numeric(liver[,i])
}

str(liver)

