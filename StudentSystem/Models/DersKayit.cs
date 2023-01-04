using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudentSystem.Model
{
    public class DersKayit
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int ID { get; set; }
        [ForeignKey("Dersler")]
        public int DersID { get; set; }
        [ForeignKey("Ogrenci")]
        public int Ogrenci_ID { get; set; }
        public DateTime CreatedDate { get; set; }

        public Dersler Dersler { get; set; }
        public Ogrenci Ogrenci { get; set; }
    }
}
