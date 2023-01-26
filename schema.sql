/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic ;

CREATE TABLE animals ( 
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals
    ADD COLUMN species VARCHAR(200);

CREATE TABLE owners (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE vets (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  age INT,
  date_of_graduation DATE );

CREATE TABLE specializations (
  sid INT REFERENCES species(id),
  vets_id INT REFERENCES vets(id),
  PRIMARY KEY (sid, vets_id),
  CONSTRAINT fk_specializations
    FOREIGN KEY(sid) REFERENCES species(id) ON DELETE CASCADE,
    FOREIGN KEY(vets_id) REFERENCES vets(id) ON DELETE CASCADE);

CREATE TABLE visits (
  animal_id INT,
  vets_id INT, 
  date_of_visits DATE NOT NULL,
  PRIMARY KEY (animal_id, vets_id,date_of_visits),
  CONSTRAINT fk_visit
    FOREIGN KEY(animal_id) REFERENCES animals(id) ON DELETE CASCADE ,
    FOREIGN KEY(vets_id) REFERENCES vets(id) ON DELETE CASCADE  );

ALTER TABLE animals
    ADD PRIMARY KEY(id);

ALTER TABLE animals
    DROP COLUMN species;

ALTER TABLE animals
    ADD COLUMN species_id INT,
    ADD COLUMN owner_id INT;

ALTER TABLE animals
    ADD CONSTRAINT fkey_species
    FOREIGN KEY (species_id)
    REFERENCES species(id);

ALTER TABLE animals
    ADD CONSTRAINT fkey_owner
    FOREIGN KEY (owner_id)
    REFERENCES owners(id);