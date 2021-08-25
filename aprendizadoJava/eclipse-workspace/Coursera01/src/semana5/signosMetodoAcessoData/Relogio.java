package semana5.signosMetodoAcessoData;

public class Relogio {
	public static long agoraFixo = 0;
	public long agora() {
		if(agoraFixo == 0) {
			return System.currentTimeMillis();
		}else {
			return agoraFixo;
		}
	}
}
