import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient) { }



  getOgrenciListesi() {
    return this.http.get('/api/user/OgrenciListesi');
  }

  addOgrenci(ogrenciDetails) {
    debugger;
    return this.http.post<any>('/api/user/ogrenciEkle', ogrenciDetails)
      .pipe(map(response => {
        return response;
      }));
  }
  editMyIletisim(ogrenciDetails) {
    debugger;
    return this.http.post<any>('/api/user/IletisimiGuncelleData', ogrenciDetails)
      .pipe(map(response => {
        return response;
      }));
  }
  getMyData() {
    return this.http.get('/api/user/getMyData');
  }
}
