--  NexusPort E-Commerce Database Sample 

-- a realistic mock e-commerce database designed for PostgreSQL.
-- It was created specifically for educational purposes

-- =======================================================
-- PostgreSQL ENV SETTINGS 
-- =======================================================

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;


-- =======================================================
-- 0. SCHEMA DROPS (for Clean Restart)
-- =======================================================

DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS addresses CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS categories CASCADE;


-- =======================================================
-- 1. TABLE DEFINITIONS
-- =======================================================

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    birth_date DATE NOT NULL,
    phone_number VARCHAR(20) NOT NULL
);

-- Categories Table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE NOT NULL
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT NOT NULL REFERENCES categories(category_id)
);

-- Addresses Table
CREATE TABLE addresses (
    address_id INT PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    address_line1 VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    is_default BOOLEAN NOT NULL
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    order_date TIMESTAMP WITH TIME ZONE NOT NULL,
    total_amount NUMERIC(10, 2), 
    order_status VARCHAR(20) NOT NULL
);

-- Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity INT NOT NULL,
    price_at_order NUMERIC(10, 2) NOT NULL,
    line_total NUMERIC(10, 2) NOT NULL
);

-- Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE REFERENCES orders(order_id),
    payment_method VARCHAR(50) NOT NULL,
    payment_date TIMESTAMP WITH TIME ZONE NOT NULL,
    payment_amount NUMERIC(10, 2) NOT NULL,
    transaction_status VARCHAR(20) NOT NULL
);

-- Reviews Table
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products(product_id),
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    rating SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT
);

-- =======================================================
-- 2. DATA INSERTION
-- =======================================================

-- 1. categories (7 Records)
INSERT INTO categories (category_id, category_name) VALUES
(1, 'Electronics'), (2, 'Apparel'), (3, 'Books'), (4, 'Home & Living'),
(5, 'Sports'), (6, 'Accessories'), (7, 'Food & Beverage');


