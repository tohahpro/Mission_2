-- Active: 1747989313361@@127.0.0.1@5432@conservation_db@public



CREATE Table rangers(
    ranger_id serial PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(100)
);



CREATE Table species(
    species_id serial PRIMARY KEY,
    common_name VARCHAR(100),
    scientific_name VARCHAR(100),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

CREATE TABLE sightings (
    sighting_id serial PRIMARY KEY,
    species_id INT REFERENCES species(species_id),
    ranger_id INT REFERENCES rangers(ranger_id),
    location VARCHAR(100),
    sighting_time TIMESTAMP,
    notes TEXT    
);


INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


-- Problem 1
INSERT INTO rangers (name, region) VALUES
('Derek Fox','Coastal Plains');

-- problem 2
SELECT COUNT(DISTINCT species_id
) as unique_species_count FROM sightings;


-- problem 3
SELECT * FROM sightings
WHERE location LIKE '%Pass%';

-- problem 4
SELECT r.name as name, COUNT(sighting_id) as total_sightings
FROM rangers as r
LEFT JOIN sightings as s ON r.ranger_id = s.ranger_id
GROUP BY r.name 


-- problem 5
SELECT species.common_name FROM species
LEFT JOIN sightings as s ON species.species_id = s.species_id
WHERE s.sighting_id IS NULL;


-- problem 6
SELECT species.common_name, s.sighting_time, r.name FROM sightings as s
INNER JOIN species ON s.species_id = species.species_id
INNER JOIN rangers as r ON s.ranger_id = r.ranger_id
ORDER BY s.sighting_time DESC LIMIT 2


-- problem 7
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- problem 8
SELECT sighting_id,
CASE 
    WHEN extract(HOUR FROM sighting_time) < 12  THEN 'Morning'
    WHEN extract(HOUR FROM sighting_time) >= 12 AND extract(HOUR FROM sighting_time) < 17 THEN 'Afternoon'
    ELSE 'Evening'
END as time_of_day FROM sightings;


-- problem 9
DELETE FROM rangers
WHERE ranger_id NOT IN (
    SELECT DISTINCT ranger_id FROM sightings
);

