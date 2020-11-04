CREATE TABLE AUTHORS (id SERIAL PRIMARY KEY, name VARCHAR(255));
-- creat Table insid the lab14_normal's data base
-- this table contains two fields
-- the first one has named "id" and include a serial primary key that will be generate auto as a related to the other fields
-- the second one has named 'name' and it is emptay.

INSERT INTO authors(name) SELECT DISTINCT author FROM books;
-- This query will use a simple subquery to retrieve unique author values from the books table and insert each one into the authors table in the name column.
--This is a great pattern for copying lots of data between tables.

ALTER TABLE books ADD COLUMN author_id INT;
-- This query will add a column to the books table named author_id.
--This will connect each book to a specific author in the other table.

UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;
--This query will prepare a connection between the two tables.
--It works by running a subquery for every row in the books table.
--The subquery finds the author row that has a name matching the current book’s author value.
--The id of that author row is then set as the value of the author_id property in the current book row.

ALTER TABLE books DROP COLUMN author;
-- This query will modify the books table by removing the column named author.
--Now that the books table contains a author_id column which will become a foreign key, your table does not need to contain a string representing each author

ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);
--This query will modify the data type of the author_id in the books table, setting it as a foreign key which references the primary key in the authors table.
--Now PostgreSQL knows HOW these 2 tables are connected.