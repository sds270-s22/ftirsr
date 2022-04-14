library(pls)


bsi_mod <- plsr(bsi_percent~., ncomp = 10, data = greenland, validation = "CV", segments = 10)
summary(bsi_mod)

build_mod <- function(x){
  # need to vectorize this!
  if(x == greenland){
    pivot_longer()
  }
}


bsi_mod <- function(...){

  plsr(ncomp = 10)

}
