USE [master]
GO
/****** Object:  Database [PlantShop]    Script Date: 7/21/2023 1:29:15 PM ******/
CREATE DATABASE [PlantShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PlantShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PlantShop.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PlantShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PlantShop_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PlantShop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PlantShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PlantShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PlantShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PlantShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PlantShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PlantShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [PlantShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PlantShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PlantShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PlantShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PlantShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PlantShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PlantShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PlantShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PlantShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PlantShop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PlantShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PlantShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PlantShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PlantShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PlantShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PlantShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PlantShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PlantShop] SET RECOVERY FULL 
GO
ALTER DATABASE [PlantShop] SET  MULTI_USER 
GO
ALTER DATABASE [PlantShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PlantShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PlantShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PlantShop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PlantShop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PlantShop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PlantShop', N'ON'
GO
ALTER DATABASE [PlantShop] SET QUERY_STORE = ON
GO
ALTER DATABASE [PlantShop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PlantShop]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 7/21/2023 1:29:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[accID] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](30) NULL,
	[password] [varchar](30) NULL,
	[fullname] [varchar](30) NULL,
	[phone] [varchar](12) NULL,
	[status] [int] NULL,
	[role] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[accID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 7/21/2023 1:29:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CateID] [int] IDENTITY(1,1) NOT NULL,
	[CateName] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[CateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 7/21/2023 1:29:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[DetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[FID] [int] NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 7/21/2023 1:29:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrdDate] [date] NULL,
	[shipdate] [date] NULL,
	[status] [int] NULL,
	[AccID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plants]    Script Date: 7/21/2023 1:29:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plants](
	[PID] [int] IDENTITY(1,1) NOT NULL,
	[PName] [varchar](30) NULL,
	[price] [int] NULL,
	[imgPath] [varchar](50) NULL,
	[description] [text] NULL,
	[status] [int] NULL,
	[CateID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([accID], [email], [password], [fullname], [phone], [status], [role]) VALUES (1, N'admin', N'admin', N'tao la admin', N'123', 1, 1)
INSERT [dbo].[Accounts] ([accID], [email], [password], [fullname], [phone], [status], [role]) VALUES (2, N'khoa', N'khoa', N'Do Khoa', N'0902503604', 1, 0)
INSERT [dbo].[Accounts] ([accID], [email], [password], [fullname], [phone], [status], [role]) VALUES (6, N'phuoc@gmail.com', N'123456789Pp', N'tran phu phuoc', N'0963560027', 1, 0)
INSERT [dbo].[Accounts] ([accID], [email], [password], [fullname], [phone], [status], [role]) VALUES (7, N'phuoc1@gmail.com', N'3902139210abA', N'Phu Phuoc', N'1234567890', 1, 0)
SET IDENTITY_INSERT [dbo].[Accounts] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (1, N'Rose')
INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (2, N'Orchid')
INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (3, N'Araceae')
INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (4, N'Hydrangeas')
INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (5, N'Nelumbonaceae')
INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (6, N'Sinningia')
INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (7, N'Allium')
INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (8, N'Asphodelaceae')
INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (9, N'Solanaceae')
INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (10, N'vvvv')
INSERT [dbo].[Categories] ([CateID], [CateName]) VALUES (11, N'aaa')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (1, 1, 1, 4)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (2, 2, 1, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (3, 3, 2, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (4, 3, 5, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (5, 3, 6, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (6, 4, 6, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (7, 4, 8, 3)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (8, 4, 9, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (9, 5, 3, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (10, 5, 4, 3)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (11, 5, 8, 3)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (12, 6, 12, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (13, 6, 5, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (14, 6, 6, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (15, 6, 10, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (16, 7, 1, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (17, 7, 2, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (18, 7, 3, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (19, 8, 4, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (20, 8, 5, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (21, 8, 6, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (22, 9, 12, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (23, 9, 9, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (24, 9, 10, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (25, 10, 13, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (26, 10, 14, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (27, 10, 16, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (28, 11, 2, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (29, 11, 3, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (30, 11, 5, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (31, 12, 8, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (32, 13, 12, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (33, 13, 13, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (34, 13, 10, 5)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (35, 14, 14, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (36, 14, 16, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (37, 15, 2, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (38, 15, 6, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (39, 16, 14, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (40, 17, 3, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (41, 17, 8, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (42, 17, 10, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (43, 18, 11, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (44, 18, 12, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (45, 18, 13, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (46, 18, 14, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (47, 18, 15, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (48, 18, 16, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (49, 18, 17, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (50, 18, 18, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (51, 18, 19, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (52, 18, 1, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (53, 18, 2, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (54, 18, 3, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (55, 18, 4, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (56, 18, 5, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (57, 18, 6, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (58, 18, 7, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (59, 18, 8, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (60, 18, 9, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (61, 18, 10, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (62, 19, 2, 3)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (63, 19, 4, 3)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (64, 19, 6, 3)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (65, 20, 1, 4)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (66, 20, 2, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (67, 21, 2, 2)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (68, 21, 8, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (69, 31, 1, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (70, 31, 3, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (71, 32, 3, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (72, 32, 8, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (73, 33, 4, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (74, 33, 7, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (75, 34, 3, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (76, 34, 6, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (77, 34, 8, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (78, 35, 11, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (79, 35, 6, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (80, 35, 8, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (81, 36, 3, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (82, 36, 7, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (83, 36, 8, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (84, 37, 3, 1)
INSERT [dbo].[OrderDetails] ([DetailId], [OrderID], [FID], [quantity]) VALUES (85, 37, 7, 1)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (1, CAST(N'2023-03-18' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (2, CAST(N'2023-03-18' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (3, CAST(N'2023-03-18' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (4, CAST(N'2023-03-19' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (5, CAST(N'2023-03-20' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (6, CAST(N'2023-03-20' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (7, CAST(N'2023-03-20' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (8, CAST(N'2023-03-20' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (9, CAST(N'2023-03-20' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (10, CAST(N'2023-03-20' AS Date), CAST(N'2023-03-20' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (11, CAST(N'2023-03-20' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (12, CAST(N'2023-03-20' AS Date), CAST(N'2023-03-20' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (13, CAST(N'2023-03-20' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (14, CAST(N'2023-03-20' AS Date), CAST(N'2023-03-20' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (15, CAST(N'2023-03-20' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (16, CAST(N'2023-03-21' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (17, CAST(N'2023-03-21' AS Date), CAST(N'2023-03-22' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (18, CAST(N'2023-03-21' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (19, CAST(N'2023-03-21' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (20, CAST(N'2023-03-22' AS Date), NULL, 3, 6)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (21, CAST(N'2023-03-22' AS Date), NULL, 1, 6)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (31, CAST(N'2023-03-22' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (32, CAST(N'2023-04-03' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (33, CAST(N'2023-04-17' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (34, CAST(N'2023-04-23' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (35, CAST(N'2023-04-29' AS Date), CAST(N'2023-04-29' AS Date), 2, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (36, CAST(N'2023-05-08' AS Date), NULL, 1, 2)
INSERT [dbo].[Orders] ([OrderID], [OrdDate], [shipdate], [status], [AccID]) VALUES (37, CAST(N'2023-07-20' AS Date), NULL, 1, 2)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Plants] ON 

INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (1, N'Vanda', 100, N'images/img1.jpg', N'This is Vanda', 1, 2)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (2, N'White rose', 200, N'images/img2.jpg', N'This is white roses', 0, 1)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (3, N'Orchids', 180, N'images/img3.jpg', N'This is Orchids', 1, 2)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (4, N'Mutant Orchid', 1000, N'images/img4.jpg', N'This is mutant Orchid', 1, 2)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (5, N'Orange rose', 220, N'images/img5.jpg', N'This is orange roses', 1, 1)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (6, N'Monstera', 400, N'images/img6.jpg', N'This is Monstera', 1, 3)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (7, N'Var Monstera', 700, N'images/img7.jpg', N'This is Var Monstera', 1, 3)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (8, N'Hydrangea macrophylla', 280, N'images/img8.jpg', N'This is Hydrangea macrophylla', 1, 4)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (9, N'White Lotus', 150, N'images/img9.jpg', N'This is White Lotus', 1, 5)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (10, N'Tiger Striped Orchid', 220, N'images/img10.jpg', N'This is Tiger Striped Orchid', 1, 2)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (11, N'Fiftieth Red Roses', 2000, N'images/img11.jpg', N'This is Fiftieth Red Roses', 1, 1)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (12, N'Sinningia Canescen', 120, N'images/img12.jpg', N'This is Sinningia Canescen', 1, 6)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (13, N'Sinningia macropoda', 190, N'images/img13.jpg', N'This is Sinningia macropoda', 1, 6)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (14, N'Sinningia eumorpha', 210, N'images/img14.jpg', N'This is Sinningia eumorpha', 1, 6)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (15, N'Allium stipitatum', 230, N'images/img15.jpg', N'This is Allium stipitatum', 1, 7)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (16, N'Aloe vera', 290, N'images/img16.jpg', N'This is aloe vera', 1, 8)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (17, N'Rainbow rose', 300, N'images/img17.jpg', N'This is rainbow rose', 1, 1)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (18, N'Arum lily', 175, N'images/img18.jpg', N'This is arum lily', 1, 3)
INSERT [dbo].[Plants] ([PID], [PName], [price], [imgPath], [description], [status], [CateID]) VALUES (19, N'Tobacco plants', 2000, N'images/img19.jpg', N'This is Tobacco plants', 1, 9)
SET IDENTITY_INSERT [dbo].[Plants] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Accounts__AB6E6164F7E0DC66]    Script Date: 7/21/2023 1:29:16 PM ******/
ALTER TABLE [dbo].[Accounts] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([FID])
REFERENCES [dbo].[Plants] ([PID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([AccID])
REFERENCES [dbo].[Accounts] ([accID])
GO
ALTER TABLE [dbo].[Plants]  WITH CHECK ADD FOREIGN KEY([CateID])
REFERENCES [dbo].[Categories] ([CateID])
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD CHECK  (([role]=(1) OR [role]=(0)))
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD CHECK  (([status]=(1) OR [status]=(0)))
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD CHECK  (([quantity]>=(1)))
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD CHECK  (([status]=(1) OR [status]=(2) OR [status]=(3)))
GO
ALTER TABLE [dbo].[Plants]  WITH CHECK ADD CHECK  (([price]>=(0)))
GO
USE [master]
GO
ALTER DATABASE [PlantShop] SET  READ_WRITE 
GO
