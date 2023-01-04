
import { Component, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { UserService } from '../services/user.service';
import { DersService  } from '../services/ders.service';
import { Ogrenci } from '../models/ogrenci';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Mufredat } from '../models/Mufredat';
import { DatePipe } from '@angular/common';
import { Iletisim } from '../models/Iletisim';
import { MufredatService } from '../services/mufredat.service';
import { Ders } from '../models/ders';
import { MufredatDers } from '../models/mufredatders';
import { DersKayit } from '../models/derskayit';

@Component({
  selector: 'app-admin-home',
  templateUrl: './user-drerskayit.component.html',
  styleUrls: ['./user-drerskayit.component.css']
  })
export class UserDarsKayitComponent {

  mfdForm: FormGroup;
  mfdEditForm: FormGroup;

  public dkListesi: DersKayit[] = [];
  public mufredatDersListesi: MufredatDers[] = [];

  fetchMyDersKayitData() {
    this.dersService.getMyDersKayitData().subscribe(
      (result: DersKayit[]) => {
        console.log(result);
        this.dkListesi = result;

      }
    );
  }
  fetchMyAccessDersData() {
    this.dersService.GetMyAccessDersData().subscribe(
      (result: MufredatDers[]) => {
        console.log(result);
        this.mufredatDersListesi = result;

      }
    );
  }
  constructor(private formBuilder: FormBuilder, private dersService: DersService, private mufredatService: MufredatService ) {
    this.fetchMyDersKayitData();
    this.fetchMyAccessDersData();
    //this.fetchDersData();

  }
  ngOnInit() {

    this.mfdForm = this.formBuilder.group({
   
      dersId: ['', Validators.required]
    });


  }
  get mfdFormControl() { return this.mfdForm.controls; }

  submitted = false;
  loading = false;
onSubmit() {
    this.submitted = true;

  if (this.mfdForm.invalid) {
      return;
    }

    this.loading = true;
    //debugger;
  this.dersService.addDersKayit(this.mfdForm.value)
    .subscribe(
      (result: DersKayit[]) => {
          console.log(result);
        this.dkListesi = result;

          this.loading = false;
          this.mfdForm.reset();
          this.closeAddModal()
        },
        () => {
          this.loading = false;
          this.mfdForm.setErrors({
            invalidLogin: true
          });
        });
  }

  displayStyle = "none";
  showAddModal() {
    this.mfdForm.reset();
    this.displayStyle = "block";
  }
  closeAddModal() {
    this.displayStyle = "none";
  }

}
