import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { Header } from "./components/template/header/header";

@Component({
  selector: 'app-root',
  imports: [ Header],
  templateUrl: 'app.component.html',
})
export class App {
  protected title = 'frontend';
}
