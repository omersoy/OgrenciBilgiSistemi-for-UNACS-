using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudentSystem.Model
{
    public class MufredatDersViewModel
    {
        public int? id { get; set; }
        public int mufredatId{ get; set; }
        public int dersId { get; set; }
    }
}
