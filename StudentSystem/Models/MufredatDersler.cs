using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudentSystem.Model
{
    public class MufredatDersler
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int ID { get; set; }
        [ForeignKey("Mufredat")]
        public int MufredatID { get; set; }
        [ForeignKey("Dersler")]
        public int DersID { get; set; }
        public Mufredat Mufredat { get; set; }
        public Dersler Dersler { get; set; }
    }
}
