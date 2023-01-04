import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdminDersComponent } from './admin-ders.component';

describe('AdminDersComponent', () => {
  let component: AdminDersComponent;
  let fixture: ComponentFixture<AdminDersComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdminDersComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdminDersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