-- 2. customers (100 Records)
INSERT INTO customers (customer_id, first_name, last_name, email, birth_date, phone_number) VALUES
(1, 'Walter', 'White', 'walter.white1@breakingbad.com', '1986-07-14', '+1 (555) 231-45-87'),
(2, 'Jon', 'Snow', 'jon.snow1@got.com', '1999-02-05', '+1 (555) 482-36-19'),
(3, 'Saul', 'Goodman', 'saul.goodman1@bettercallsaul.com', '1994-08-02', '+1 (555) 197-28-63'),
(4, 'Michael', 'Scofield', 'michael.scofield1@prisonbreak.com', '1985-11-20', '+1 (555) 356-94-12'),
(5, 'Jesse', 'Pinkman', 'jesse.pinkman1@breakingbad.com', '1995-04-13', '+1 (555) 408-73-21'),
(6, 'Daenerys', 'Targaryen', 'daenerys.targaryen1@got.com', '1981-04-08', '+1 (555) 523-19-84'),
(7, 'Kim', 'Wexler', 'kim.wexler1@bettercallsaul.com', '1981-10-25', '+1 (555) 689-42-35'),
(8, 'Lincoln', 'Burrows', 'lincoln.burrows1@prisonbreak.com', '2001-04-27', '+1 (555) 274-68-09'),
(9, 'Hank', 'Schrader', 'hank.schrader1@breakingbad.com', '1984-04-10', '+1 (555) 391-57-46'),
(10, 'Tyrion', 'Lannister', 'tyrion.lannister1@got.com', '1988-04-07', '+1 (555) 146-82-79'),
(11, 'Nacho', 'Varga', 'nacho.varga1@bettercallsaul.com', '1995-05-29', '+1 (555) 837-24-65'),
(12, 'Sara', 'Tancredi', 'sara.tancredi1@prisonbreak.com', '1997-05-07', '+1 (555) 468-31-90'),
(13, 'Skyler', 'White', 'skyler.white1@breakingbad.com', '1997-03-26', '+1 (555) 209-74-18'),
(14, 'Arya', 'Stark', 'arya.stark1@got.com', '1998-11-11', '+1 (555) 574-68-03'),
(15, 'Gus', 'Fring', 'gus.fring1@breakingbad.com', '1986-09-10', '+1 (555) 685-29-41'),
(16, 'Cersei', 'Lannister', 'cersei.lannister1@got.com', '1991-09-07', '+1 (555) 132-47-95'),
(17, 'Jimmy', 'McGill', 'jimmy.mcgill1@bettercallsaul.com', '1981-06-29', '+1 (555) 926-13-78'),
(18, 'Fernando', 'Sucre', 'fernando.sucre1@prisonbreak.com', '1984-02-07', '+1 (555) 347-50-62'),
(19, 'Mike', 'Ehrmantraut', 'mike.ehrmantraut1@breakingbad.com', '2004-11-16', '+1 (555) 718-96-24'),
(20, 'Brienne', 'OfTarth', 'brienne.oftarth1@got.com', '2000-07-17', '+1 (555) 251-83-09'),
(21, 'Lalo', 'Salamanca', 'lalo.salamanca1@bettercallsaul.com', '1980-02-23', '+1 (555) 604-29-75'),
(22, 'Theodore', 'T-Bag', 'theodore.t-bag1@prisonbreak.com', '2003-08-29', '+1 (555) 478-16-93'),
(23, 'Marie', 'Schrader', 'marie.schrader1@breakingbad.com', '2003-12-03', '+1 (555) 835-42-61'),
(24, 'Sansa', 'Stark', 'sansa.stark1@got.com', '1988-07-04', '+1 (555) 362-89-14'),
(25, 'Howard', 'Hamlin', 'howard.hamlin1@bettercallsaul.com', '1995-01-24', '+1 (555) 419-57-28'),
(26, 'Alex', 'Mahone', 'alex.mahone1@prisonbreak.com', '1980-04-05', '+1 (555) 597-03-86'),
(27, 'Todd', 'Alquist', 'todd.alquist1@breakingbad.com', '1995-08-27', '+1 (555) 284-71-59'),
(28, 'Jorah', 'Mormont', 'jorah.mormont1@got.com', '1983-02-02', '+1 (555) 630-48-12'),
(29, 'Chuck', 'McGill', 'chuck.mcgill1@bettercallsaul.com', '1995-05-05', '+1 (555) 715-20-43'),
(30, 'Paul', 'Kellerman', 'paul.kellerman1@prisonbreak.com', '1987-01-16', '+1 (555) 492-36-87'),
(31, 'Hector', 'Salamanca', 'hector.salamanca1@breakingbad.com', '1983-11-26', '+1 (555) 168-95-24'),
(32, 'Ramsay', 'Bolton', 'ramsay.bolton1@got.com', '2000-10-11', '+1 (555) 803-62-19'),
(33, 'Gale', 'Boetticher', 'gale.boetticher1@breakingbad.com', '1994-05-22', '+1 (555) 376-18-54'),
(34, 'Melisandre', 'OfAsshai', 'melisandre.ofasshai1@got.com', '1981-01-07', '+1 (555) 529-84-30'),
(35, 'Rhea', 'Seehorn', 'rhea.seehorn1@bettercallsaul.com', '1988-11-11', '+1 (555) 271-46-89'),
(36, 'Charles', 'Westmoreland', 'charles.westmoreland1@prisonbreak.com', '1985-11-15', '+1 (555) 604-73-21'),
(37, 'Tuco', 'Salamanca', 'tuco.salamanca1@breakingbad.com', '1984-11-26', '+1 (555) 138-59-47'),
(38, 'Joffrey', 'Baratheon', 'joffrey.baratheon1@got.com', '2004-01-06', '+1 (555) 492-67-05'),
(39, 'Cliff', 'Main', 'cliff.main1@bettercallsaul.com', '1982-09-15', '+1 (555) 753-12-68'),
(40, 'John', 'Abruzzi', 'john.abruzzi1@prisonbreak.com', '1989-01-10', '+1 (555) 621-30-49'),
(41, 'Lydia', 'Rodarte-Quayle', 'lydia.rodarte-quayle1@breakingbad.com', '2003-12-17', '+1 (555) 384-90-26'),
(42, 'Margaery', 'Tyrell', 'margaery.tyrell1@got.com', '1980-05-13', '+1 (555) 507-43-12'),
(43, 'Kimberley', 'Carmichael', 'kimberley.carmichael1@prisonbreak.com', '2004-10-01', '+1 (555) 268-75-93'),
(44, 'Badger', 'Mayhew', 'badger.mayhew1@breakingbad.com', '1994-04-16', '+1 (555) 391-68-54'),
(45, 'Samwell', 'Tarly', 'samwell.tarly1@got.com', '2003-02-24', '+1 (555) 174-29-86'),
(46, 'Ernesto', 'Vidal', 'ernesto.vidal1@bettercallsaul.com', '2002-07-16', '+1 (555) 486-13-72'),
(47, 'James', 'Whistler', 'james.whistler1@prisonbreak.com', '1987-04-16', '+1 (555) 319-57-08'),
(48, 'Combo', 'Ortega', 'combo.ortega1@breakingbad.com', '1995-10-13', '+1 (555) 625-84-19'),
(49, 'Bronn', 'Blackwater', 'bronn.blackwater1@got.com', '2004-07-26', '+1 (555) 240-36-71'),
(50, 'Mrs', 'McGill', 'mrs.mcgill1@bettercallsaul.com', '2001-12-02', '+1 (555) 597-12-46'),
(51, 'Norman', 'St. John', 'norman.st. john1@prisonbreak.com', '1981-03-28', '+1 (555) 382-90-53'),
(52, 'Huell', 'Babineaux', 'huell.babineaux1@breakingbad.com', '2002-07-15', '+1 (555) 467-21-08'),
(53, 'Grey', 'Worm', 'grey.worm1@got.com', '2001-11-22', '+1 (555) 108-74-95'),
(54, 'Marco', 'Pasquale', 'marco.pasquale1@bettercallsaul.com', '1999-01-02', '+1 (555) 295-68-40'),
(55, 'David', 'Apollonio', 'david.apollonio1@prisonbreak.com', '2004-02-15', '+1 (555) 634-27-19'),
(56, 'Jane', 'Margolis', 'jane.margolis1@breakingbad.com', '1980-10-14', '+1 (555) 478-59-62'),
(57, 'Podrick', 'Payne', 'podrick.payne1@got.com', '1999-05-20', '+1 (555) 521-03-78'),
(58, 'Francesca', 'Liddy', 'francesca.liddy1@bettercallsaul.com', '1997-05-08', '+1 (555) 392-46-81'),
(59, 'Donald', 'Self', 'donald.self1@prisonbreak.com', '1981-11-20', '+1 (555) 703-15-49'),
(60, 'Wendy', 'S.', 'wendy.s.1@breakingbad.com', '1997-01-24', '+1 (555) 468-72-30'),
(61, 'Daario', 'Naharis', 'daario.naharis1@got.com', '2000-10-18', '+1 (555) 127-89-54'),
(62, 'Richter', 'Goodman', 'richter.goodman1@bettercallsaul.com', '1997-11-22', '+1 (555) 354-16-87'),
(63, 'Roland', 'Glenn', 'roland.glenn1@prisonbreak.com', '1981-09-17', '+1 (555) 809-42-73'),
(64, 'Jack', 'Welker', 'jack.welker1@breakingbad.com', '1981-05-03', '+1 (555) 613-58-20'),
(65, 'Ygritte', 'OfTheFree', 'ygritte.ofthefree1@got.com', '1986-10-02', '+1 (555) 247-96-31'),
(66, 'Victor', 'St.Clair', 'victor.st.clair1@bettercallsaul.com', '1994-06-29', '+1 (555) 530-41-68'),
(67, 'Benjamin', 'Miles', 'benjamin.miles1@prisonbreak.com', '2004-03-08', '+1 (555) 689-25-40'),
(68, 'Steven', 'Gomez', 'steven.gomez1@breakingbad.com', '1985-12-25', '+1 (555) 402-73-95'),
(69, 'Gendry', 'Waters', 'gendry.waters1@got.com', '1981-07-02', '+1 (555) 571-84-29'),
(70, 'Werner', 'Ziegler', 'werner.ziegler1@bettercallsaul.com', '1999-02-22', '+1 (555) 236-09-71'),
(71, 'Kellerman', 'Mason', 'kellerman.mason1@prisonbreak.com', '1999-06-07', '+1 (555) 391-46-82'),
(72, 'Todd', 'Packer', 'todd.packer1@breakingbad.com', '1998-06-06', '+1 (555) 164-78-53'),
(73, 'Sandor', 'Clegane', 'sandor.clegane1@got.com', '1996-04-22', '+1 (555) 498-21-36'),
(74, 'Gene', 'Takavic', 'gene.takavic1@bettercallsaul.com', '1995-02-03', '+1 (555) 572-63-09'),
(75, 'Pamela', 'Milera', 'pamela.milera1@prisonbreak.com', '1983-07-10', '+1 (555) 603-95-47'),
(76, 'Holly', 'White', 'holly.white1@breakingbad.com', '1987-10-21', '+1 (555) 314-28-76'),
(77, 'Ellaria', 'Sand', 'ellaria.sand1@got.com', '1991-07-25', '+1 (555) 457-19-82'),
(78, 'Patrick', 'Kuby', 'patrick.kuby1@breakingbad.com', '1988-02-23', '+1 (555) 280-46-93'),
(79, 'Barristan', 'Selmy', 'barristan.selmy1@got.com', '1985-12-18', '+1 (555) 695-37-14'),
(80, 'Sherlock', 'Holmes', 'sherlock.holmes1@sherlock.com', '1998-01-06', '+1 (555) 132-58-69'),
(81, 'John', 'Watson', 'john.watson1@sherlock.com', '1989-01-11', '+1 (555) 509-71-42'),
(82, 'Mycroft', 'Holmes', 'mycroft.holmes1@sherlock.com', '1984-07-09', '+1 (555) 374-06-85'),
(83, 'Molly', 'Hooper', 'molly.hooper1@sherlock.com', '1993-04-25', '+1 (555) 286-91-53'),
(84, 'Greg', 'Lestrade', 'greg.lestrade1@sherlock.com', '2005-05-27', '+1 (555) 613-47-20'),
(85, 'Paul', 'McCartney', 'paul.mccartney1@beatles.com', '1994-08-07', '+1 (555) 428-69-31'),
(86, 'John', 'Lennon', 'john.lennon1@beatles.com', '1994-07-16', '+1 (555) 571-02-48'),
(87, 'George', 'Harrison', 'george.harrison1@beatles.com', '1980-09-07', '+1 (555) 349-78-16'),
(88, 'Ringo', 'Starr', 'ringo.starr1@beatles.com', '1990-11-15', '+1 (555) 208-43-79'),
(89, 'Kurt', 'Cobain', 'kurt.cobain1@nirvana.com', '2003-04-14', '+1 (555) 495-62-31'),
(90, 'Krist', 'Novoselic', 'krist.novoselic1@nirvana.com', '1986-01-14', '+1 (555) 637-14-58'),
(91, 'Dave', 'Grohl', 'dave.grohl1@nirvana.com', '1996-11-06', '+1 (555) 281-90-46'),
(92, 'James', 'Hetfield', 'james.hetfield1@metallica.com', '1996-07-26', '+1 (555) 564-38-19'),
(93, 'Lars', 'Ulrich', 'lars.ulrich1@metallica.com', '1994-02-21', '+1 (555) 317-05-84'),
(94, 'Kirk', 'Hammett', 'kirk.hammett1@metallica.com', '1999-07-29', '+1 (555) 472-61-39'),
(95, 'Robert', 'Trujillo', 'robert.trujillo1@metallica.com', '1981-03-04', '+1 (555) 196-84-25'),
(96, 'Irene', 'Adler', 'irene.adler1@sherlock.com', '1999-08-15', '+1 (555) 503-27-91'),
(97, 'Lestrade', 'Greg', 'lestrade.greg1@sherlock.com', '2003-08-27', '+1 (555) 682-50-74'),
(98, 'Pauline', 'Simpson', 'pauline.simpson1@sherlock.com', '2003-06-26', '+1 (555) 347-18-62'),
(99, 'Yoko', 'Ono', 'yoko.ono1@beatles.com', '1981-05-21', '+1 (555) 214-95-03'),
(100, 'Sean', 'Lennon', 'sean.lennon1@beatles.com', '1981-01-15', '+1 (555) 439-26-75');


