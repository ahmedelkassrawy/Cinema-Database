# 🎬 Cinema Management System

## 📌 Features Overview

#### a. 🎞️ Movie Management

Stores movie details: title, genre, duration, rating (e.g., PG-13), release date, and synopsis.

Movies must have a valid duration > 0 minutes and a valid rating.

Titles must be unique per release date.

#### b. 🏛️ Theater Management
Tracks theater details: location, total seats, screen size, and seating capacity per row.

Valid location and positive seat capacity required.

Theaters can host multiple screenings per day.

#### c. 📅 Screening Scheduling
Records screening info: movie ID, theater ID, start/end time, ticket price, and available seats.

No overlapping screenings in the same theater.

Ticket prices must be ≥ $5.

#### d. 🎟️ Booking System
Allows customers to book tickets for screenings.

Stores: customer ID, screening ID, seat numbers, payment status, and booking timestamp.

Validates unique seat selection per screening.

Supports cancellation and refund logic.

#### e. 👤 Customer Accounts
Manages: ID, name, unique email, phone number, and loyalty points.

Customers can submit reviews for movies they watched.

Loyalty points earned based on spending.

#### f. 🍿 Concession Sales
Tracks products: name, price, stock quantity, and category (e.g., snacks, drinks).

Concessions are linked to bookings (purchase history).

#### g. ⭐ Reviews & Ratings
Customers can submit ratings (1–5 stars) and text reviews.

Reviews must be from customers who attended the movie.

## 🔒 Data Integrity Requirements
Deleting a movie sets references to NULL in screenings and reviews.

Deleting a theater removes all related screenings (cascade).

Deleting a customer removes their bookings, reviews, and concessions (cascade).

## ⚖️ Business Rules
No screening may have a ticket price < $5.

Customers must be ≥ 13 years old to book R-rated movies.

Seat numbers must be unique per screening.

Concession stock cannot go below zero.

## 📊 Key Queries
Find all current screenings of a specific movie at a location.

List top 5 highest-rated movies in the past month.

Find all bookings by customer email.

Calculate total revenue from tickets and concessions per theater.

Identify the most popular genre by bookings.

List available theaters for a specific movie on a given date.

Show concession sales trends (e.g., most popular snack).

## 📂 Entities & Attributes

#### 1. 🎥 Movies
   
| Attribute    | Details                |
| ------------ | ---------------------- |
| MovieID (PK) | Unique identifier      |
| Title        | Unique per ReleaseDate |
| Genre        | e.g., Action, Comedy   |
| Duration     | Must be > 0 minutes    |
| Rating       | e.g., PG-13, R         |
| ReleaseDate  | Date format            |
| Synopsis     | Short summary          |

#### 2. 🏟️ Theaters

| Attribute      | Details                 |
| -------------- | ----------------------- |
| TheaterID (PK) | Unique identifier       |
| Location       | Must be unique          |
| TotalSeats     | Must be > 0             |
| ScreenSize     | e.g., IMAX              |
| SeatingPerRow  | Number of seats per row |

#### 3. ⏰ Screenings

| Attribute        | Details               |
| ---------------- | --------------------- |
| ScreeningID (PK) | Unique identifier     |
| MovieID (FK)     | Reference to Movies   |
| TheaterID (FK)   | Reference to Theaters |
| StartTime        | DateTime              |
| EndTime          | DateTime              |
| TicketPrice      | Must be ≥ \$5         |
| AvailableSeats   | Integer count         |

#### 4.🧑 Customers

| Attribute       | Details           |
| --------------- | ----------------- |
| CustomerID (PK) | Unique identifier |
| Name            | Required          |
| Email           | Must be unique    |
| PhoneNumber     | Optional          |
| LoyaltyPoints   | Integer           |

#### 5.📝 Bookings

| Attribute        | Details                 |
| ---------------- | ----------------------- |
| BookingID (PK)   | Unique identifier       |
| CustomerID (FK)  | Reference to Customers  |
| ScreeningID (FK) | Reference to Screenings |
| SeatNumbers      | Unique per screening    |
| PaymentStatus    | Paid / Pending          |
| BookingTimestamp | DateTime                |

#### 6. 🛍️ Concessions

| Attribute      | Details           |
| -------------- | ----------------- |
| ProductID (PK) | Unique identifier |
| ProductName    | e.g., Popcorn     |
| Price          | Must be ≥ \$0     |
| StockQuantity  | Must be ≥ 0       |
| Category       | Snacks / Drinks   |

#### 7. 💬 Reviews

| Attribute       | Details                |
| --------------- | ---------------------- |
| ReviewID (PK)   | Unique identifier      |
| CustomerID (FK) | Reference to Customers |
| MovieID (FK)    | Reference to Movies    |
| Rating          | 1–5 stars              |
| ReviewText      | Text content           |
| Timestamp       | DateTime               |

## 🔗 Relationships & Cardinality

| Entity A               | →            | Entity B               | Cardinality |
| ---------------------- | ------------ | ---------------------- | ----------- |
| Movies                 | →            | Screenings             | 1 : N       |
| Theaters               | →            | Screenings             | 1 : N       |
| Customers              | →            | Bookings               | 1 : N       |
| Screenings             | →            | Bookings               | 1 : N       |
| Customers              | →            | Reviews                | 1 : N       |
| Movies                 | →            | Reviews                | 1 : N       |
| Bookings ↔ Concessions | Many-to-Many | via BookingConcessions |             |

## ⚠️ Constraints & Validation Rules

#### 🧩 Data Integrity

Deleting a Movie: sets NULL in Screenings.MovieID, Reviews.MovieID.

Deleting a Theater: cascades to delete Screenings.

Deleting a Customer: cascades to delete Bookings, Reviews, and BookingConcessions.

#### 🔐 Uniqueness

Movies.Title is unique per ReleaseDate.

Customers.Email is unique.

Theaters.Location is unique.

#### ✅ Validation

TicketPrice ≥ $5

Duration > 0

StockQuantity ≥ 0

Customers must be ≥ 13 years old to book R-rated movies

Seat numbers must be unique per screening




