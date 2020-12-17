barplot(VADeaths, beside = TRUE, col = c("lightblue","mistyrose","lightcyan","lavender","cornsilk"),legend = rownames(VADeaths), ylim= c(0,100))
title(main = "Death Rates in Virginia", font.main=4)

boxplot(count~spray, data = InsectSprays, col ="cyan")



View(InsectSprays)
