#Loading required packages
library(usethis)
library(devtools)
devtools::install_github("OmaymaS/yelpr") 

#Set api key
key = "_"

rest = c("college park maryland", "silver spring maryland", "beltsville maryland", "greenbelt maryland", "washingtondc")

for (i in 1:5)
  {
search = business_search(api_key = key,
                     location = rest[i],
                     categories = 'Restaurants',
                     limit = 50)

df=search$businesses

#delete unnecessary data
for (j in c(8,10)) {df[j] = NULL}
df$location$display_address = NULL

c1 = do.call(rbind.data.frame, sapply(search$businesses$categories, "[", 1) )
df = data.frame(df, c1[1])
df = subset(df, select = c(1:3,15,4:14))
names(df)[4] = "category"

#output
write.csv(df, paste('yelp', rest[i], 'csv', sep = '.'))
  }