import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdminMufDersComponent } from './admin-mufders.component';

describe('AdminMufDersComponent', () => {
  let component: AdminMufDersComponent;
  let fixture: ComponentFixture<AdminMufDersComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdminMufDersComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdminMufDersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
