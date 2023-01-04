import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule} from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { RouterModule } from '@angular/router';

import { AppComponent } from './app.component';
import { NavMenuComponent } from './nav-menu/nav-menu.component';
import { HomeComponent } from './home/home.component';

import { CounterComponent } from './counter/counter.component';
import { FetchDataComponent } from './fetch-data/fetch-data.component';

import { LoginComponent } from './login/login.component';
import { UserHomeComponent } from './user-home/user-home.component';
import { AdminHomeComponent } from './admin-home/admin-home.component';


import { AuthGuard } from './guards/auth.guard';
import { AdminGuard } from './guards/admin.guard';

import { HttpInterceptorService } from './services/http-interceptor.service';
import { ErrorInterceptorService } from './services/error-interceptor.service';
import { AdminMufredatComponent } from './admin-mufredat/admin-mufredat.component';
import { AdminDersComponent } from './admin-ders/admin-ders.component';
import { AdminMufDersComponent } from './admin-mufders/admin-mufders.component';
import { UserDarsKayitComponent } from './user-drerskayit/user-drerskayit.component';

@NgModule({
  declarations: [
    AppComponent,
    NavMenuComponent,
    HomeComponent,
    LoginComponent,
    UserHomeComponent,
    UserDarsKayitComponent,
    AdminHomeComponent,
    AdminMufredatComponent,
    AdminDersComponent,
    AdminMufDersComponent,
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'ng-cli-universal' }),
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule.forRoot([
      { path: '', component: LoginComponent, pathMatch: 'full' },
      { path: 'login', component: LoginComponent },
      { path: 'user-home', component: UserHomeComponent, canActivate: [AuthGuard] },
      { path: 'admin-home', component: AdminHomeComponent, canActivate: [AdminGuard] },
      { path: 'admin-mufredat', component: AdminMufredatComponent, canActivate: [AdminGuard] },
      { path: 'admin-ders', component: AdminDersComponent, canActivate: [AdminGuard] },
      { path: 'admin-mufders', component: AdminMufDersComponent, canActivate: [AdminGuard] },
      { path: 'user-derskayit', component: UserDarsKayitComponent, canActivate: [AuthGuard] }
    ])
  ],
  providers: [{ provide: HTTP_INTERCEPTORS, useClass: HttpInterceptorService, multi: true },
  { provide: HTTP_INTERCEPTORS, useClass: ErrorInterceptorService, multi: true },
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
