# What is PostgreSQL?
PostPostgreSQL is a powerful, open-source object-relational database management system.

- ****Open Source:** This means it's free to use, modify, and distribute. It's developed and maintained by a global community of developers.
- ****Object-Relational:** PostgreSQL combines the best of both relational databases and object-oriented databases which can handle more complex data types and structures.

PostgreSQL is a versatile database used for a wide range of applications such as Web and Mobile Applications, Transaction Processing, Data Analytics etc.


# Explain the Primary Key and Foreign Key concepts in PostgreSQL.

A primary key is a column (or set of columns) that uniquely identifies each row in a table. It's the database's way of giving each record a distinct identity.

- PostgreSQL implements primary keys using unique indexes
- Primary keys are used as the physical sort order for the table in many cases

### **Key Characteristics:**

1. **Uniqueness**: No two rows can have the same primary key value
2. **Non-null**: Primary key columns cannot contain NULL values
3. **Single per table**: A table can have only one primary key

``
CREATE Table rangers(
    ranger_id serial PRIMARY KEY,
    name VARCHAR(100),
    region VARCHAR(100)
);
``

### **Foreign Keys**

A foreign key is a column or set of columns that references the primary key of another table, establishing a relationship between the two tables.

### **Key Characteristics:**

1. **Referential integrity**: Ensures the relationship between data remains valid
2. **Can be null**: Unless explicitly set to NOT NULL
3. **Multiple per table**: A table can have many foreign keys
4. **Optional index**: Unlike primary keys, indexes aren't automatically created.

``
CREATE TABLE sightings (
    sighting_id serial PRIMARY KEY,
    species_id INT REFERENCES species(species_id),
    ranger_id INT REFERENCES rangers(ranger_id),
    location VARCHAR(100),
    sighting_time TIMESTAMP,
    notes TEXT    
);
``

# What is the difference between the VARCHAR and CHAR data types?

### **CHAR (Character)**

- **Fixed-length** storage
- Always occupies the declared length
- Pads with spaces if content is shorter than declared length
- Also known as **`CHAR(n)`** or **`CHARACTER(n)`**

### **VARCHAR (Variable Character)**

- **Variable-length** storage
- Only uses space needed for the actual content (plus small overhead)
- No padding is added
- Also known as **`VARCHAR(n)`**, **`CHARACTER VARYING(n)`**, or **`TEXT`** (without length limit)


# Explain the purpose of the WHERE clause in a SELECT statement.
The `WHERE` clause in a `SELECT` statement acts like a **filter** for your data.

When you use a `SELECT` statement, you're essentially saying, "Show me data from this table." Without a `WHERE` clause, the database shows you *all* the rows.

But when add a `WHERE` clause, you're telling the database, "Only show me the rows that meet a specific condition."

**In simple terms, the `WHERE` clause helps you pick out exactly what you want from a larger set of data.**

**Here's a breakdown:**

- **`SELECT`**: What you want to see (e.g., names, ages, product prices).
- **`WHERE`**: **The specific condition(s) that rows must meet to be included in your results.**

The `WHERE` clause is incredibly powerful for narrowing down your data and getting precisely the information you need from a database.


# How can you modify data using UPDATE statements?
For modify data in a database using the UPDATE statement in SQL. The UPDATE statement allows you to change existing records in a table.

``
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';
``

- `table_name`: The name of the table you want to update.
- `SET`: Specifies the columns and the new values.
- `WHERE`: Specifies which rows should be updated.

