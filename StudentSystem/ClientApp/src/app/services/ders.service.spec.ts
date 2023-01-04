import { TestBed } from '@angular/core/testing';

import { DersService } from './ders.service';

describe('DersService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: DersService = TestBed.get(DersService);
    expect(service).toBeTruthy();
  });
});
