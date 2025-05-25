-- Active: 1748104304981@@127.0.0.1@5432@conservation_db
CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL
);

CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) CHECK (conservation_status IN ('Endangered', 'Vulnerable'))
);

CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT NOT NULL,
    species_id INT NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(100) NOT NULL,
    notes TEXT,
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id),
    FOREIGN KEY (species_id) REFERENCES species(species_id)
);


INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range'),
('Daniel Brooks', 'Western Plains'),
('Eva Stone', 'Forest Edge'),
('Frank Martin', 'Eastern Cliffs'),
('Grace Lin', 'Savannah North'),
('Henry Ford', 'Central Basin'),
('Isla Ray', 'Desert Fringe'),
('Jake Moon', 'Valley Deep'),
('Karen Hill', 'Rainforest Loop'),
('Leo Frost', 'Glacier Bay');

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Indian Pangolin', 'Manis crassicaudata', '1822-03-05', 'Endangered'),
('Great Indian Bustard', 'Ardeotis nigriceps', '1861-07-11', 'Endangered'),
('Nilgiri Tahr', 'Nilgiritragus hylocrius', '1838-02-14', 'Endangered'),
('Malayan Tapir', 'Tapirus indicus', '1819-05-01', 'Endangered'),
('Clouded Leopard', 'Neofelis nebulosa', '1821-01-01', 'Vulnerable'),
('Indian Wolf', 'Canis lupus pallipes', '1832-06-15', 'Endangered'),
('Sloth Bear', 'Melursus ursinus', '1791-11-23', 'Vulnerable'),
('Shadow Leopard', 'Panthera shadowus', '2023-09-12', 'Endangered'),
('Shadow Leopard', 'Panthera pardus nebulosa', '1901-06-15', 'Endangered'),
('Golden Antelope', 'Antilope aurea', '1795-03-10', 'Endangered');

INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(4, 4, 'Elephant Path', '2024-05-20 11:00:00', 'Herd of 6 spotted'),
(5, 5, 'Hilltop Rock', '2024-05-21 13:30:00', 'Scales found on trail'),
(6, 6, 'Open Meadow', '2024-05-22 08:50:00', 'Flight captured on drone'),
(7, 7, 'Steep Slope', '2024-05-23 06:25:00', 'Alone adult male seen'),
(8, 8, 'Tapir Lake', '2024-05-24 10:45:00', 'Tracks near water'),
(9, 9, 'Fog Forest', '2024-05-25 17:15:00', 'Roar recorded'),
(10, 10, 'Wolf Canyon', '2024-05-26 09:35:00', 'Pack behavior noted'),
(11, 11, 'Bear Valley', '2024-05-27 15:05:00', 'Cub with mother'),
(2, 3, 'River Edge', '2024-05-28 12:30:00', NULL),
(5, 1, 'Pangolin Hollow', '2024-05-29 14:40:00', 'Tracks photographed'),
(3, 6, 'Eastern Bamboo', '2024-05-30 07:20:00', 'Feeding on bamboo'),
(7, 12, 'High Ridge', '2024-06-01 16:50:00', 'Seen at sunset'),
(9, 4, 'Cliffside Trail', '2024-06-02 06:00:00', 'Camera trap capture'),
(11, 2, 'Valley Creek', '2024-06-03 13:15:00', 'Wandering alone'),
(12, 1, 'Shadow Ravine', '2024-06-04 19:45:00', 'Faint silhouette seen'),
(12, 5, 'Whispering Woods', '2024-06-05 21:00:00', 'Unconfirmed sighting'),
(12, 8, 'Frozen Ridge', '2024-06-06 22:10:00', 'Tracks in snow');


SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;



--Problem 1: Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'
INSERT INTO rangers(name, region) VALUES('Derek Fox', 'Coastal Plains');

--Problem 2: Count unique species ever sighted.
SELECT COUNT(DISTINCT species_id) as unique_species_count FROM sightings; 

--Problem 3:  Find all sightings where the location includes "Pass".
SELECT * FROM sightings WHERE location LIKE '%Pass%';

--Problem 4: List each ranger's name and their total number of sightings.
SELECT r.name, COUNT(*) as total_sightings FROM rangers as r LEFT JOIN sightings as s ON s.ranger_id = r.ranger_id GROUP BY r.name;

--Problem 5: List species that have never been sighted. 
SELECT sp.common_name FROM species as sp LEFT JOIN sightings as s ON s.species_id = sp.species_id WHERE s.sighting_id IS NULL;

--Problem 6:  Show the most recent 2 sightings.
SELECT common_name, sighting_time, name from rangers as r JOIN (SELECT * FROM sightings as s JOIN species as sp ON s.species_id = sp.species_id) as ssp ON r.ranger_id = ssp.ranger_id ORDER BY sighting_time DESC LIMIT 2;

--Problem 7: Update all species discovered before year 1800 to have status 'Historic'.
ALTER TABLE species DROP CONSTRAINT species_conservation_status_check;
ALTER TABLE species ADD CONSTRAINT species_conservation_status_check CHECK (conservation_status IN ('Endangered', 'Vulnerable', 'Historic'));
UPDATE species SET conservation_status = 'Historic' WHERE discovery_date < '1800-01-01';


--Problem 8:  Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT sighting_id, CASE WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning' WHEN EXTRACT(HOUR FROM sighting_time) >=12 AND EXTRACT(HOUR FROM sighting_time) < 17 THEN 'Afternoon' ELSE 'Evening' END AS time_of_day FROM sightings;



--Problem 9: Delete rangers who have never sighted any species
DELETE FROM rangers WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);
