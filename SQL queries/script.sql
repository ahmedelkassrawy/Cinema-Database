USE [master]
GO
/****** Object:  Database [Cinema]    Script Date: 5/21/2025 1:59:31 AM ******/
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
/****** Object:  Table [dbo].[BookingConcessions]    Script Date: 5/21/2025 1:59:31 AM ******/
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
/****** Object:  Table [dbo].[Bookings]    Script Date: 5/21/2025 1:59:31 AM ******/
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
/****** Object:  Table [dbo].[ConcessionRevenues]    Script Date: 5/21/2025 1:59:31 AM ******/
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
/****** Object:  Table [dbo].[Concessions]    Script Date: 5/21/2025 1:59:31 AM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 5/21/2025 1:59:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[customer_id] [int] NOT NULL,
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
/****** Object:  Table [dbo].[MovieRevenues]    Script Date: 5/21/2025 1:59:31 AM ******/
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
/****** Object:  Table [dbo].[Movies]    Script Date: 5/21/2025 1:59:31 AM ******/
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
/****** Object:  Table [dbo].[Reviews]    Script Date: 5/21/2025 1:59:31 AM ******/
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
/****** Object:  Table [dbo].[Screenings]    Script Date: 5/21/2025 1:59:31 AM ******/
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
/****** Object:  Table [dbo].[TheaterRevenues]    Script Date: 5/21/2025 1:59:31 AM ******/
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
/****** Object:  Table [dbo].[Theaters]    Script Date: 5/21/2025 1:59:31 AM ******/
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
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (1, N'Ahmed Mohamed', N'ahmed.mohamed@gmail.com', N'01012345678', 150)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (2, N'Yara Hassan', N'yara.hassan@yahoo.com', N'01187654321', 100)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (3, N'Karim Adel', N'karim.adel@hotmail.com', N'01234567890', 200)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (4, N'Nada Ahmed', N'nada.ahmed@gmail.com', N'01098765432', 120)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (5, N'Omar Tarek', N'omar.tarek@gmail.com', N'01112345678', 80)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (6, N'Reem Salah', N'reem.salah@yahoo.com', N'01287654321', 130)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (7, N'Mahmoud Kamal', N'mahmoud.kamal@hotmail.com', N'01011223344', 90)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (8, N'Laila Hany', N'laila.hany@gmail.com', N'01199887766', 110)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (9, N'Hossam Reda', N'hossam.reda@yahoo.com', N'01277665544', 140)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (10, N'Mai Elsayed', N'mai.elsayed@gmail.com', N'01088776655', 160)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (11, N'oee', N'ffff@gmail.com', N'01088776755', 800)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (12, N'Sara Zayed', N'sara.zayed12@example.com', N'01000000084', 270)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (13, N'Khaled Shalaby', N'khaled.shalaby13@example.com', N'01100000091', 211)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (14, N'Nour Nabil', N'nour.nabil14@example.com', N'01200000098', 62)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (15, N'Islam Fouad', N'islam.fouad15@example.com', N'01000000105', 294)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (16, N'Amr Amin', N'amr.amin16@example.com', N'01100000112', 176)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (17, N'Dina Nasr', N'dina.nasr17@example.com', N'01200000119', 293)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (18, N'Salma Magdy', N'salma.magdy18@example.com', N'01000000126', 2)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (19, N'Hany Wagih', N'hany.wagih19@example.com', N'01100000133', 93)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (20, N'Doaa Samir', N'doaa.samir20@example.com', N'01200000140', 71)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (21, N'Ahmed Mohamed', N'ahmed.mohamed21@example.com', N'01000000147', 203)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (22, N'Yara Hassan', N'yara.hassan22@example.com', N'01100000154', 205)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (23, N'Karim Adel', N'karim.adel23@example.com', N'01200000161', 165)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (24, N'Nada Ahmed', N'nada.ahmed24@example.com', N'01000000168', 28)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (25, N'Omar Tarek', N'omar.tarek25@example.com', N'01100000175', 187)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (26, N'Reem Salah', N'reem.salah26@example.com', N'01200000182', 97)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (27, N'Mahmoud Kamal', N'mahmoud.kamal27@example.com', N'01000000189', 212)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (28, N'Laila Hany', N'laila.hany28@example.com', N'01100000196', 76)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (29, N'Hossam Reda', N'hossam.reda29@example.com', N'01200000203', 190)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (30, N'Mai Elsayed', N'mai.elsayed30@example.com', N'01000000210', 51)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (31, N'Tarek Fathy', N'tarek.fathy31@example.com', N'01100000217', 105)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (32, N'Sara Zayed', N'sara.zayed32@example.com', N'01200000224', 99)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (33, N'Khaled Shalaby', N'khaled.shalaby33@example.com', N'01000000231', 67)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (34, N'Nour Nabil', N'nour.nabil34@example.com', N'01100000238', 107)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (35, N'Islam Fouad', N'islam.fouad35@example.com', N'01200000245', 268)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (36, N'Amr Amin', N'amr.amin36@example.com', N'01000000252', 171)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (37, N'Dina Nasr', N'dina.nasr37@example.com', N'01100000259', 66)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (38, N'Salma Magdy', N'salma.magdy38@example.com', N'01200000266', 291)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (39, N'Hany Wagih', N'hany.wagih39@example.com', N'01000000273', 47)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (40, N'Doaa Samir', N'doaa.samir40@example.com', N'01100000280', 236)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (41, N'Ahmed Mohamed', N'ahmed.mohamed41@example.com', N'01200000287', 266)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (42, N'Yara Hassan', N'yara.hassan42@example.com', N'01000000294', 36)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (43, N'Karim Adel', N'karim.adel43@example.com', N'01100000301', 102)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (44, N'Nada Ahmed', N'nada.ahmed44@example.com', N'01200000308', 125)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (45, N'Omar Tarek', N'omar.tarek45@example.com', N'01000000315', 217)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (46, N'Reem Salah', N'reem.salah46@example.com', N'01100000322', 62)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (47, N'Mahmoud Kamal', N'mahmoud.kamal47@example.com', N'01200000329', 157)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (48, N'Laila Hany', N'laila.hany48@example.com', N'01000000336', 257)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (49, N'Hossam Reda', N'hossam.reda49@example.com', N'01100000343', 205)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (50, N'Mai Elsayed', N'mai.elsayed50@example.com', N'01200000350', 209)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (51, N'Tarek Fathy', N'tarek.fathy51@example.com', N'01000000357', 11)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (52, N'Sara Zayed', N'sara.zayed52@example.com', N'01100000364', 124)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (53, N'Khaled Shalaby', N'khaled.shalaby53@example.com', N'01200000371', 240)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (54, N'Nour Nabil', N'nour.nabil54@example.com', N'01000000378', 51)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (55, N'Islam Fouad', N'islam.fouad55@example.com', N'01100000385', 1)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (56, N'Amr Amin', N'amr.amin56@example.com', N'01200000392', 24)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (57, N'Dina Nasr', N'dina.nasr57@example.com', N'01000000399', 197)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (58, N'Salma Magdy', N'salma.magdy58@example.com', N'01100000406', 91)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (59, N'Hany Wagih', N'hany.wagih59@example.com', N'01200000413', 142)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (60, N'Doaa Samir', N'doaa.samir60@example.com', N'01000000420', 42)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (61, N'Ahmed Mohamed', N'ahmed.mohamed61@example.com', N'01100000427', 7)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (62, N'Yara Hassan', N'yara.hassan62@example.com', N'01200000434', 138)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (63, N'Karim Adel', N'karim.adel63@example.com', N'01000000441', 148)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (64, N'Nada Ahmed', N'nada.ahmed64@example.com', N'01100000448', 78)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (65, N'Omar Tarek', N'omar.tarek65@example.com', N'01200000455', 225)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (66, N'Reem Salah', N'reem.salah66@example.com', N'01000000462', 293)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (67, N'Mahmoud Kamal', N'mahmoud.kamal67@example.com', N'01100000469', 48)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (68, N'Laila Hany', N'laila.hany68@example.com', N'01200000476', 54)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (69, N'Hossam Reda', N'hossam.reda69@example.com', N'01000000483', 51)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (70, N'Mai Elsayed', N'mai.elsayed70@example.com', N'01100000490', 273)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (71, N'Tarek Fathy', N'tarek.fathy71@example.com', N'01200000497', 88)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (72, N'Sara Zayed', N'sara.zayed72@example.com', N'01000000504', 104)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (73, N'Khaled Shalaby', N'khaled.shalaby73@example.com', N'01100000511', 244)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (74, N'Nour Nabil', N'nour.nabil74@example.com', N'01200000518', 125)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (75, N'Islam Fouad', N'islam.fouad75@example.com', N'01000000525', 221)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (76, N'Amr Amin', N'amr.amin76@example.com', N'01100000532', 219)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (77, N'Dina Nasr', N'dina.nasr77@example.com', N'01200000539', 94)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (78, N'Salma Magdy', N'salma.magdy78@example.com', N'01000000546', 235)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (79, N'Hany Wagih', N'hany.wagih79@example.com', N'01100000553', 18)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (80, N'Doaa Samir', N'doaa.samir80@example.com', N'01200000560', 168)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (81, N'Ahmed Mohamed', N'ahmed.mohamed81@example.com', N'01000000567', 74)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (82, N'Yara Hassan', N'yara.hassan82@example.com', N'01100000574', 111)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (83, N'Karim Adel', N'karim.adel83@example.com', N'01200000581', 90)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (84, N'Nada Ahmed', N'nada.ahmed84@example.com', N'01000000588', 201)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (85, N'Omar Tarek', N'omar.tarek85@example.com', N'01100000595', 143)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (86, N'Reem Salah', N'reem.salah86@example.com', N'01200000602', 241)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (87, N'Mahmoud Kamal', N'mahmoud.kamal87@example.com', N'01000000609', 185)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (88, N'Laila Hany', N'laila.hany88@example.com', N'01100000616', 10)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (89, N'Hossam Reda', N'hossam.reda89@example.com', N'01200000623', 175)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (90, N'Mai Elsayed', N'mai.elsayed90@example.com', N'01000000630', 199)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (91, N'Tarek Fathy', N'tarek.fathy91@example.com', N'01100000637', 127)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (92, N'Sara Zayed', N'sara.zayed92@example.com', N'01200000644', 155)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (93, N'Khaled Shalaby', N'khaled.shalaby93@example.com', N'01000000651', 206)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (94, N'Nour Nabil', N'nour.nabil94@example.com', N'01100000658', 43)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (95, N'Islam Fouad', N'islam.fouad95@example.com', N'01200000665', 60)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (96, N'Amr Amin', N'amr.amin96@example.com', N'01000000672', 54)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (97, N'Dina Nasr', N'dina.nasr97@example.com', N'01100000679', 244)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (98, N'Salma Magdy', N'salma.magdy98@example.com', N'01200000686', 29)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (99, N'Hany Wagih', N'hany.wagih99@example.com', N'01000000693', 257)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (100, N'Doaa Samir', N'doaa.samir100@example.com', N'01100000700', 215)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (101, N'Ahmed Mohamed', N'ahmed.mohamed101@example.com', N'01200000707', 101)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (102, N'Yara Hassan', N'yara.hassan102@example.com', N'01000000714', 175)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (103, N'Karim Adel', N'karim.adel103@example.com', N'01100000721', 38)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (104, N'Nada Ahmed', N'nada.ahmed104@example.com', N'01200000728', 77)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (105, N'Omar Tarek', N'omar.tarek105@example.com', N'01000000735', 213)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (106, N'Reem Salah', N'reem.salah106@example.com', N'01100000742', 254)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (107, N'Mahmoud Kamal', N'mahmoud.kamal107@example.com', N'01200000749', 234)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (108, N'Laila Hany', N'laila.hany108@example.com', N'01000000756', 224)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (109, N'Hossam Reda', N'hossam.reda109@example.com', N'01100000763', 62)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (110, N'Mai Elsayed', N'mai.elsayed110@example.com', N'01200000770', 127)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (111, N'Tarek Fathy', N'tarek.fathy111@example.com', N'01000000777', 38)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (112, N'Sara Zayed', N'sara.zayed112@example.com', N'01100000784', 135)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (113, N'Khaled Shalaby', N'khaled.shalaby113@example.com', N'01200000791', 127)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (114, N'Nour Nabil', N'nour.nabil114@example.com', N'01000000798', 296)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (115, N'Islam Fouad', N'islam.fouad115@example.com', N'01100000805', 92)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (116, N'Amr Amin', N'amr.amin116@example.com', N'01200000812', 128)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (117, N'Dina Nasr', N'dina.nasr117@example.com', N'01000000819', 276)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (118, N'Salma Magdy', N'salma.magdy118@example.com', N'01100000826', 66)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (119, N'Hany Wagih', N'hany.wagih119@example.com', N'01200000833', 18)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (120, N'Doaa Samir', N'doaa.samir120@example.com', N'01000000840', 178)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (121, N'Ahmed Mohamed', N'ahmed.mohamed121@example.com', N'01100000847', 86)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (122, N'Yara Hassan', N'yara.hassan122@example.com', N'01200000854', 165)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (123, N'Karim Adel', N'karim.adel123@example.com', N'01000000861', 31)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (124, N'Nada Ahmed', N'nada.ahmed124@example.com', N'01100000868', 233)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (125, N'Omar Tarek', N'omar.tarek125@example.com', N'01200000875', 166)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (126, N'Reem Salah', N'reem.salah126@example.com', N'01000000882', 186)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (127, N'Mahmoud Kamal', N'mahmoud.kamal127@example.com', N'01100000889', 3)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (128, N'Laila Hany', N'laila.hany128@example.com', N'01200000896', 182)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (129, N'Hossam Reda', N'hossam.reda129@example.com', N'01000000903', 222)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (130, N'Mai Elsayed', N'mai.elsayed130@example.com', N'01100000910', 88)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (131, N'Tarek Fathy', N'tarek.fathy131@example.com', N'01200000917', 292)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (132, N'Sara Zayed', N'sara.zayed132@example.com', N'01000000924', 161)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (133, N'Khaled Shalaby', N'khaled.shalaby133@example.com', N'01100000931', 72)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (134, N'Nour Nabil', N'nour.nabil134@example.com', N'01200000938', 168)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (135, N'Islam Fouad', N'islam.fouad135@example.com', N'01000000945', 259)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (136, N'Amr Amin', N'amr.amin136@example.com', N'01100000952', 235)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (137, N'Dina Nasr', N'dina.nasr137@example.com', N'01200000959', 205)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (138, N'Salma Magdy', N'salma.magdy138@example.com', N'01000000966', 122)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (139, N'Hany Wagih', N'hany.wagih139@example.com', N'01100000973', 74)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (140, N'Doaa Samir', N'doaa.samir140@example.com', N'01200000980', 5)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (141, N'Ahmed Mohamed', N'ahmed.mohamed141@example.com', N'01000000987', 138)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (142, N'Yara Hassan', N'yara.hassan142@example.com', N'01100000994', 108)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (143, N'Karim Adel', N'karim.adel143@example.com', N'01200001001', 242)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (144, N'Nada Ahmed', N'nada.ahmed144@example.com', N'01000001008', 189)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (145, N'Omar Tarek', N'omar.tarek145@example.com', N'01100001015', 139)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (146, N'Reem Salah', N'reem.salah146@example.com', N'01200001022', 188)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (147, N'Mahmoud Kamal', N'mahmoud.kamal147@example.com', N'01000001029', 91)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (148, N'Laila Hany', N'laila.hany148@example.com', N'01100001036', 157)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (149, N'Hossam Reda', N'hossam.reda149@example.com', N'01200001043', 31)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (150, N'Mai Elsayed', N'mai.elsayed150@example.com', N'01000001050', 163)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (151, N'Tarek Fathy', N'tarek.fathy151@example.com', N'01100001057', 252)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (152, N'Sara Zayed', N'sara.zayed152@example.com', N'01200001064', 190)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (153, N'Khaled Shalaby', N'khaled.shalaby153@example.com', N'01000001071', 40)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (154, N'Nour Nabil', N'nour.nabil154@example.com', N'01100001078', 119)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (155, N'Islam Fouad', N'islam.fouad155@example.com', N'01200001085', 81)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (156, N'Amr Amin', N'amr.amin156@example.com', N'01000001092', 160)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (157, N'Dina Nasr', N'dina.nasr157@example.com', N'01100001099', 91)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (158, N'Salma Magdy', N'salma.magdy158@example.com', N'01200001106', 34)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (159, N'Hany Wagih', N'hany.wagih159@example.com', N'01000001113', 63)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (160, N'Doaa Samir', N'doaa.samir160@example.com', N'01100001120', 158)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (161, N'Ahmed Mohamed', N'ahmed.mohamed161@example.com', N'01200001127', 159)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (162, N'Yara Hassan', N'yara.hassan162@example.com', N'01000001134', 173)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (163, N'Karim Adel', N'karim.adel163@example.com', N'01100001141', 231)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (164, N'Nada Ahmed', N'nada.ahmed164@example.com', N'01200001148', 74)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (165, N'Omar Tarek', N'omar.tarek165@example.com', N'01000001155', 50)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (166, N'Reem Salah', N'reem.salah166@example.com', N'01100001162', 73)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (167, N'Mahmoud Kamal', N'mahmoud.kamal167@example.com', N'01200001169', 57)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (168, N'Laila Hany', N'laila.hany168@example.com', N'01000001176', 67)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (169, N'Hossam Reda', N'hossam.reda169@example.com', N'01100001183', 52)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (170, N'Mai Elsayed', N'mai.elsayed170@example.com', N'01200001190', 290)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (171, N'Tarek Fathy', N'tarek.fathy171@example.com', N'01000001197', 146)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (172, N'Sara Zayed', N'sara.zayed172@example.com', N'01100001204', 189)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (173, N'Khaled Shalaby', N'khaled.shalaby173@example.com', N'01200001211', 142)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (174, N'Nour Nabil', N'nour.nabil174@example.com', N'01000001218', 139)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (175, N'Islam Fouad', N'islam.fouad175@example.com', N'01100001225', 263)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (176, N'Amr Amin', N'amr.amin176@example.com', N'01200001232', 279)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (177, N'Dina Nasr', N'dina.nasr177@example.com', N'01000001239', 110)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (178, N'Salma Magdy', N'salma.magdy178@example.com', N'01100001246', 61)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (179, N'Hany Wagih', N'hany.wagih179@example.com', N'01200001253', 162)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (180, N'Doaa Samir', N'doaa.samir180@example.com', N'01000001260', 284)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (181, N'Ahmed Mohamed', N'ahmed.mohamed181@example.com', N'01100001267', 204)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (182, N'Yara Hassan', N'yara.hassan182@example.com', N'01200001274', 233)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (183, N'Karim Adel', N'karim.adel183@example.com', N'01000001281', 200)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (184, N'Nada Ahmed', N'nada.ahmed184@example.com', N'01100001288', 103)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (185, N'Omar Tarek', N'omar.tarek185@example.com', N'01200001295', 186)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (186, N'Reem Salah', N'reem.salah186@example.com', N'01000001302', 118)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (187, N'Mahmoud Kamal', N'mahmoud.kamal187@example.com', N'01100001309', 133)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (188, N'Laila Hany', N'laila.hany188@example.com', N'01200001316', 146)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (189, N'Hossam Reda', N'hossam.reda189@example.com', N'01000001323', 294)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (190, N'Mai Elsayed', N'mai.elsayed190@example.com', N'01100001330', 241)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (191, N'Tarek Fathy', N'tarek.fathy191@example.com', N'01200001337', 204)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (192, N'Sara Zayed', N'sara.zayed192@example.com', N'01000001344', 106)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (193, N'Khaled Shalaby', N'khaled.shalaby193@example.com', N'01100001351', 275)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (194, N'Nour Nabil', N'nour.nabil194@example.com', N'01200001358', 18)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (195, N'Islam Fouad', N'islam.fouad195@example.com', N'01000001365', 93)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (196, N'Amr Amin', N'amr.amin196@example.com', N'01100001372', 88)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (197, N'Dina Nasr', N'dina.nasr197@example.com', N'01200001379', 147)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (198, N'Salma Magdy', N'salma.magdy198@example.com', N'01000001386', 136)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (199, N'Hany Wagih', N'hany.wagih199@example.com', N'01100001393', 254)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (200, N'Doaa Samir', N'doaa.samir200@example.com', N'01200001400', 291)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (201, N'Ahmed Mohamed', N'ahmed.mohamed201@example.com', N'01000001407', 66)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (202, N'Yara Hassan', N'yara.hassan202@example.com', N'01100001414', 241)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (203, N'Karim Adel', N'karim.adel203@example.com', N'01200001421', 291)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (204, N'Nada Ahmed', N'nada.ahmed204@example.com', N'01000001428', 8)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (205, N'Omar Tarek', N'omar.tarek205@example.com', N'01100001435', 73)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (206, N'Reem Salah', N'reem.salah206@example.com', N'01200001442', 170)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (207, N'Mahmoud Kamal', N'mahmoud.kamal207@example.com', N'01000001449', 159)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (208, N'Laila Hany', N'laila.hany208@example.com', N'01100001456', 118)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (209, N'Hossam Reda', N'hossam.reda209@example.com', N'01200001463', 215)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (210, N'Mai Elsayed', N'mai.elsayed210@example.com', N'01000001470', 169)
GO
INSERT [dbo].[Customers] ([customer_id], [name], [email], [phone_number], [loyal_points]) VALUES (211, N'Tarek Fathy', N'tarek.fathy211@example.com', N'01100001477', 136)
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
/****** Object:  Index [seat_screen_uq]    Script Date: 5/21/2025 1:59:31 AM ******/
ALTER TABLE [dbo].[Bookings] ADD  CONSTRAINT [seat_screen_uq] UNIQUE NONCLUSTERED 
(
	[seat_number] ASC,
	[screening_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [email_uq]    Script Date: 5/21/2025 1:59:31 AM ******/
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [email_uq] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [phone_uq]    Script Date: 5/21/2025 1:59:31 AM ******/
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [phone_uq] UNIQUE NONCLUSTERED 
(
	[phone_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [title_date_uq]    Script Date: 5/21/2025 1:59:31 AM ******/
ALTER TABLE [dbo].[Movies] ADD  CONSTRAINT [title_date_uq] UNIQUE NONCLUSTERED 
(
	[title] ASC,
	[release_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [location_uq]    Script Date: 5/21/2025 1:59:31 AM ******/
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
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [customer_fk_bookings] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [customer_fk_bookings]
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
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD  CONSTRAINT [customer_fk_reviews] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Customers] ([customer_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews] CHECK CONSTRAINT [customer_fk_reviews]
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
