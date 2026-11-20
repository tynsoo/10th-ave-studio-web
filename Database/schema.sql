-- 10th Ave Studio database schema
-- Rebuilt from the SQL queries in the site's code-behind files (the original
-- database was not included in the project). Run this once against a new, empty
-- Azure SQL database (Azure portal > SQL database > Query editor).
--
-- After you sign up on the live site, make yourself an admin with:
--   UPDATE Users SET Role = 'Admin' WHERE Email = 'you@example.com';

CREATE TABLE Users (
    Users_ID      INT IDENTITY(1,1) PRIMARY KEY,
    FName         NVARCHAR(100) NOT NULL,
    LName         NVARCHAR(100) NOT NULL,
    PhoneNumber   NVARCHAR(30)  NULL,
    FBLink        NVARCHAR(255) NULL,
    Email         NVARCHAR(255) NOT NULL UNIQUE,
    UserPassword  NVARCHAR(64)  NOT NULL,          -- SHA-256 hex hash
    Role          NVARCHAR(20)  NOT NULL DEFAULT 'Student'  -- Student | Instructor | Admin
);

CREATE TABLE Instructors (
    Instructor_ID INT IDENTITY(1,1) PRIMARY KEY,
    Users_ID      INT NOT NULL REFERENCES Users(Users_ID),
    Specialty     NVARCHAR(100) NULL,
    Experience    NVARCHAR(MAX) NULL
);

CREATE TABLE Classes (
    Class_ID          INT IDENTITY(1,1) PRIMARY KEY,
    Name              NVARCHAR(100) NOT NULL,
    Class_Description NVARCHAR(MAX) NULL,
    Instructor_ID     INT NULL REFERENCES Instructors(Instructor_ID),
    Price             DECIMAL(10,2) NOT NULL DEFAULT 0,
    MaxStudents       INT NOT NULL DEFAULT 20
);

CREATE TABLE Schedules (
    Schedule_ID   INT IDENTITY(1,1) PRIMARY KEY,
    Class_ID      INT NOT NULL REFERENCES Classes(Class_ID),
    Schedule_Day  DATE NOT NULL,
    Schedule_Time TIME NOT NULL,
    Location      INT  NOT NULL                    -- 1 = Studio 1, 2 = Studio 2
);

CREATE TABLE Bookings (
    Booking_ID           INT IDENTITY(1,1) PRIMARY KEY,
    Schedule_ID          INT NOT NULL REFERENCES Schedules(Schedule_ID),
    Users_ID             INT NOT NULL REFERENCES Users(Users_ID),
    PaymentReference     NVARCHAR(100) NOT NULL,
    PaymentProofFilePath NVARCHAR(500) NULL,
    BookingDate          DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE StudentAttendance (
    Attendance_ID  INT IDENTITY(1,1) PRIMARY KEY,
    Users_ID       INT NOT NULL REFERENCES Users(Users_ID),
    Schedule_ID    INT NOT NULL REFERENCES Schedules(Schedule_ID),
    AttendanceDate DATE NOT NULL,
    AttendanceTime TIME NOT NULL,
    Status         NVARCHAR(20) NOT NULL           -- Present | Late
);

CREATE TABLE Rentals (
    Rental_ID  INT IDENTITY(1,1) PRIMARY KEY,
    Users_ID   INT NOT NULL REFERENCES Users(Users_ID),
    EventTitle NVARCHAR(100) NOT NULL,
    RentalDate DATE NOT NULL,
    RentalTime TIME NOT NULL
);

CREATE TABLE Contacts (
    Contacts_Id INT IDENTITY(1,1) PRIMARY KEY,
    Users_ID    INT NOT NULL REFERENCES Users(Users_ID),
    Comments    NVARCHAR(MAX) NOT NULL,
    CreatedAt   DATETIME NOT NULL DEFAULT GETDATE()
);
