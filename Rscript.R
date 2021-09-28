#Loading required packages
library(usethis)
library(devtools)
devtools::install_github("OmaymaS/yelpr") 

#Set api key
key = "_"

rest = c("college park maryland", "silver spring maryland", "beltsville maryland", "greenbelt maryland", "washingtondc")

for (i in 1:5)
  {
d1 = business_search(api_key = key,
                     location = rest[i],
                     categories = 'Restaurants',
                     limit = 50)

d2=d1$businesses

#delete unnecessary data
for (j in c(8,10)) {d2[j] = NULL}
d2$location$display_address = NULL

c1 = do.call(rbind.data.frame, sapply(d1$businesses$categories, "[", 1) )
d2 = data.frame(d2, c1[1])
d2 = subset(d2, select = c(1:3,15,4:14))
names(d2)[4] = "category"

#output
write.csv(d2, paste('yelp', rest[i], 'csv', sep = '.'))
  }