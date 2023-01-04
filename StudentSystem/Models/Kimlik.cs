using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace StudentSystem.Model
{
    [Index(nameof(TCNO), IsUnique = true)]
    public class Kimlik
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int ID { get; set; }
        public long TCNO { get; set; }
        public string Ad { get; set; }
        public string Soyad { get; set; }
        public string DogumYeri { get; set; }
        public DateTime DogumTarihi { get; set; }
        [ForeignKey("Iletisim")]
        public int IlatisimID { get; set; }

        public Iletisim Iletisim { get; set; }
        
        public Kullanicilar Kullanicilar { get; set; }


    }
}