-- 3. products (100 Records)
INSERT INTO products (product_id, product_name, description, price, stock_quantity, category_id) VALUES
-- Electronics (Category ID: 1) - 15 Items
(1, 'Wireless Noise-Cancelling Headphones', 'High quality audio experience.', 105.50, 20, 1), 
(2, 'Smart LED TV 55"', 'Ultra HD viewing experience.', 200.00, 30, 1),
(3, 'Portable Bluetooth Speaker', 'Compact and powerful sound.', 110.50, 40, 1),
(4, 'Smart Home Security Camera', '24/7 home monitoring.', 132.00, 50, 1),
(5, 'USB-C Fast Charging Adapter', 'Quick charge technology.', 12.50, 60, 1),
(6, 'Gaming Mechanical Keyboard', 'Tactile switches for gaming.', 63.00, 70, 1),
(7, 'Wireless Ergonomic Mouse', 'Comfortable for long use.', 18.50, 10, 1),
(8, '4K Action Camera', 'Capture life in Ultra HD.', 140.00, 20, 1),
(9, 'Smartwatch Series X', 'Fitness and health tracking.', 19.50, 30, 1),
(10, 'Laptop Cooling Pad', 'Prevents overheating during use.', 15.00, 40, 1),
(11, 'External SSD 1TB', 'High-speed portable storage.', 10.50, 50, 1),
(12, 'Wireless Charging Pad', 'Convenient phone charging.', 16.00, 60, 1),
(13, 'Ultra HD Projector', 'Cinema quality viewing at home.', 11.50, 70, 1),
(14, 'Bluetooth Car FM Transmitter', 'Stream music in your car.', 17.00, 10, 1),
(15, 'Home Theater Soundbar', 'Immersive cinematic audio.', 18.50, 20, 1),
-- Apparel (Category ID: 2) - 15 Items
(16, 'Men’s Slim Fit Jeans', 'Durable, stylish denim.', 18.00, 30, 2), 
(17, 'Women’s Oversized Hoodie', 'Comfortable and trendy.', 19.50, 40, 2),
(18, 'Classic White Cotton T-Shirt', 'Essential wardrobe item.', 19.00, 50, 2),
(19, 'Thermal Winter Jacket', 'Keeps warm in cold weather.', 20.50, 60, 2),
(20, 'Athletic Jogger Pants', 'Flexible and breathable fabric.', 21.00, 70, 2),
(21, 'Women’s Summer Floral Dress', 'Light and fashionable.', 21.50, 10, 2),
(22, 'Men’s Formal Shirt', 'Ideal for business attire.', 22.00, 20, 2),
(23, 'Sport Performance Shorts', 'Moisture-wicking material.', 22.50, 30, 2),
(24, 'Unisex Zip-Up Sweatshirt', 'Versatile casual wear.', 23.00, 40, 2),
(25, 'Casual Sneakers', 'Comfortable for daily wear.', 23.50, 50, 2),
(26, 'Knitted Wool Scarf', 'Warm and soft texture.', 23.00, 60, 2),
(27, 'Lightweight Raincoat', 'Water-resistant outer layer.', 24.50, 70, 2),
(28, 'Women’s High-Waist Leggings', 'Stretchy and supportive.', 24.00, 10, 2),
(29, 'Men’s Leather Belt', 'Genuine leather accessory.', 25.50, 20, 2),
(30, 'Cotton Crew Socks Pack', 'Essential daily wear.', 26.00, 30, 2),
-- Books (Category ID: 3) - 14 Items
(31, 'Modern Software Testing Guide', 'Covers latest testing trends.', 2.50, 40, 3), 
(32, 'Foundations of Data Structures', 'Core computer science concepts.', 7.00, 50, 3),
(33, 'The Art of Creative Writing', 'Techniques for better storytelling.', 8.50, 60, 3),
(34, 'Beginner’s Guide to Photography', 'Camera basics and composition.', 7.00, 70, 3),
(35, 'History of Ancient Civilizations', 'Explore ancient world empires.', 9.50, 10, 3),
(36, 'Mastering Java Programming', 'Advanced Java development guide.', 29.00, 20, 3),
(37, 'Personal Finance Made Simple', 'Tips for budgeting and saving.', 3.50, 30, 3),
(38, 'Psychology of Human Behavior', 'Understanding motivation and emotion.', 39.00, 40, 3),
(39, 'Advanced SQL Techniques', 'Optimize complex database queries.', 4.50, 50, 3),
(40, 'Introduction to Machine Learning', 'Fundamentals of AI models.', 3.00, 60, 3),
(41, 'Principles of UX Design', 'Creating user-friendly interfaces.', 5.50, 70, 3),
(42, 'Modern Data Analytics', 'Tools and methods for data analysis.', 1.00, 10, 3),
(43, 'Cognitive Science Basics', 'The study of mind and intelligence.', 6.50, 20, 3),
(44, 'Startup Growth Handbook', 'Strategies for scaling a business.', 2.00, 30, 3),
-- Home & Living (Category ID: 4) - 14 Items
(45, 'Wooden Coffee Table', 'Minimalist Scandinavian design.', 34.50, 40, 4), 
(46, 'Memory Foam Pillow', 'Contour support for neck and head.', 35.00, 50, 4),
(47, 'Scented Soy Candle Set', 'Natural, long-lasting aroma.', 35.50, 60, 4),
(48, 'Stainless Steel Cookware Set', 'Durable, non-reactive pots and pans.', 36.00, 70, 4),
(49, 'Non-Stick Frying Pan', 'Easy to clean cooking surface.', 39.50, 10, 4),
(50, 'Ultra-Soft Throw Blanket', 'Cozy and warm fleece material.', 37.00, 20, 4),
(51, 'Ceramic Dinnerware Set', 'Elegant place setting for four.', 38.50, 30, 4),
(52, 'Decorative Wall Clock', 'Silent quartz movement.', 38.00, 40, 4),
(53, 'Indoor Plant Pot', 'Modern geometric design.', 39.50, 50, 4),
(54, 'Bamboo Laundry Basket', 'Eco-friendly and spacious.', 39.00, 60, 4),
(55, 'Microfiber Bath Towel Set', 'Highly absorbent and quick-drying.', 40.50, 70, 4),
(56, 'Kitchen Knife Set', 'Professional grade stainless steel.', 40.00, 10, 4),
(57, 'Bedroom LED Strip Lights', 'Ambient lighting with remote.', 41.50, 20, 4),
(58, 'Adjustable Office Chair', 'Ergonomic lumbar support.', 41.00, 30, 4),
-- Sports (Category ID: 5) - 14 Items
(59, 'Adjustable Dumbbell Set', 'Weight range 5-50 lbs.', 42.50, 40, 5), 
(60, 'Yoga Mat with Carry Strap', 'Non-slip surface.', 43.00, 50, 5),
(61, 'High-Performance Running Shoes', 'Maximum cushioning.', 43.50, 60, 5),
(62, 'Resistance Bands Kit', 'Versatile full-body workout.', 41.00, 70, 5),
(63, 'Mountain Bike Helmet', 'Safety certified.', 44.50, 10, 5),
(64, 'Foldable Fitness Bench', 'Ideal for strength training.', 62.00, 20, 5),
(65, 'Swimming Goggles', 'Anti-fog lenses.', 4.50, 30, 5),
(66, 'Tennis Racket', 'Lightweight composite frame.', 13.00, 40, 5),
(67, 'Premium Soccer Ball', 'Official size and weight.', 4.50, 50, 5),
(68, 'Boxing Gloves', 'Durable synthetic leather.', 4.00, 60, 5),
(69, 'Gym Water Bottle', 'Insulated stainless steel.', 4.50, 70, 5),
(70, 'Pilates Ring', 'Toning and core workout tool.', 4.00, 10, 5),
(71, 'Hiking Backpack', 'Large capacity for multi-day trips.', 49.50, 20, 5),
(72, 'Outdoor Camping Tent', 'Two-person waterproof design.', 46.00, 30, 5),
-- Accessories (Category ID: 6) - 14 Items
(73, 'Minimalist Leather Wallet', 'Slim design, multiple card slots.', 11.50, 40, 6), 
(74, 'Stainless Steel Wristwatch', 'Classic analog display.', 57.00, 50, 6),
(75, 'Blue-Light Blocking Glasses', 'Reduces eye strain.', 12.50, 60, 6),
(76, 'Classic Aviator Sunglasses', 'UV protection lenses.', 18.00, 70, 6),
(77, 'Adjustable Baseball Cap', 'Unisex design.', 23.50, 10, 6),
(78, 'Canvas Backpack', 'Durable everyday bag.', 29.00, 20, 6),
(79, 'Silver Chain Necklace', 'Sterling silver jewelry.', 53.50, 30, 6),
(80, 'Crossbody Phone Bag', 'Secure and hands-free.', 5.00, 40, 6),
(81, 'Travel Toiletry Organizer', 'Hanging hook included.', 5.50, 50, 6),
(82, 'RFID Card Holder', 'Protects against electronic theft.', 5.00, 60, 6),
(83, 'Gold-Plated Bracelet', 'Elegant wristwear.', 6.50, 70, 6),
(84, 'Touchscreen Winter Gloves', 'Compatible with smart devices.', 2.00, 10, 6),
(85, 'Beanie Hat', 'Warm knitted headwear.', 7.50, 20, 6),
(86, 'Stylish Laptop Sleeve', 'Padded protection.', 5.00, 30, 6),
-- Food & Beverage (Category ID: 7) - 14 Items
(87, 'Organic Honey 500g', 'Natural sweetener.', 8.50, 40, 7), 
(88, 'Whole Grain Pasta', 'Healthy cooking staple.', 4.00, 50, 7),
(89, 'Premium Dark Chocolate 70%', 'Rich cocoa flavor.', 5.50, 60, 7),
(90, 'Roasted Coffee Beans', 'Freshly roasted arabica.', 55.00, 70, 7),
(91, 'Herbal Green Tea', 'Natural detox blend.', 60.50, 10, 7),
(92, 'Natural Peanut Butter', 'High protein spread.', 6.00, 20, 7),
(93, 'Almond Milk Unsweetened', 'Dairy-free alternative.', 11.50, 30, 7),
(94, 'Spicy Tomato Sauce', 'Ready-made Italian sauce.', 17.00, 40, 7),
(95, 'Extra Virgin Olive Oil', 'Cold-pressed quality.', 22.50, 50, 7),
(96, 'Protein Energy Bar', 'Quick energy source.', 12.00, 60, 7),
(97, 'Mixed Dried Fruits Pack', 'Healthy snack mix.', 11.50, 70, 7),
(98, 'Fresh Orange Juice', '100% pure squeezed.', 11.00, 10, 7),
(99, 'Gluten-Free Bread', 'Alternative bread option.', 5.00, 20, 7),
(100, 'Granola Cereal Mix', 'Breakfast food staple.', 10.00, 30, 7);


