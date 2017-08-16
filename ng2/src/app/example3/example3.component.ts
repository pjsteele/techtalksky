import { Component, OnInit } from '@angular/core';
import { Http, Response } from '@angular/http';
import 'rxjs/add/operator/map';

@Component({
  selector: 'app-example3',
  templateUrl: './example3.component.html',
  styles: []
})
export class Example3Component implements OnInit {

  constructor(private http: Http) { }

  centerLat: number = 34.5133;
  centerLng: number = -94.1629;
  centerZoom:number = 4;
  geoJson: object;

  ngOnInit() {
    this.http.get('assets/AllStates.geojson')
    .map( (data)=> {
      this.geoJson = data.json();
    }).subscribe();
  }
}
