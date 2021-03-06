# MySQL Paket installieren und einbinden

install.packages('RMySQL')
require(RMySQL)




# Mit MySQL verbinden

connection <- dbConnect(
				MySQL(),
				user = 'jgruhne',
				password = 'zu3Wood9',
				host = 'wdb2.hs-mittweida.de',
				client.flag=CLIENT_MULTI_RESULTS
				)





# Datenbank ausw�hlen

sql <- "USE jgruhne"
result <- dbGetQuery(connection , sql)





# Kreisdiagramm mit Anzahl der Baumfarben

sql <- "SELECT Colour, COUNT(Colour) FROM oak_table WHERE Locality != 'Mittweida' GROUP BY Colour"
result <- dbGetQuery(connection , sql)
pie(
	x = result[c(-1:-2),2],								# Werte
	labels = result[c(-1:-2),1], 							# Label
	main = "Anteil der farbigen Baume",						# Titel
	col = c("orange", "lightblue", "red", "white", "yellow")			# Farben
	)




# B�ume in jedem Land als Balkendiagramm

sql <- "SELECT Country, count(Country) FROM oak_table WHERE Locality != 'Mittweida' GROUP BY Country"
result <- dbGetQuery(connection, sql)
barplot(
		result[,2],								# Werte
		xlab = "L�nder",							# Beschriftung x-Achse
		ylab = "Anzahl B�ume",							# Beschriftung y-Achse
		main = "B�ume pro Land",						# Titel
		names.arg = result[,1], 						# Label
		col = c("darkblue", "red", "white")					# Farben
		)




# Meeresh�he der B�ume als Histogramm

sql <- "SELECT Altitude FROM oak_table WHERE Locality != 'Mittweida'"
result <- dbGetQuery(connection, sql)
hist(
		x = result[,1],								# Werte
		xlab = 'H�he �ber NN',							# Beschriftung x-Achse
		ylab = 'Anzahl der B�me',						# Beschriftung y-Achse
		main = 'B�ume nach H�he �ber NN',					# Titel	
		xlim = c(0, 500),							# Spanne x-Achse
		ylim = c(0, 250),							# Spanne y-Achse
		col = c('lightgrey')							# Farben
		)




# Plotten der geografischen Daten

sql <-"SELECT Latitude, Longitude FROM oak_table WHERE Locality != 'Mittweida'"
result <- dbGetQuery(connection, sql)
plot(
		x = result[,2],								# x-Werte
		y = result[,1],								# y-Werte
		type = 'p',								# angezeigte Symbole = Punkt
		main = 'Baumstandorte',							# Titel
		xlab = 'Breitengrad',							# Beschriftung x-Achse
		ylab = 'L�ngengrad',							# Beschriftung y-Achse
		ylim = c(2, -6),							# Grenzen y-Achse
		col = c('black')							# Farben
		)

sql <- "DROP TABLE oak_table"
dbGetQuery(connection, sql)