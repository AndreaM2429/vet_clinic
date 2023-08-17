/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, true, 11);

/* Insert new data into the table */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, false, 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, true, 5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, false, 12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, true, 45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, true, 22);

/* Owners' data */

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), 
('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

/* Species' data */

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

/* Modify the animals table */

UPDATE animals SET species_id = (CASE WHEN name LIKE '%mon' THEN (SELECT id from species where name = 'Digimon') ELSE (SELECT id from species where name = 'Pokemon') END);

UPDATE animals SET owner_id = (CASE WHEN name = 'Agumon' THEN (SELECT id from owners where full_name = 'Sam Smith')
WHEN name = 'Gabumon' OR name = 'Pikachu' THEN (SELECT id from owners where full_name = 'Jennifer Orwell')
WHEN name = 'Devimon' OR name = 'Plantmon' THEN (SELECT id from owners where full_name = 'Bob')
WHEN name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom' THEN (SELECT id from owners where full_name = 'Melody Pond')
WHEN name = 'Angemon' OR name = 'Boarmon' THEN (SELECT id from owners where full_name = 'Dean Winchester')
END);

/* vets' data */

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '23-04-2000'), ('Maisy Smith', 26, '17-01-2019'),
('Stephanie Mendez', 64, '04-05-1981'), ('Jack Harkness', 38, '08-06-2008');

/* specializations data */

INSERT INTO specializations (specie_id, vet_id) VALUES
((SELECT id from species where name = 'Pokemon'), (SELECT id from vets where name = 'William Tatcher')),
((SELECT id from species where name = 'Digimon'), (SELECT id from vets where name = 'Stephanie Mendez')),
((SELECT id from species where name = 'Pokemon'), (SELECT id from vets where name = 'Stephanie Mendez')),
((SELECT id from species where name = 'Digimon'), (SELECT id from vets where name = 'Jack Harkness'));

/* visits data */

INSERT INTO visits (animal_id, vet_id, date_of_visit) VALUES
((SELECT id from animals where name = 'Agumon'), (SELECT id from vets where name = 'William Tatcher'), '24-05-2020'),
((SELECT id from animals where name = 'Agumon'), (SELECT id from vets where name = 'Stephanie Mendez'), '22-07-2020'),
((SELECT id from animals where name = 'Gabumon'), (SELECT id from vets where name = 'Jack Harkness'), '02-02-2021'),
((SELECT id from animals where name = 'Pikachu'), (SELECT id from vets where name = 'Maisy Smith'), '05-01-2020'),
((SELECT id from animals where name = 'Pikachu'), (SELECT id from vets where name = 'Maisy Smith'), '08-03-2020'),
((SELECT id from animals where name = 'Pikachu'), (SELECT id from vets where name = 'Maisy Smith'), '14-05-2020'),
((SELECT id from animals where name = 'Devimon'), (SELECT id from vets where name = 'Stephanie Mendez'), '04-05-2021'),
((SELECT id from animals where name = 'Charmander'), (SELECT id from vets where name = 'Jack Harkness'), '24-02-2021'),
((SELECT id from animals where name = 'Plantmon'), (SELECT id from vets where name = 'Maisy Smith'), '21-12-2019'),
((SELECT id from animals where name = 'Plantmon'), (SELECT id from vets where name = 'William Tatcher'), '10-08-2020'),
((SELECT id from animals where name = 'Plantmon'), (SELECT id from vets where name = 'Maisy Smith'), '07-04-2021'),
((SELECT id from animals where name = 'Squirtle'), (SELECT id from vets where name = 'Stephanie Mendez'), '29-09-2019'),
((SELECT id from animals where name = 'Angemon'), (SELECT id from vets where name = 'Jack Harkness'), '03-10-2020'),
((SELECT id from animals where name = 'Angemon'), (SELECT id from vets where name = 'Jack Harkness'), '04-11-2020'),
((SELECT id from animals where name = 'Boarmon'), (SELECT id from vets where name = 'Maisy Smith'), '24-01-2019'),
((SELECT id from animals where name = 'Boarmon'), (SELECT id from vets where name = 'Maisy Smith'), '15-05-2019'),
((SELECT id from animals where name = 'Boarmon'), (SELECT id from vets where name = 'Maisy Smith'), '27-02-2020'),
((SELECT id from animals where name = 'Boarmon'), (SELECT id from vets where name = 'Maisy Smith'), '03-08-2020'),
((SELECT id from animals where name = 'Blossom'), (SELECT id from vets where name = 'Stephanie Mendez'), '24-05-2020'),
((SELECT id from animals where name = 'Blossom'), (SELECT id from vets where name = 'William Tatcher'), '11-01-2021');
