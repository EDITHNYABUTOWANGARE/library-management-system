-- Creating the Books table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,  -- Primary Key
    Title VARCHAR(255) NOT NULL,            -- Book Title
    Author VARCHAR(255) NOT NULL,           -- Author of the book
    PublishedYear INT,                      -- Year the book was published
    ISBN VARCHAR(13) UNIQUE NOT NULL,       -- ISBN of the book (unique)
    AvailableCopies INT NOT NULL CHECK (AvailableCopies >= 0) -- Available copies
);

-- Creating the Members table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key
    FirstName VARCHAR(100) NOT NULL,         -- First Name of Member
    LastName VARCHAR(100) NOT NULL,          -- Last Name of Member
    Email VARCHAR(255) UNIQUE NOT NULL,      -- Email (unique)
    PhoneNumber VARCHAR(15),                 -- Phone Number of Member
    JoinDate DATE NOT NULL                   -- Date of joining
);

-- Creating the Book_Loans table
CREATE TABLE Book_Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,    -- Primary Key
    BookID INT NOT NULL,                       -- Foreign Key to Books table
    MemberID INT NOT NULL,                     -- Foreign Key to Members table
    LoanDate DATE NOT NULL,                    -- Date the book was checked out
    ReturnDate DATE,                           -- Date the book was returned (can be NULL)
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,  -- Foreign Key Constraint
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE -- Foreign Key Constraint
);

-- Optionally, add constraints for unique data integrity and consistency
ALTER TABLE Books ADD CONSTRAINT chk_available_copies CHECK (AvailableCopies >= 0);

-- Insert Sample Data into Books Table
INSERT INTO Books (Title, Author, PublishedYear, ISBN, AvailableCopies) 
VALUES
    ('The Great Gatsby', 'F. Scott Fitzgerald', 1925, '9780743273565', 5),
    ('1984', 'George Orwell', 1949, '9780451524935', 3),
    ('To Kill a Mockingbird', 'Harper Lee', 1960, '9780061120084', 2);

-- Insert Sample Data into Members Table
INSERT INTO Members (FirstName, LastName, Email, PhoneNumber, JoinDate)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '555-1234', '2023-01-15'),
    ('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '2022-08-21'),
    ('Emily', 'Clark', 'emily.clark@example.com', '555-8765', '2023-04-10');

-- Insert Sample Data into Book_Loans Table
INSERT INTO Book_Loans (BookID, MemberID, LoanDate, ReturnDate)
VALUES
    (1, 1, '2023-01-20', NULL), -- John Doe checked out "The Great Gatsby" on 2023-01-20
    (2, 2, '2023-04-01', '2023-04-15'), -- Jane Smith checked out "1984" on 2023-04-01 and returned it on 2023-04-15
    (3, 3, '2023-04-12', NULL); -- Emily Clark checked out "To Kill a Mockingbird" on 2023-04-12
