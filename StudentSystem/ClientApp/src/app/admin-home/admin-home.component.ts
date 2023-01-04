
import { Component, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { UserService } from '../services/user.service';
import { MufredatService  } from '../services/mufredat.service';
import { Ogrenci } from '../models/ogrenci';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Mufredat } from '../models/Mufredat';
import { DatePipe } from '@angular/common';
import { Iletisim } from '../models/Iletisim';

@Component({
  selector: 'app-admin-home',
  templateUrl: './admin-home.component.html',
  styleUrls: ['./admin-home.component.css']
})
export class AdminHomeComponent {

  iletisim: any;
  ogrenciForm: FormGroup;
  ogrenciEditForm: FormGroup;
  public ogrenciler: Ogrenci[] = [];
  public mufredatListesi: Mufredat[] = [];
  fetchOgrenciData() {
    this.userService.getOgrenciListesi().subscribe(
      (result: Ogrenci[]) => {
        console.log(result);
        this.ogrenciler = result;

      }
    );
  }
  fetchMufredatData() {
    this.mufredatService.getMufredatData().subscribe(
      (result: Mufredat[]) => {
        console.log(result);
        this.mufredatListesi = result;

      }
    );
  }
  constructor(private formBuilder: FormBuilder,
    private userService: UserService, private mufredatService: MufredatService ) {
    this.fetchOgrenciData();
    this.fetchMufredatData();

  }
  ngOnInit() {



    this.ogrenciForm = this.formBuilder.group({
   
      ogrNo: ['', Validators.required],
      tcno: ['', Validators.required],
      ad: ['', Validators.required],
      soyad: ['', Validators.required],
      dogumYeri: ['', Validators.required],
      dogumTarihi: ['', Validators.required],
      adres: ['', Validators.required],
      il: ['', Validators.required],
      ilce: ['', Validators.required],
      email: ['', Validators.required],
      gsm: ['', Validators.required],
      kullaniciAdi: ['', Validators.required],
      sifre: ['', Validators.required],
      mufredatId: ['', Validators.required]
    });


    this.ogrenciEditForm = this.formBuilder.group({
      ogrId: ['', Validators.required],
      kimlikId: ['', Validators.required],
      iletisimId: ['', Validators.required],
      kullaniciId: ['', Validators.required],
      ogrNo: ['', Validators.required],
      tcno: ['', Validators.required],
      ad: ['', Validators.required],
      soyad: ['', Validators.required],
      dogumYeri: ['', Validators.required],
      dogumTarihi: ['', Validators.required],
      adres: ['', Validators.required],
      il: ['', Validators.required],
      ilce: ['', Validators.required],
      email: ['', Validators.required],
      gsm: ['', Validators.required],
      kullaniciAdi: ['', Validators.required],
      sifre: ['',],
      mufredatId: ['', Validators.required]
    });

  }
  get ogrenciFormControl() { return this.ogrenciForm.controls; }
  get ogrenciEditFormControl() { return this.ogrenciEditForm.controls; }


  submitted = false;
  loading = false;
  onSubmit() {
    this.submitted = true;

    if (this.ogrenciForm.invalid) {
      return;
    }

    this.loading = true;
    //debugger;
    this.userService.addOgrenci(this.ogrenciForm.value)
      .subscribe(
        (result: Ogrenci[]) => {
          console.log(result);
          this.ogrenciler = result;

          this.loading = false;
          this.ogrenciForm.reset();
          this.closeAddModal()
        },
        () => {
          this.loading = false;
          this.ogrenciForm.setErrors({
            invalidLogin: true
          });
        });
  }

  onSubmitEdit() {
    this.submitted = true;

    if (this.ogrenciEditForm.invalid) {
      return;
    }

    this.loading = true;
    this.userService.addOgrenci(this.ogrenciEditForm.value)
      .subscribe(
        (result: Ogrenci[]) => {
          console.log(result);
          this.ogrenciler = result;

          this.loading = false;
          this.ogrenciEditForm.reset();
          this.closeEditModal()
        },
        () => {
          this.loading = false;
          this.ogrenciEditForm.setErrors({
            invalidLogin: true
          });
        });
  }

  displayIletisimStyle = "none";
  displayEditStyle = "none";
  displayStyle = "none";
  showAddModal() {
    this.ogrenciForm.reset();
    this.displayStyle = "block";
  }
  closeAddModal() {
    this.displayStyle = "none";
  }
  getFormatedDate(date: Date, format: string) {
    const datePipe = new DatePipe('en-US');
    console.log(datePipe.transform(date, format));
    return datePipe.transform(date, format);
  }
  editObj: any;
  showEditModal(ogrenci) {
    console.log(ogrenci);
    this.ogrenciEditForm.patchValue({
      ogrId: ogrenci.id,
      kimlikId: ogrenci.kimlik.id,
      iletisimId: ogrenci.kimlik.iletisim.id,
      kullaniciId: ogrenci.kimlik.kullanicilar.id,
      ogrNo: ogrenci.ogrNo,
      tcno: ogrenci.kimlik.tcno,
      ad: ogrenci.kimlik.ad,
      soyad: ogrenci.kimlik.soyad,
      dogumYeri: ogrenci.kimlik.dogumYeri,
      dogumTarihi: this.getFormatedDate(ogrenci.kimlik.dogumTarihi, 'yyyy-MM-dd'),
      adres: ogrenci.kimlik.iletisim.adres,
      il: ogrenci.kimlik.iletisim.il,
      ilce: ogrenci.kimlik.iletisim.ilce,
      email: ogrenci.kimlik.iletisim.email,
      gsm: ogrenci.kimlik.iletisim.gsm,
      kullaniciAdi: ogrenci.kimlik.kullanicilar.kullaniciAdi,
      mufredatId: ogrenci.mufredatID
      
    });
   
    this.displayEditStyle = "block";
  }
  closeEditModal() {
    this.displayEditStyle = "none";
  }

  
  showIletisimModal(ogrenci) {
    console.log(ogrenci.kimlik.iletisim);
    this.iletisim = ogrenci.kimlik.iletisim
    this.displayIletisimStyle = "block";
  }
  closeIletisimModal() {
    this.displayIletisimStyle = "none";
  }

}