-- 4. addresses (150 Records)
INSERT INTO addresses (address_id, customer_id, address_line1, city, country, is_default) VALUES
(1, 1, '12 Maple Street', 'New York', 'USA', True),
(2, 2, '48 Hillcrest Ave', 'Chicago', 'USA', True),
(3, 3, '903 Sunset Blvd', 'Los Angeles', 'USA', True),
(4, 4, '2218 Pinewood Drive', 'Houston', 'USA', True),
(5, 5, '77 Riverside Road', 'Phoenix', 'USA', True),
(6, 6, '642 Elmwood Lane', 'Seattle', 'USA', True),
(7, 7, '19 Brookside Court', 'Miami', 'USA', True),
(8, 8, '1280 Willow Way', 'Boston', 'USA', True),
(9, 9, '453 Oakridge Street', 'Denver', 'USA', True),
(10, 10, '302 Birchwood Drive', 'Dallas', 'USA', True),
(11, 11, '56 London Road', 'London', 'United Kingdom', True),
(12, 12, '14 Kingfisher Close', 'Manchester', 'United Kingdom', True),
(13, 13, '87 Rosehill Street', 'Birmingham', 'United Kingdom', True),
(14, 14, '102 Greenfield Road', 'Leeds', 'United Kingdom', True),
(15, 15, '28 Meadow Lane', 'Liverpool', 'United Kingdom', True),
(16, 16, '63 Hawthorn Street', 'Bristol', 'United Kingdom', True),
(17, 17, '7 Parkside Gardens', 'Glasgow', 'United Kingdom', True),
(18, 18, '94 Queensbridge Road', 'Edinburgh', 'United Kingdom', True),
(19, 19, '40 Millbrook Avenue', 'Nottingham', 'United Kingdom', True),
(20, 20, '135 Riverstone Drive', 'Cardiff', 'United Kingdom', True),
(21, 21, '22 Rue Lafayette', 'Paris', 'France', True),
(22, 22, '18 Rue de Provence', 'Lyon', 'France', True),
(23, 23, '74 Boulevard Saint-Michel', 'Marseille', 'France', True),
(24, 24, '10 Rue des Lilas', 'Toulouse', 'France', True),
(25, 25, '59 Rue du Port', 'Nice', 'France', True),
(26, 26, '87 Avenue des Fleurs', 'Nantes', 'France', True),
(27, 27, '41 Chemin du Lac', 'Strasbourg', 'France', True),
(28, 28, '33 Rue Victor Hugo', 'Bordeaux', 'France', True),
(29, 29, '19 Allée du Château', 'Lille', 'France', True),
(30, 30, '62 Rue du Marché', 'Montpellier', 'France', True),
(31, 31, '11 Lindenstrasse', 'Berlin', 'Germany', True),
(32, 32, '74 Gartenweg', 'Munich', 'Germany', True),
(33, 33, '23 Rosenstrasse', 'Hamburg', 'Germany', True),
(34, 34, '59 Bahnhofstrasse', 'Frankfurt', 'Germany', True),
(35, 35, '40 Parkstrasse', 'Stuttgart', 'Germany', True),
(36, 36, '81 Waldweg', 'Düsseldorf', 'Germany', True),
(37, 37, '14 Mozartstrasse', 'Cologne', 'Germany', True),
(38, 38, '66 Blumenweg', 'Leipzig', 'Germany', True),
(39, 39, '9 Schillerstrasse', 'Bremen', 'Germany', True),
(40, 40, '32 Sonnenweg', 'Hanover', 'Germany', True),
(41, 41, '27 Via Roma', 'Rome', 'Italy', True),
(42, 42, '14 Via Milano', 'Milan', 'Italy', True),
(43, 43, '78 Via Firenze', 'Florence', 'Italy', True),
(44, 44, '51 Via Torino', 'Turin', 'Italy', True),
(45, 45, '8 Via Bologna', 'Bologna', 'Italy', True),
(46, 46, '33 Via Genova', 'Genoa', 'Italy', True),
(47, 47, '72 Via del Mare', 'Naples', 'Italy', True),
(48, 48, '19 Via Verona', 'Verona', 'Italy', True),
(49, 49, '60 Via Padova', 'Padua', 'Italy', True),
(50, 50, '42 Via Venezia', 'Venice', 'Italy', True),
(51, 51, '15 Długa Street', 'Warsaw', 'Poland', True),
(52, 52, '20 Polna Street', 'Krakow', 'Poland', True),
(53, 53, '74 Słoneczna Street', 'Gdansk', 'Poland', True),
(54, 54, '48 Ogrodowa Street', 'Wroclaw', 'Poland', True),
(55, 55, '36 Lipowa Street', 'Poznan', 'Poland', True),
(56, 56, '82 Brzozowa Street', 'Lodz', 'Poland', True),
(57, 57, '97 Kwiatowa Street', 'Szczecin', 'Poland', True),
(58, 58, '14 Lesna Street', 'Lublin', 'Poland', True),
(59, 59, '58 Zamkowa Street', 'Katowice', 'Poland', True),
(60, 60, '21 Krótka Street', 'Bydgoszcz', 'Poland', True),
(61, 61, '32 Atatürk Caddesi', 'İstanbul', 'Türkiye', True),
(62, 62, '54 Çınar Sokak', 'Ankara', 'Türkiye', True),
(63, 63, '91 Papatya Mahallesi', 'İzmir', 'Türkiye', True),
(64, 64, '10 Şehitler Caddesi', 'Bursa', 'Türkiye', True),
(65, 65, '67 Gül Sokak', 'Antalya', 'Türkiye', True),
(66, 66, '89 Vadi Caddesi', 'Konya', 'Türkiye', True),
(67, 67, '44 Sahil Mahallesi', 'Samsun', 'Türkiye', True),
(68, 68, '13 Bağlar Sokak', 'Diyarbakır', 'Türkiye', True),
(69, 69, '75 Park Caddesi', 'Eskişehir', 'Türkiye', True),
(70, 70, '50 Çamlık Sokak', 'Adana', 'Türkiye', True),
(71, 71, '84 Maple Street', 'San Francisco', 'USA', True),
(72, 72, '29 Lakeview Drive', 'Atlanta', 'USA', True),
(73, 73, '903 Arbor Lane', 'Philadelphia', 'USA', True),
(74, 74, '74 Willow Bend', 'Detroit', 'USA', True),
(75, 75, '40 Creekside Road', 'Las Vegas', 'USA', True),
(76, 76, '188 Meadowbrook Ave', 'Orlando', 'USA', True),
(77, 77, '67 Forest Hills Road', 'Austin', 'USA', True),
(78, 78, '93 Cedarwood Lane', 'Portland', 'USA', True),
(79, 79, '27 Highland Way', 'Kansas City', 'USA', True),
(80, 80, '304 Oak Street', 'Charlotte', 'USA', True),
(81, 81, '92 Elm Grove Road', 'Liverpool', 'United Kingdom', True),
(82, 82, '27 York Road', 'Sheffield', 'United Kingdom', True),
(83, 83, '16 Station Close', 'Southampton', 'United Kingdom', True),
(84, 84, '74 Riverside Road', 'Coventry', 'United Kingdom', True),
(85, 85, '18 Chapel Lane', 'Leicester', 'United Kingdom', True),
(86, 86, '55 Meadowfield Court', 'Belfast', 'United Kingdom', True),
(87, 87, '23 Highfield Drive', 'Aberdeen', 'United Kingdom', True),
(88, 88, '10 Brook Lane', 'Swansea', 'United Kingdom', True),
(89, 89, '41 Ashleigh Road', 'Oxford', 'United Kingdom', True),
(90, 90, '64 Northbridge Street', 'Cambridge', 'United Kingdom', True),
(91, 91, '38 Rue de la Gare', 'Rennes', 'France', True),
(92, 92, '57 Avenue du Parc', 'Dijon', 'France', True),
(93, 93, '15 Rue des Jardins', 'Reims', 'France', True),
(94, 94, '72 Chemin des Clos', 'Toulon', 'France', True),
(95, 95, '44 Rue du Soleil', 'Clermont-Ferrand', 'France', True),
(96, 96, '26 Avenue Liberté', 'Grenoble', 'France', True),
(97, 97, '91 Rue des Arts', 'Angers', 'France', True),
(98, 98, '84 Rue Colbert', 'Le Havre', 'France', True),
(99, 99, '33 Rue Marceau', 'Metz', 'France', True),
(100, 100, '20 Chemin de la Plage', 'Cannes', 'France', True),
-- Secondary Addresses (is_default=FALSE, assigned to even customer_ids)
(101, 2, '11 Kaiserstrasse', 'Bonn', 'Germany', False),
(102, 4, '29 Hofstrasse', 'Essen', 'Germany', False),
(103, 6, '48 Lindenweg', 'Dortmund', 'Germany', False),
(104, 8, '92 Tulpenweg', 'Aachen', 'Germany', False),
(105, 10, '37 Gartenstrasse', 'Nürnberg', 'Germany', False),
(106, 12, '16 Wiesenstrasse', 'Freiburg', 'Germany', False),
(107, 14, '81 Mozartweg', 'Mainz', 'Germany', False),
(108, 16, '53 Birkenweg', 'Kiel', 'Germany', False),
(109, 18, '24 Rosenweg', 'Augsburg', 'Germany', False),
(110, 20, '68 Hafenstrasse', 'Duisburg', 'Germany', False),
(111, 22, '22 Via Palermo', 'Palermo', 'Italy', False),
(112, 24, '15 Via Bari', 'Bari', 'Italy', False),
(113, 26, '77 Via Siena', 'Siena', 'Italy', False),
(114, 28, '98 Via Como', 'Como', 'Italy', False),
(115, 30, '41 Via Parma', 'Parma', 'Italy', False),
(116, 32, '63 Via Lucca', 'Lucca', 'Italy', False),
(117, 34, '54 Via Taranto', 'Taranto', 'Italy', False),
(118, 36, '20 Via Latina', 'Latina', 'Italy', False),
(119, 38, '36 Via Ferrara', 'Ferrara', 'Italy', False),
(120, 40, '14 Via Modena', 'Modena', 'Italy', False),
(121, 42, '90 Letnia Street', 'Rzeszow', 'Poland', False),
(122, 44, '38 Spacerowa Street', 'Torun', 'Poland', False),
(123, 46, '52 Pogodna Street', 'Kielce', 'Poland', False),
(124, 48, '71 Jesionowa Street', 'Opole', 'Poland', False),
(125, 50, '18 Jaskółcza Street', 'Zabrze', 'Poland', False),
(126, 52, '60 Parkowa Street', 'Olsztyn', 'Poland', False),
(127, 54, '43 Miodowa Street', 'Bialystok', 'Poland', False),
(128, 56, '27 Wiosenna Street', 'Radom', 'Poland', False),
(129, 58, '86 Szeroka Street', 'Gliwice', 'Poland', False),
(130, 60, '14 Różana Street', 'Sosnowiec', 'Poland', False),
(131, 62, '23 Cedar Lane', 'San Diego', 'USA', False),
(132, 64, '87 Pinecrest Avenue', 'Minneapolis', 'USA', False),
(133, 66, '14 Rosewood Drive', 'Tampa', 'USA', False),
(134, 68, '56 Oakridge Court', 'Sacramento', 'USA', False),
(135, 70, '91 Willowbrook Street', 'New Orleans', 'USA', False),
(136, 72, '35 King Street', 'Bristol', 'United Kingdom', False),
(137, 74, '62 Elmwood Road', ' Plymouth', ' United Kingdom', False),
(138, 76, '18 Queens Road', ' Cambridge', ' United Kingdom', False),
(139, 78, '49 Church Lane', ' Edinburgh', ' United Kingdom', False),
(140, 80, '72 Park Avenue', ' Belfast', ' United Kingdom', False),
(141, 82, '31 Rue du Parc', 'Lille', 'France', False),
(142, 84, '58 Boulevard Victor Hugo', 'Paris', 'France', False),
(143, 86, '44 Chemin des Fleurs', 'Lyon', 'France', False),
(144, 88, '77 Rue de la République', 'Marseille', 'France', False),
(145, 90, '19 Avenue du Château', 'Bordeaux', 'France', False),
(146, 92, '86 Via San Marco', 'Milan', 'Italy', False),
(147, 94, '23 Via Giuseppe Verdi', 'Rome', 'Italy', False),
(148, 96, '41 Via Dante', 'Florence', 'Italy', False),
(149, 98, '67 Via Roma', 'Naples', 'Italy', False),
(150, 100, '12 Via Garibaldi', 'Turin', 'Italy', False);


