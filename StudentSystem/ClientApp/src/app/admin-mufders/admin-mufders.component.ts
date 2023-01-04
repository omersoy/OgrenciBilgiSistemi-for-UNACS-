
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

@Component({
  selector: 'app-admin-home',
  templateUrl: './admin-mufders.component.html',
    styleUrls: ['./admin-mufders.component.css']
  })
export class AdminMufDersComponent {

  mfdForm: FormGroup;
  mfdEditForm: FormGroup;

  public mfdListesi: MufredatDers[] = [];
  public mufredatListesi: Mufredat[] = [];
  public dersListesi: Ders[] = [];

  fetchMfdData() {
    this.dersService.getMufredatDersData().subscribe(
      (result: MufredatDers[]) => {
        console.log(result);
        this.mfdListesi = result;

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
  fetchDersData() {
    this.dersService.getAktifDersData().subscribe(
      (result: Ders[]) => {
        console.log(result);
        this.dersListesi = result;

      }
    );
  }
  constructor(private formBuilder: FormBuilder, private dersService: DersService, private mufredatService: MufredatService ) {
    this.fetchMfdData();
    this.fetchMufredatData();
    this.fetchDersData();

  }
  ngOnInit() {

    this.mfdForm = this.formBuilder.group({
   
      dersId: ['', Validators.required],
      mufredatId: ['', Validators.required]
    });


    this.mfdEditForm = this.formBuilder.group({
      id: ['', Validators.required],
      dersId: ['', Validators.required],
      mufredatId: ['', Validators.required]

    });

  }
  get mfdFormControl() { return this.mfdForm.controls; }
  get mfdEditFormControl() { return this.mfdEditForm.controls; }


  submitted = false;
  loading = false;
onSubmit() {
    this.submitted = true;

  if (this.mfdForm.invalid) {
      return;
    }

    this.loading = true;
    //debugger;
  this.dersService.addMfd(this.mfdForm.value)
    .subscribe(
      (result: MufredatDers[]) => {
          console.log(result);
        this.mfdListesi = result;

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

  onSubmitEdit() {
    this.submitted = true;

    if (this.mfdEditForm.invalid) {
      return;
    }

    this.loading = true;
    this.dersService.addMfd(this.mfdEditForm.value)
      .subscribe(
        (result: MufredatDers[]) => {
          console.log(result);
          this.mfdListesi = result;

          this.loading = false;
          this.mfdEditForm.reset();
          this.closeEditModal()
        },
        () => {
          this.loading = false;
          this.mfdEditForm.setErrors({
            invalidLogin: true
          });
        });
  }

  displayEditStyle = "none";
  displayStyle = "none";
  showAddModal() {
    this.mfdForm.reset();
    this.displayStyle = "block";
  }
  closeAddModal() {
    this.displayStyle = "none";
  }

  showEditModal(mfd) {

    console.log(mfd);
    this.mfdEditForm.patchValue({
      id: mfd.id,
      dersId: mfd.dersID,
      mufredatId: mfd.mufredatID
    });
   
    this.displayEditStyle = "block";
  }
  closeEditModal() {
    this.displayEditStyle = "none";
  }
}
