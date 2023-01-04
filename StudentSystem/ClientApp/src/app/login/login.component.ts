import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';
import { User } from '../models/user';
import { UserRole } from '../models/roles';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  loading = false;
  loginForm: FormGroup;
  submitted = false;
  returnUrl: string;
  userRole = UserRole;

  userDataSubscription: any;
  userData = new User();


  constructor(private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private authService: AuthService) {

    this.userDataSubscription = this.authService.userData.asObservable().subscribe(data => {
      this.userData = data;

    });
  }

  ngOnInit() {
    if (this.userData.isLoggedIn) {
      if (this.userData.role == this.userRole.Admin) {
        this.router.navigate(['/admin-home']);
      }
      else {
        this.router.navigate(['/user-home']);
      }
    }
    
    this.loginForm = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });

  }

  get loginFormControl() { return this.loginForm.controls; }

  onSubmit() {
    this.submitted = true;

    if (this.loginForm.invalid) {
      return;
    }

    this.loading = true;
    const returnUrl = this.route.snapshot.queryParamMap.get('returnUrl') || '/';
    this.authService.login(this.loginForm.value)
      .subscribe(
        (result) => {
          if (result.userDetails.tur == 0) {
            this.router.navigate(['/admin-home']);
          }
          else {
            this.router.navigate(['/user-home']);
          }
          //this.router.navigate([returnUrl]);
        },
        () => {
          this.loading = false;
          this.loginForm.reset();
          this.loginForm.setErrors({
            invalidLogin: true
          });
        });
  }

}
