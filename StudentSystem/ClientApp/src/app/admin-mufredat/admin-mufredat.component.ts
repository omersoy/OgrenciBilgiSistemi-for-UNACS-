
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
  templateUrl: './admin-mufredat.component.html',
  styleUrls: ['./admin-mufredat.component.css']
})
export class AdminMufredatComponent {

  mufredatForm: FormGroup;
  mufredatEditForm: FormGroup;

  public mufredatListesi: Mufredat[] = [];

  fetchMufredatData() {
    this.mufredatService.getMufredatData().subscribe(
      (result: Mufredat[]) => {
        console.log(result);
        this.mufredatListesi = result;

      }
    );
  }
  constructor(private formBuilder: FormBuilder, private mufredatService: MufredatService ) {
    this.fetchMufredatData();

  }
  ngOnInit() {

    this.mufredatForm = this.formBuilder.group({
   
      mufredatAdi: ['', Validators.required]
    });


    this.mufredatEditForm = this.formBuilder.group({
      mufredatId: ['', Validators.required],
      mufredatAdi: ['', Validators.required]

    });

  }
  get mufredatFormControl() { return this.mufredatForm.controls; }
  get mufredatEditFormControl() { return this.mufredatEditForm.controls; }


  submitted = false;
  loading = false;
onSubmit() {
    this.submitted = true;

  if (this.mufredatForm.invalid) {
      return;
    }

    this.loading = true;
    //debugger;
  this.mufredatService.addMufredat(this.mufredatForm.value)
    .subscribe(
      (result: Mufredat[]) => {
          console.log(result);
          this.mufredatListesi = result;

          this.loading = false;
          this.mufredatForm.reset();
          this.closeAddModal()
        },
        () => {
          this.loading = false;
          this.mufredatForm.setErrors({
            invalidLogin: true
          });
        });
  }

  onSubmitEdit() {
    this.submitted = true;

    if (this.mufredatEditForm.invalid) {
      return;
    }

    this.loading = true;
    this.mufredatService.addMufredat(this.mufredatEditForm.value)
      .subscribe(
        (result: Mufredat[]) => {
          console.log(result);
          this.mufredatListesi = result;

          this.loading = false;
          this.mufredatEditForm.reset();
          this.closeEditModal()
        },
        () => {
          this.loading = false;
          this.mufredatEditForm.setErrors({
            invalidLogin: true
          });
        });
  }

  displayEditStyle = "none";
  displayStyle = "none";
  showAddModal() {
    this.mufredatForm.reset();
    this.displayStyle = "block";
  }
  closeAddModal() {
    this.displayStyle = "none";
  }

  showEditModal(mufredat) {
    console.log(mufredat.mufredatAdi);
    this.mufredatEditForm.patchValue({
      mufredatId: mufredat.id,
      mufredatAdi: mufredat.mufredatAdi,
      
    });
   
    this.displayEditStyle = "block";
  }
  closeEditModal() {
    this.displayEditStyle = "none";
  }


}
