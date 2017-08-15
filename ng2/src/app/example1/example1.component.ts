import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-example1',
  templateUrl: './example1.component.html',
  styles: []
})
export class Example1Component implements OnInit {

  constructor() {  }

  centerLat: number = 38.240768;
  centerLng: number = -85.724907;
  centerZoom:number = 18;

  title = "O'Shea's Irish Pub";
  lat: number = 38.240768;
  lng: number = -85.724907;

  ngOnInit() {
  }

}
