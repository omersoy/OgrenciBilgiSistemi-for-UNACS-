import { Mufredat } from './Mufredat';
import { Kimlik } from './Kimlik';

export class Ogrenci {
  id: number;
  ogrNo: string;
  kimlikId: number;
  Kimlik: Kimlik;
  mufredatId: number;
  mufredat: Mufredat;
}
