using Microsoft.EntityFrameworkCore;
using StudentSystem.Helper;
using System;

namespace StudentSystem.Model
{

    public class StudentSystemDBContext : DbContext 
    {
        public StudentSystemDBContext(DbContextOptions<StudentSystemDBContext> options) : base(options)
        {
            Database.EnsureCreated();
            
        }

        public DbSet<DersKayit> DersKayit { get; set; }
        public DbSet<Dersler> Dersler { get; set; }
        public DbSet<Iletisim> Iletisim { get; set; }
        public DbSet<Kimlik> Kimlik { get; set; }
        public DbSet<Kullanicilar> Kullanicilar { get; set; }
        public DbSet<Mufredat> Mufredat { get; set; }
        public DbSet<MufredatDersler> MufredatDersler { get; set; }
        public DbSet<Ogrenci> Ogrenci { get; set; }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {


            modelBuilder.Entity<Iletisim>().HasData(
                new Iletisim
                {
                    ID = 1,
                    Adres = "CUMHURİYET MAH. BİRİNCİ SOK. İKİNCİ APT. NO:111/6  ",
                    Il = "ANKARA",
                    Ilce = "YENİMAHALLE",
                    Email = "abc@hotmail.com",
                    GSM = "5332342342"
                }, new Iletisim
                {
                    ID = 2,
                    Adres = "KUŞADASI SOK. NO:123 KARAAĞAÇ",
                    Il = "ANKARA",
                    Ilce = "ÇANKAYA",
                    Email = "def@gmail.com",
                    GSM = "5437657567"
                },new Iletisim
                {
                    ID = 3,
                    Adres = "TURAN GÜNEŞ BULVARI TAMTAM SİTESİ 13. CAD. NO:51",
                    Il = "ANKARA",
                    Ilce = "KEÇİÖREN",
                    Email = "ghi@abc.com",
                    GSM = "5305464646"
                },new Iletisim
                {
                    ID = 4,
                    Adres = "DEMİRCİKARA MAH. B.ONAT CAD. HEDE SİT. B BLOK NO : 1",
                    Il = "ANKARA",
                    Ilce = "PURSAKLAR",
                    Email = "mno@xyz.com",
                    GSM = "5555424245"
                },new Iletisim
                {
                    ID = 5,
                    Adres = "AHMET HAMDİ SOK. NO:19/15",
                    Il = "ANKARA",
                    Ilce = "SİNCAN",
                    Email = "prs@hotmail.com",
                    GSM = "5302908432"
                },new Iletisim
                {
                    ID = 6,
                    Adres = "SİTELER MAHALLESİ 6223 SOKAK DURU APT. NO:11 KAT:3  ",
                    Il = "ANKARA",
                    Ilce = "POLATLI",
                    Email = "klm@outlook.com",
                    GSM = "5408932042"
                }
            );
            modelBuilder.Entity<Kimlik>().HasData(
                new Kimlik { ID = 1, TCNO = 45456747611, Ad = "Hasan", Soyad = "Ersoy", DogumYeri = "Kayseri", DogumTarihi=new DateTime(1983,10,11), IlatisimID=4},
                new Kimlik { ID = 2, TCNO = 67967856634, Ad = "Mehmet", Soyad = "Yılmaz", DogumYeri = "Adana", DogumTarihi = new DateTime(2000, 3, 12), IlatisimID = 1 },
                new Kimlik { ID = 3, TCNO = 72347322958, Ad = "Ahmet", Soyad = "Ünal", DogumYeri = "Ankara", DogumTarihi = new DateTime(2001, 6, 14), IlatisimID = 6 },
                new Kimlik { ID = 4, TCNO = 97850348520, Ad = "Mustafa", Soyad = "Işık", DogumYeri = "Sivas", DogumTarihi=new DateTime(2000,12,21), IlatisimID=3},
                new Kimlik { ID = 5, TCNO = 32756874239, Ad = "Ayşe", Soyad = "Erdoğan", DogumYeri = "Uşak", DogumTarihi = new DateTime(2001, 3, 4), IlatisimID = 5 },
                new Kimlik { ID = 6, TCNO = 98423479320, Ad = "Fatma", Soyad = "Korkmaz", DogumYeri = "Kütahya", DogumTarihi = new DateTime(2001, 1, 1), IlatisimID = 2 }
            );
            modelBuilder.Entity<Kullanicilar>().HasData(
                new Kullanicilar { ID = 1, KullaniciAdi = "hasan.ersoy", Sifre = SecretHasher.Hash("Haser1."), Tur = 0, KimlikID =1},
                new Kullanicilar { ID = 2, KullaniciAdi = "mehmet.yilmaz", Sifre = SecretHasher.Hash("Mehyil6!"), Tur = 1, KimlikID =2},
                new Kullanicilar { ID = 3, KullaniciAdi = "ahmet.unal", Sifre = SecretHasher.Hash("Ahun23+"), Tur = 1, KimlikID =3},
                new Kullanicilar { ID = 4, KullaniciAdi = "mustafa.isik", Sifre = SecretHasher.Hash("Musi64%"), Tur = 1, KimlikID =4},
                new Kullanicilar { ID = 5, KullaniciAdi = "ayse.erdogan", Sifre = SecretHasher.Hash("Ayer33."), Tur = 1, KimlikID =5},
                new Kullanicilar { ID = 6, KullaniciAdi = "fatma.korkmaz", Sifre = SecretHasher.Hash("Fatkor12%"), Tur = 1, KimlikID =6}
             );

            modelBuilder.Entity<Mufredat>().HasData(
                new Mufredat { ID = 1, MufredatAdi = "BilgMuh_Mufredat" },
                new Mufredat { ID = 2, MufredatAdi = "GrafikMuh_Mufredat" },
                new Mufredat { ID = 3, MufredatAdi = "IngDilEdebiyat_Muf" }
           );

            modelBuilder.Entity<Ogrenci>().HasData(
               new Ogrenci { ID = 1, OgrNo = 27482379, KimlikID = 3, MufredatID = 1 },
               new Ogrenci { ID = 2, OgrNo = 23462368, KimlikID = 5, MufredatID = 1 },
               new Ogrenci { ID = 3, OgrNo = 34565479, KimlikID = 6, MufredatID = 2 },
               new Ogrenci { ID = 4, OgrNo = 53456346, KimlikID = 2, MufredatID = 2 },
               new Ogrenci { ID = 5, OgrNo = 34674575, KimlikID = 4, MufredatID = 3 }

          );
            modelBuilder.Entity<Dersler>().HasData(
              new Dersler { ID = 1, DersKodu = "HUM101", DersAdi = "Türk Demokrasi Tarihi", Durum = 1 ,Kredi=5},
              new Dersler { ID = 2, DersKodu = "MATH102", DersAdi = "Calculus 2", Durum = 0 ,Kredi=6},
              new Dersler { ID = 3, DersKodu = "MATE103", DersAdi = "Metalurjiye Giriş ", Durum = 0 ,Kredi=6},
              new Dersler { ID = 4, DersKodu = "GRA105", DersAdi = "Grafik Dizayn", Durum = 1 ,Kredi=5},
              new Dersler { ID = 5, DersKodu = "CMPE201", DersAdi = "Bilgisayar Teknolojileri", Durum = 1 ,Kredi=4},
              new Dersler { ID = 6, DersKodu = "ENG102", DersAdi = "İngilizce 2", Durum = 1 ,Kredi=4},
              new Dersler { ID = 7, DersKodu = "MATH201", DersAdi = "İleri Calculus ", Durum = 1 ,Kredi=6}
         );
            modelBuilder.Entity<MufredatDersler>().HasData(
              new MufredatDersler { ID = 1, MufredatID = 1, DersID = 2 },
              new MufredatDersler { ID = 2, MufredatID = 1, DersID = 5 },
              new MufredatDersler { ID = 3, MufredatID = 1, DersID = 6 },
              new MufredatDersler { ID = 4, MufredatID = 1, DersID = 7 },
              new MufredatDersler { ID = 5, MufredatID = 2, DersID = 1 },
              new MufredatDersler { ID = 6, MufredatID = 2, DersID = 2 },
              new MufredatDersler { ID = 7, MufredatID = 2, DersID = 3 },
              new MufredatDersler { ID = 8, MufredatID = 2, DersID = 4 },
              new MufredatDersler { ID = 9, MufredatID = 2, DersID = 6 },
              new MufredatDersler { ID = 10, MufredatID = 2, DersID = 7 },
              new MufredatDersler { ID = 11, MufredatID = 3, DersID = 1 },
              new MufredatDersler { ID = 12, MufredatID = 3, DersID = 4 },
              new MufredatDersler { ID = 13, MufredatID = 3, DersID = 5 },
              new MufredatDersler { ID = 14, MufredatID = 3, DersID = 6 }

         );

            modelBuilder.Entity<DersKayit>().HasData(
              new DersKayit { ID = 1, Ogrenci_ID = 3, DersID = 3, CreatedDate = DateTime.Now },
              new DersKayit { ID = 2, Ogrenci_ID = 4, DersID = 6, CreatedDate = DateTime.Now }
         );

        }


    }
}
