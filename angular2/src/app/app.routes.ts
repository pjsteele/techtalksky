import { ModuleWithProviders }  from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { Example1Component } from './example1/example1.component';
import { Example2Component } from './example2/example2.component';


// Route Configuration
export const routes: Routes = [
  { path: '1', component: Example1Component },
  { path: '2', component: Example2Component }
];

export const routing: ModuleWithProviders = RouterModule.forRoot(routes);