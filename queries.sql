/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name like '%mon';
SELECT * from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * from animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE NOT name = 'Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* New queries using transactions */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * from animals;
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name like '%mon';
UPDATE animals SET species = 'pokemon' WHERE name not like '%mon';
SELECT * from animals;
COMMIT;
SELECT * from animals;

BEGIN;
DELETE from animals;
ROLLBACK;
SELECT * from animals;

BEGIN;
DELETE from animals where date_of_birth > '2022-01-01';
SAVEPOINT delete2022;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * from animals;
ROLLBACK TO delete2022;
SELECT * from animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * from animals;

/* Queries to answer specific questions */

/* How many animals are there? */
SELECT COUNT(*) from animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) from animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) from animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, SUM(escape_attempts) from animals GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MAX(weight_kg), MIN(weight_kg) from animals GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, AVG(escape_attempts) from animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;



/* What animals belong to Melody Pond? */
SELECT name AS "Melody Pond's animals" from animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT animals.name AS "Animals' pokemon type" from animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal */
SELECT full_name AS owner, name AS "animals' name" from animals RIGHT JOIN owners ON animals.owner_id = owners.id;

/* How many animals are there per species? */
SELECT species.name AS "Specie type", COUNT(*) AS "Total" from animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell */
SELECT full_name AS owner, animals.name AS "Digimon animals" from animals INNER JOIN species ON animals.species_id = species.id
INNER JOIN owners ON animals.owner_id = owners.id where owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape */
SELECT full_name AS owner, name AS "Animals never try to scape" from animals INNER JOIN owners ON animals.owner_id = owners.id WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

/* Who owns the most animals? */
SELECT full_name AS "Owner with more animals", COUNT(animals.id) AS "Total animals" from animals INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name ORDER BY "Total animals" DESC LIMIT 1;


/* Who was the last animal seen by William Tatcher? */
SELECT animals.name AS "Last animal visited by William Tatcher", date_of_visit from visits INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id WHERE vet_id = (SELECT id from vets WHERE name = 'William Tatcher') ORDER BY date_of_visit DESC LIMIT 1;

/* How many different animals did Stephanie Mendez see? */
SELECT COUNT(specie_id) as "Types of animals that Stephanie Mendez see" from specializations where vet_id = (SELECT id from vets WHERE name = 'Stephanie Mendez');

/* List all vets and their specialties, including vets with no specialties. */
SELECT vets.name AS vet, species.name AS specialization from vets LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON species.id = specializations.specie_id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT animals.name AS "animals visited by Stephanie Mendez", date_of_visit from visits
INNER JOIN animals ON animals.id = visits.animal_id
WHERE vet_id = (SELECT id from vets WHERE name = 'Stephanie Mendez') AND date_of_visit BETWEEN '01-04-2020' AND '30-08-2020';

/* What animal has the most visits to vets? */
SELECT animals.name AS "animal with most visits", COUNT(animal_id) AS "total of visits" from visits
INNER JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name ORDER BY "total of visits" DESC LIMIT 1;

/* Who was Maisy Smith's first visit? */
SELECT animals.name AS "Maisy Smith's first visit", date_of_visit from visits
INNER JOIN animals ON animals.id = visits.animal_id
WHERE vet_id = (SELECT id from vets WHERE name = 'Maisy Smith') ORDER BY date_of_visit LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT animals.name AS "animals' name", species.name AS "type", vets.name AS vet, date_of_visit from visits
INNER JOIN animals ON animals.id = visits.animal_id
INNER JOIN vets ON vets.id = visits.vet_id
INNER JOIN species ON species.id = animals.species_id ORDER BY date_of_visit DESC LIMIT 1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT COUNT(visits.vet_id) AS "visits made by not specialize vet" from visits
INNER JOIN animals ON animals.id = visits.animal_id
INNER JOIN vets ON vets.id = visits.vet_id
LEFT JOIN specializations ON specializations.vet_id = vets.id
WHERE specializations.vet_id IS NULL;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT species.name AS "specialization recommended", COUNT(*) AS "total of visits" from visits
INNER JOIN animals ON animals.id = visits.animal_id
INNER JOIN species ON species.id = animals.species_id
WHERE vet_id = (SELECT id from vets where name = 'Maisy Smith')
GROUP BY species.name ORDER BY "total of visits" DESC LIMIT 1;
