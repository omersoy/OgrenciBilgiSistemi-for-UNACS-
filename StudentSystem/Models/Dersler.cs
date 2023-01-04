using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace StudentSystem.Model
{
    public class Dersler
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int ID { get; set; }
        public string DersKodu { get; set; }
        public string DersAdi { get; set; }
        public int Durum { get; set; }
        public int Kredi { get; set; }
        [JsonIgnore]
        public List<DersKayit> DersKayit { get; set; }
        [JsonIgnore]
        public List<MufredatDersler> MufredatDersler { get; set; }


    }
}
