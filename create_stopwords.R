
stopwords <- c(
   "miękka", "miekka", "twarda", "okładka", "okladka", "oprawa", "op",
   "książka", "ksiazka", "książki", "ksiazki", "książek", "ksiazek",
   paste0("t", 1:100), "tom", "tomy", paste0("tom", 1:100), paste0("t.", 1:100),
   10:3000, paste0(1, "-", 2:100), paste0(2:100, "x"),
   "ksiąg", "ksiag", paste0(2:100, "ksiąg"), paste0(2:100, "ksiag"),
   "wysyłka", "wysylka", "24h", "nowa", "nowe", "pakiet"
)
stopwords <- data.frame(stopwords = stopwords)

write.csv(stopwords, "stopwords.csv", row.names = FALSE)
