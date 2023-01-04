import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class DersService {

  constructor(private http: HttpClient) { }

  getDersData() {
    return this.http.get('/api/ders/DersListesi');
  }
  getAktifDersData() {
    return this.http.get('/api/ders/AktifDersListesi');
  }
  getMufredatDersData() {
    return this.http.get('/api/ders/MuredatDersListesi');
  }
  GetMyAccessDersData() {
    return this.http.get('/api/ders/GetMyAccessDers');
  }

  getMyDersKayitData() {
    return this.http.get('/api/ders/MyDersKayit');
  }
  addDersKayit(mufredatDetails) {
    return this.http.post<any>('/api/ders/DarsKayitiEkle', mufredatDetails)
      .pipe(map(response => {
        return response;
      }));
  }
  addDers(mufredatDetails) {
    return this.http.post<any>('/api/ders/dersEkle', mufredatDetails)
      .pipe(map(response => {
        return response;
      }));
  }
   addMfd(mfdDetails) {
     return this.http.post<any>('/api/ders/MufredatDersEkle', mfdDetails)
      .pipe(map(response => {
        return response;
      }));
  }


}
