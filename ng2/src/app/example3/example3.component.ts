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
  }

  public clear(): void {
    this.geoJson = null;
  }
  
  public loadStates(): void {
    this.loadGeoJson('assets/AllStates.geojson');
  }

  public loadEclipsePath(): void {
    this.loadGeoJson('assets/eclipse.geojson');
  }

  public loadEclipseStates(): void {
    this.loadGeoJson('assets/EclipseAndStates.geojson');
  }  

  private loadGeoJson(path: string): void {
    this.http.get(path)
    .map( (data)=> {
      this.geoJson = data.json();
    }).subscribe();
  }
}
