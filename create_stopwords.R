stopwords <- c(
   "miękka", "miekka", "twarda", "okładka", "okladka", "oprawa", "op",
   "książka", "ksiazka", "książki", "ksiazki", "książek", "ksiazek", "fantasy",
   paste0("t", 1:100), "tom", "tomy", paste0("tom", 1:100), paste0("t.", 1:100),
   10:3000, paste0(1, "-", 2:100), paste0(2:100, "x"),
   "ksiąg", "ksiag", paste0(2:100, "ksiąg"), paste0(2:100, "ksiag"),
   "wysyłka", "wysylka", "24h", "nowa", "nowe", "pakiet",
   "stan", "db", "db+", "bdb", "bdb+", "hit"
)
stopwords <- data.frame(stopwords = stopwords, stringsAsFactors = FALSE)

write.csv(stopwords, "stopwords.csv", row.names = FALSE, fileEncoding = "UTF-8")
