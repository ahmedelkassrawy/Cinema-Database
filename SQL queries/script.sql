USE [master]
GO
/****** Object:  Database [Cinema]    Script Date: 5/21/2025 6:45:26 PM ******/
CREATE DATABASE [Cinema]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Cinema_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Cinema.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Cinema_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Cinema.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Cinema] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cinema].[dbo].[sp_fulltext_database] @action = 'enable'
end
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
ALTER DATABASE [Cinema] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Cinema] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Cinema] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Cinema] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Cinema] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Cinema] SET  ENABLE_BROKER 
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
ALTER DATABASE [Cinema] SET  MULTI_USER 
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
ALTER DATABASE [Cinema] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Cinema]
GO
/****** Object:  Table [dbo].[BookingConcessions]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingConcessions](
	[BookingID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[booking_id] [int] NOT NULL,
	[seat_number] [int] NOT NULL,
	[payment_status] [bit] NOT NULL,
	[booking_timestamp] [datetime2](7) NULL,
	[customer_id] [int] NOT NULL,
	[screening_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[booking_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConcessionRevenues]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConcessionRevenues](
	[product_id] [int] NOT NULL,
	[total_revenue] [decimal](12, 2) NULL,
	[last_updated] [datetime2](7) NULL,
 CONSTRAINT [PK_ConcessionRevenues] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Concessions]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Concessions](
	[product_id] [int] NOT NULL,
	[product_name] [varchar](50) NULL,
	[price] [decimal](10, 2) NULL,
	[stock_quantity] [int] NULL,
	[category] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[phone_number] [varchar](15) NULL,
	[loyal_points] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MovieRevenues]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovieRevenues](
	[movie_id] [int] NOT NULL,
	[total_revenue] [decimal](12, 2) NULL,
	[last_updated] [datetime2](7) NULL,
 CONSTRAINT [PK_MovieRevenues] PRIMARY KEY CLUSTERED 
(
	[movie_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[movie_id] [int] NOT NULL,
	[title] [varchar](40) NOT NULL,
	[genre] [varchar](20) NOT NULL,
	[duration] [time](7) NOT NULL,
	[rating] [varchar](10) NULL,
	[release_date] [date] NOT NULL,
	[Synopsis] [varchar](200) NULL,
 CONSTRAINT [movies_pk] PRIMARY KEY CLUSTERED 
(
	[movie_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[review_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[movie_id] [int] NULL,
	[rating] [int] NULL,
	[review_text] [varchar](150) NULL,
	[review_timestamp] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Screenings]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Screenings](
	[Screening_id] [int] NOT NULL,
	[Theater_id] [int] NOT NULL,
	[Movie_id] [int] NULL,
	[start_time] [time](7) NOT NULL,
	[end_time] [time](7) NOT NULL,
	[ticket_price] [decimal](10, 2) NOT NULL,
	[available_Seats] [int] NOT NULL,
 CONSTRAINT [Screenings_pk] PRIMARY KEY CLUSTERED 
(
	[Screening_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TheaterRevenues]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TheaterRevenues](
	[theater_id] [int] NOT NULL,
	[total_revenue] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[theater_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Theaters]    Script Date: 5/21/2025 6:45:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Theaters](
	[Theater_id] [int] NOT NULL,
	[T_location] [varchar](100) NOT NULL,
	[ScreenSize] [varchar](20) NOT NULL,
	[TotalSeats] [int] NOT NULL,
	[SeatingPerRow] [int] NOT NULL,
 CONSTRAINT [theater_pk] PRIMARY KEY CLUSTERED 
(
	[Theater_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[BookingConcessions] ([BookingID], [ProductID], [Quantity]) VALUES (1, 1, 3)
GO
INSERT [dbo].[BookingConcessions] ([BookingID], [ProductID], [Quantity]) VALUES (1, 3, 2)
GO
INSERT [dbo].[BookingConcessions] ([BookingID], [ProductID], [Quantity]) VALUES (2, 2, 1)
GO
INSERT [dbo].[BookingConcessions] ([BookingID], [ProductID], [Quantity]) VALUES (2, 4, 2)
GO
INSERT [dbo].[BookingConcessions] ([BookingID], [ProductID], [Quantity]) VALUES (4, 5, 1)
GO
INSERT [dbo].[BookingConcessions] ([BookingID], [ProductID], [Quantity]) VALUES (5, 1, 1)
GO
INSERT [dbo].[BookingConcessions] ([BookingID], [ProductID], [Quantity]) VALUES (6, 3, 2)
GO
INSERT [dbo].[BookingConcessions] ([BookingID], [ProductID], [Quantity]) VALUES (7, 7, 1)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (1, 105, 1, CAST(N'2025-04-04T15:30:00.0000000' AS DateTime2), 1, 1)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (2, 45, 1, CAST(N'2025-04-04T16:15:00.0000000' AS DateTime2), 2, 2)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (3, 99, 1, CAST(N'2025-04-04T17:00:00.0000000' AS DateTime2), 3, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4, 78, 1, CAST(N'2025-04-04T18:00:00.0000000' AS DateTime2), 4, 4)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (5, 50, 1, CAST(N'2025-04-04T19:00:00.0000000' AS DateTime2), 5, 5)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (6, 101, 1, CAST(N'2025-04-04T20:00:00.0000000' AS DateTime2), 6, 6)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (7, 89, 1, CAST(N'2025-04-04T21:00:00.0000000' AS DateTime2), 7, 7)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (8, 89, 1, CAST(N'2025-05-05T21:00:00.0000000' AS DateTime2), 8, 1)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4342, 1, 1, NULL, 12, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4343, 2, 1, NULL, 13, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4344, 3, 1, NULL, 14, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4345, 19, 1, NULL, 15, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4346, 5, 1, NULL, 16, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4347, 6, 1, NULL, 17, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4348, 7, 1, NULL, 18, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4349, 8, 1, NULL, 19, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4350, 9, 1, NULL, 20, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4351, 10, 1, NULL, 21, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4352, 11, 1, NULL, 22, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4353, 12, 1, NULL, 23, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4354, 13, 1, NULL, 24, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4355, 14, 1, NULL, 25, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4356, 15, 1, NULL, 26, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4357, 16, 1, NULL, 27, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4358, 17, 1, NULL, 28, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4359, 18, 1, NULL, 29, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4360, 25, 1, NULL, 30, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4361, 20, 1, NULL, 31, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4362, 21, 1, NULL, 32, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4363, 22, 1, NULL, 33, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4364, 23, 1, NULL, 34, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4365, 24, 1, NULL, 35, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4366, 111, 1, NULL, 36, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4367, 110, 1, NULL, 37, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4368, 112, 1, NULL, 38, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4369, 113, 1, NULL, 39, 3)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4370, 114, 1, NULL, 40, 1)
GO
INSERT [dbo].[Bookings] ([booking_id], [seat_number], [payment_status], [booking_timestamp], [customer_id], [screening_id]) VALUES (4371, 115, 1, NULL, 41, 1)
GO
INSERT [dbo].[ConcessionRevenues] ([product_id], [total_revenue], [last_updated]) VALUES (1, CAST(225.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:12:38.9866667' AS DateTime2))
GO
INSERT [dbo].[ConcessionRevenues] ([product_id], [total_revenue], [last_updated]) VALUES (2, CAST(60.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:12:38.9866667' AS DateTime2))
GO
INSERT [dbo].[ConcessionRevenues] ([product_id], [total_revenue], [last_updated]) VALUES (3, CAST(120.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:12:38.9866667' AS DateTime2))
GO
INSERT [dbo].[ConcessionRevenues] ([product_id], [total_revenue], [last_updated]) VALUES (4, CAST(60.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:12:38.9866667' AS DateTime2))
GO
INSERT [dbo].[ConcessionRevenues] ([product_id], [total_revenue], [last_updated]) VALUES (5, CAST(40.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:12:38.9866667' AS DateTime2))
GO
INSERT [dbo].[ConcessionRevenues] ([product_id], [total_revenue], [last_updated]) VALUES (7, CAST(45.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:12:38.9866667' AS DateTime2))
GO
INSERT [dbo].[Concessions] ([product_id], [product_name], [price], [stock_quantity], [category]) VALUES (1, N'Popcorn Large', CAST(75.00 AS Decimal(10, 2)), 200, N'Snacks')
GO
INSERT [dbo].[Concessions] ([product_id], [product_name], [price], [stock_quantity], [category]) VALUES (2, N'Nachos with Cheese', CAST(60.00 AS Decimal(10, 2)), 150, N'Snacks')
GO
INSERT [dbo].[Concessions] ([product_id], [product_name], [price], [stock_quantity], [category]) VALUES (3, N'Coca-Cola 500ml', CAST(30.00 AS Decimal(10, 2)), 300, N'Beverages')
GO
INSERT [dbo].[Concessions] ([product_id], [product_name], [price], [stock_quantity], [category]) VALUES (4, N'Pepsi 500ml', CAST(30.00 AS Decimal(10, 2)), 250, N'Beverages')
GO
INSERT [dbo].[Concessions] ([product_id], [product_name], [price], [stock_quantity], [category]) VALUES (5, N'Chocolate Box', CAST(40.00 AS Decimal(10, 2)), 100, N'Snacks')
GO
INSERT [dbo].[Concessions] ([product_id], [product_name], [price], [stock_quantity], [category]) VALUES (6, N'Water Bottle', CAST(15.00 AS Decimal(10, 2)), 400, N'Beverages')
GO
INSERT [dbo].[Concessions] ([product_id], [product_name], [price], [stock_quantity], [category]) VALUES (7, N'Hot Dog', CAST(45.00 AS Decimal(10, 2)), 120, N'Snacks')
GO
INSERT [dbo].[MovieRevenues] ([movie_id], [total_revenue], [last_updated]) VALUES (1, CAST(445.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:04:43.8166667' AS DateTime2))
GO
INSERT [dbo].[MovieRevenues] ([movie_id], [total_revenue], [last_updated]) VALUES (2, CAST(95.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:04:43.8166667' AS DateTime2))
GO
INSERT [dbo].[MovieRevenues] ([movie_id], [total_revenue], [last_updated]) VALUES (3, CAST(2545.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:04:43.8166667' AS DateTime2))
GO
INSERT [dbo].[MovieRevenues] ([movie_id], [total_revenue], [last_updated]) VALUES (4, CAST(100.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:04:43.8166667' AS DateTime2))
GO
INSERT [dbo].[MovieRevenues] ([movie_id], [total_revenue], [last_updated]) VALUES (5, CAST(90.00 AS Decimal(12, 2)), CAST(N'2025-05-20T23:04:43.8166667' AS DateTime2))
GO
INSERT [dbo].[Movies] ([movie_id], [title], [genre], [duration], [rating], [release_date], [Synopsis]) VALUES (1, N'Inception', N'Action/Sci-Fi', CAST(N'02:28:00' AS Time), N'8.8', CAST(N'2010-07-16' AS Date), N'A thief who enters the dreams of others to steal secrets is given the inverse task of planting an idea into a C.E.O.''s mind.')
GO
INSERT [dbo].[Movies] ([movie_id], [title], [genre], [duration], [rating], [release_date], [Synopsis]) VALUES (2, N'The Dark Knight', N'Action/Crime', CAST(N'02:32:00' AS Time), N'9.0', CAST(N'2008-07-18' AS Date), N'When the menace known as the Joker wreaks havoc on the people of Gotham, Batman must accept one of the greatest psychological tests.')
GO
INSERT [dbo].[Movies] ([movie_id], [title], [genre], [duration], [rating], [release_date], [Synopsis]) VALUES (3, N'Interstellar', N'Sci-Fi/Adventure', CAST(N'02:49:00' AS Time), N'8.6', CAST(N'2014-11-05' AS Date), N'A team of explorers travel through a wormhole in space in an attempt to ensure humanity''s survival.')
GO
INSERT [dbo].[Movies] ([movie_id], [title], [genre], [duration], [rating], [release_date], [Synopsis]) VALUES (4, N'Avengers: Endgame', N'Action/Sci-Fi', CAST(N'03:01:00' AS Time), N'8.4', CAST(N'2019-04-26' AS Date), N'After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more.')
GO
INSERT [dbo].[Movies] ([movie_id], [title], [genre], [duration], [rating], [release_date], [Synopsis]) VALUES (5, N'Joker', N'Crime/Drama', CAST(N'02:02:00' AS Time), N'9.0', CAST(N'2019-10-04' AS Date), N'A mentally troubled stand-up comedian embarks on a downward spiral of revolution and chaos in the form of a person known as the Joker.')
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (1, 1, 1, 5, N'Inception was mind-blowing! The visuals and plot twists were amazing.', CAST(N'2025-05-19T23:15:23.9000000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (2, 2, 2, 5, N'The Dark Knight is still the best superhero movie ever made.', CAST(N'2025-05-19T23:15:23.9000000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (3, 3, 3, 4, N'Interstellar was a bit slow but the space visuals were stunning.', CAST(N'2025-05-19T23:15:23.9000000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (4, 4, 4, 4, N'Avengers: Endgame was epic, but too long. Still worth watching.', CAST(N'2025-05-19T23:15:23.9000000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (5, 5, 5, 5, N'Joker was intense. Joaquin Phoenix gave a performance of a lifetime.', CAST(N'2025-05-19T23:15:23.9000000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (101, 12, 1, 5, N'Amazing! Definitely recommend.', CAST(N'2025-05-20T23:59:43.5066667' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (102, 13, 1, 4, N'Very good, but a bit long.', CAST(N'2025-05-20T23:59:43.5066667' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (103, 14, 1, 3, N'Average, nothing special.', CAST(N'2025-05-20T23:59:43.5066667' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (104, 15, 1, 2, N'Could have been better.', CAST(N'2025-05-20T23:59:43.5066667' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (105, 16, 1, 5, N'Mind-blowing visuals and plot!', CAST(N'2025-05-20T23:59:43.5066667' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (106, 17, 2, 5, N'Best superhero movie ever!', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (107, 18, 2, 5, N'Great action, weak ending.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (108, 19, 2, 4, N'Entertaining but predictable.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (109, 20, 2, 5, N'Joaquin Phoenix was incredible.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (110, 21, 2, 4, N'Loved the soundtrack and pacing.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (111, 22, 3, 4, N'Innovative ideas, slow start.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (112, 23, 3, 5, N'A visual masterpiece!', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (113, 24, 3, 3, N'Too technical for casual viewers.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (114, 25, 3, 4, N'Enjoyed the space scenes.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (115, 26, 3, 5, N'Changed how I see space movies.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (116, 27, 4, 4, N'Epic finale, but too many characters.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (117, 28, 4, 5, N'Superb closure for the Marvel saga!', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (118, 29, 4, 3, N'Good, but not worth 3 hours.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (119, 30, 4, 4, N'Action-packed and emotional.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (120, 31, 4, 5, N'Perfect end to an era.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (121, 32, 5, 5, N'Dark and intense masterpiece!', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (122, 33, 5, 4, N'Great acting, disturbing themes.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (123, 34, 5, 3, N'Too slow in parts.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (124, 35, 5, 5, N'One of the best films of the decade.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Reviews] ([review_id], [customer_id], [movie_id], [rating], [review_text], [review_timestamp]) VALUES (125, 36, 5, 4, N'Haunting performance by the lead.', CAST(N'2025-05-20T23:59:43.5100000' AS DateTime2))
GO
INSERT [dbo].[Screenings] ([Screening_id], [Theater_id], [Movie_id], [start_time], [end_time], [ticket_price], [available_Seats]) VALUES (1, 1, 1, CAST(N'10:00:00' AS Time), CAST(N'12:30:00' AS Time), CAST(90.00 AS Decimal(10, 2)), 138)
GO
INSERT [dbo].[Screenings] ([Screening_id], [Theater_id], [Movie_id], [start_time], [end_time], [ticket_price], [available_Seats]) VALUES (2, 1, 2, CAST(N'14:00:00' AS Time), CAST(N'16:40:00' AS Time), CAST(95.00 AS Decimal(10, 2)), 130)
GO
INSERT [dbo].[Screenings] ([Screening_id], [Theater_id], [Movie_id], [start_time], [end_time], [ticket_price], [available_Seats]) VALUES (3, 2, 3, CAST(N'11:00:00' AS Time), CAST(N'13:50:00' AS Time), CAST(85.00 AS Decimal(10, 2)), 0)
GO
INSERT [dbo].[Screenings] ([Screening_id], [Theater_id], [Movie_id], [start_time], [end_time], [ticket_price], [available_Seats]) VALUES (4, 2, 4, CAST(N'16:00:00' AS Time), CAST(N'19:01:00' AS Time), CAST(100.00 AS Decimal(10, 2)), 100)
GO
INSERT [dbo].[Screenings] ([Screening_id], [Theater_id], [Movie_id], [start_time], [end_time], [ticket_price], [available_Seats]) VALUES (5, 3, 5, CAST(N'13:00:00' AS Time), CAST(N'15:02:00' AS Time), CAST(90.00 AS Decimal(10, 2)), 90)
GO
INSERT [dbo].[Screenings] ([Screening_id], [Theater_id], [Movie_id], [start_time], [end_time], [ticket_price], [available_Seats]) VALUES (6, 4, 1, CAST(N'09:30:00' AS Time), CAST(N'12:00:00' AS Time), CAST(85.00 AS Decimal(10, 2)), 180)
GO
INSERT [dbo].[Screenings] ([Screening_id], [Theater_id], [Movie_id], [start_time], [end_time], [ticket_price], [available_Seats]) VALUES (7, 5, 3, CAST(N'10:30:00' AS Time), CAST(N'13:19:00' AS Time), CAST(80.00 AS Decimal(10, 2)), 95)
GO
INSERT [dbo].[Screenings] ([Screening_id], [Theater_id], [Movie_id], [start_time], [end_time], [ticket_price], [available_Seats]) VALUES (53, 3, 3, CAST(N'12:30:00' AS Time), CAST(N'01:00:00' AS Time), CAST(61.00 AS Decimal(10, 2)), 55)
GO
INSERT [dbo].[TheaterRevenues] ([theater_id], [total_revenue]) VALUES (1, CAST(90.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Theaters] ([Theater_id], [T_location], [ScreenSize], [TotalSeats], [SeatingPerRow]) VALUES (1, N'Cairo Festival, Cairo', N'IMAX', 200, 20)
GO
INSERT [dbo].[Theaters] ([Theater_id], [T_location], [ScreenSize], [TotalSeats], [SeatingPerRow]) VALUES (2, N'Mall Of Egyot, Cairo', N'4K Digital', 200, 10)
GO
INSERT [dbo].[Theaters] ([Theater_id], [T_location], [ScreenSize], [TotalSeats], [SeatingPerRow]) VALUES (3, N'Heliopolis, Cairo', N'Standard', 200, 10)
GO
INSERT [dbo].[Theaters] ([Theater_id], [T_location], [ScreenSize], [TotalSeats], [SeatingPerRow]) VALUES (4, N'City Center, Alexandria', N'Dolby Atmos', 200, 20)
GO
INSERT [dbo].[Theaters] ([Theater_id], [T_location], [ScreenSize], [TotalSeats], [SeatingPerRow]) VALUES (5, N'Mall Of Tanta', N'Standard', 100, 10)
GO
/****** Object:  Index [seat_screen_uq]    Script Date: 5/21/2025 6:45:26 PM ******/
ALTER TABLE [dbo].[Bookings] ADD  CONSTRAINT [seat_screen_uq] UNIQUE NONCLUSTERED 
(
	[seat_number] ASC,
	[screening_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [email_uq]    Script Date: 5/21/2025 6:45:26 PM ******/
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [email_uq] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [phone_uq]    Script Date: 5/21/2025 6:45:26 PM ******/
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [phone_uq] UNIQUE NONCLUSTERED 
(
	[phone_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [title_date_uq]    Script Date: 5/21/2025 6:45:26 PM ******/
ALTER TABLE [dbo].[Movies] ADD  CONSTRAINT [title_date_uq] UNIQUE NONCLUSTERED 
(
	[title] ASC,
	[release_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [location_uq]    Script Date: 5/21/2025 6:45:26 PM ******/
ALTER TABLE [dbo].[Theaters] ADD  CONSTRAINT [location_uq] UNIQUE NONCLUSTERED 
(
	[T_location] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ConcessionRevenues] ADD  DEFAULT ((0.00)) FOR [total_revenue]
GO
ALTER TABLE [dbo].[ConcessionRevenues] ADD  DEFAULT (getdate()) FOR [last_updated]
GO
ALTER TABLE [dbo].[MovieRevenues] ADD  DEFAULT ((0.00)) FOR [total_revenue]
GO
ALTER TABLE [dbo].[MovieRevenues] ADD  DEFAULT (getdate()) FOR [last_updated]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT (getdate()) FOR [review_timestamp]
GO
ALTER TABLE [dbo].[TheaterRevenues] ADD  DEFAULT ((0)) FOR [total_revenue]
GO
ALTER TABLE [dbo].[BookingConcessions]  WITH CHECK ADD  CONSTRAINT [booking_fk_concessions] FOREIGN KEY([BookingID])
REFERENCES [dbo].[Bookings] ([booking_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BookingConcessions] CHECK CONSTRAINT [booking_fk_concessions]
GO
ALTER TABLE [dbo].[BookingConcessions]  WITH CHECK ADD  CONSTRAINT [product_fk_concessions] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Concessions] ([product_id])
GO
ALTER TABLE [dbo].[BookingConcessions] CHECK CONSTRAINT [product_fk_concessions]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [screening_fk_bookings] FOREIGN KEY([screening_id])
REFERENCES [dbo].[Screenings] ([Screening_id])
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [screening_fk_bookings]
GO
ALTER TABLE [dbo].[ConcessionRevenues]  WITH CHECK ADD  CONSTRAINT [FK_ConcessionRevenues_Concessions] FOREIGN KEY([product_id])
REFERENCES [dbo].[Concessions] ([product_id])
GO
ALTER TABLE [dbo].[ConcessionRevenues] CHECK CONSTRAINT [FK_ConcessionRevenues_Concessions]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [movie_fk_reviews] FOREIGN KEY([movie_id])
REFERENCES [dbo].[Movies] ([movie_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [movie_fk_reviews]
GO
ALTER TABLE [dbo].[Screenings]  WITH CHECK ADD  CONSTRAINT [movie_fk] FOREIGN KEY([Movie_id])
REFERENCES [dbo].[Movies] ([movie_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Screenings] CHECK CONSTRAINT [movie_fk]
GO
ALTER TABLE [dbo].[Screenings]  WITH CHECK ADD  CONSTRAINT [theatre_fk] FOREIGN KEY([Theater_id])
REFERENCES [dbo].[Theaters] ([Theater_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Screenings] CHECK CONSTRAINT [theatre_fk]
GO
ALTER TABLE [dbo].[BookingConcessions]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [seat_nums_ck] CHECK  (([seat_number]>=(1) AND [seat_number]<=(200)))
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [seat_nums_ck]
GO
ALTER TABLE [dbo].[Concessions]  WITH CHECK ADD  CONSTRAINT [price_ck] CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[Concessions] CHECK CONSTRAINT [price_ck]
GO
ALTER TABLE [dbo].[Concessions]  WITH CHECK ADD  CONSTRAINT [stock_ck] CHECK  (([stock_quantity]>=(0)))
GO
ALTER TABLE [dbo].[Concessions] CHECK CONSTRAINT [stock_ck]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [chk_phone_egyptian_format] CHECK  (([phone_number] like '01%' AND NOT [phone_number] like '%[^0-9]%'))
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [chk_phone_egyptian_format]
GO
ALTER TABLE [dbo].[Movies]  WITH CHECK ADD  CONSTRAINT [duration_ck] CHECK  (([duration]>'00:00:00'))
GO
ALTER TABLE [dbo].[Movies] CHECK CONSTRAINT [duration_ck]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[Screenings]  WITH CHECK ADD  CONSTRAINT [seats_chk] CHECK  (([available_Seats]>=(0)))
GO
ALTER TABLE [dbo].[Screenings] CHECK CONSTRAINT [seats_chk]
GO
ALTER TABLE [dbo].[Screenings]  WITH CHECK ADD  CONSTRAINT [ticket_ck] CHECK  (([ticket_price]>=(60)))
GO
ALTER TABLE [dbo].[Screenings] CHECK CONSTRAINT [ticket_ck]
GO
ALTER TABLE [dbo].[Theaters]  WITH CHECK ADD  CONSTRAINT [seats_ck] CHECK  (([TotalSeats]>(0) AND [SeatingPerRow]>(0)))
GO
ALTER TABLE [dbo].[Theaters] CHECK CONSTRAINT [seats_ck]
GO
USE [master]
GO
ALTER DATABASE [Cinema] SET  READ_WRITE 
GO
