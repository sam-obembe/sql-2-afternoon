--Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT * FROM invoice
WHERE invoice_id IN (
SELECT invoice_id FROM invoice_line 
 WHERE unit_price>0.99
)

--Get the invoice_date, customer first_name and last_name, and total from all invoices.
SELECT 
invoice.customer_id,
invoice.invoice_date,
invoice.total,
customer.customer_id,
customer.first_name,
customer.last_name
FROM invoice JOIN customer ON invoice.customer_id = customer.customer_id

--Get the customer first_name and last_name and the support rep's first_name and last_name from all customers.Support reps are on the employee table.
SELECT customer.first_name, customer.last_name, 
customer.support_rep_id, employee.employee_id, 
employee.first_name, employee.last_name
FROM customer JOIN employee ON customer.support_rep_id = employee.employee_id

--Get the album title and the artist name from all albums.
SELECT album.artist_id, album.title, artist.artist_id,artist.name
FROM album JOIN artist ON album.artist_id = artist.artist_id

--Get all playlist_track track_ids where the playlist name is Music.
SELECT playlist_track.track_id,
playlist_track.playlist_id,
playlist.playlist_id,
playlist.name
FROM playlist_track JOIN playlist 
ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music'

--Get all track names for playlist_id 5.
SELECT track.track_id, 
track.name,
playlist_track.playlist_id,
playlist_track.track_id
FROM track JOIN playlist_track 
ON track.track_id = playlist_track.track_id
WHERE playlist_track.playlist_id = 5

--Get all track names and the playlist name that they're on ( 2 joins ).
SELECT track.track_id, 
track.name, 
playlist_track.playlist_id,
playlist_track.track_id,
playlist.playlist_id,
playlist.name
FROM (playlist_track 
JOIN track
ON playlist_track.track_id = track.track_id)
JOIN  playlist ON 
playlist_track.playlist_id = playlist.playlist_id


--Get all invoices where the unit_price on the invoice_line is greater than $0.99.
SELECT * FROM  invoice WHERE invoice_id IN(
	SELECT invoice_id FROM invoice_line WHERE
  unit_price>0.99
)

--Get all playlist tracks where the playlist name is Music.
SELECT * FROM playlist_track 
WHERE playlist_id IN(
  SELECT playlist_id FROM playlist WHERE
  name = 'Music'
  )

--Get all track names for playlist_id 5.
SELECT name FROM track WHERE
track_id IN (
SELECT track_id FROM playlist_track WHERE
  playlist_id = 5
)

--Get all tracks where the genre is Comedy.
SELECT * FROM track WHERE genre_id IN(
	SELECT genre_id FROM genre WHERE
  name = 'Comedy'
)

--Get all tracks where the album is Fireball.
SELECT * FROM track WHERE album_id IN(
 SELECT album_id FROM album WHERE 
  title = 'Fireball'
)

--Get all tracks for the artist Queen ( 2 nested subqueries )
SELECT * FROM track WHERE album_id IN(
	SELECT album_id FROM album WHERE artist_id
  IN (
  	SELECT artist_id FROM artist WHERE
    name = 'Queen'
  )
)

--Find all customers with fax numbers and set those numbers to null.
UPDATE customer
SET fax = null 
WHERE fax IS NOT null

--Find all customers with no company (null) and set their company to "Self".
UPDATE customer
SET company = 'Self'
WHERE company IS null

--Find the customer Julia Barnett and change her last name to Thompson.
UPDATE customer
SET last_name = 'Thompson'
WHERE customer_id = 28

--Find the customer with this email luisrojas@yahoo.cl and change his support rep to 4.
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'

--Find all tracks that are the genre Metal and have no composer. Set the composer to "The darkness around us".
UPDATE track
SET composer = 'The darkness around us'
WHERE composer IS null 
AND genre_id IN(
 	SELECT genre_id FROM genre 
   WHERE name = 'Metal'
 ) 


--Find a count of how many tracks there are per genre. Display the genre name with the count.
SELECT COUNT (name), genre_id
FROM track 
GROUP BY genre_id
    
--Find a count of how many tracks are the "Pop" genre and how many tracks are the "Rock" genre.
SELECT COUNT (name), genre_id
FROM track 
WHERE genre_id IN (
	SELECT genre_id FROM genre WHERE
  name = 'Pop'
)
GROUP BY genre_id
    
--Find a list of all artists and how many albums they have.
SELECT COUNT (album_id),  artist_id
FROM album 
GROUP BY artist_id


--From the track table find a unique list of all composers.
SELECT DISTINCT composer
FROM track

--From the invoice table find a unique list of all billing_postal_codes.
SELECT DISTINCT billing_postal_code
FROM invoice

--From the customer table find a unique list of all companys.
SELECT DISTINCT company
FROM customer


--Copy, paste, and run the SQL code from the summary.

--Delete all 'bronze' entries from the table.
DELETE FROM practice_delete 
WHERE type = 'bronze'

--Delete all 'silver' entries from the table.
DELETE FROM practice_delete 
WHERE type = 'silver'

--Delete all entries whose value is equal to 150.
DELETE FROM practice_delete 
WHERE value = 150


--Create 3 tables following the criteria in the summary.
CREATE TABLE users(
name TEXT, 
email TEXT, 
id INTEGER PRIMARY KEY
);

CREATE TABLE product(
  product_id INTEGER PRIMARY KEY,
  price INTEGER,
  name TEXT
)

CREATE TABLE orders(
order_id INTEGER PRIMARY KEY,
product_id INTEGER REFERENCES product(product_id)
);

INSERT INTO users(name, email, id)
VALUES ('tEE', 'tee@gmail.com', 69)

INSERT INTO product(name, price, product_id)
VALUES ('Pen cap', 2, 93)

--Get all orders.
SELECT * FROM orders

--Get all products for the first order.
SELECT name,price FROM product WHERE
product_id IN (
SELECT product_id FROM orders WHERE order_id =1
)

--Get all orders for a user.
SELECT * FROM orders WHERE user_id IN (
 SELECT id FROM users WHERE name = 'PEE'
)

--Get how many orders each user has
SELECT COUNT (order_id),  user_id 
FROM orders
GROUP BY user_id
