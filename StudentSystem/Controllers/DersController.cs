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
    public class DersController : Controller
    {
        private readonly StudentSystemDBContext _db;

        public DersController( StudentSystemDBContext db)
        {
            _db = db;
        }

        [HttpGet]
        [Route("DersListesi")]
        [Authorize(Policy = Policies.Admin)]
        public IActionResult DersListesi()
        {
            var list = _db.Dersler.ToList();
            return Ok(list);
        }

        [HttpGet]
        [Route("AktifDersListesi")]
        [Authorize(Policy = Policies.Admin)]
        public IActionResult AktifDersListesi()
        {
            var list = _db.Dersler.Where(a=>a.Durum==1).ToList();
            return Ok(list);
        }

        [HttpGet]
        [Route("MuredatDersListesi")]
        [Authorize(Policy = Policies.Admin)]
        public IActionResult MuredatDersListesi()
        {
            var list = _db.MufredatDersler.Include(a=>a.Dersler).Include(a=>a.Mufredat).ToList();
            return Ok(list);
        }


        [HttpGet]
        [Route("MyDersKayit")]
        [Authorize(Policy = Policies.User)]
        public IActionResult MyDersKayit()
        {
            var data = _db.DersKayit.Include(a => a.Dersler)
                .Include(a=>a.Ogrenci)
                .ThenInclude(a=>a.Kimlik).ThenInclude(a=>a.Kullanicilar)
              .Where(a => a.Ogrenci.Kimlik.Kullanicilar.KullaniciAdi == User.FindFirst("username").Value);
            return Ok(data);
        }

        [HttpGet]
        [Route("GetMyAccessDers")]
        [Authorize(Policy = Policies.User)]
        public IActionResult GetMyAccessDers()
        {
            var ogrenci = _db.Ogrenci.Include(a => a.Kimlik).ThenInclude(a => a.Kullanicilar)
              .First(a => a.Kimlik.Kullanicilar.KullaniciAdi == User.FindFirst("username").Value);

            var mufredatDers = _db.MufredatDersler.Include(a=>a.Dersler).Where(a => a.MufredatID == ogrenci.MufredatID).ToList();
            return Ok(mufredatDers);
        }



        [HttpPost]
        [Route("DarsKayitiEkle")]
        [Authorize(Policy = Policies.User)]
        public IActionResult mufredatEkle([FromBody] DersKayitiViewModel model)
        {
            var ogrenci = _db.Ogrenci.Include(a => a.Kimlik).ThenInclude(a => a.Kullanicilar)
              .First(a => a.Kimlik.Kullanicilar.KullaniciAdi == User.FindFirst("username").Value);

            if (_db.DersKayit.Any(a => a.DersID == model.dersId && a.Ogrenci_ID == ogrenci.ID))
            {
                return BadRequest("Hata.Bu ders Onceden secilmis ");
            }

            var transaction = _db.Database.BeginTransaction();
            try
            {
                _db.DersKayit.Add(new DersKayit()
                {
                    Ogrenci_ID = ogrenci.ID,
                    DersID = model.dersId
                });
                _db.SaveChanges();

                transaction.Commit();


                var data = _db.DersKayit.Include(a => a.Dersler)
             .Include(a => a.Ogrenci)
             .ThenInclude(a => a.Kimlik).ThenInclude(a => a.Kullanicilar)
           .Where(a => a.Ogrenci.Kimlik.Kullanicilar.KullaniciAdi == User.FindFirst("username").Value);
                return Ok(data);
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                return BadRequest("Hata olustu");
            }
        }

        [HttpPost]
        [Route("dersEkle")]
        [Authorize(Policy = Policies.Admin)]
        public IActionResult mufredatEkle([FromBody] DersViewModel model)
        {
            if (model.id != null)
            {
                var transaction = _db.Database.BeginTransaction();
                try
                {
                    var ders = _db.Dersler.FirstOrDefault(a => a.ID == model.id);
                    ders.DersAdi = model.dersAdi;
                    ders.DersKodu = model.dersKodu;
                    ders.Durum = model.durum;
                    ders.Kredi = model.kredi;
                    _db.Dersler.Update(ders);
                    _db.SaveChanges();
                    
                    transaction.Commit();


                    var list = _db.Dersler.ToList();
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
                    var ders = _db.Dersler.Add(new Dersler()
                    {
                        DersAdi = model.dersAdi,
                        DersKodu = model.dersKodu,
                        Durum = model.durum,
                        Kredi = model.kredi
                    });
                    _db.SaveChanges();
                    transaction.Commit();


                    var list = _db.Dersler.ToList();
                    return Ok(list);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return BadRequest("Hata olustu");
                }


            }

        }



        [HttpPost]
        [Route("MufredatDersEkle")]
        [Authorize(Policy = Policies.Admin)]
        public IActionResult mufredatDersEkle([FromBody] MufredatDersViewModel model)
        {
            if (_db.MufredatDersler.Any(a => a.MufredatID == model.mufredatId && a.DersID == model.dersId))
            { 
                return BadRequest("Hata. Zaten mevcut");
            }
            if (model.id != null)
            {
                var transaction = _db.Database.BeginTransaction();
                try
                {
                    var mfd = _db.MufredatDersler.FirstOrDefault(a => a.ID == model.id);
                    mfd.DersID = model.dersId;
                    mfd.MufredatID = model.mufredatId;
                    _db.MufredatDersler.Update(mfd);
                    _db.SaveChanges();

                    transaction.Commit();


                    var list = _db.MufredatDersler.Include(a => a.Dersler).Include(a => a.Mufredat).ToList();
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
                    var ders = _db.MufredatDersler.Add(new MufredatDersler()
                    {
                        DersID = model.dersId,
                        MufredatID = model.mufredatId
                    });
                    _db.SaveChanges();
                    transaction.Commit();


                    var list = _db.MufredatDersler.Include(a => a.Dersler).Include(a => a.Mufredat).ToList();
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
