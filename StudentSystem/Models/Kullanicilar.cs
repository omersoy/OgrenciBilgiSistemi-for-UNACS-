using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace StudentSystem.Model
{
    public class Kullanicilar
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]

        public int ID { get; set; }
        public string KullaniciAdi { get; set; }
        public string Sifre { get; set; }
        public int Tur { get; set; }
        [ForeignKey("Kimlik")]
        public int KimlikID { get; set; }
        [JsonIgnore]
        public Kimlik Kimlik { get; set; }

    }
}
