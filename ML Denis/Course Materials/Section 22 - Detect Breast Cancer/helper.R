library(ggplot2)

plot_classifier <- function(model, data, formula, proba = FALSE, xlab = NULL, ylab = NULL) {
  stopifnot(typeof(formula[[1]]) == "symbol")
  
  xcol <- formula[[3]][[2]]
  ycol <- formula[[3]][[3]]
  zcol <- formula[[2]]
  
  xmin <- floor(min(data[, eval(xcol)])) - 5
  xmax <- ceiling(max(data[, eval(xcol)])) + 5
  
  ymin <- floor(min(data[, eval(ycol)])) - 5
  ymax <- ceiling(max(data[, eval(ycol)])) + 5
  
  expand.grid.params <- list(
    (1:251 - 1) * ((xmax - xmin) / 250) + xmin, 
    (1:251 - 1) * ((ymax - ymin) / 250) + ymin
  )
  
  names(expand.grid.params) <- c(xcol, ycol)
  zz <- do.call(expand.grid, expand.grid.params)
  
  if (proba == FALSE) {
    clss <- class(model)[1]
    if (clss == "knn3") {
      result <- predict(model, zz)
    } else if (clss == "train") { # caret
      result<- predict(model, zz, type = "prob")
    } else if (clss == "rpart") { # rpart
      result <- predict(model, zz, type = "prob")
    } else if (clss == "naiveBayes") { #1701
      result <- predict(model, zz, type = "class")
    } else if (clss == "naive_bayes") { # naivebayes
      result <- predict(model, zz, type = "class")
    } else {
      result <- predict(model, zz, type = "response")
    }
    
    if (class(result) == "factor") {
      result <- as.numeric(levels(result)[result])
    }
    if (class(result) == "matrix" | class(result) == "data.frame") {
      result <- as.numeric(result[, 2])
    }
    
    zz$result <- round(result)
    g <- ggplot(data, aes_string(xcol, ycol)) + 
      geom_raster(data = zz, aes(fill = result), alpha = 0.5) +
      scale_fill_gradientn(colors=c("#c1747a", "#9ca3d6"), guide = FALSE) + 
      geom_point(aes_string(color = zcol), show.legend = FALSE) + 
      scale_color_manual(values=c("#961e28FF", "#28327DFF")) + 
      scale_x_continuous(xlab, limits = c(xmin, xmax), expand = c(0, 0)) + 
      scale_y_continuous(ylab, limits = c(ymin, ymax), expand = c(0, 0))
    
    return(g)
  } else {
    clss <- class(model)[1]
    print(clss)
    if (clss == "knn3") {
      result <- predict(model, zz)
    } else if (clss == "randomForest.formula") { # randomForest
      result <- predict(model, zz, type = "prob")
    } else if (clss == "rpart") { # rpart
      result <- predict(model, zz, type = "prob")
    } else if (clss == "train") { # caret
      result <- predict(model, zz, type = "prob")
    } else if (clss == "svm.formula") { #e1701
      result <- attr(predict(model, zz, probability = TRUE), "probabilities")
    } else if (clss == "naiveBayes") { # e1701
      result <- predict(model, zz, type = "raw")
    } else if (clss == "naive_bayes") { # naivebayes
      result <- predict(model, zz, type = "prob")
    } else {
      result <- predict(model, zz, type = "response")
    }
    
    if (class(result)[1] == "factor") {
      result <- as.numeric(levels(result)[result])
    }
    if (class(result)[1] == "matrix" | class(result)[1] == "data.frame") {
      result <- as.numeric(result[, 2])
    }
    
    zz$result <- result
    
    g <- ggplot(data, aes_string(xcol, ycol), environment = environment()) + 
      geom_raster(data = zz, aes(fill = result), alpha = I(0.5)) +
      scale_fill_gradientn(colors=c("#c1747a", "#ffffffff", "#9ca3d6"), guide = FALSE) + 
      geom_point(aes_string(color = zcol), show.legend = FALSE) + 
      geom_contour(data = zz, aes(z = result), breaks = I(0.5), color = I("black")) + 
      scale_color_manual(values=c("#961e28FF", "#28327DFF")) + 
      scale_x_continuous(xlab, limits = c(xmin, xmax), expand = c(0, 0)) + 
      scale_y_continuous(ylab, limits = c(ymin, ymax), expand = c(0, 0))
    
    return(g)
  }
}