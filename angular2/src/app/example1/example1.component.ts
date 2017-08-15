import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-example1',
  templateUrl: './example1.component.html',
  styles: []
})
export class Example1Component implements OnInit {

  constructor() {  }

  centerLat: number = 38.25486;
  centerLng: number = -85.7664;
  centerZoom:number = 6;

  lat: number = 38.25486;
  lng: number = -85.7664;

  ngOnInit() {
  }

}
