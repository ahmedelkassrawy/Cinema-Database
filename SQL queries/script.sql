CREATE DATABASE [Cinema]
GO
USE [master]
GO
ALTER DATABASE [Cinema] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [Cinema].[dbo).[sp_fulltext_database] @action = 'enable'
END
GO
ALTER DATABASE [Cinema] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Cinema] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Cinema] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Cinema] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Cinema] SET ARITHABORT OFF 
GO
ALTER DATABASE [Cinema] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Cinema] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Cinema] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Cinema] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Cinema] SET CURSOR_DEFAULT GLOBAL 
GO
ALTER DATABASE [Cinema] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Cinema] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Cinema] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Cinema] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Cinema] SET ENABLE_BROKER 
GO
ALTER DATABASE [Cinema] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Cinema] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Cinema] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Cinema] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Cinema] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Cinema] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Cinema] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Cinema] SET RECOVERY FULL 
GO
ALTER DATABASE [Cinema] SET MULTI_USER 
GO
ALTER DATABASE [Cinema] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Cinema] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Cinema] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Cinema] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Cinema] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Cinema] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Cinema', N'ON'
GO
ALTER DATABASE [Cinema] SET QUERY_STORE = ON
GO
ALTER DATABASE [Cinema] SET QUERY_STORE (
    OPERATION_MODE = READ_WRITE, 
    CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), 
    DATA_FLUSH_INTERVAL_SECONDS = 900, 
    INTERVAL_LENGTH_MINUTES = 60, 
    MAX_STORAGE_SIZE_MB = 1000, 
    QUERY_CAPTURE_MODE = AUTO, 
    SIZE_BASED_CLEANUP_MODE = AUTO, 
    MAX_PLANS_PER_QUERY = 200, 
    WAIT_STATS_CAPTURE_MODE = ON
)
GO
USE [Cinema]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Movies](
    [movie_id] [int] NOT NULL,
    [title] [varchar](40) NOT NULL,
    [genre] [varchar](20) NOT NULL,
    [duration] [time](7) NOT NULL,
    [rating] [varchar](10) NULL,
    [release_date] [date] NOT NULL,
    [Synopsis] [varchar](200) NULL,
    CONSTRAINT [movies_pk] PRIMARY KEY CLUSTERED ([movie_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
              ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT [title_uq] UNIQUE NONCLUSTERED ([title] ASC, [release_date] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
              ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Movies] WITH CHECK ADD CONSTRAINT [duration_ck] CHECK (([duration]>'00:00:00'))
GO
ALTER TABLE [Movies] CHECK CONSTRAINT [duration_ck]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Theaters](
    [Theater_id] [int] NOT NULL,
    [T_location] [varchar](100) NOT NULL,
    [ScreenSize] [varchar](20) NOT NULL,
    [TotalSeats] [int] NOT NULL,
    [SeatingPerRow] [int] NOT NULL,
    CONSTRAINT [theater_pk] PRIMARY KEY CLUSTERED ([Theater_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
              ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
    CONSTRAINT [location_uq] UNIQUE NONCLUSTERED ([T_location] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
              ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Theaters] WITH CHECK ADD CONSTRAINT [seats_ck] CHECK (([TotalSeats]>(0) AND [SeatingPerRow]>(0)))
GO
ALTER TABLE [Theaters] CHECK CONSTRAINT [seats_ck]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Screenings](
    [Screening_id] [int] NOT NULL,
    [Theater_id] [int] NOT NULL,
    [Movie_id] [int] NULL,
    [start_time] [time](7) NOT NULL,
    [end_time] [time](7) NOT NULL,
    [ticket_price] [decimal](10, 2) NOT NULL,
    [available_Seats] [int] NOT NULL,
    CONSTRAINT [Screenings_pk] PRIMARY KEY CLUSTERED ([Screening_id] ASC)
        WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
              ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Screenings] WITH CHECK ADD CONSTRAINT [movie_fk] 
    FOREIGN KEY ([Movie_id]) REFERENCES [Movies] ([movie_id]) ON DELETE SET NULL
GO
ALTER TABLE [Screenings] CHECK CONSTRAINT [movie_fk]
GO
ALTER TABLE [Screenings] WITH CHECK ADD CONSTRAINT [theatre_fk] 
    FOREIGN KEY ([Theater_id]) REFERENCES [Theaters] ([Theater_id]) ON DELETE CASCADE
GO
ALTER TABLE [Screenings] CHECK CONSTRAINT [theatre_fk]
GO
ALTER TABLE [Screenings] WITH CHECK ADD CONSTRAINT [seats_chk] CHECK (([available_Seats]>=(0)))
GO
ALTER TABLE [Screenings] CHECK CONSTRAINT [seats_chk]
GO
ALTER TABLE [Screenings] WITH CHECK ADD CONSTRAINT [ticket_ck] CHECK (([ticket_price]>=(5)))
GO
ALTER TABLE [Screenings] CHECK CONSTRAINT [ticket_ck]
GO
CREATE TABLE [Customers](
    [customer_id] [int] PRIMARY KEY,
    [name] [varchar](50) NOT NULL,
    [email] [varchar](100),
    [phone_number] [varchar](15),
    [loyal_points] [int],
    CONSTRAINT [email_uq] UNIQUE ([email])
)
GO
CREATE TABLE [Bookings](
    [booking_id] [int] PRIMARY KEY,
    [seat_numbers] [int],
    [payment_status] [bit],
    [booking_timestamp] [datetime2],
    [customer_id] [int] NOT NULL,
    [screening_id] [int] NOT NULL,
    CONSTRAINT [customer_fk_bookings] 
        FOREIGN KEY ([customer_id]) REFERENCES [Customers] ([customer_id]) ON DELETE CASCADE,
    CONSTRAINT [screening_fk_bookings] 
        FOREIGN KEY ([screening_id]) REFERENCES [Screenings] ([Screening_id]),
    CONSTRAINT [seat_screening_uq] UNIQUE ([seat_numbers], [screening_id])
)
GO
CREATE TABLE [Concessions](
    [product_id] [int] PRIMARY KEY,
    [product_name] [varchar](50),
    [price] [decimal](10, 2),
    [stock_quantity] [int],
    [category] [varchar](20),
    CONSTRAINT [price_ck] CHECK ([price] >= 0),
    CONSTRAINT [stock_ck] CHECK ([stock_quantity] >= 0)
)
GO
CREATE TABLE [Reviews](
    [review_id] [int] PRIMARY KEY,
    [customer_id] [int] NOT NULL,
    [movie_id] [int] NULL,
    [rating] [int] CHECK ([rating] >= 1 AND [rating] <= 5),
    [review_text] [varchar](150),
    [review_timestamp] [datetime2] DEFAULT GETDATE(),
    CONSTRAINT [customer_fk_reviews] 
        FOREIGN KEY ([customer_id]) REFERENCES [Customers] ([customer_id]) ON DELETE CASCADE,
    CONSTRAINT [movie_fk_reviews] 
        FOREIGN KEY ([movie_id]) REFERENCES [Movies] ([movie_id]) ON DELETE SET NULL
)
GO
CREATE TABLE [Booking-Concessions](
    [BookingID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [Quantity] [int] NOT NULL CHECK ([Quantity] > 0),
    CONSTRAINT [booking_fk_concessions] 
        FOREIGN KEY ([BookingID]) REFERENCES [Bookings] ([booking_id]) ON DELETE CASCADE,
    CONSTRAINT [product_fk_concessions] 
        FOREIGN KEY ([ProductID]) REFERENCES [Concessions] ([product_id]),
    PRIMARY KEY ([BookingID], [ProductID])
)
GO
USE [master]
GO
ALTER DATABASE [Cinema] SET READ_WRITE 
GO
