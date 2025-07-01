# Curs d'introducció a R
# Errors i missigns
# Eudald Correig i Fraga

### Introducció

# En aquesta classe repassarem els errors més comuns que tots fem en R i aprendrem a 
# identificar-los i solucionar-los.

# Per altra banda, també tractarem el tema dels missings, que en R requereix d'un tractament
# més acurat que en altres paquets estadístics. 

# Com veieu, aquesta classe no està en Markdown, si no en un script d'R normal i corrent. 
# Això és perquè tindrem molts errors (evidentment) i amb el Markdown no seria possible compilar.
# El primer que identifiquem és que en un script normal d'R no hi podem escriure de forma normal, 
# si no que hem de posar un coixinet (#) davant de tot el que no sigui codi (que, com ja hem vist,
# correspon a escriure un comentari).

# Carreguem les llibreries necessàries
library(readr)
library(dplyr)
library(ggplot2)
library(forcats)
library(tidyr)
library(mice)
library(randomForest)

#### Carreguem les dades que farem servir

liver <- read_csv('indian_liver_patient.csv') # primer error!
# Error: 'indian_liver_patient.csv' does not exist in current working directory.
# (equivalent al antic: Error in file(file, "rt") : cannot open the connection)

# Versió correcta:
liver <- read_csv('input/indian_liver_patient.csv', show_col_types = FALSE)

# Preparació de dades amb tidyverse:
liver <- liver |> 
  mutate(
    Dataset = case_when(
      Dataset == 1 ~ "No malalt",
      Dataset == 2 ~ "Malalt",
      .default = NA_character_
    ) |> fct_inorder()
  )

#### Errors clàssics ####

# Relacionats amb filtrat (antic subsetting):
  
liver_dones <- liver |> filter(Gender = "Female")
# Error: Can't transform a vector with class <function>.
# ℹ The error occurred in group 1.

liver_dones <- liver |> filter(Gender == Female)
# Error: object 'Female' not found

liver_dones <- liver |> filter(Gender == "Female")

# Error relacionat amb pipes:
liver_dones <- liver %>% filter(Gender == "Female")  # Error si no hem carregat magrittr
# Error: could not find function "%>%"

# Relacionats amb arguments de funcions:

t_student <- t.test(liver$Gender)
# Error in var(x, na.rm = na.rm) : invalid 'type' (character) of argument

t_student <- t.test(liver$Total_Bilirubin, liver$Gender)
# Error in if (stderr < 10 * .Machine$double.eps * max(abs(mx), abs(my))) stop("data are essentially constant") : 
# missing value where TRUE/FALSE needed

?t.test

# Veiem que el segon argument també és un non-empty numeric vector, o sigui que 
# espera dues mostres per comparar-les, però si mirem més amunt també podem posar
# una fórmula, per tant:

t_student <- t.test(Total_Bilirubin ~ Gender, data = liver)

# Error amb model lineal:
model <- lm(Age ~ Total_Bilirubin, data = liver)  # Correcte
model <- lm(Dataset ~ ., liver)  # Error! Falta data =
# Error in eval(predvars, data, env) : object 'Age' not found

model <- lm(Dataset ~ ., data = liver)
# Warning: using type = "numeric" with a factor response will be ignored

# bàsicament ens està dient que compte perquè estem fent una regressió lineal
# amb una variable depenent categòrica... Hem de passar a regressió logística:

model <- glm(Dataset ~ ., data = liver, family = "binomial")

# Fent operacions amb dplyr:

liver |> summarise(mitjana_dataset = mean(Dataset))
# Warning: NAs introduced by coercion

# és un factor, per tant no podem fer la mitjana

# Versió correcta per estadístiques descriptives:
liver |> 
  group_by(Dataset) |> 
  summarise(
    n = n(),
    mitjana_edat = mean(Age, na.rm = TRUE),
    .groups = 'drop'
  )

# Error amb select:
liver |> select(Edat)  # Error! La columna no existeix
# Error: Can't subset columns that don't exist.
# ✖ Column `Edat` doesn't exist.

liver |> select(Age)  # Correcte

# Dibuixant amb ggplot:

liver |> ggplot(aes(x = Total_Bilirubin, y = Alkaline_Phosphotase))
# Error: No layers in plot

liver |> 
  ggplot(aes(x = Total_Bilirubin, y = Alkaline_Phosphotase)) +
  geom_point()

# Error comú: oblidar carregar ggplot2
# ggplot(liver, aes(...))  # Si no hem carregat ggplot2
# Error: could not find function "ggplot"

# a vegades no estem al directori que toca, aleshores surt:
# Error: 'file.csv' does not exist in current working directory.

# setwd('correct_path')
# o millor: utilitzar here::here() o projects d'RStudio

# o a vegades no he carregat la llibreria...

forest <- randomForest(Dataset ~ ., data = liver)

# Error in randomForest.default(m, y, ...) : 
# could not find function "randomForest"

