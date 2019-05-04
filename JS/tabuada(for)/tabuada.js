/**
* JS - Aula7: Tabuada
*/

var valor = 7;

for(var i = 1; i<11;i++){
	document.write('<p>Tabuada do ' + i + ' = ' + valor * i + "</p>");
	for(var j = 1;j<=10;j++){
		document.write(i + ' x ' + j + ' = ' + i * j + "<br>");
	}
}