--1.How many kinds of restaurants in each city?
SELECT r.rstCity, COUNT(DISTINCT r.rstCategory) AS 'Number of Category'
FROM [Jelp.Restaurant] r
GROUP BY r.rstCity
ORDER BY r.rstCity ASC, COUNT(r.rstCategory) DESC

--2.What is the average price, average rating and average reviewcounts of each type of restaurant in College Park?
SELECT c.ctyName, r.rstCategory, AVG(r.rstPrice) AS 'avg_Price', AVG(r.rstRating) AS 'avg_Rating', 
	AVG(r.rstReviewCount) AS 'avg_ReviewCounts'
FROM [Jelp.Restaurant] r, [Jelp.City]c
WHERE r.ctyId=c.ctyId AND c.ctyName = 'College Park'
GROUP BY rstCategory, c.ctyName

--3. What is  the price level compared to the income in each city?
SELECT r.rstCity, AVG(r.rstPrice) AS 'Average Price', c.ctyIncome
FROM [Jelp.Restaurant] r, [Jelp.City] c
WHERE c.ctyId = r.ctyId
GROUP BY r.rstCity, c.ctyIncome
ORDER BY r.rstCity

--4. What is the average price and average rating of the restaurants by which every shuttle passes?
SELECT p.shtId, avg(r.rstRating) AS 'Average Rating', avg(r.rstPrice) AS 'Average Price'
FROM [Jelp.Restaurant] r, [Jelp.Pass] p
WHERE r.rstId = p.rstId
GROUP BY p.shtId

--5. What is the restaurants rating distribution of each city?
SELECT c.ctyName, MAX(r.rstRating) AS 'highest rating',AVG(r.rstRating) AS 'average rating', MIN(r.rstRating) AS 'lowest rating' 
FROM [Jelp.Restaurant] r, [Jelp.City] c
WHERE c.ctyId = r.ctyId
GROUP BY c.ctyName

--6. What are the name, price, rating and number of reviews of the restaurants by which shuttle 143 passes?
SELECT p.shtId, r.rstName, r.rstRating , r.rstPrice, r.rstReviewCount
FROM [Jelp.Restaurant] r, [Jelp.Pass] p
WHERE p.rstId = r.rstId AND p.shtId = 'B0143'
ORDER BY r.rstRating DESC, r.rstReviewCount DESC

--7. What are the top 5 stops closest to the restaurant R0012?
SELECT TOP 5 * FROM (SELECT r.rstName, s.stpName, st.shtId, (6371 * acos( 
                cos( radians(s.stpLatitude) ) 
              * cos( radians( r.rstLatitude ) ) 
              * cos( radians( r.rstLongitude ) - radians(s.stpLongitude) ) 
              + sin( radians(s.stpLatitude) ) 
              * sin( radians(r.rstLatitude) )
                ) ) AS 'distance(KM)'
				FROM [Jelp.StopLocation] s, [Jelp.Restaurant] r, [Jelp.Stop] st
				WHERE r.rstId = 'R0012' AND s.stpId = st.stpId				
				) a
ORDER BY 'distance(KM)'



