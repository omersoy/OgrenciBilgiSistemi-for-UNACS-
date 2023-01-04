namespace StudentSystem.Models
{
    public class OgrenciViewModel
    {
        public long? ogrId { get; set; }
        public long? kimlikId { get; set; }
        public long? iletisimId { get; set; }
        public long? kullaniciId { get; set; }
        public long ogrNo { get; set; }
        public long tcno { get; set; }
        public string ad { get; set; }
        public string soyad { get; set; }
        public string dogumYeri { get; set; }
        public string dogumTarihi { get; set; }
        public string adres { get; set; }
        public string il { get; set; }
        public string ilce { get; set; }
        public string email { get; set; }
        public long gsm { get; set; }
        public string kullaniciAdi { get; set; }
        public string sifre { get; set; }

        public int mufredatId { get; set; }
    }
}
