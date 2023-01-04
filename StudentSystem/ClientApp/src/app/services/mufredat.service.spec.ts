import { TestBed } from '@angular/core/testing';

import { MufredatService } from './mufredat.service';

describe('MufredatService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: MufredatService = TestBed.get(MufredatService);
    expect(service).toBeTruthy();
  });
});
