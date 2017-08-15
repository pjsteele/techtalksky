import { Component, OnInit } from '@angular/core';
import { Ng2Map } from 'ng2-map';

@Component({
  selector: 'app-example1',
  templateUrl: './example1.component.html',
  styles: []
})
export class Example1Component implements OnInit {

  constructor(private _map:Ng2Map) {  }

  ngOnInit() {
    var debug = 0;
  }

}
