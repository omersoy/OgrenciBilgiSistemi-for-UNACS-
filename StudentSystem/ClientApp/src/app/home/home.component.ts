import { Component } from '@angular/core';
import { AuthService } from '../services/auth.service';
import { User } from '../models/user';
import { UserRole } from '../models/roles';
import { Router } from '@angular/router';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
})
export class HomeComponent {
  isExpanded = false;
  userDataSubscription: any;
  userData = new User();
  userRole = UserRole;

  private router: Router;

  constructor(private authService: AuthService) {
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
    else {
      console.log('/login');
      this.router.navigate(['https://localhost:44463/login']);

    }

  }
}
