# Politicians

A lab1 Open Computing project with international politicians and public officials who have actively advocated for, authored, or sponsored law making aimed at regulating artificial intelligence. Also, enforcing copyright protections against model training, and setting check and balance parameters for AI instantiation.

## Repository Structure

- `politicians.json` - 2d JSON export.
- `politicians.csv` - Flattened CSV.
- `politicians_dump.sql` - Full SQL dump containing database schema and seed data.
- `LICENSE` - MIT License documentation.
- `Readme.md` - You are reading it.
- `Language` - English
- `Author` - Vedran Lekić

## Database Schema & Architecture

The database utilizes a relational model with two core entities linked (`politicians` $\rightarrow$ `terms_in_office`).

### 1. `politicians` (Parent Entity)
- `id` (INTEGER, Primary Key, Auto Increment) - unique identifier for the politician in question
- `first_name` (TEXT)
- `last_name` (TEXT)
- `birth_year` (INTEGER)
- `country` (TEXT)
- `current_office` (TEXT)
- `is_active` (INTEGER - Boolean 1/0) - enum to say whether one is active: 1-active 0-inactive
- `education_level` (TEXT)
- `official_website` (TEXT)
- `party_name` (TEXT) - refers to the current political party non term related
- `ideology` (TEXT) - with respect to AI and general

### 2. `terms_in_office` (Child Entity)
- `id` (INTEGER, Primary Key, Auto Increment) - unique identifier for the terms
- `politician_id` (INTEGER, Foreign Key referencing `politicians.id`) - the same as in parent entity
- `role` (TEXT) - the title of the office interchangable with title semantically
- `start_year` (INTEGER) - of term
- `end_year` (INTEGER - NULL if currently serving/ ATM)-  of term
