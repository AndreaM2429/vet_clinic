/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals (
  id int GENERATED ALWAYS AS IDENTITY,
  name varchar(200),
  date_of_birth date,
  escape_attempts int,
  neutered boolean,
  weight_kg float
);

/* Update the animals table */

ALTER TABLE animals ADD species varchar(200);

/* Create the owners and species tables and modify the animals table*/

CREATE TABLE owners(
  id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  full_name varchar(250),
  age int
);

CREATE TABLE species(
  id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name varchar(250)
);

ALTER TABLE animals ADD PRIMARY KEY (id);
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id int;
ALTER TABLE animals ADD CONSTRAINT FK_speciesId FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD owner_id int;
ALTER TABLE animals ADD CONSTRAINT FK_ownerId FOREIGN KEY (owner_id) REFERENCES owners(id);

/* Create the vets table */

CREATE TABLE vets(
  id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name varchar(250),
  age int,
  date_of_graduation date
);

/* Create the specializations table (many-to-many between vets and species) */

CREATE TABLE specializations(
  specie_id int,
  vet_id int,
  PRIMARY KEY (specie_id, vet_id),
  CONSTRAINT FK_speciesId FOREIGN KEY (specie_id) REFERENCES species(id),
  CONSTRAINT FK_vetsId FOREIGN KEY (vet_id) REFERENCES vets(id)
);

/* Create the visits table (many-to-many between animals and vets) */

CREATE TABLE visits(
  animal_id int,
  vet_id int,
  date_of_visit date,
  PRIMARY KEY (animal_id, vet_id, date_of_visit),
  CONSTRAINT FK_animalsId FOREIGN KEY (animal_id) REFERENCES animals(id),
  CONSTRAINT FK_vetsId FOREIGN KEY (vet_id) REFERENCES vets(id)
);
