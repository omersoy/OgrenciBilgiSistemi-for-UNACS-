import { Component, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { UserService } from '../services/user.service';
import { MufredatService } from '../services/mufredat.service';
import { Ogrenci } from '../models/ogrenci';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { Mufredat } from '../models/Mufredat';
import { DatePipe } from '@angular/common';
import { Iletisim } from '../models/Iletisim';


@Component({
  selector: 'app-user-home',
  templateUrl: './user-home.component.html',
  styleUrls: ['./user-home.component.css']
})
export class UserHomeComponent {

  submitted = false;
  loading = false;
  public ogrenciler: Ogrenci[] = [];
  ogrenciEditForm: FormGroup;
  fetchOgrenciData() {
    this.userService.getMyData().subscribe(
      (result: Ogrenci[]) => {
        console.log(result);
        this.ogrenciler = result;

      }
    );
  }
  constructor(private formBuilder: FormBuilder,
    private userService: UserService) {
    this.fetchOgrenciData();

  }

  ngOnInit() {


    this.ogrenciEditForm = this.formBuilder.group({
      iletisimId: ['', Validators.required],
      adres: ['', Validators.required],
      il: ['', Validators.required],
      ilce: ['', Validators.required],
      email: ['', Validators.required],
      gsm: ['', Validators.required]

    });

  }
  get ogrenciEditFormControl() { return this.ogrenciEditForm.controls; }




  onSubmitEdit() {
    this.submitted = true;

    if (this.ogrenciEditForm.invalid) {
      return;
    }

    this.loading = true;
    this.userService.editMyIletisim(this.ogrenciEditForm.value)
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
  displayEditStyle = "none";

  showEditModal(ogrenci) {
    console.log(ogrenci);
    this.ogrenciEditForm.patchValue({
      iletisimId: ogrenci.kimlik.iletisim.id,
      adres: ogrenci.kimlik.iletisim.adres,
      il: ogrenci.kimlik.iletisim.il,
      ilce: ogrenci.kimlik.iletisim.ilce,
      email: ogrenci.kimlik.iletisim.email,
      gsm: ogrenci.kimlik.iletisim.gsm,

    });

    this.displayEditStyle = "block";
  }
  closeEditModal() {
    this.displayEditStyle = "none";
  }

}
