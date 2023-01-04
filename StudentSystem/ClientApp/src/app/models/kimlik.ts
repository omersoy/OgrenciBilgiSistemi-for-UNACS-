import { Iletisim } from './Iletisim';
import { Kullanici } from './kullanici';
export class Kimlik {
  id: number;
  tcno: number;
  ad: string;
  soyad: string;
  dogumYeri: string;
  dogumTarihi: string;
  ilatisimId: number;
  iletisim: Iletisim;
  kullanici: Kullanici;
}
