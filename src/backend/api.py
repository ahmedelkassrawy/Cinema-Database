from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel
from typing import List, Optional
import pyodbc
import logging
from datetime import date, time
from decimal import Decimal

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

app = FastAPI(title="Cinema Database API", description="API for managing the Cinema database")

connection_string = (
    'DRIVER={ODBC Driver 18 for SQL Server};'
    'SERVER=DESKTOP-U28C2MI;'
    'DATABASE=Cinema;'
    'Trusted_Connection=yes;'
    'TrustServerCertificate=yes;'
    'Connection Timeout=30'
)


class Movie(BaseModel):
    movie_id: int
    title: str
    genre: str
    duration: str  # time as string
    rating: Optional[str]
    release_date: date
    synopsis: Optional[str]

    class Config:
        from_attributes = True

class MovieCreate(BaseModel):
    title: str
    genre: str
    duration: str
    rating: Optional[str] = None
    release_date: date
    synopsis: Optional[str] = None

class Customer(BaseModel):
    customer_id: int
    name: str
    email: str
    phone_number: Optional[str]
    loyal_points: Optional[int]

    class Config:
        from_attributes = True

class CustomerCreate(BaseModel):
    name: str
    email: str
    phone_number: Optional[str] = None
    loyal_points: Optional[int] = 0

class Booking(BaseModel):
    booking_id: int
    seat_number: int
    payment_status: bool
    booking_timestamp: Optional[str]
    customer_id: int
    screening_id: int

    class Config:
        from_attributes = True

class BookingCreate(BaseModel):
    seat_number: int
    payment_status: bool
    customer_id: int
    screening_id: int

class Concession(BaseModel):
    product_id: int
    product_name: str
    price: float
    stock_quantity: Optional[int]
    category: Optional[str]

    class Config:
        from_attributes = True

class ConcessionPurchase(BaseModel):
    booking_id: int
    product_id: int
    quantity: int


def get_db_connection():
    try:
        conn = pyodbc.connect(connection_string)
        return conn
    except pyodbc.Error as e:
        logger.error(f"Database connection error: {e}")
        raise HTTPException(status_code=500, detail="Failed to connect to database")

#movies endpoint
@app.get("/movies", response_model=List[Movie])
async def get_all_movies():
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT movie_id, title, genre, duration, rating, release_date, Synopsis FROM Movies")
        rows = cursor.fetchall()
        movies = [
            Movie(
                movie_id=row.movie_id,
                title=row.title,
                genre=row.genre,
                duration=str(row.duration),
                rating=row.rating,
                release_date=row.release_date,
                synopsis=row.Synopsis
            ) for row in rows
        ]
        return movies
    except pyodbc.Error as e:
        logger.error(f"Error fetching movies: {e}")
        raise HTTPException(status_code=500, detail="Failed to fetch movies")
    finally:
        cursor.close()
        conn.close()

@app.get("/movies/{movie_id}", response_model=Movie)
async def get_movie(movie_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT movie_id, title, genre, duration, rating, release_date, Synopsis FROM Movies WHERE movie_id = ?", movie_id)
        row = cursor.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Movie not found")
        return Movie(
            movie_id=row.movie_id,
            title=row.title,
            genre=row.genre,
            duration=str(row.duration),
            rating=row.rating,
            release_date=row.release_date,
            synopsis=row.Synopsis
        )
    except pyodbc.Error as e:
        logger.error(f"Error fetching movie {movie_id}: {e}")
        raise HTTPException(status_code=500, detail="Failed to fetch movie")
    finally:
        cursor.close()
        conn.close()

@app.post("/movies", response_model=Movie, status_code=status.HTTP_201_CREATED)
async def create_movie(movie: MovieCreate):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            """
            INSERT INTO Movies (title, genre, duration, rating, release_date, Synopsis)
            OUTPUT INSERTED.movie_id, INSERTED.title, INSERTED.genre, INSERTED.duration, INSERTED.rating, INSERTED.release_date, INSERTED.Synopsis
            VALUES (?, ?, ?, ?, ?, ?)
            """,
            (movie.title, movie.genre, movie.duration, movie.rating, movie.release_date, movie.synopsis)
        )
        row = cursor.fetchone()
        conn.commit()
        return Movie(
            movie_id=row.movie_id,
            title=row.title,
            genre=row.genre,
            duration=str(row.duration),
            rating=row.rating,
            release_date=row.release_date,
            synopsis=row.Synopsis
        )
    except pyodbc.Error as e:
        conn.rollback()
        logger.error(f"Error creating movie: {e}")
        raise HTTPException(status_code=500, detail="Failed to create movie")
    finally:
        cursor.close()
        conn.close()

