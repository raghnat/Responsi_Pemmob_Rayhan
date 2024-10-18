CREATE TABLE isbn (
    id SERIAL PRIMARY KEY,
    isbn_code VARCHAR(255),
    format VARCHAR(100),
    print_length INTEGER
);
