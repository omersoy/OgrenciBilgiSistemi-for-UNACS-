import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdminMufredatComponent } from './admin-mufredat.component';

describe('AdminMufredatComponent', () => {
  let component: AdminMufredatComponent;
  let fixture: ComponentFixture<AdminMufredatComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdminMufredatComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdminMufredatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
