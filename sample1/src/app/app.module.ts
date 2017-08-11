import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Ng2MapModule} from 'ng2-map';
import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    Ng2MapModule.forRoot({apiUrl: 'https://maps.google.com/maps/api/js?key=AIzaSyBCS2tNRE4wd0_3lIsJ-8dtuz9eqWgHahc'})
   
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
