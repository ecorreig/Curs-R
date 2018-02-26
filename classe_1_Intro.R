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
# Demanar ajuda: https://stackoverflow.com (prgramar)
# Demanar ajuda: https://stats.stackexchange.com/ (estadística)

# Per qualsevol altra cosa, google.

# Aquesta classe la podeu trobar actualitzada a 
# https://github.com/ecorreig/Curs-R


    #####################################

############## Introducció a R ####################

    ####################################


###### Escalars, vectors i operacions simples #####

a = 3
x = c(1,9,3,4) # c ve de concatenar, és de les opeacions més útils
y = seq(0,1,100) # creem un vector a través de l'operació seqüència
?seq #mirem què és això de l'opearció seqüència

# El signe = és totalment equivalent a <- en R

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

vec[1] # agafem el primer element
vec[17] # agafem l'element en posició 17
vec[17:20] # agafem els elements en posicions de 17 a 20
length(vec[17:20])

vec[c(1,2,10:15,20)]  # agafem el primer, segon, del 10 al quinzè i el vintè

vec[-9] # tots menys el novè
vec[10:15] # del 10 al 15
vec[-10:15] # alerta amb aquest, s'ha de fer:

vec[-c(10:15)]


##### Matrius ######


matriu = matrix(seq(1,12),4,3) # amb la comanda "matrix" creem matrius
matriu
# sempre, primer element són files i el segon són columnes

matriu[1,1] # element a la primera fila, primera columna
matriu[2,1] # element a la segona fila, primera columna
matriu[1,2] # element a la primera fila, segona columna

matriu[1:2,2:3]
matriu[1:2,c(1,3)] # puc concatenar dins de la selecció

matriu[-1,1:2] # puc fer servir negatius, com abans

matriu[,1:2] # si no poso res m'agafa totes les columnes
matriu[3,] # o totes les files

nou_vector = matriu[2,]

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


##### Directori #####

ls()

rm(y)

rm(list = ls())

# per interactuar amb l'exterior, primer hem de saber on som

setwd('~path')

# podem fer servir un path global (C:/path/to/fitxer)
# o relatiu (../Carpeta/)

liver = read.csv('indian_liver_patient.csv')

# ALERTA: en castellà se sol guardar en tsv, no csv! 

liver = read.csv('indian_cast.csv') # error!

?read.csv # -> mirem les opcions de read.csv

liver = read.csv('indian_cast.csv', sep=";", dec = ",")

####### Dataframes #########

View(liver) # també es pot clicar al símbol blau al costat del nom a l'environment

# Només a tall informatiu, què hi ha en la base de dades que utilitzarem 

# This data set contains 416 liver patient records and 167 non liver patient records 
# collected from North East of Andhra Pradesh, India.
# The "Dataset" column is a class label used to divide groups into liver patient 
# (liver disease) or not (no disease). 
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
# Dataset: field used to split the data into two sets (patient with liver disease, 
# or no disease)

#### Informació sobre la base de dades ####

colnames(liver)
dim(liver)
class(liver)
str(liver)

summary(liver) # molt útil per tenir una visió general
pairs(liver) # o plot(liver) també per tenir una visió general

liver$Dataset # accedir a una columna (variable) concreta
liver[,c(1,3)] # accedir a diverses columnes

head(liver) # 5 primeres files -> va bé per tenir una visió ràpida de com són els valors
tail(liver) # 5 últimes files

# Podem combinar coses:
head(liver[,c(1,3)])
tail(liver[,c("Age","Dataset")])

liver[1:10,c("Age","Dataset")]

# canviar tipus de variable, funcions: 
# as.factor -> passar a categòrica (R crea els "dummies" automàticament!)
# as.numeric -> passar a numèrica 
# as.character -> passar a caràcter (CIPs dels pacients, per exmeple)

liver$Dataset = as.factor(liver$Dataset)

str(liver)

# liver$Dataset = as.numeric(as.character(liver$Dataset)) # a vegades s'ha de fer així

# si volem canviar el tipus de moltes columnes:

cols = c(1,5,6,7) # cols = c(1,5:7)

for (i in cols){
  liver[,i] = as.numeric(liver[,i])
}

str(liver)
summary(liver)

#### Attach, detach ####

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


#### Manipulació de dades i "subsetting" ####

# creem una nova columna a partir de les anteriors
liver$prova = liver$prova+liver$Total_Bilirubin

# creem una nova columna categòrica amb l'ajuda de la funció ifelse()
# per a més info ?ifelse

# dues categories:
liver$cat = ifelse(liver$prova>5,1,0)

# tres categories:
liver$bins = ifelse(liver$prova>5,1,ifelse(liver$prova>2,2,3))

# podem anar concatenant ifelse per tenir tantes categories com vulguem

# Eliminem una columna; es pot fer de dues maneres:
liver = liver[,-12]
liver$bins = NULL

# Seguim creant columnes fent opearcions amb altres columnes
liver$prova = liver$Direct_Bilirubin*2.3

# Subsetting 

# Treballem la part d'agafar subgrups del data frame complet (seria l'equivalent del filtre de l'SPSS, 
# amb la diferència que en R normalment creem una dataframe nova cada vegada que fem algun filtrat).
# El subsetting és una de les parts que costa més al principi; una bona referència/resum es pot trobar a
# https://www.statmethods.net/management/subset.html
# Alerta amb corxets, parèntisis, comes; tot ha d'estar exactament al seu lloc

# Com funciona:

# L'R escull files (o columnes) basat en booleans, és a dir, en columnes de veritat i false; 
# què vol dir això:

liver$Gender=="Female"

# Aquí veiem que, de totes les files del dataframe liver, ens surt un True si en aquella fila la 
# variable Gender és igual a "Female" i un False si no ho és.

# Si això ho poso en la següent estructura, estaré agafant només aquelles files on hi hagi un True
# en la condició que explicito dins dels corxets.

liver_dones = liver[liver$Gender=="Female",] # alerta amb la coma! 
                                            # -> La coma vol dir que volem agafar totes les columnes

# Aquí el mateix, tindrem un True per totles les files que tinguin la bilirrubina a més de 5 i 
# un False a les altres; per tant estarem creant una nova base de dades amb pacients amb la 
# bilirrubina més alta de 5. 

liver_bili = liver[liver$Total_Bilirubin>5,]

# Podem incloure dues condicions amb el signe & (and) o | (or)

liver_bili = liver[(liver$Total_Bilirubin>1 & liver$Total_Bilirubin<5),]

# Més exemples:

colnames(liver)[ncol(liver)-1] = "malaltia"

levels(liver$malaltia) = c("no malalt", "malalt")

liver_malalt = liver[liver$malaltia=="malalt",]


