# Curs d'Introducció a R

📊 **Repositori del curs d'introducció al llenguatge de programació R amb enfocament en estadística i anàlisi de dades**


| Nota important: estic actualitzant el curs a utilitzar tidyverse, i a pràctiques d'R més modernes. Mentre no he acabat, trobareu el nou codi a la branca `new_version`.


## 📋 Descripció del curs

Aquest curs està dissenyat per a persones que volen aprendre R i estadística des de zero, amb un enfocament pràctic en estadística, anàlisi de dades i creació d'informes reproducibles. El curs combina teoria i pràctica mitjançant classes interactives i exercicis aplicats.

## 🎯 Objectius d'aprenentatge

Al finalitzar aquest curs, els estudiants seran capaços de:
- Instal·lar i configurar R i RStudio
- Comprendre els conceptes bàsics de programació en R
- Crear documents reproduïbles amb R Markdown
- Aplicar tècniques d'estadística descriptiva i inferencial
- Desenvolupar models predictius bàsics
- Crear visualitzacions de dades efectives
- Treballar amb diferents tipus de dades i formats de fitxers

## 📚 Estructura del curs

### Classes principals
- **Classe 0**: Configuració i introducció general
- **Classe 1**: Introducció a R i RStudio
- **Classe 2**: R Markdown i documentació reproducible
- **Classe 3**: Estadística bàsica
- **Classe 4**: Gestió d'errors i debugging
- **Classe 5**: Models predictius
- **Classe 6**: Selecció de models
- **Classe 7**: Visualització de dades (gràfics)

### Exercicis pràctics
- Exercicis guiats per cada sessió
- Sessions pràctiques amb datasets reals
- Material de suport i resolucions

### Datasets inclosos
El curs inclou diversos conjunts de dades per a la pràctica:
- `Heart.csv` - Dades cardiovasculars
- `indian_liver_patient.csv` - Dades mèdiques del fetge
- `dades.csv` i `dades_exercicis.csv` - Datasets per exercicis

## 🔧 Prerequisits

### Software necessari
1. **R** (versió 4.5.1 o superior)
   - Descàrrega: https://cran.r-project.org/
   
2. **RStudio** (IDE recomanat)
   - Descàrrega: https://www.rstudio.com/products/rstudio/download/
   
3. **LaTeX** (per generar PDFs amb R Markdown)
   ```r
   install.packages("tinytex")
   tinytex::install_tinytex()
   ```

### Paquets de R necessaris
```r
# Paquets bàsics per al curs
install.packages(c(
  "readr",        # Lectura de dades
  "ggplot2",      # Visualització
  "knitr",        # R Markdown
  "gridExtra",    # Organització de gràfics
  "tinytex"       # Compilació PDF
))
```

### Coneixements previs
- Coneixements bàsics d'estadística
- Nocions d'informàtica a nivell d'usuari
- **No es requereix experiència prèvia en programació**

## 🚀 Com utilitzar aquest repositori

### 1. Clonació del repositori
```bash
git clone https://github.com/ecorreig/Curs-R
cd Curs-R
```

### 2. Configuració de l'espai de treball
- Obre RStudio
- Estableix el directori de treball al directori del curs
- Assegura't que tots els fitxers de la carpeta `input/` són accessibles

### 3. Seguiment de les classes
1. Comença per `classe_0.Rmd` per a la introducció
2. Segueix l'ordre numèric de les classes
3. Practica amb els exercicis corresponents
4. Consulta les solucions només després d'intentar els exercicis

### 4. Compilació dels documents
- Utilitza el botó "Knit" a RStudio per generar els documents HTML/PDF
- Assegura't que tots els paquets necessaris estan instal·lats

## 📖 Recursos addicionals

### Documentació oficial
- [Documentació de R](https://www.r-project.org/other-docs.html)
- [R Markdown Guide](https://rmarkdown.rstudio.com/lesson-1.html)
- [ggplot2 Reference](https://ggplot2.tidyverse.org/reference/)

### Tutorials i guies
- [Swirl](https://swirlstats.com/) - Aprèn R interactivament
- [R for Data Science](https://r4ds.had.co.nz/) - Llibre online gratuït
- [Quick-R](https://www.statmethods.net/) - Referència ràpida

## 🆘 Resolució de problemes comuns

### Error: "object not found"
- Assegura't que has executat tot el codi previ
- Verifica que has carregat les llibreries necessàries

### Error de path/ruta
- Verifica que estàs al directori correcte amb `getwd()`
- Els fitxers de dades han d'estar a la carpeta `input/`

### Problemes de compilació PDF
- Assegura't que tinytex està instal·lat correctament
- Prova primer compilar a HTML abans que PDF

## 👨‍🏫 Autor

**Eudald Correig i Fraga**

## 📄 Estructura de fitxers

```
Curs-R/
├── README.md                          # Aquest fitxer
├── classe_*.Rmd                       # Classes del curs
├── classe_*.html                      # Versions compilades
├── exercicis/                         # Exercicis pràctics
│   ├── exercicis_*.Rmd
│   └── exercicis_*_resolts.Rmd
├── input/                             # Datasets i recursos
│   ├── *.csv                          # Fitxers de dades
│   ├── *.png                          # Imatges i logos
│   └── *.sav                          # Fitxers SPSS
└── scripts específics (*.R)           # Scripts R addicionals
```

## 📊 Nivell del curs

- **Nivell**: Principiant a Intermedi
- **Duració estimada**: 7 sessions + exercicis
- **Modalitat**: Autoestudi amb material estructurat

---

*Aquest curs forma part del material educatiu desenvolupat per a l'aprenentatge pràctic de R en l'àmbit acadèmic i professional.*
