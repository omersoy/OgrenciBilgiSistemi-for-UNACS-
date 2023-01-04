import { Ders } from "./ders";
import { Mufredat } from "./Mufredat";

export class MufredatDers {
  id: number;
  dersId: number;
  mufredatId: number;
  dersler: Ders;
  mufredat: Mufredat;
}