-- 5. orders 
WITH customer_order_counts AS (
    SELECT
        c.customer_id,
        (
            ('x' || substring(MD5(CAST(c.customer_id AS TEXT) || c.first_name || 'ORDER_SEED'), 1, 8))::BIT(32)::INT
        ) AS hash_seed,
        LENGTH(c.first_name) AS name_length
    FROM customers c
),
orders_per_customer AS (
    SELECT
        customer_id,
        (ABS(hash_seed) + name_length) % 11 AS num_orders_to_generate -- Range 0-10
    FROM customer_order_counts
),
orders_base AS (
    SELECT
        oc.customer_id,
        (ROW_NUMBER() OVER (ORDER BY oc.customer_id)) AS order_sequence_num_total
    FROM
        orders_per_customer oc
    CROSS JOIN
        generate_series(0, 10) gs(series_id)
    WHERE
        gs.series_id < oc.num_orders_to_generate
        AND oc.num_orders_to_generate > 0
)
INSERT INTO orders (order_id, customer_id, order_date, order_status, total_amount)
SELECT
    (ROW_NUMBER() OVER (ORDER BY ob.customer_id)) AS order_id,
    ob.customer_id,
    '2024-05-01 12:00:00+03'::TIMESTAMP WITH TIME ZONE - ((ROW_NUMBER() OVER ()) * 3 || ' hours')::INTERVAL,
    
    -- Sipariş durumunu atama (4 farklı durum arasında döngü yapar)
    CASE (ob.order_sequence_num_total % 4) 
        WHEN 0 THEN 'Delivered'
        WHEN 1 THEN 'Cancelled'
        WHEN 2 THEN 'Pending'
        ELSE 'Shipped'
    END AS order_status,
    NULL
