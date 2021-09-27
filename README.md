# MSSQL-Restaurant-Database

#
# **Overview**

Jelp is a campus-based restaurant ranking platform that helps users to search for ideal restaurants based on their diet and location preferences. Users can use this app to evaluate the restaurants they go by rating from star1~5 (5 stars represents the highest recommendation), which will automatically be shared on Jelp platform. Also, users can use the platform to obtain the information of shuttles or stops that close to the restaurant.

#
# **Relational Diagram**

- ER schema and diagram.

**Entity:**

City ( **ctyId** , ctyName, ctyPoppulation, ctyRace, ctyIncome, ctyAge )

Restaurant ( **rstId** , rstName, rstPrice, rstStreet, rstZipcode, rstCity, rstState, rstPhoneNo, rstRating, rstCategory, rstReviewCount, rstLocation, -rstLatitude, -rstLongitude)

User ( **usrId** , usrName)

Review ( **rvwId** , rvwStar, rvwComment )

Shuttle ( **shtId** , shtFrom, shtTo, shtWeekend, shtInterval )

StopLocation ( **stpId** , stpName, stpLocation, -stpLatitude, -stpLongitude)

**Relationship:**

Locate: binary relationship

1 Restaurant to 1 City

1 City to 0 or more Restaurant

Pass: binary relationship

1 Restaurant to 0 or more Shuttles

1 Shuttle to 0 or more Restaurants

Comment With: binary relationship

1 User to 1 or many Reviews

1 Review to 1 User

Is Commented With: binary relationship

1 Review to 1 Restaurant

1 Restaurant to 1 or many Reviews

Stop: binary relationship

1 Shuttle to 1 or more StopLocations

1 StopLocations to 1 or more Shuttles

![](RackMultipart20210927-4-1i4jhp5_html_f2be81360c40b040.jpg)

## **Getting Started**

**Built With**

- [RStudio](https://rstudio.com/) &amp; [R](https://www.r-project.org/) - Fetching Yelp data, Cleaning data
- [Microsoft SQL Server](https://www.microsoft.com/en-us/sql-server/default.aspx) - Building database
- [Tableau](https://www.tableau.com/) - Visualizing

### **Preparing**

Follow the instruction to install R studio first:
[Download R and RStudio](http://bit.ly/2sRNZFb)

Install the RStudio package [yelpr](https://github.com/OmaymaS/yelpr)

devtools::install\_github(&quot;OmaymaS/yelpr&quot;)

To use the package, you need a Yelp Fusion account to acquire the user API key.
https://www.yelp.com/developers/v3/manage\_app

For the restaurant data you need, execute the R script file to fetch restaurant data you need. You may modify the restaurant keywords to search the location or categories you need. If you wish to fetch more than 50 restaurant data per search, you can use offset features.

More commands please refer to https://www.yelp.com/developers/documentation/v3/get\_started

The dataset was processed by using R. After cleaning and normalizing the data will ouput as CSV files.
 ![](RackMultipart20210927-4-1i4jhp5_html_fe1fbb497898cb6e.png)

## **Usage**

Now the database is in good shape and you can use the SQL server to write some query statements

Example queries:

What are the average price, average rating and average reviewcounts of each type of restaurant in College Park?

_SELECT c.ctyName, r.rstCategory, AVG(r.rstPrice) AS &#39;avg\_Price&#39;, AVG(r.rstRating) AS &#39;avg\_Rating&#39;,_

_AVG(r.rstReviewCount) AS &#39;avg\_ReviewCounts&#39;_

_FROM [Jelp.Restaurant] r, [Jelp.City]c_

_WHERE r.ctyId=c.ctyId AND c.ctyName = &#39;College Park&#39;_

_GROUP BY rstCategory, c.ctyName_

![](RackMultipart20210927-4-1i4jhp5_html_9055066cf4fa295d.png)

#


# **Visualizing**

What is the price of all restaurants?

![](RackMultipart20210927-4-1i4jhp5_html_3e8c4b0013147d3.png)

Example: An overview dashboard of city

![](RackMultipart20210927-4-1i4jhp5_html_b315842d3228e57d.png)
