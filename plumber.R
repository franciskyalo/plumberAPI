
# load the  plumber package 
library(plumber)

# load the saved model 

mpgmodel <- read_rds("model-mpg.rds")

# create a dataframe to predict

to_predict <- data.frame(cty=20, displ=1.8)


#* @apiTitle MPG highway miles per gallon prediction

#* @get /hwy

#* @apiDescription This API serves up predictions of highway miles per gallon based on city miles per gallon and engine displacement

#* @param  cty_var  city miles per gallon

#* @param  displ_var  engine displacement 

function(cty_var, displ_var){
  
  to_predict <- data.frame(cty= as.numeric(cty_var),
                           displ= as.numeric(displ_var))
  
  predict(mpgmodel,to_predict )
}
