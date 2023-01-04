using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace StudentSystem.Model
{
    public class Mufredat
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Key]
        public int ID { get; set; }
        public string MufredatAdi { get; set; }
        [JsonIgnore]
        public List<MufredatDersler> MufredatDersler { get; set; }
    }
}