@app.put("/movies/{movie_id}", response_model=Movie)
async def update_movie(movie_id: int, movie: MovieCreate):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            """
            UPDATE Movies
            SET title = ?, genre = ?, duration = ?, rating = ?, release_date = ?, Synopsis = ?
            OUTPUT INSERTED.movie_id, INSERTED.title, INSERTED.genre, INSERTED.duration, INSERTED.rating, INSERTED.release_date, INSERTED.Synopsis
            WHERE movie_id = ?
            """,
            (movie.title, movie.genre, movie.duration, movie.rating, movie.release_date, movie.synopsis, movie_id)
        )
        row = cursor.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Movie not found")
        conn.commit()
        return Movie(
            movie_id=row.movie_id,
            title=row.title,
            genre=row.genre,
            duration=str(row.duration),
            rating=row.rating,
            release_date=row.release_date,
            synopsis=row.Synopsis
        )
    except pyodbc.Error as e:
        conn.rollback()
        logger.error(f"Error updating movie {movie_id}: {e}")
        raise HTTPException(status_code=500, detail="Failed to update movie")
    finally:
        cursor.close()
        conn.close()

@app.delete("/movies/{movie_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_movie(movie_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM Movies WHERE movie_id = ?", movie_id)
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Movie not found")
        conn.commit()
    except pyodbc.Error as e:
        conn.rollback()
        logger.error(f"Error deleting movie {movie_id}: {e}")
        raise HTTPException(status_code=500, detail="Failed to delete movie")
    finally:
        cursor.close()
        conn.close()

#customers endpoints
@app.get("/customers", response_model=List[Customer])
async def get_all_customers():
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT customer_id, name, email, phone_number, loyal_points FROM Customers")
        rows = cursor.fetchall()
        customers = [
            Customer(
                customer_id=row.customer_id,
                name=row.name,
                email=row.email,
                phone_number=row.phone_number,
                loyal_points=row.loyal_points
            ) for row in rows
        ]
        return customers
    except pyodbc.Error as e:
        logger.error(f"Error fetching customers: {e}")
        raise HTTPException(status_code=500, detail="Failed to fetch customers")
    finally:
        cursor.close()
        conn.close()

@app.post("/customers", response_model=Customer, status_code=status.HTTP_201_CREATED)
async def create_customer(customer: CustomerCreate):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            """
            INSERT INTO Customers (name, email, phone_number, loyal_points)
            OUTPUT INSERTED.customer_id, INSERTED.name, INSERTED.email, INSERTED.phone_number, INSERTED.loyal_points
            VALUES (?, ?, ?, ?)
            """,
            (customer.name, customer.email, customer.phone_number, customer.loyal_points)
        )
        row = cursor.fetchone()
        conn.commit()
        return Customer(
            customer_id=row.customer_id,
            name=row.name,
            email=row.email,
            phone_number=row.phone_number,
            loyal_points=row.loyal_points
        )
    except pyodbc.Error as e:
        conn.rollback()
        logger.error(f"Error creating customer: {e}")
        raise HTTPException(status_code=500, detail="Failed to create customer")
    finally:
        cursor.close()
        conn.close()

@app.put("/customers/{customer_id}", response_model=Customer)
async def update_customer(customer_id: int, customer: CustomerCreate):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            """
            UPDATE Customers
            SET name = ?, email = ?, phone_number = ?, loyal_points = ?
            OUTPUT INSERTED.customer_id, INSERTED.name, INSERTED.email, INSERTED.phone_number, INSERTED.loyal_points
            WHERE customer_id = ?
            """,
            (customer.name, customer.email, customer.phone_number, customer.loyal_points, customer_id)
        )
        row = cursor.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Customer not found")
        conn.commit()
        return Customer(
            customer_id=row.customer_id,
            name=row.name,
            email=row.email,
            phone_number=row.phone_number,
            loyal_points=row.loyal_points
        )
    except pyodbc.Error as e:
        conn.rollback()
        logger.error(f"Error updating customer {customer_id}: {e}")
        raise HTTPException(status_code=500, detail="Failed to update customer")
    finally:
        cursor.close()
        conn.close()

#bookings endpoints
@app.get("/bookings", response_model=List[Booking])
async def get_all_bookings():
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT booking_id, seat_number, payment_status, booking_timestamp, customer_id, screening_id FROM Bookings")
        rows = cursor.fetchall()
        bookings = [
            Booking(
                booking_id=row.booking_id,
                seat_number=row.seat_number,
                payment_status=row.payment_status,
                booking_timestamp=str(row.booking_timestamp) if row.booking_timestamp else None,
                customer_id=row.customer_id,
                screening_id=row.screening_id
            ) for row in rows
        ]
        return bookings
    except pyodbc.Error as e:
        logger.error(f"Error fetching bookings: {e}")
        raise HTTPException(status_code=500, detail="Failed to fetch bookings")
    finally:
        cursor.close()
        conn.close()

