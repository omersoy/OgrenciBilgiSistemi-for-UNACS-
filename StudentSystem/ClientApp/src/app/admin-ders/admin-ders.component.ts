
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

@Component({
  selector: 'app-admin-home',
  templateUrl: './admin-ders.component.html',
  styleUrls: ['./admin-ders.component.css']
})
export class AdminDersComponent {

  dersForm: FormGroup;
  dersEditForm: FormGroup;

  public dersListesi: Ders[] = [];

  fetchDersData() {
    this.dersService.getDersData().subscribe(
      (result: Ders[]) => {
        console.log(result);
        this.dersListesi = result;

      }
    );
  }
  constructor(private formBuilder: FormBuilder, private dersService: DersService ) {
    this.fetchDersData();

  }
  ngOnInit() {

    this.dersForm = this.formBuilder.group({
   
      dersAdi: ['', Validators.required],
      dersKodu: ['', Validators.required],
      durum: ['', Validators.required],
      kredi: ['', Validators.required],
    });


    this.dersEditForm = this.formBuilder.group({
      id: ['', Validators.required],
      dersAdi: ['', Validators.required],
      dersKodu: ['', Validators.required],
      durum: ['', Validators.required],
      kredi: ['', Validators.required],

    });

  }
  get dersFormControl() { return this.dersForm.controls; }
  get dersEditFormControl() { return this.dersEditForm.controls; }


  submitted = false;
  loading = false;
onSubmit() {
    this.submitted = true;

  if (this.dersForm.invalid) {
      return;
    }

    this.loading = true;
    //debugger;
  this.dersService.addDers(this.dersForm.value)
    .subscribe(
      (result: Ders[]) => {
          console.log(result);
          this.dersListesi = result;

          this.loading = false;
          this.dersForm.reset();
          this.closeAddModal()
        },
        () => {
          this.loading = false;
          this.dersForm.setErrors({
            invalidLogin: true
          });
        });
  }

  onSubmitEdit() {
    this.submitted = true;

    if (this.dersEditForm.invalid) {
      return;
    }

    this.loading = true;
    this.dersService.addDers(this.dersEditForm.value)
      .subscribe(
        (result: Ders[]) => {
          console.log(result);
          this.dersListesi = result;

          this.loading = false;
          this.dersEditForm.reset();
          this.closeEditModal()
        },
        () => {
          this.loading = false;
          this.dersEditForm.setErrors({
            invalidLogin: true
          });
        });
  }

  displayEditStyle = "none";
  displayStyle = "none";
  showAddModal() {
    this.dersForm.reset();
    this.displayStyle = "block";
  }
  closeAddModal() {
    this.displayStyle = "none";
  }

  showEditModal(ders) {
    console.log(ders);
    this.dersEditForm.patchValue({
      id: ders.id,
      dersAdi: ders.dersAdi,
      dersKodu: ders.dersKodu,
      durum: ders.durum,
      kredi: ders.kredi
    });
   
    this.displayEditStyle = "block";
  }
  closeEditModal() {
    this.displayEditStyle = "none";
  }
}
