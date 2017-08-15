import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AgmCoreModule} from '@agm/core';
import { AppComponent } from './app.component';
import { routing } from './app.routes';
import { Example1Component } from './example1/example1.component';
import { Example2Component } from './example2/example2.component';

@NgModule({
  declarations: [
    AppComponent,
    Example1Component,
    Example2Component
  ],
  imports: [
    BrowserModule,
    AgmCoreModule.forRoot({
      apiKey: 'AIzaSyBCS2tNRE4wd0_3lIsJ-8dtuz9eqWgHahc'
    }),
    routing
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
