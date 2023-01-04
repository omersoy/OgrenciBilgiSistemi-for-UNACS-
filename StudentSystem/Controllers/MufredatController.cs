using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using StudentSystem.Helper;
using StudentSystem.Model;
using StudentSystem.Models;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;

namespace StudentSystem.Controllers
{
    [Produces("application/json")]
    [Route("api/[controller]")]
    public class MufredatController : Controller
    {
        private readonly StudentSystemDBContext _db;

        public MufredatController( StudentSystemDBContext db)
        {
            _db = db;
        }





        [HttpGet]
        [Route("MufredatListesi")]
        [Authorize(Policy = Policies.Admin)]
        public IActionResult MufredatListesi()
        {
            var list = _db.Mufredat.ToList();
            return Ok(list);
        }


        [HttpPost]
        [Route("mufredatEkle")]
        [Authorize(Policy = Policies.Admin)]
        public IActionResult mufredatEkle([FromBody] MufredatViewModel model)
        {
            if (model.mufredatId != null)
            {
                var transaction = _db.Database.BeginTransaction();
                try
                {
                    var mufredat = _db.Mufredat.FirstOrDefault(a => a.ID == model.mufredatId);
                    mufredat.MufredatAdi = model.mufredatAdi;
                    _db.Mufredat.Update(mufredat);
                    _db.SaveChanges();
                    
                    transaction.Commit();


                    var list = _db.Mufredat.ToList();
                    return Ok(list);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return BadRequest("Hata olustu");
                }



            }
            else
            {
                var transaction = _db.Database.BeginTransaction();
                try
                {
                    var iletisim = _db.Mufredat.Add(new Mufredat()
                    {
                        MufredatAdi = model.mufredatAdi
                    });
                    _db.SaveChanges();
                    transaction.Commit();


                    var list = _db.Mufredat.ToList();
                    return Ok(list);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return BadRequest("Hata olustu");
                }


            }

        }


    }
}
