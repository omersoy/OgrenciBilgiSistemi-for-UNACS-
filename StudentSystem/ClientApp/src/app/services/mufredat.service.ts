import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class MufredatService {

  constructor(private http: HttpClient) { }

  getMufredatData() {
    return this.http.get('/api/mufredat/MufredatListesi');
  }

  addMufredat(mufredatDetails) {
    return this.http.post<any>('/api/mufredat/mufredatEkle', mufredatDetails)
      .pipe(map(response => {
        return response;
      }));
  }
}
