/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';

SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT * FROM animals WHERE neutered IS true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered IS true;

SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

  UPDATE animals
  SET species = 'unspecified';

SELECT species FROM animals;

ROLLBACK;

SELECT species FROM animals;


BEGIN;

  UPDATE animals 
  SET species = 'digimon'
  WHERE name LIKE '%mon%';

  UPDATE animals
  SET species = 'pokemon'
  WHERE species is NULL;

  SELECT species FROM animals;

COMMIT;

  SELECT species FROM animals;


BEGIN;
  TRUNCATE TABLE animals;

  SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;


BEGIN;
  DELETE FROM animals
  WHERE date_of_birth > '2022-01-01';

  SAVEPOINT birth_date;

  UPDATE animals
  SET weight_kg = -weight_kg;

  ROLLBACK TO birth_date;

  UPDATE animals
  SET weight_kg = -weight_kg
  WHERE weight_kg < 0;

COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, CAST(AVG(escape_attempts) AS DECIMAL(10)) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT name, full_name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, species.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners FULL OUTER JOIN animals ON owners.id = animals.owner_id;

SELECT COUNT(animals.name), species.name FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT owners.full_name, animals.name, species.name FROM owners INNER JOIN animals ON owners.id = animals.owner_id INNER JOIN species ON species.id = animals.species_id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT owners.full_name, animals.name FROM owners INNER JOIN animals ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(*) FROM owners INNER JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY count DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name, vs.date_of_visits as date
FROM animals a
  JOIN visits vs ON vs.animal_id=a.id
  JOIN vets v ON v.id=vs.vets_id
WHERE v.name='William Tatcher'
ORDER BY date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) as Animals_Stephanie_see
FROM animals a
  JOIN visits vs ON vs.animal_id=a.id
  JOIN vets v ON v.id=vs.vets_id
WHERE v.name='Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name, s.name
FROM vets v
  LEFT JOIN specializations ss ON ss.vets_id=v.id
  LEFT JOIN species s ON s.id=ss.sid;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name,vs.date_of_visits as date
FROM animals a
  JOIN visits vs ON vs.animal_id=a.id
  JOIN vets v ON v.id=vs.vets_id
WHERE v.name='Stephanie Mendez' AND vs.date_of_visits>'2020-04-01' AND vs.date_of_visits<'2020-07-30';

-- What animal has the most visits to vets?
SELECT a.name, COUNT(*) as Animals_Most_Visited
FROM animals as a, visits as vs
WHERE  vs.animal_id=a.id
GROUP BY a.name
ORDER BY Animals_Most_Visited DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT a.name,vs.date_of_visits as date
FROM animals a
  JOIN visits vs ON vs.animal_id=a.id
  JOIN vets v ON v.id=vs.vets_id
WHERE v.name='Maisy Smith'
ORDER BY date
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_information,v.name AS vet_information, vs.date_of_visits
FROM animals a
  JOIN visits vs ON vs.animal_id=a.id
  JOIN vets v ON v.id=vs.vets_id
ORDER BY vs.date_of_visits DESC
LIMIT 3;

-- How many visits were with a vet that did not specialize in that animal's species?

SELECT vs.vets_id,vs.date_of_visits
FROM visits vs
  JOIN specializations ss ON ss.vets_id=vs.vets_id
WHERE ss.vets_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT s.name as Should_Specialize_With, COUNT(*) as visit_Count
FROM animals a
  JOIN visits vs ON vs.animal_id=a.id
  JOIN vets v ON v.id=vs.vets_id
  JOIN species s ON s.id=a.species_id
WHERE v.name='Maisy Smith'
GROUP BY s.name
ORDER BY visit_Count DESC
LIMIT 1;

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 15;
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';