@app.get("/bookings/customer/{customer_id}", response_model=List[Booking])
async def get_bookings_by_customer(customer_id: int):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT booking_id, seat_number, payment_status, booking_timestamp, customer_id, screening_id FROM Bookings WHERE customer_id = ?", customer_id)
        rows = cursor.fetchall()
        if not rows:
            raise HTTPException(status_code=404, detail="No bookings found for this customer")
        bookings = [
            Booking(
                booking_id=row.booking_id,
                seat_number=row.seat_number,
                payment_status=row.payment_status,
                booking_timestamp=str(row.booking_timestamp) if row.booking_timestamp else None,
                customer_id=row.customer_id,
                screening_id=row.screening_id
            ) for row in rows
        ]
        return bookings
    except pyodbc.Error as e:
        logger.error(f"Error fetching bookings for customer {customer_id}: {e}")
        raise HTTPException(status_code=500, detail="Failed to fetch bookings")
    finally:
        cursor.close()
        conn.close()

@app.post("/bookings", response_model=Booking, status_code=status.HTTP_201_CREATED)
async def create_booking(booking: BookingCreate):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        #check seats for screening
        cursor.execute(
            """
            SELECT available_Seats FROM Screenings WHERE Screening_id = ?
            """, booking.screening_id
        )
        available_seats = cursor.fetchone()
        if not available_seats or available_seats.available_Seats <= 0:
            raise HTTPException(status_code=400, detail="No available seats for this screening")

        #error handle
        cursor.execute(
            """
            SELECT booking_id FROM Bookings WHERE screening_id = ? AND seat_number = ?
            """, (booking.screening_id, booking.seat_number)
        )
        if cursor.fetchone():
            raise HTTPException(status_code=400, detail="Seat already booked for this screening")

        #dakhal booking
        cursor.execute(
            """
            INSERT INTO Bookings (seat_number, payment_status, customer_id, screening_id)
            OUTPUT INSERTED.booking_id, INSERTED.seat_number, INSERTED.payment_status, INSERTED.booking_timestamp, INSERTED.customer_id, INSERTED.screening_id
            VALUES (?, ?, ?, ?)
            """,
            (booking.seat_number, booking.payment_status, booking.customer_id, booking.screening_id)
        )
        row = cursor.fetchone()

        #update available seats
        cursor.execute(
            """
            UPDATE Screenings SET available_Seats = available_Seats - 1 WHERE Screening_id = ?
            """, booking.screening_id
        )
        conn.commit()
        return Booking(
            booking_id=row.booking_id,
            seat_number=row.seat_number,
            payment_status=row.payment_status,
            booking_timestamp=str(row.booking_timestamp) if row.booking_timestamp else None,
            customer_id=row.customer_id,
            screening_id=row.screening_id
        )
    except pyodbc.Error as e:
        conn.rollback()
        logger.error(f"Error creating booking: {e}")
        raise HTTPException(status_code=500, detail="Failed to create booking")
    finally:
        cursor.close()
        conn.close()

#concessions endpoints
@app.get("/concessions", response_model=List[Concession])
async def get_all_concessions():
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT product_id, product_name, price, stock_quantity, category FROM Concessions")
        rows = cursor.fetchall()
        concessions = [
            Concession(
                product_id=row.product_id,
                product_name=row.product_name,
                price=float(row.price),
                stock_quantity=row.stock_quantity,
                category=row.category
            ) for row in rows
        ]
        return concessions
    except pyodbc.Error as e:
        logger.error(f"Error fetching concessions: {e}")
        raise HTTPException(status_code=500, detail="Failed to fetch concessions")
    finally:
        cursor.close()
        conn.close()

@app.post("/concessions/purchase", response_model=ConcessionPurchase, status_code=status.HTTP_201_CREATED)
async def purchase_concession(purchase: ConcessionPurchase):
    conn = get_db_connection()
    cursor = conn.cursor()
    try:
        #check stock
        cursor.execute(
            """
            SELECT stock_quantity, price FROM Concessions WHERE product_id = ?
            """, purchase.product_id
        )
        row = cursor.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Concession product not found")
        if row.stock_quantity < purchase.quantity:
            raise HTTPException(status_code=400, detail="Insufficient stock for this product")

        # Insert into BookingConcessions
        cursor.execute(
            """
            INSERT INTO BookingConcessions (BookingID, ProductID, Quantity)
            VALUES (?, ?, ?)
            """,
            (purchase.booking_id, purchase.product_id, purchase.quantity)
        )

        #update stock
        cursor.execute(
            """
            UPDATE Concessions SET stock_quantity = stock_quantity - ? WHERE product_id = ?
            """, (purchase.quantity, purchase.product_id)
        )

        #update ConcessionRevenues
        cursor.execute(
            """
            UPDATE ConcessionRevenues
            SET total_revenue = total_revenue + (? * ?), last_updated = GETDATE()
            WHERE product_id = ?
            """, (purchase.quantity, row.price, purchase.product_id)
        )
        conn.commit()
        return purchase
    except pyodbc.Error as e:
        conn.rollback()
        logger.error(f"Error purchasing concession: {e}")
        raise HTTPException(status_code=500, detail="Failed to purchase concession")
    finally:
        cursor.close()
        conn.close()

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
