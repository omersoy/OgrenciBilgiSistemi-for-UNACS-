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
    public class UserController : Controller
    {

        private readonly IConfiguration _config;
        private readonly StudentSystemDBContext _db;

        public UserController(IConfiguration config, StudentSystemDBContext db)
        {
            _config = config;
            _db = db;
        }


        [HttpGet]
        [Route("OgrenciListesi")]
        [Authorize(Policy = Policies.Admin)]
        public IActionResult OgrenciListesi()
        {
            var x = HttpContext.User.Identity.IsAuthenticated;
            var list = _db.Ogrenci.Include(a => a.Mufredat).Include(a => a.Kimlik).ThenInclude(a => a.Iletisim).Include(a => a.Kimlik).ThenInclude(a => a.Kullanicilar).ToList();
            return Ok(list);
        }

        [HttpGet]
        [Route("getMyData")]
        [Authorize(Policy = Policies.User)]
        public IActionResult getMyData()
        {
            var list = _db.Ogrenci.Include(a => a.Mufredat).Include(a => a.Kimlik).ThenInclude(a => a.Iletisim)
                .Include(a => a.Kimlik).ThenInclude(a => a.Kullanicilar)
                .Where(a=>a.Kimlik.Kullanicilar.KullaniciAdi == User.FindFirst("username").Value);
            return Ok(list);
        }

        [HttpPost]
        [Route("IletisimiGuncelleData")]
        [AllowAnonymous]
        public IActionResult IletisimiGuncelleData([FromBody] OgrenciViewModel model)
        {
            var iletisim = _db.Kimlik.Include(a => a.Iletisim)
                .Where(a => a.Kullanicilar.KullaniciAdi == User.FindFirst("username").Value).Select(a=>a.Iletisim).FirstOrDefault();
            if (iletisim != null)
            {
                iletisim.Adres = model.adres;
                iletisim.Il = model.il;
                iletisim.Ilce = model.ilce;
                iletisim.Email = model.email;
                iletisim.GSM = model.gsm.ToString();
                _db.Iletisim.Update(iletisim);
                _db.SaveChanges();


                var list = _db.Ogrenci.Include(a => a.Mufredat).Include(a => a.Kimlik).ThenInclude(a => a.Iletisim)
                .Include(a => a.Kimlik).ThenInclude(a => a.Kullanicilar)
                .Where(a => a.Kimlik.Kullanicilar.KullaniciAdi == User.FindFirst("username").Value);
                return Ok(list);
            }
            else {

                return BadRequest("Error");
            }
            
        }

        [HttpPost]
        [Route("Login")]
        [AllowAnonymous]
        public IActionResult Login([FromBody] LoginViewModel model)
        {
            IActionResult response = Unauthorized();

            Kullanicilar kullanici = AuthenticateUser(model);
            if (kullanici != null)
            {
                var tokenString = GenerateJWT(kullanici);
                response = Ok(new
                {
                    token = tokenString,
                    userDetails = kullanici,
                });
            }

            return response;
        }
        [HttpPost]
        [Route("ogrenciEkle")]
        [AllowAnonymous]
        public IActionResult ogrenciEkle([FromBody] OgrenciViewModel model)
        {
            if (model.ogrId != null)
            {
                var transaction = _db.Database.BeginTransaction();
                try
                {
                    var iletisim = _db.Iletisim.FirstOrDefault(a => a.ID == model.iletisimId);
                    iletisim.Adres = model.adres;
                    iletisim.Il = model.il;
                    iletisim.Ilce = model.ilce;
                    iletisim.Email = model.email;
                    iletisim.GSM = model.gsm.ToString();
                    _db.Iletisim.Update(iletisim);
                    _db.SaveChanges();
                    var kimlik = _db.Kimlik.FirstOrDefault(a => a.ID == model.kimlikId);

                    kimlik.Ad = model.ad;
                    kimlik.Soyad = model.soyad;
                    kimlik.DogumTarihi = DateTime.Parse(model.dogumTarihi);
                    kimlik.TCNO = model.tcno;
                    kimlik.DogumYeri = model.dogumYeri;
                    _db.Kimlik.Update(kimlik);
                    _db.SaveChanges();

                    var ogrenci = _db.Ogrenci.FirstOrDefault(a => a.ID == model.ogrId);

                    ogrenci.OgrNo = model.ogrNo;

                    ogrenci.MufredatID = model.mufredatId;
                    _db.Ogrenci.Update(ogrenci);
                    _db.SaveChanges();

                    var kullanici = _db.Kullanicilar.FirstOrDefault(a => a.ID == model.kullaniciId);

                    kullanici.KullaniciAdi = model.kullaniciAdi;
                    if (model.sifre != null || model.sifre != "")
                        kullanici.Sifre = SecretHasher.Hash(model.sifre);
                    _db.Kullanicilar.Update(kullanici);
                    _db.SaveChanges();
                    transaction.Commit();


                    var list = _db.Ogrenci.Include(a => a.Mufredat).Include(a => a.Kimlik).ThenInclude(a => a.Iletisim).Include(a => a.Kimlik).ThenInclude(a => a.Kullanicilar).ToList();
                    return Ok(list);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return BadRequest("Hata olustu");
                }



            }
            else {
                var transaction = _db.Database.BeginTransaction();
                try
                {
                    var iletisim = _db.Iletisim.Add(new Iletisim()
                    {
                        Adres = model.adres,
                        Il = model.il,
                        Ilce = model.ilce,
                        Email = model.email,
                        GSM = model.gsm.ToString()
                    });
                    _db.SaveChanges();
                    var kimlik = _db.Kimlik.Add(new Kimlik()
                    {
                        Ad = model.ad,
                        Soyad = model.soyad,
                        DogumTarihi = DateTime.Parse(model.dogumTarihi),
                        IlatisimID = iletisim.Entity.ID,
                        TCNO = model.tcno,
                        DogumYeri = model.dogumYeri
                    });
                    _db.SaveChanges();
                    var ogrenci = _db.Ogrenci.Add(new Ogrenci()
                    {
                        OgrNo = model.ogrNo,
                        KimlikID = kimlik.Entity.ID,
                        MufredatID = model.mufredatId
                    });
                    _db.SaveChanges();
                    var kullanici = _db.Kullanicilar.Add(new Kullanicilar()
                    {
                        KimlikID = kimlik.Entity.ID,
                        Tur = 1,
                        KullaniciAdi = model.kullaniciAdi,
                        Sifre = SecretHasher.Hash(model.sifre)
                    });
                    _db.SaveChanges();
                    transaction.Commit();


                    var list = _db.Ogrenci.Include(a => a.Mufredat).Include(a => a.Kimlik).ThenInclude(a => a.Iletisim).Include(a => a.Kimlik).ThenInclude(a => a.Kullanicilar).ToList();
                    return Ok(list);
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    return BadRequest("Hata olustu");
                }


            }

        }

        Kullanicilar AuthenticateUser(LoginViewModel model)
        {

            Kullanicilar kullanici = _db.Kullanicilar.Include(a => a.Kimlik).FirstOrDefault(a => a.KullaniciAdi == model.username);
            if (kullanici != null && SecretHasher.Verify(model.password, kullanici.Sifre))
            {
                return kullanici;
            }
            return null;
        }

        string GenerateJWT(Kullanicilar model)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:SecretKey"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim("username", model.KullaniciAdi),
                new Claim("id", model.ID.ToString()),
                new Claim("name", model.Kimlik.Ad+" "+model.Kimlik.Soyad),
                new Claim("role",(model.Tur==0)?"Admin":"User"),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            };

            var token = new JwtSecurityToken(
                issuer: _config["Jwt:Issuer"],
                audience: _config["Jwt:Audience"],
                claims: claims,
                expires: DateTime.Now.AddDays(30),
                signingCredentials: credentials
            );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

    }
}
