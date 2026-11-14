# Politicians & AI Regulation - Open Dataset

An Open Computing project providing a curated dataset of international politicians and public officials who have actively advocated for, authored, or sponsored law-making aimed at regulating artificial intelligence. The dataset also tracks efforts related to enforcing copyright protections against AI model training and setting check-and-balance parameters for AI instantiation.

The repository includes both the raw data (JSON/CSV) for public use and a web interface to browse, filter, and download the data.

## 1. The Nature of the Data

This dataset is not a generic directory of all politicians. It is a highly targeted, curated collection focused specifically on the intersection of **politics, artificial intelligence, and digital rights**.

### Domain and Scope
- **Focus:** The primary criteria for inclusion is that the individual has actively engaged in AI regulation. This engagement includes drafting legislation (e.g., the EU AI Act), sponsoring bills (e.g., the NO FAKES Act), issuing public statements, or holding key committee positions related to technology and justice.
- **Geographic Coverage:** The dataset currently spans multiple jurisdictions, primarily the European Union (EU), the United States (US), and New Zealand.
- **Temporal Nature:** The data captures historical context (e.g., birth years, past terms in office) as well as ongoing legislative efforts (e.g., bills currently pending or public statements made in recent years).

### Granularity and Relationships
The data is highly relational and multidimensional. A single politician is not just a name and a party; they are a nexus of political activity:
- **Terms in Office:** Tracks their career trajectory (start and end years).
- **Legislative Actions:** Documents specific bills or public statements they have made regarding AI, complete with the year and current status (e.g., Passed, Introduced, Failed).
- **Committee Memberships:** Identifies which legislative bodies (e.g., Senate Judiciary, Committee on Civil Liberties) they sit on, which directly influences their power over tech policy.
- **Ideology:** Captures their stance not just broadly, but specifically regarding tech regulation (e.g., "Social Democracy / AI Act Co-Author").

### Potential Use Cases for Data Consumers
Researchers, journalists, and analysts can use this data to:
- Map the global political landscape of AI regulation.
- Identify which political parties or ideologies are most active in drafting AI legislation.
- Cross-reference committee memberships with the passage of specific AI bills.
- Track the timeline of AI-related legislative actions across different countries.

## 2. Data Formats & Structure (For Data Users)

This dataset is designed to be easily consumed. You can access the raw data directly without needing to run any backend code.

### Available Formats
- **`politicians.json`**: A deeply nested JSON structure. This is the recommended format for programmatic use (e.g., Python, JavaScript) as it preserves the relationships between politicians, their terms, legislative actions, and committee memberships.
- **`politicians.csv`**: A flattened version of the dataset. This is ideal for spreadsheet software (Excel, Google Sheets) or statistical tools (R, pandas). Nested arrays are condensed into semicolon-separated strings in a single cell.
- **`schema.json`**: A machine-readable JSON Schema (Draft 2020-12) that formally describes the structure, data types, and required fields of `politicians.json`, allowing for automated validation.

### JSON Data Structure
Each record in the JSON array represents one politician and contains:
- **Basic Info:** `id`, `first_name`, `last_name`, `birth_year`, `country`, `current_office`, `is_active` (1 = currently in office, 0 = no longer active), `education_level`, `official_website`.
- **`party_affiliation`** (Object): Contains `party_name` and `ideology`.
- **`terms_in_office`** (Array of Objects): Contains `role`, `start_year`, and `end_year` (null if currently serving).
- **`legislative_actions`** (Array of Objects): Contains `title`, `action_type`, `year`, and `status`.
- **`committee_memberships`** (Array of Objects): Contains `committee_name`, `role`, `start_year`, and `end_year`.

## 3. Web Interface Functionality

If you want to explore the data visually, the project includes a static web interface that communicates with a local backend server.

- **`index.html` (Landing Page):** Provides a human-readable summary of the dataset, its metadata (Title, Description, Author), and direct download links to the raw files. It also includes a schema reference and links to the interactive table.
- **`datatable.html` (Interactive Table):** 
  - **Asynchronous Loading:** Fetches data from the backend database without reloading the page.
  - **Live Filtering:** Features a search bar that defaults to a "wildcard" search across all attributes (including nested arrays). A dropdown menu allows you to narrow the search to specific fields (e.g., only searching by Country, or only searching within Legislative Actions). Typing an empty string resets the view.
  - **Multiple Views:** The UI splits the data into four clear tables: Politicians, Terms in Office, Legislative Actions, and Committee Memberships.
  - **Custom Export:** Buttons above the tables allow you to download the *currently filtered* view into a new CSV or JSON file, allowing for quick data extraction based on your search parameters.

## 4. How to Run the Project Locally

**Prerequisites:** Python 3.x installed.

1. **Install dependencies:**
   pip install flask flask-cors

2. **Start the Backend (Terminal 1):**
   python app.py
   *This starts the Flask server on `http://127.0.0.1:5000` and automatically generates the SQLite database (`politicians.db`) from the SQL dump if it doesn't already exist.*

3. **Start the Frontend (Terminal 2):**
   Open a new terminal in the same directory and run:
   python -m http.server 8000

4. **View the Website:**
   Open your browser and navigate to `http://localhost:8000/index.html`.

Appendix: Database Schemas (For Developers)
Note for data consumers: You do not need this section to use the JSON/CSV files. This is only for developers extending the backend or rebuilding the database.

Appendix A: Current Database Schema (Lab 2)
The backend uses a relational SQLite model with four interconnected tables to maintain data integrity and power the interactive web interface.

1. politicians (Parent Entity)
id (INTEGER, Primary Key)

first_name, last_name, country, education_level, official_website, party_name, ideology (TEXT)

birth_year (INTEGER), current_office (TEXT), is_active (INTEGER)

2. terms_in_office (Child Entity)
id (INTEGER, Primary Key)

politician_id (INTEGER, Foreign Key)

role (TEXT), start_year (INTEGER), end_year (INTEGER - NULL if current)

3. legislative_actions (Child Entity)
id (INTEGER, Primary Key)

politician_id (INTEGER, Foreign Key)

title (TEXT), action_type (TEXT), year (INTEGER), status (TEXT)

4. committee_memberships (Child Entity)
id (INTEGER, Primary Key)

politician_id (INTEGER, Foreign Key)

committee_name (TEXT), role (TEXT), start_year (INTEGER), end_year (INTEGER - NULL if current)

The database can be entirely rebuilt by running app.py, which executes the politicians_dump.sql file.

Appendix B: Original Lab 1 Database Sketch (Legacy)
This section is kept for historical context, representing the initial 2-table database schema designed during the 1st laboratory exercise before the dataset was expanded.

1. politicians (Parent Entity)
id (INTEGER, Primary Key, Auto Increment) - unique identifier for the politician in question

first_name (TEXT)

last_name (TEXT)

birth_year (INTEGER)

country (TEXT)

current_office (TEXT)

is_active (INTEGER - Boolean 1/0) - enum to say whether one is active: 1-active 0-inactive

education_level (TEXT)

official_website (TEXT)

party_name (TEXT) - refers to the current political party non term related

ideology (TEXT) - with respect to AI and general

2. terms_in_office (Child Entity)
id (INTEGER, Primary Key, Auto Increment) - unique identifier for the terms

politician_id (INTEGER, Foreign Key referencing politicians.id) - the same as in parent entity

role (TEXT) - the title of the office interchangeable with title semantically

start_year (INTEGER) - of term

end_year (INTEGER - NULL if currently serving/ ATM) - of term