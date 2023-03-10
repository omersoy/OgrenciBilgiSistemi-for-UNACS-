USE [master]
GO
/****** Object:  Database [StudentSystem]    Script Date: 4.01.2023 21:53:40 ******/
CREATE DATABASE [StudentSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'StudentSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\StudentSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'StudentSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\StudentSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [StudentSystem] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [StudentSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [StudentSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [StudentSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [StudentSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [StudentSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [StudentSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [StudentSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [StudentSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [StudentSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [StudentSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [StudentSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [StudentSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [StudentSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [StudentSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [StudentSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [StudentSystem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [StudentSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [StudentSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [StudentSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [StudentSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [StudentSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [StudentSystem] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [StudentSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [StudentSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [StudentSystem] SET  MULTI_USER 
GO
ALTER DATABASE [StudentSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [StudentSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [StudentSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [StudentSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [StudentSystem] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'StudentSystem', N'ON'
GO
ALTER DATABASE [StudentSystem] SET QUERY_STORE = OFF
GO
USE [StudentSystem]
GO
/****** Object:  Table [dbo].[DersKayit]    Script Date: 4.01.2023 21:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DersKayit](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DersID] [int] NOT NULL,
	[Ogrenci_ID] [int] NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_DersKayit] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dersler]    Script Date: 4.01.2023 21:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dersler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DersKodu] [nvarchar](max) NULL,
	[DersAdi] [nvarchar](max) NULL,
	[Durum] [int] NOT NULL,
	[Kredi] [int] NOT NULL,
 CONSTRAINT [PK_Dersler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Iletisim]    Script Date: 4.01.2023 21:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Iletisim](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Adres] [nvarchar](max) NULL,
	[Il] [nvarchar](max) NULL,
	[Ilce] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[GSM] [nvarchar](max) NULL,
 CONSTRAINT [PK_Iletisim] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kimlik]    Script Date: 4.01.2023 21:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kimlik](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TCNO] [bigint] NOT NULL,
	[Ad] [nvarchar](max) NULL,
	[Soyad] [nvarchar](max) NULL,
	[DogumYeri] [nvarchar](max) NULL,
	[DogumTarihi] [datetime2](7) NOT NULL,
	[IlatisimID] [int] NOT NULL,
 CONSTRAINT [PK_Kimlik] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kullanicilar]    Script Date: 4.01.2023 21:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kullanicilar](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[KullaniciAdi] [nvarchar](max) NULL,
	[Sifre] [nvarchar](max) NULL,
	[Tur] [int] NOT NULL,
	[KimlikID] [int] NOT NULL,
 CONSTRAINT [PK_Kullanicilar] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mufredat]    Script Date: 4.01.2023 21:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mufredat](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MufredatAdi] [nvarchar](max) NULL,
 CONSTRAINT [PK_Mufredat] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MufredatDersler]    Script Date: 4.01.2023 21:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MufredatDersler](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MufredatID] [int] NOT NULL,
	[DersID] [int] NOT NULL,
 CONSTRAINT [PK_MufredatDersler] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ogrenci]    Script Date: 4.01.2023 21:53:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ogrenci](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OgrNo] [bigint] NOT NULL,
	[KimlikID] [int] NOT NULL,
	[MufredatID] [int] NOT NULL,
 CONSTRAINT [PK_Ogrenci] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DersKayit] ON 

INSERT [dbo].[DersKayit] ([ID], [DersID], [Ogrenci_ID], [CreatedDate]) VALUES (1, 3, 3, CAST(N'2023-01-04T21:15:51.1687715' AS DateTime2))
INSERT [dbo].[DersKayit] ([ID], [DersID], [Ogrenci_ID], [CreatedDate]) VALUES (2, 6, 4, CAST(N'2023-01-04T21:15:51.1687730' AS DateTime2))
INSERT [dbo].[DersKayit] ([ID], [DersID], [Ogrenci_ID], [CreatedDate]) VALUES (3, 1, 3, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[DersKayit] ([ID], [DersID], [Ogrenci_ID], [CreatedDate]) VALUES (4, 8, 3, CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[DersKayit] OFF
GO
SET IDENTITY_INSERT [dbo].[Dersler] ON 

INSERT [dbo].[Dersler] ([ID], [DersKodu], [DersAdi], [Durum], [Kredi]) VALUES (1, N'HUM101', N'Türk Demokrasi Tarihi', 1, 5)
INSERT [dbo].[Dersler] ([ID], [DersKodu], [DersAdi], [Durum], [Kredi]) VALUES (2, N'MATH102', N'Calculus 2', 0, 6)
INSERT [dbo].[Dersler] ([ID], [DersKodu], [DersAdi], [Durum], [Kredi]) VALUES (3, N'MATE103', N'Metalurjiye Giriş ', 0, 6)
INSERT [dbo].[Dersler] ([ID], [DersKodu], [DersAdi], [Durum], [Kredi]) VALUES (4, N'GRA105', N'Grafik Dizayn', 1, 5)
INSERT [dbo].[Dersler] ([ID], [DersKodu], [DersAdi], [Durum], [Kredi]) VALUES (5, N'CMPE201', N'Bilgisayar Teknolojileri', 1, 4)
INSERT [dbo].[Dersler] ([ID], [DersKodu], [DersAdi], [Durum], [Kredi]) VALUES (6, N'ENG102', N'İngilizce 2', 1, 4)
INSERT [dbo].[Dersler] ([ID], [DersKodu], [DersAdi], [Durum], [Kredi]) VALUES (7, N'MATH201', N'İleri Calculus ', 1, 6)
INSERT [dbo].[Dersler] ([ID], [DersKodu], [DersAdi], [Durum], [Kredi]) VALUES (8, N'Test111', N'Test', 1, 6)
SET IDENTITY_INSERT [dbo].[Dersler] OFF
GO
SET IDENTITY_INSERT [dbo].[Iletisim] ON 

INSERT [dbo].[Iletisim] ([ID], [Adres], [Il], [Ilce], [Email], [GSM]) VALUES (1, N'CUMHURİYET MAH. BİRİNCİ SOK. İKİNCİ APT. NO:111/6  ', N'ANKARA', N'YENİMAHALLE', N'abc@hotmail.com', N'5332342342')
INSERT [dbo].[Iletisim] ([ID], [Adres], [Il], [Ilce], [Email], [GSM]) VALUES (2, N'KUŞADASI SOK. NO:123 KARAAĞAÇ', N'ANKARA', N'ÇANKAYA', N'def@gmail.com', N'5437657567')
INSERT [dbo].[Iletisim] ([ID], [Adres], [Il], [Ilce], [Email], [GSM]) VALUES (3, N'TURAN GÜNEŞ BULVARI TAMTAM SİTESİ 13. CAD. NO:51', N'ANKARA', N'KEÇİÖREN', N'ghi@abc.com', N'5305464646')
INSERT [dbo].[Iletisim] ([ID], [Adres], [Il], [Ilce], [Email], [GSM]) VALUES (4, N'DEMİRCİKARA MAH. B.ONAT CAD. HEDE SİT. B BLOK NO : 1', N'ANKARA', N'PURSAKLAR', N'mno@xyz.com', N'5555424245')
INSERT [dbo].[Iletisim] ([ID], [Adres], [Il], [Ilce], [Email], [GSM]) VALUES (5, N'AHMET HAMDİ SOK. NO:19/15', N'ANKARA', N'SİNCAN', N'prs@hotmail.com', N'5302908432')
INSERT [dbo].[Iletisim] ([ID], [Adres], [Il], [Ilce], [Email], [GSM]) VALUES (6, N'SİTELER MAHALLESİ 6223 SOKAK DURU APT. NO:11 KAT:3  ', N'ANKARA', N'POLATLI', N'klm@outlook.com', N'5408932042')
SET IDENTITY_INSERT [dbo].[Iletisim] OFF
GO
SET IDENTITY_INSERT [dbo].[Kimlik] ON 

INSERT [dbo].[Kimlik] ([ID], [TCNO], [Ad], [Soyad], [DogumYeri], [DogumTarihi], [IlatisimID]) VALUES (1, 45456747611, N'Hasan', N'Ersoy', N'Kayseri', CAST(N'1983-10-11T00:00:00.0000000' AS DateTime2), 4)
INSERT [dbo].[Kimlik] ([ID], [TCNO], [Ad], [Soyad], [DogumYeri], [DogumTarihi], [IlatisimID]) VALUES (2, 67967856634, N'Mehmet', N'Yılmaz', N'Adana', CAST(N'2000-03-12T00:00:00.0000000' AS DateTime2), 1)
INSERT [dbo].[Kimlik] ([ID], [TCNO], [Ad], [Soyad], [DogumYeri], [DogumTarihi], [IlatisimID]) VALUES (3, 72347322958, N'Ahmet', N'Ünal', N'Ankara', CAST(N'2001-06-14T00:00:00.0000000' AS DateTime2), 6)
INSERT [dbo].[Kimlik] ([ID], [TCNO], [Ad], [Soyad], [DogumYeri], [DogumTarihi], [IlatisimID]) VALUES (4, 97850348520, N'Mustafa', N'Işık', N'Sivas', CAST(N'2000-12-21T00:00:00.0000000' AS DateTime2), 3)
INSERT [dbo].[Kimlik] ([ID], [TCNO], [Ad], [Soyad], [DogumYeri], [DogumTarihi], [IlatisimID]) VALUES (5, 32756874239, N'Ayşe', N'Erdoğan', N'Uşak', CAST(N'2001-03-04T00:00:00.0000000' AS DateTime2), 5)
INSERT [dbo].[Kimlik] ([ID], [TCNO], [Ad], [Soyad], [DogumYeri], [DogumTarihi], [IlatisimID]) VALUES (6, 98423479320, N'Fatma', N'Korkmaz', N'Kütahya', CAST(N'2001-01-01T00:00:00.0000000' AS DateTime2), 2)
SET IDENTITY_INSERT [dbo].[Kimlik] OFF
GO
SET IDENTITY_INSERT [dbo].[Kullanicilar] ON 

INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Tur], [KimlikID]) VALUES (1, N'hasan.ersoy', N'9DF84B59CEEBCE17E4A694D13833604EBABBFFBA83936656C681AA2BCE3E1D30:9D9A870A12C57EC8C54ADF0DE3F88E4E:100000:SHA256', 0, 1)
INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Tur], [KimlikID]) VALUES (2, N'mehmet.yilmaz', N'92CB6281456B15A5125D5904562AF9EB0DF568B7AB4E58999A37014DD0F9AAC0:EF61BC33D4CAC6E196DFE79512CE1F69:100000:SHA256', 1, 2)
INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Tur], [KimlikID]) VALUES (3, N'ahmet.unal', N'0B01CD1422BF62F327BDCBC5FACF7CBDB5BE3B996044EE83EC83E00AA0E44FA2:DFAACEF5576E3F5565D18C57BF46E5D7:100000:SHA256', 1, 3)
INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Tur], [KimlikID]) VALUES (4, N'mustafa.isik', N'64C8BA2D606532F266B82308B0DB1A5395A57510F61B4FE2149377DE9CB3E00D:E273DEB85E330C42BEC78D145DAF06BA:100000:SHA256', 1, 4)
INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Tur], [KimlikID]) VALUES (5, N'ayse.erdogan', N'37BBD2219ED37763FA194200E5354174D66BB3A377745766E48B6A686781D7BA:2F174106F97FCC6EA6BD6CA7951EF95B:100000:SHA256', 1, 5)
INSERT [dbo].[Kullanicilar] ([ID], [KullaniciAdi], [Sifre], [Tur], [KimlikID]) VALUES (6, N'fatma.korkmaz', N'BD6618AC96977300868D63E6BE8627005388FBB68C4D196DF8BC661C4AFAA9C9:F06BBEFD281EBBA9860C5E35A124DFD4:100000:SHA256', 1, 6)
SET IDENTITY_INSERT [dbo].[Kullanicilar] OFF
GO
SET IDENTITY_INSERT [dbo].[Mufredat] ON 

INSERT [dbo].[Mufredat] ([ID], [MufredatAdi]) VALUES (1, N'BilgMuh_Mufredat')
INSERT [dbo].[Mufredat] ([ID], [MufredatAdi]) VALUES (2, N'GrafikMuh_Mufredat')
INSERT [dbo].[Mufredat] ([ID], [MufredatAdi]) VALUES (3, N'IngDilEdebiyat_Muf')
SET IDENTITY_INSERT [dbo].[Mufredat] OFF
GO
SET IDENTITY_INSERT [dbo].[MufredatDersler] ON 

INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (1, 1, 2)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (2, 1, 5)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (3, 1, 6)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (4, 1, 7)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (5, 2, 1)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (6, 2, 2)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (7, 2, 3)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (8, 2, 4)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (9, 2, 6)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (10, 2, 7)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (11, 3, 1)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (12, 3, 4)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (13, 3, 5)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (14, 3, 6)
INSERT [dbo].[MufredatDersler] ([ID], [MufredatID], [DersID]) VALUES (15, 2, 8)
SET IDENTITY_INSERT [dbo].[MufredatDersler] OFF
GO
SET IDENTITY_INSERT [dbo].[Ogrenci] ON 

INSERT [dbo].[Ogrenci] ([ID], [OgrNo], [KimlikID], [MufredatID]) VALUES (1, 27482379, 3, 1)
INSERT [dbo].[Ogrenci] ([ID], [OgrNo], [KimlikID], [MufredatID]) VALUES (2, 23462368, 5, 1)
INSERT [dbo].[Ogrenci] ([ID], [OgrNo], [KimlikID], [MufredatID]) VALUES (3, 34565479, 6, 2)
INSERT [dbo].[Ogrenci] ([ID], [OgrNo], [KimlikID], [MufredatID]) VALUES (4, 53456346, 2, 2)
INSERT [dbo].[Ogrenci] ([ID], [OgrNo], [KimlikID], [MufredatID]) VALUES (5, 34674575, 4, 3)
SET IDENTITY_INSERT [dbo].[Ogrenci] OFF
GO
/****** Object:  Index [IX_DersKayit_DersID]    Script Date: 4.01.2023 21:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_DersKayit_DersID] ON [dbo].[DersKayit]
(
	[DersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_DersKayit_Ogrenci_ID]    Script Date: 4.01.2023 21:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_DersKayit_Ogrenci_ID] ON [dbo].[DersKayit]
(
	[Ogrenci_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Kimlik_IlatisimID]    Script Date: 4.01.2023 21:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_Kimlik_IlatisimID] ON [dbo].[Kimlik]
(
	[IlatisimID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Kimlik_TCNO]    Script Date: 4.01.2023 21:53:40 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Kimlik_TCNO] ON [dbo].[Kimlik]
(
	[TCNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Kullanicilar_KimlikID]    Script Date: 4.01.2023 21:53:40 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Kullanicilar_KimlikID] ON [dbo].[Kullanicilar]
(
	[KimlikID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MufredatDersler_DersID]    Script Date: 4.01.2023 21:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_MufredatDersler_DersID] ON [dbo].[MufredatDersler]
(
	[DersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_MufredatDersler_MufredatID]    Script Date: 4.01.2023 21:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_MufredatDersler_MufredatID] ON [dbo].[MufredatDersler]
(
	[MufredatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Ogrenci_KimlikID]    Script Date: 4.01.2023 21:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_Ogrenci_KimlikID] ON [dbo].[Ogrenci]
(
	[KimlikID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Ogrenci_MufredatID]    Script Date: 4.01.2023 21:53:40 ******/
CREATE NONCLUSTERED INDEX [IX_Ogrenci_MufredatID] ON [dbo].[Ogrenci]
(
	[MufredatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Ogrenci_OgrNo]    Script Date: 4.01.2023 21:53:40 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Ogrenci_OgrNo] ON [dbo].[Ogrenci]
(
	[OgrNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DersKayit]  WITH CHECK ADD  CONSTRAINT [FK_DersKayit_Dersler_DersID] FOREIGN KEY([DersID])
REFERENCES [dbo].[Dersler] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DersKayit] CHECK CONSTRAINT [FK_DersKayit_Dersler_DersID]
GO
ALTER TABLE [dbo].[DersKayit]  WITH CHECK ADD  CONSTRAINT [FK_DersKayit_Ogrenci_Ogrenci_ID] FOREIGN KEY([Ogrenci_ID])
REFERENCES [dbo].[Ogrenci] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DersKayit] CHECK CONSTRAINT [FK_DersKayit_Ogrenci_Ogrenci_ID]
GO
ALTER TABLE [dbo].[Kimlik]  WITH CHECK ADD  CONSTRAINT [FK_Kimlik_Iletisim_IlatisimID] FOREIGN KEY([IlatisimID])
REFERENCES [dbo].[Iletisim] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Kimlik] CHECK CONSTRAINT [FK_Kimlik_Iletisim_IlatisimID]
GO
ALTER TABLE [dbo].[Kullanicilar]  WITH CHECK ADD  CONSTRAINT [FK_Kullanicilar_Kimlik_KimlikID] FOREIGN KEY([KimlikID])
REFERENCES [dbo].[Kimlik] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Kullanicilar] CHECK CONSTRAINT [FK_Kullanicilar_Kimlik_KimlikID]
GO
ALTER TABLE [dbo].[MufredatDersler]  WITH CHECK ADD  CONSTRAINT [FK_MufredatDersler_Dersler_DersID] FOREIGN KEY([DersID])
REFERENCES [dbo].[Dersler] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MufredatDersler] CHECK CONSTRAINT [FK_MufredatDersler_Dersler_DersID]
GO
ALTER TABLE [dbo].[MufredatDersler]  WITH CHECK ADD  CONSTRAINT [FK_MufredatDersler_Mufredat_MufredatID] FOREIGN KEY([MufredatID])
REFERENCES [dbo].[Mufredat] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[MufredatDersler] CHECK CONSTRAINT [FK_MufredatDersler_Mufredat_MufredatID]
GO
ALTER TABLE [dbo].[Ogrenci]  WITH CHECK ADD  CONSTRAINT [FK_Ogrenci_Kimlik_KimlikID] FOREIGN KEY([KimlikID])
REFERENCES [dbo].[Kimlik] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ogrenci] CHECK CONSTRAINT [FK_Ogrenci_Kimlik_KimlikID]
GO
ALTER TABLE [dbo].[Ogrenci]  WITH CHECK ADD  CONSTRAINT [FK_Ogrenci_Mufredat_MufredatID] FOREIGN KEY([MufredatID])
REFERENCES [dbo].[Mufredat] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ogrenci] CHECK CONSTRAINT [FK_Ogrenci_Mufredat_MufredatID]
GO
USE [master]
GO
ALTER DATABASE [StudentSystem] SET  READ_WRITE 
GO