# No troba la funció perquè li he de carregar la llibreria
library(randomForest) 

# Error en instal·lació:
# Error in library(randomForest) : there is no package called 'randomForest'

# Sembla que no tinc la llibreria, és molt fàcil instal·larla:
install.packages('randomForest')

# Ara ja sí que la podré carregar:
library(randomForest)

# I aplico la funció:
forest <- randomForest(Dataset ~ ., data = liver)
# Error in na.fail.default(list(Dataset = c(1L, 1L, 1L, 1L, 1L, 1L, 1L,  : 
#                                             missing values in object

# Però sembla que encara ho hem de suar una mica més
forest <- randomForest(Dataset ~ ., data = liver, na.action = na.exclude)

# Ha passat que teníem NAs al nostre dataframe, i a randomForest no li han agradat.
# En la comanda de dalt li hem dit que les traiés, però hem de pensar bé què fem

# Per començar mirem on són i si n'hi ha gaires:

summary(liver)

# Versió tidyverse per explorar missings:
liver |> 
  summarise(across(everything(), ~ sum(is.na(.x)))) |> 
  pivot_longer(everything(), names_to = "variable", values_to = "missings") |> 
  filter(missings > 0)

# Veiem doncs que a la columna d'Albumin_and_Globulin_Ratio hi ha 4 nans

# Tenim diverses opcions:

# Podem eliminar els casos (els pacients) que tenen algun NA:
nou_liver <- liver |> drop_na()
forest <- randomForest(Dataset ~ ., data = nou_liver)

# Podem eliminar les columnes on hi ha NAs:
nou_liver <- liver |> 
  select(-Albumin_and_Globulin_Ratio)
forest <- randomForest(Dataset ~ ., data = nou_liver)

# Opció més difícil: podem imputar les dades
# El millor paquet d'R per fer-ho és el mice

#### Missings en R ####

# Els missings estan representats pel caràcter especial NA

# NA és un caràcter curiós, per exemple:
# NA <- c(1,2,3)  # això sobreescriuria NA!
2 == 2
"hola" == "hola"
NA == NA

# Error comú amb missings:
# liver |> filter(Age != NA)  # Error! Ha de ser !is.na()
# Error: Type mismatch: `Age` (double) != `NA` (logical).

# Maneres de trobar els nans en la nostra base de dades:

is.na(NA)
!is.na(NA)

is.na(liver) # és la funció especial per trobar nans

sum(is.na(liver))
summary(liver) 

# Versió tidyverse per trobar missings per columna:
liver |>
  summarise(across(everything(), \(x) sum(is.na(x)))) |>
  pivot_longer(everything(), names_to = "variable", values_to = "missings") |>
  filter(missings > 0) |>
  print()

# Maneres d'interactuar amb els nans:

mean(liver$Age)
mean(liver$Albumin_and_Globulin_Ratio)

mean(liver$Albumin_and_Globulin_Ratio, na.rm = TRUE)

# Versió tidyverse:
liver |> 
  summarise(mitjana_ratio = mean(Albumin_and_Globulin_Ratio, na.rm = TRUE))

#### Com netejar una base de dades ####

# Opció 1: treure els casos que tenen nans
nou_liver <- liver |> drop_na()

# Opció 2: treure variables amb molts missings
# (jo ho faig a partir del 40-50%, fins i tot baixant fins al 15% si la variable no és molt important)

# Opció 3: combinació dels anteriors

# Opció 4: combinar amb imputació de missings

#### Imputació de missings ####

# OPCIÓ ABSOLUTAMENT PROHIBIDA: reemplaçar els NA amb 0:
liver <- liver |> 
  mutate(Albumin_and_Globulin_Ratio = replace_na(Albumin_and_Globulin_Ratio, 0))
forest <- randomForest(Dataset ~ ., data = liver)

# Opció poc recomanable: reemplaçar els NA amb la mitjana:
liver <- liver |> 
  mutate(
    mitjana_ratio = mean(Albumin_and_Globulin_Ratio, na.rm = TRUE),
    Albumin_and_Globulin_Ratio = replace_na(Albumin_and_Globulin_Ratio, mitjana_ratio)
  ) |> 
  select(-mitjana_ratio)

# Millor opció: mice per imputació
library(mice)

# ATENCIÓ: amb la pipe nativa |> no podem fer servir el placeholder "."!
# Això NO funciona: liver |> mice(method = 'rf') |> complete()
# Perquè mice() espera el dataframe com a primer argument però complete() no

# Versió correcta:
miced <- mice(liver, method = 'rf') # mètode basat en random forest
nou_liver <- complete(miced)
forest <- randomForest(Dataset ~ ., data = nou_liver)

# O també podem fer:
nou_liver <- liver |> 
  mice(method = 'rf') |> 
  complete()

# centenars d'altres implacables, insensibles i inesperats errors que inexorablement
# us amargaran les vostres primeres sessions d'R 
