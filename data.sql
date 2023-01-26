/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', 'Feb 03,2020', 0, true, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', 'Nov 15, 2018', 2, true, 8);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', 'Jan 07, 2021', 1, false, 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', 'May 12, 2017', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', 'Feb 08, 2020', 0, false, -11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', 'Nov 15, 2021', 2, true, -5.7);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', 'Apr 02, 1993', 3, false, -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', 'Jun 12, 2005', 1, true, -45);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', 'Jun 07, 2005', 7, true, 20.4);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', 'Oct 13, 1998', 3, true, 17);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', 'May 14, 2022', 4, true, 22);

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);

INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);

INSERT INTO owners (full_name, age) VALUES ('Bob', 45);

INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);

INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);

INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon');

INSERT INTO species (name) VALUES ('Digimon');

INSERT INTO vets (name,age, date_of_graduation) VALUES 
('William Tatcher',45,'2000-04-23'),
('Maisy Smith',26,'2019-01-17'),
('Stephanie Mendez',64,'1981-05-4'),
('Jack Harkness',45,'2008-06-08');

INSERT INTO specializations (vets_id,sid) VALUES 
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

INSERT INTO visits (animal_id,vets_id,date_of_visits) VALUES 
(23,1,'2020-05-24'),
(23,3,'2020-07-22'),
(24,4,'02-02-2021'),
(25,2,'05-01-2020'),
(25,2,'08-03-2020'),
(25,2,'14-05-2020'),
(26,3,'04-05-2021'),
(27,4,'24-02-2021'),
(28,2,'21-12-2019'),
(28,1,'10-08-2020'),
(28,2,'07-04-2021'),
(29,3,'29-09-2019'),
(30,4,'03-10-2020'),
(30,4,'04-11-2020'),
(31,2,'24-01-2019'),
(31,2,'15-05-2019'),
(31,2,'27-02-2020'),
(31,2,'03-08-2020'),
(32,3,'24-05-2020'),
(32,1,'11-01-2021');

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon%';

UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';

UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');
