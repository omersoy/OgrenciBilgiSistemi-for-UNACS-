import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { UserDarsKayitComponent } from './user-drerskayit.component';

describe('UserDarsKayitComponent', () => {
  let component: UserDarsKayitComponent;
  let fixture: ComponentFixture<UserDarsKayitComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [UserDarsKayitComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(UserDarsKayitComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
