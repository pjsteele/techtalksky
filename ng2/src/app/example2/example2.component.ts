import { Component, OnInit } from '@angular/core';
import { Http, Response } from '@angular/http';
import 'rxjs/add/operator/map';

@Component({
  selector: 'app-example2',
  templateUrl: './example2.component.html',
  styles: []
})
export class Example2Component implements OnInit {

  constructor(private http: Http) { }

  centerLat: number = 34.5133;
  centerLng: number = -94.1629;
  centerZoom:number = 5;
  markers: object[];

  ngOnInit() {
    this.http.get('assets/TopCities.json')
    .map( (data)=> {
      this.markers = data.json();
    }).subscribe();
  }
}
