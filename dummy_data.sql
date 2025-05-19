USE [Cinema]
GO

INSERT INTO [Movies] ([movie_id], [title], [genre], [duration], [rating], [release_date], [Synopsis])
VALUES 
    (1, 'The Galactic Quest', 'Sci-Fi', '02:15:00', 'PG-13', '2025-01-15', 'A crew explores uncharted galaxies.'),
    (2, 'Love in Time', 'Romance', '01:45:00', 'PG', '2024-11-20', 'A time-traveling love story.'),
    (3, 'Mystery Manor', 'Thriller', '01:55:00', 'R', '2025-03-10', 'A detective uncovers dark secrets.'),
    (4, 'Super Speed', 'Action', '02:00:00', 'PG-13', '2025-02-01', 'A racer battles a crime syndicate.'),
    (5, 'Jungle Adventure', 'Adventure', '01:30:00', 'G', '2024-12-05', 'Kids explore a magical jungle.');
GO

INSERT INTO [Theaters] ([Theater_id], [T_location], [ScreenSize], [TotalSeats], [SeatingPerRow])
VALUES 
    (1, 'Downtown Cinema, NY', 'Large', 200, 20),
    (2, 'Westside Plaza, LA', 'Medium', 150, 15),
    (3, 'Main Street, Chicago', 'Small', 100, 10);
GO


INSERT INTO [Screenings] ([Screening_id], [Theater_id], [Movie_id], [start_time], [end_time], [ticket_price], [available_Seats])
VALUES 
    (1, 1, 1, '18:00:00', '20:15:00', 12.50, 180),
    (2, 1, 2, '21:00:00', '22:45:00', 10.00, 190),
    (3, 2, 3, '19:30:00', '21:25:00', 11.00, 140),
    (4, 2, 4, '16:00:00', '18:00:00', 13.00, 130),
    (5, 3, 5, '14:00:00', '15:30:00', 8.50, 95);
GO


INSERT INTO [Customers] ([customer_id], [name], [email], [phone_number], [loyal_points])
VALUES 
    (1, 'John Doe', 'john.doe@email.com', '555-0101', 100),
    (2, 'Jane Smith', 'jane.smith@email.com', '555-0102', 50),
    (3, 'Mike Johnson', 'mike.j@email.com', '555-0103', 20),
    (4, 'Emily Brown', 'emily.brown@email.com', '555-0104', 80),
    (5, 'Alex Lee', 'alex.lee@email.com', '555-0105', 0);
GO


INSERT INTO [Bookings] ([booking_id], [seat_numbers], [payment_status], [booking_timestamp], [customer_id], [screening_id])
VALUES 
    (1, 5, 1, '2025-05-18 10:00:00', 1, 1),
    (2, 10, 1, '2025-05-18 12:30:00', 2, 2),
    (3, 15, 0, '2025-05-19 09:00:00', 3, 3),
    (4, 20, 1, '2025-05-19 11:15:00', 4, 4),
    (5, 25, 1, '2025-05-19 13:45:00', 5, 5);
GO


INSERT INTO [Concessions] ([product_id], [product_name], [price], [stock_quantity], [category])
VALUES 
    (1, 'Popcorn (Large)', 7.50, 100, 'Snack'),
    (2, 'Soda (Medium)', 4.00, 200, 'Drink'),
    (3, 'Nachos', 6.00, 80, 'Snack'),
    (4, 'Candy Box', 3.50, 150, 'Snack'),
    (5, 'Bottled Water', 2.50, 300, 'Drink');
GO


INSERT INTO [Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp])
VALUES 
    (1, 1, 1, 4, 'Great visuals, but slow pacing at times.', '2025-05-18 21:00:00'),
    (2, 2, 2, 5, 'Heartwarming and beautifully done!', '2025-05-18 23:00:00'),
    (3, 3, 3, 3, 'Good plot, but too predictable.', '2025-05-19 10:00:00'),
    (4, 4, 4, 4, 'Action-packed and thrilling!', '2025-05-19 12:00:00'),
    (5, 5, 5, 5, 'Perfect for kids, so much fun!', '2025-05-19 16:00:00');
GO


INSERT INTO [Booking-Concessions] ([BookingID], [ProductID], [Quantity])
VALUES 
    (1, 1, 2),
    (1, 2, 1),
    (2, 3, 1),
    (3, 4, 3),
    (4, 5, 2);
GO
