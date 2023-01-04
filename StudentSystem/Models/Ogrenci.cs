using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace StudentSystem.Model
{
    [Index(nameof(OgrNo), IsUnique = true)]
    public class Ogrenci
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int ID { get; set; }
        public long OgrNo { get; set; }

        [ForeignKey("Kimlik")]
        public int KimlikID { get; set; }
        public Kimlik Kimlik { get; set; }

        [ForeignKey("Mufredat")]
        public int MufredatID { get; set; }
        public Mufredat Mufredat { get; set; }
        [JsonIgnore]

        public List<DersKayit> DersKayitlari { get; set; }


    }
}
