import { Ders } from "./ders";
import { Ogrenci } from "./ogrenci";

export class DersKayit {
  id: number;
  dersId: number;
  ogrenciId: number;
  createdDate: number;
  dersler: Ders;
  ogrenci: Ogrenci;
}
