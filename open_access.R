library(data.table)

#set working directory
setwd('/Users/analutzky/Desktop')

#lire le fichier des effectifs d'étudiants inscrits
Table=fread('open-access-monitor-france.csv')


### regarder l'objet
# afficher les premières et dernières ligne de apb (pour des objets de type data.table)
Table
# afficher les noms de colonnes
colnames(Table)
# dans R studio (pour des tableaux pas trop grands) 
View(Table)
# -> affichage excel-like

var.names=colnames(Table)

### supprimer les espaces et caractères spéciaux des noms de colonnes
colnames(Table)=make.names(var.names)

# afficher les nouveaux noms de colonnes
colnames(Table)


# tableau croisé dynamique du nombre d'articles ayant un doi par année et par degré d'ouverture
TCD_year = Table[,.(count=length(doi)),by=.(year,oa_host_type)]

# dcast
TCD_year = dcast(TCD_year,
				year~oa_host_type,
				value.var=c("count"))

TCD_field = Table[,.(count=length(doi)),by=.(scientific_field,oa_host_type)]
TCD_field = dcast(TCD_field,
				scientific_field~oa_host_type,
				value.var=c("count"))

TCD_publisher = Table[,.(count=length(doi)),by=.(publisher,oa_host_type)]
TCD_publisher = dcast(TCD_publisher,
				publisher~oa_host_type,
				value.var=c("count"))

var.names=colnames(TCD_publisher)
### supprimer les espaces et caractères spéciaux des noms de colonnes
colnames(TCD_publisher)=make.names(var.names)
# afficher les nouveaux noms de colonnes
colnames(TCD_publisher)


TCD_publisher=setorder(TCD_publisher,closed.access)