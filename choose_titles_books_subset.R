dane = read.csv("titles_books.csv", encoding = "UTF-8", stringsAsFactors = FALSE)

library(stringi)
tytuly2 = dane$title
tytuly = stri_trans_tolower(tytuly2)

martin = stri_detect_regex(tytuly, "gra o tron")
tytuly[martin]
m = sample(which(martin), 10)

m1 = stri_detect_regex(tytuly, "gra o tron starcie królów")
tytuly[m1]
m1 = sample(which(m1), 5)

m2 = stri_detect_regex(tytuly, "gra o tron taniec ze smokami")
tytuly[m2]
m2 = sample(which(m2), 5)

m3 = stri_detect_regex(tytuly, "gra o tron nawałnica mieczy")
tytuly[m3]
m3 = sample(which(m3), 5)

m4 = stri_detect_regex(tytuly, "gra o tron uczta dla wron")
tytuly[m4]
m4 = sample(which(m4), 5)

tolkien = stri_detect_regex(tytuly, "tolkien")
tytuly[tolkien]
t = sample(which(tolkien), 10)

t1 = stri_detect_regex(tytuly, "tolkien silmarillion")
tytuly[t1]
t1 = sample(which(t1), 5)

t2 = stri_detect_regex(tytuly, "j.r.r. tolkien hobbit")
tytuly[t2]
t2 = sample(which(t2), 5)

t3 = stri_detect_regex(tytuly, "tolkien dwie wieże")
tytuly[t3]
t3 = sample(which(t3), 5)

t4 = stri_detect_regex(tytuly, "władca pierścieni bractwo")
tytuly[t4]
t4 = sample(which(t4), 5)

sapkowski = stri_detect_regex(tytuly, "sapkowski")
tytuly[sapkowski]
s = sample(which(sapkowski), 10)

s1 = stri_detect_regex(tytuly, "sapkowski wieża jaskółki")
tytuly[s1]
s1 = sample(which(s1), 5)

s2 = stri_detect_regex(tytuly, "sapkowski sezon burz")
tytuly[s2]
s2 = sample(which(s2), 5)

s3 = stri_detect_regex(tytuly, "sapkowski miecz przeznaczenia")
tytuly[s3]
s3 = sample(which(s3), 5)

s4 = stri_detect_regex(tytuly, "wiedźmin ostatnie życzenie")
tytuly[s4]
s4 = sample(which(s4), 5)

starwars = stri_detect_regex(tytuly, "star wars")
tytuly[starwars]
sw = sample(which(starwars), 10)

sw1 = stri_detect_regex(tytuly, "star wars. lordowie sithów")
tytuly[sw1]
sw1 = sample(which(sw1), 5)

sw2 = stri_detect_regex(tytuly, "powrót jedi")
tytuly[sw2]
sw2 = sample(which(sw2), 5)

sw3 = stri_detect_regex(tytuly, "star wars łotr 1")
tytuly[sw3]
sw3 = sample(which(sw3), 5)

sw4 = stri_detect_regex(tytuly, "star wars przeznaczenie jedi")
tytuly[sw4]
sw4 = sample(which(sw4), 5)

assassinscreed = stri_detect_regex(tytuly, "assassin")
tytuly[assassinscreed]
ac = sample(which(assassinscreed), 10)

ac1 = stri_detect_regex(tytuly, "creed renesans")
tytuly[ac1]
ac1 = sample(which(ac1), 5)

ac2 = stri_detect_regex(tytuly, "creed czarna bandera")
tytuly[ac2]
ac2 = sample(which(ac2), 5)

ac3 = stri_detect_regex(tytuly, "creed bractwo")
tytuly[ac3]
ac3 = sample(which(ac3), 5)

ac4 = stri_detect_regex(tytuly, "creed pojednanie")
tytuly[ac4]
ac4 = sample(which(ac4), 5)

wybor = c(m1, m2, m3, m4, 
          t1, t2, t3, t4,
          s1, s2, s3, s4,
          sw1, sw2, sw3, sw4,
          ac1, ac2, ac3, ac4)
#wybor = c(m, t, s, sw, ac)
tytuly_wybor = tytuly2[wybor]
tytuly_wybor

write.csv(tytuly_wybor, file = "titles_books_chosen.csv", fileEncoding = "UTF-8")

porownanie = read.csv("titles_books_chosen_comparison.csv", encoding = "UTF-8", stringsAsFactors = FALSE)
porownanie = porownanie[,-1]
porownanie = as.matrix(porownanie)
colnames(porownanie) = tytuly_wybor
row.names(porownanie) = tytuly_wybor

library(plotly)
plot_ly(x = tytuly_wybor, y = tytuly_wybor, z = porownanie, type = "heatmap")
