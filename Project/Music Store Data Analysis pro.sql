-- create database music_store_pro;
use music_store_pro;

-- 1. Genre and MediaType
CREATE TABLE Genre (
	genre_id INT PRIMARY KEY,
	name VARCHAR(120)
);

CREATE TABLE MediaType (
	media_type_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 2. Employee
CREATE TABLE Employee (
	employee_id INT PRIMARY KEY,
	last_name VARCHAR(120),
	first_name VARCHAR(120),
	title VARCHAR(120),
	reports_to INT,
  levels VARCHAR(255),
	birthdate DATE,
	hire_date DATE,
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100)
);

-- 3. Customer
CREATE TABLE Customer (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(120),
	last_name VARCHAR(120),
	company VARCHAR(120),
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100),
	support_rep_id INT,
	FOREIGN KEY (support_rep_id) REFERENCES Employee(employee_id)
);

-- 4. Artist
CREATE TABLE Artist (
	artist_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 5. Album
CREATE TABLE Album (
	album_id INT PRIMARY KEY,
	title VARCHAR(160),
	artist_id INT,
	FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);

-- 6. Track
CREATE TABLE Track (
	track_id INT PRIMARY KEY,
	name VARCHAR(200),
	album_id INT,
	media_type_id INT,
	genre_id INT,
	composer VARCHAR(220),
	milliseconds INT,
	bytes INT,
	unit_price DECIMAL(10,2),
	FOREIGN KEY (album_id) REFERENCES Album(album_id),
	FOREIGN KEY (media_type_id) REFERENCES MediaType(media_type_id),
	FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

-- 7. Invoice
CREATE TABLE Invoice (
	invoice_id INT PRIMARY KEY,
	customer_id INT,
	invoice_date DATE,
	billing_address VARCHAR(255),
	billing_city VARCHAR(100),
	billing_state VARCHAR(100),
	billing_country VARCHAR(100),
	billing_postal_code VARCHAR(20),
	total DECIMAL(10,2),
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- 8. InvoiceLine
CREATE TABLE InvoiceLine (
	invoice_line_id INT PRIMARY KEY,
	invoice_id INT,
	track_id INT,
	unit_price DECIMAL(10,2),
	quantity INT,
	FOREIGN KEY (invoice_id) REFERENCES Invoice(invoice_id),
	FOREIGN KEY (track_id) REFERENCES Track(track_id)
);

-- 9. Playlist
CREATE TABLE Playlist (
 	playlist_id INT PRIMARY KEY,
	name VARCHAR(255)
);

-- 10. PlaylistTrack
CREATE TABLE PlaylistTrack (
	playlist_id INT,
	track_id INT,
	PRIMARY KEY (playlist_id, track_id),
	FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id),
	FOREIGN KEY (track_id) REFERENCES Track(track_id)
);

-- here manual inserting one record which is missing while loading the from csv files
insert into employee(employee_id,last_name,first_name,title,levels,birthdate,hire_date,address,city,state,country,postal_code,phone,fax,email)
values(9,'Madan','Mohan','Senior General Manager','L7','1961-01-26','2016-01-14','1008 Vrinda Ave MT','Edmonton','AB','Canada','T5K 2N1','+1 (780) 428-9482','+1 (780) 428-3457','madan.mohan@chinookcorp.com');


-- 1. Who is the senior most employee based on job title? 
select *From employee;

SELECT 
    first_name, 
    last_name, 
    title
FROM Employee
ORDER BY title desc
LIMIT 1;

-- 2. Which countries have the most Invoices?
select *from invoice;

SELECT BILLING_COUNTRY AS COUNTRY_NAME, COUNT(*) AS NUM_OF_INVOICE
FROM INVOICE
GROUP BY BILLING_COUNTRY
ORDER BY 1 DESC
LIMIT 1;

-- 3. What are the top 3 values of total invoice?
SELECT * FROM INVOICE ORDER BY TOTAL DESC LIMIT 3;

-- 4. Which city has the best customers? - We would like to throw a promotional Music Festival in the city we made the most money. 
	-- Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
SELECT BILLING_CITY AS CITY , SUM(TOTAL) AS TOTAL_INVOICE
FROM INVOICE
GROUP BY BILLING_CITY
ORDER BY TOTAL_INVOICE DESC
LIMIT 1;

-- 5. Who is the best customer? - The customer who has spent the most money will be declared the best customer. 
	-- Write a query that returns the person who has spent the most money
SELECT *FROM INVOICE;

SELECT *FROM CUSTOMER;

SELECT INV.CUSTOMER_ID,
	   CUS.FIRST_NAME,
       CUS.LAST_NAME,
	   SUM(TOTAL) AS INVOICE_AMOUNT
FROM INVOICE INV,
CUSTOMER CUS
WHERE INV.CUSTOMER_ID = CUS.CUSTOMER_ID
GROUP BY INV.CUSTOMER_ID,
	   CUS.FIRST_NAME,
       CUS.LAST_NAME
ORDER BY INVOICE_AMOUNT DESC
LIMIT 1;


-- 6. Write a query to return the email, first name, last name, & Genre of all Rock Music listeners. 
	-- Return your list ordered alphabetically by email starting with A
SELECT C.EMAIL
	  ,C.FIRST_NAME
      ,C.LAST_NAME
FROM CUSTOMER C
	,INVOICE I
    ,INVOICELINE IL
    ,TRACK T
    ,GENRE G
WHERE C.CUSTOMER_ID = I.CUSTOMER_ID
AND I.INVOICE_ID = IL.INVOICE_ID
AND IL.TRACK_ID = T.TRACK_ID
AND T.GENRE_ID = G.GENRE_ID
AND G.NAME LIKE 'ROCK'
ORDER BY C.EMAIL ASC;

-- 7. Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands 
SELECT A.NAME AS ARTIST_NAME
	  ,COUNT(T.TRACK_ID) AS NUM_OF_TRACKS
FROM ARTIST A 
JOIN ALBUM AB ON A.ARTIST_ID = AB.ARTIST_ID
JOIN TRACK T ON T.ALBUM_ID = AB.ALBUM_ID
JOIN GENRE G ON G.GENRE_ID = T.GENRE_ID
WHERE G.NAME LIKE 'ROCK'
GROUP BY A.NAME
ORDER BY NUM_OF_TRACKS DESC
LIMIT 10;


-- 8. Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length, with the longest songs listed first
SELECT T.NAME
	  ,T.MILLISECONDS
FROM TRACK T
WHERE MILLISECONDS >(SELECT AVG(MILLISECONDS) FROM TRACK)
ORDER BY T.MILLISECONDS DESC;


-- 9. Find how much amount is spent by each customer on artists? Write a query to return customer name, artist name and total spent 
SELECT CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS CUSTOMER_NAME
	  ,AR.NAME AS ARTIST_NAME
      ,SUM(IL.UNIT_PRICE * IL.QUANTITY) AS TOTAL_SPENT
FROM CUSTOMER C	,INVOICE I
    ,INVOICELINE IL    ,TRACK T
    ,ALBUM AB    ,ARTIST AR
WHERE C.CUSTOMER_ID = I.CUSTOMER_ID
AND I.INVOICE_ID = IL.INVOICE_ID
AND IL.TRACK_ID = T.TRACK_ID
AND T.ALBUM_ID = AB.ALBUM_ID
AND AB.ARTIST_ID = AR.ARTIST_ID
GROUP BY C.CUSTOMER_ID,AR.ARTIST_ID
ORDER BY TOTAL_SPENT DESC;

-- 10. We want to find out the most popular music Genre for each country. 
-- We determine the most popular genre as the genre with the highest amount of purchases. 
-- Write a query that returns each country along with the top Genre. 
-- For countries where the maximum number of purchases is shared, return all Genres
-- Find top Genre per country based on number of purchases
WITH GenreCountry AS (
    SELECT 
        c.country,
        g.name AS GenreName,
        COUNT(il.quantity) AS Purchases
    FROM InvoiceLine il
    JOIN Invoice i ON il.invoice_id = i.invoice_id
    JOIN Customer c ON i.customer_id = c.customer_id
    JOIN Track t ON il.track_id = t.track_id
    JOIN Genre g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name
),
RankedGenre AS (
    SELECT 
        country,
        GenreName,
        Purchases,
        RANK() OVER (PARTITION BY country ORDER BY Purchases DESC) AS GenreRank
    FROM GenreCountry
)
SELECT 
    country,
    GenreName,
    Purchases
FROM RankedGenre
WHERE GenreRank = 1;


-- 11. Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount Top spending customer for each country
WITH CustomerSpending AS (
    SELECT 
        c.country,c.first_name,c.last_name,SUM(i.total) AS TotalSpent
    FROM Customer c
    JOIN Invoice i ON c.customer_id = i.customer_id
    GROUP BY c.country, c.customer_id
),
RankedSpending AS (
    SELECT 
        country,first_name,last_name,TotalSpent,
        RANK() OVER (PARTITION BY country ORDER BY TotalSpent DESC) AS RankByCountry
    FROM CustomerSpending
)
SELECT 
    country,concat(first_name,' ',last_name) as customer_name,TotalSpent
FROM RankedSpending
WHERE RankByCountry = 1;