FROM
    orders_base ob
ORDER BY
    order_id
;


-- 6. order_items 
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price_at_order, line_total)
WITH all_possible_items AS (
    SELECT
        o.order_id,
        p.product_id,
        p.price,
        (
            ('x' || substring(MD5(CAST(o.order_id AS TEXT) || CAST(p.product_id AS TEXT)), 1, 8))::BIT(32)::INT
        ) AS inclusion_seed,
        ((o.order_id + p.product_id) % 4) + 1 AS quantity,
        p.product_id AS product_id_order_key
    FROM orders o
    CROSS JOIN products p
),
potential_items AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY product_id_order_key) as rn
    FROM all_possible_items
    
    WHERE ABS(inclusion_seed) % 5 = 1 
)
SELECT
    -- Final global ID
    (ROW_NUMBER() OVER (ORDER BY order_id, product_id)) AS order_item_id, 
    order_id,
    product_id,
    quantity,
    price AS price_at_order,
    quantity * price AS line_total
FROM potential_items
WHERE rn <= 3 
ORDER BY 
    order_id, product_id;

-- 7. Update Orders Table 
UPDATE orders o
SET total_amount = sub.total_amount
FROM (
    SELECT order_id, SUM(line_total) AS total_amount
    FROM order_items
    GROUP BY order_id
) sub
WHERE o.order_id = sub.order_id;


