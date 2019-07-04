# Damit setzen wir das Working Directory auf den Ordner dieser Datei
if (!is.null(parent.frame(2)$ofile)) {
  this.dir <- dirname(parent.frame(2)$ofile)
  setwd(this.dir)
}

library(data.table)
library(ggplot2)
library(caret)

# Daten einlesen
foods <- fread("foods.csv")
foods$clss <- as.factor(foods$clss)

# Train / Test
train.index <- createDataPartition(foods$clss, p = 0.75, list = FALSE)
train <- foods[train.index, ]
test <- foods[-train.index, ]

# Leere Liste anlegen
models <- vector("list", nlevels(foods$clss))
names(models) <- levels(foods$clss)

# Verschiedene Modelle trainieren (one-vs-all)
for (level in levels(foods$clss)) {
  train.now <- train
  train.now$res <- train.now$clss == level
  model <- glm(res ~ energy_100g + fat_100g + carbohydrates_100g + sugars_100g + proteins_100g, 
               family = binomial(),
               data = train.now,
               control = list(maxit = 300))
  
  models[[level]] <- model
}

# Vorhersage auf allen Models durchführen
pred.scores.tmp <- predict(models, test, type="response")

# Heraus kam eine Liste mit Ergebnissen zu jedem Model
# Diese wandeln wir jetzt in eine Matrix um
pred.scores <- matrix(unlist(pred.scores.tmp), ncol = nlevels(foods$clss), byrow = FALSE)
colnames(pred.scores) <- levels(foods$clss)

# Und ermitteln, in welcher Spalte der hoechste Wert stand
# Heraus kommt eine Zahl (hier: zwischen 1-3)
pred.scores.max.col <- max.col(pred.scores)

# Diese Zahl wandeln wir wieder zurueck in "Cola", "Apple" bzw. "Orange" um
preds <- colnames(pred.scores)[pred.scores.max.col]

# Und ermitteln jetzt die Accuracy
print(confusionMatrix(test$clss, preds)$overall["Accuracy"])

