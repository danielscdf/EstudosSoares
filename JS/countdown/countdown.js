/**
* JS - Aula10: CountDown
*/

var check = false;

function xequeMate(){
	if (check == false){
		var timer1 = setInterval(function(){start()}, 1000);
		var count = 10;
		function start(){
			soundBeep();
		}
		check = true;
	}
	document.getElementById("banner").src="banner1.jpg";
	setTimeout("slide2()", intervalo);
}

function soundThunder(){
	var beep = new Audio();
	beep.src = "Thunder_Crack.mp3";
	beep.play();
}