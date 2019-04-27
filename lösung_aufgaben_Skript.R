# Lade RMySQL-Paket
require(RMySQL)



# Verbinde mit MySQL
connection <- dbConnect(
				MySQL(),
				user = 'jgruhne',
				password = 'zu3Wood9',
				host = 'wdb2.hs-mittweida.de',
				client.flag=CLIENT_MULTI_RESULTS
				)



# Datenbank auswählen
sql <- "USE jgruhne"
result <- dbGetQuery(connection , sql)



# Erstelle Tabelle
sql <- "CREATE TABLE ebola (
					Indicator VARCHAR(250),
					Country VARCHAR(100),
					Date DATE,
					Value INT)"
dbGetQuery(connection, sql)




# Tabelle einladen
sql <- "LOAD DATA LOCAL INFILE 'ebola_data.csv' INTO TABLE ebola
		FIELDS TERMINATED BY ','
		OPTIONALLY ENCLOSED BY '\"'
		LINES TERMINATED BY '\r\n'
		IGNORE 1 LINES"
dbGetQuery(connection, sql)





# Aufgabe 1
sql <- "SELECT Country FROM ebola 
		GROUP BY Country"
Lösung1 <- dbGetQuery(connection, sql)
print(Lösung1)


# Aufgabe 2
sql <- "SELECT MIN(Date), Max(Date) FROM ebola"
Lösung2 <- dbGetQuery(connection, sql)
print(Lösung2)

# Aufgabe 3
sql <- "SELECT Date FROM ebola GROUP BY Date"
Lösung3 <- dbGetQuery(connection, sql)
print(Lösung3)

# Aufgabe 4
sql <- "SELECT * FROM ebola 
		WHERE Indicator LIKE '%confirmed Ebola deaths%' 
		GROUP BY Country 
		ORDER BY Value"
Lösung4 <- dbGetQuery(connection, sql)
print(Lösung4)


# Aufgabe 5
sql <- "SELECT 'suspected ebola cases', Country, Value FROM ebola 
		WHERE (Indicator, Date) = ('Cumulative number of suspected Ebola cases', '2016-03-23')"
Lösung5 <- dbGetQuery(connection, sql)
print(Lösung5)


# Aufbage 6 (2014)
sql <- "SELECT Value, Date, Country FROM ebola 
		WHERE (Date BETWEEN '2014-01-01' AND '2015-01-01') 
			AND Indicator = 'Cumulative number of confirmed Ebola deaths' 
		GROUP BY Country"
Lösung6a <- dbGetQuery(connection, sql)

# Aufgabe 6 (2015)
sql <- "SELECT Value, Date, Country FROM ebola 
		WHERE (Date BETWEEN '2015-01-01' AND '2016-01-01') 
			AND Indicator = 'Cumulative number of confirmed Ebola deaths' 
		Group BY Country"
Lösung6b <- dbGetQuery(connection, sql)

# Aufgabe 6 (2016)
sql <- "SELECT Value, Date, Country FROM ebola 
		WHERE (Date BETWEEN '2016-01-01' AND '2017-01-01') 
			AND Indicator = 'Cumulative number of confirmed Ebola deaths' 
		GROUP BY Country"
Lösung6c <- dbGetQuery(connection, sql)

print(Lösung6a)
print(Lösung6b)
print(Lösung6c)