-- 8. payments
INSERT INTO payments (payment_id, order_id, payment_method, payment_date, payment_amount, transaction_status)
SELECT
    o.order_id, o.order_id,
    CASE (o.order_id % 3) WHEN 0 THEN 'Credit Card' WHEN 1 THEN 'EFT Transfer' ELSE 'Cash on Delivery' END,
    o.order_date + '1 hour'::INTERVAL, o.total_amount,
    CASE (o.order_id % 10) WHEN 0 THEN 'Failed' ELSE 'Success' END
FROM orders o;


-- 9. reviews 

WITH purchased_items AS (
    SELECT DISTINCT o.customer_id, oi.product_id
    FROM order_items oi
    JOIN orders o ON o.order_id = oi.order_id
),
reviews_to_insert AS (
    SELECT
        rti.customer_id,
        rti.product_id,

        (
            ('x' || substring(MD5(CAST(rti.customer_id AS TEXT) || CAST(rti.product_id AS TEXT)), 1, 8))::BIT(32)::INT
        ) AS hash_seed,

        (rti.customer_id + rti.product_id) AS selection_key
    FROM purchased_items rti
    WHERE (rti.customer_id + rti.product_id) % 3 = 0
)
INSERT INTO reviews (review_id, customer_id, product_id, rating, review_text)
SELECT
    (ROW_NUMBER() OVER ()) AS review_id,
    rti.customer_id,
    rti.product_id,

    ((ABS(rti.hash_seed) % 5) + 1)::SMALLINT AS rating,
    
    CASE 
        WHEN ((ABS(rti.hash_seed) % 5) + 1) IN (4, 5) THEN
            CASE (rti.selection_key % 4)
                WHEN 0 THEN 'Excellent product, highly satisfied.'
                WHEN 1 THEN 'Great quality and works perfectly.'
                WHEN 2 THEN 'Highly recommended! Best product in its category.'
                ELSE 'Very nice, exactly what I needed.'
            END
            
        WHEN ((ABS(rti.hash_seed) % 5) + 1) = 3 THEN
            CASE (rti.selection_key % 2)
                WHEN 0 THEN 'It did not meet my expectations for the price.'
                ELSE 'It could have been better, quality is just average.'
            END
            
        WHEN ((ABS(rti.hash_seed) % 5) + 1) IN (1, 2) THEN
            CASE (rti.selection_key % 3)
                WHEN 0 THEN 'Absolutely terrible, I regret this purchase. Would not buy again.'
                WHEN 1 THEN 'Very poor quality and did not meet basic expectations.'
                ELSE 'Worst product I have ever bought, highly disappointing.'
            END
            
        ELSE 'Review logic failed.'
    END AS review_text
FROM reviews_to_insert rti;
