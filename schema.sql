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
