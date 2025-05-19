USE [Cinema]
GO

INSERT INTO [Movies] ([movie_id], [title], [genre], [duration], [rating], [release_date], [Synopsis])
VALUES 
    (1, 'Inception', 'Sci-Fi', '02:28:00', 'PG-13', '2010-07-16', 'A thief enters dreams to plant an idea that could change everything.'),
    (2, 'The Martian', 'Sci-Fi', '02:24:00', 'PG-13', '2015-10-02', 'An astronaut is presumed dead and left behind on Mars.'),
    (3, 'Pulp Fiction', 'Crime', '02:34:00', 'R', '1994-10-14', 'Intersecting stories of crime, redemption, and chaos in LA.'),
    (4, 'Fight Club', 'Drama', '02:19:00', 'R', '1999-10-15', 'A disillusioned man starts a secret fight club to break free from consumer culture.'),
    (5, 'The Dark Knight', 'Action', '02:32:00', 'PG-13', '2008-07-18', 'Batman faces the Joker in a battle for Gotham\'s soul.'),
    (6, 'Gladiator', 'Action', '02:35:00', 'R', '2000-05-05', 'A Roman general becomes a gladiator to seek vengeance.'),
    (7, 'Interstellar', 'Sci-Fi', '02:49:00', 'PG-13', '2014-11-07', 'A group of astronauts travel through a wormhole to save mankind.'),
    (8, 'Gone Girl', 'Thriller', '02:29:00', 'R', '2014-10-03', 'A man becomes the center of media attention after his wife disappears.'),
    (9, 'Inglourious Basterds', 'War', '02:33:00', 'R', '2009-08-21', 'A team of Jewish soldiers plot to assassinate Nazi leaders.'),
    (10, 'The Social Network', 'Biography', '02:00:00', 'PG-13', '2010-10-01', 'The dramatic rise of Facebook and the legal battles that followed.'),
    (11, 'Tenet', 'Action', '02:30:00', 'PG-13', '2020-09-03', 'A secret agent manipulates time to prevent global catastrophe.'),
    (12, 'Se7en', 'Crime', '02:07:00', 'R', '1995-09-22', 'Two detectives track a killer who uses the seven deadly sins.'),
    (13, 'Death Proof', 'Thriller', '01:53:00', 'R', '2007-05-22', 'A stuntman stalks and kills women using his "death-proof" car.'),
    (14, 'The Prestige', 'Drama', '02:10:00', 'PG-13', '2006-10-20', 'Two magicians compete in a deadly game of illusion.'),
    (15, 'Alien', 'Horror', '01:57:00', 'R', '1979-05-25', 'A deadly alien stalks a spaceship crew in deep space.');
GO


INSERT INTO [Theaters] ([Theater_id], [T_location], [ScreenSize], [TotalSeats], [SeatingPerRow])
VALUES 
    (1, 'Galaxy Cinema, Tanta', 'Large', 200, 20),
    (2, 'City Stars Cinema, Nasr City', 'Medium', 150, 15),
    (3, 'San Stefano Cinema, Alexandria', 'Small', 100, 10);
GO



INSERT INTO [Screenings] ([Screening_id], [Theater_id], [Movie_id], [start_time], [end_time], [ticket_price], [available_Seats])
VALUES 
    (1, 1, 1, '18:00:00', '20:15:00', 120.00, 180),
    (2, 1, 2, '21:00:00', '22:45:00', 100.00, 190),
    (3, 2, 3, '19:30:00', '21:25:00', 110.00, 140),
    (4, 2, 4, '16:00:00', '18:00:00', 130.00, 130),
    (5, 3, 5, '14:00:00', '15:30:00', 85.00, 95);
GO



INSERT INTO [Customers] ([customer_id], [name], [email], [phone_number], [loyal_points])
VALUES 
    (1, 'Omar El-Masry', 'omar.masry@email.com', '0100-123-4567', 100),
    (2, 'Sara Hossam', 'sara.hossam@email.com', '0101-234-5678', 50),
    (3, 'Khaled Nabil', 'khaled.nabil@email.com', '0102-345-6789', 20),
    (4, 'Mona Adel', 'mona.adel@email.com', '0103-456-7890', 80),
    (5, 'Youssef Gamal', 'youssef.gamal@email.com', '0104-567-8901', 0);
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
    (1, 'Popcorn (Large)', 75.00, 100, 'Snack'),
    (2, 'Soda (Medium)', 40.00, 200, 'Drink'),
    (3, 'Nachos', 60.00, 80, 'Snack'),
    (4, 'Candy Box', 35.00, 150, 'Snack'),
    (5, 'Bottled Water', 25.00, 300, 'Drink');
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

