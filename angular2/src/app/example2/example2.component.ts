import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-example2',
  templateUrl: './example2.component.html',
  styles: []
})
export class Example2Component implements OnInit {

  constructor() { }

  centerLat: number = 34.5133;
  centerLng: number = -94.1629;
  centerZoom:number = 5;

  ngOnInit() {
  }

}
