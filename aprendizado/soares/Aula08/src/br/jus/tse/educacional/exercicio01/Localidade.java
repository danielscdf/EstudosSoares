package br.jus.tse.educacional.exercicio01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Localidade extends Uf{
	String localidade;
	
	public String getLocalidade() {
		return localidade;
	}

	public void setLocalidade(String localidade) {
		this.localidade = localidade;
	}

	public boolean isCapital() {
		return capital;
	}

	public void setCapital(boolean capital) {
		this.capital = capital;
	}

	boolean capital;
	
	//public List<String> buscarLocalidadesUFs(String nomeUF){
	public List<Localidade> buscarLocalidadesUFs(String nomeUF){
		try{
			Class.forName("org.postgresql.Driver");
		}catch(ClassNotFoundException e){
			e.printStackTrace();
			return null;
		}
		
		String url = "jdbc:postgresql://localhost:5432/postgres";
		String login = "postgres";
		String senha = "12345678";
		
		Connection con;
		try{
			con = DriverManager.getConnection(url, login, senha);
			String sql = "select b.no_bairro from endereco.bairro b join endereco.uf u on b.nu_uf = u.nu_uf where u.sg_uf = ? ";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, nomeUF);
			ResultSet rs = stmt.executeQuery();
			/*List<String> ufs = new ArrayList<String>();
			while (rs.next()) {
				String uf = rs.getString(1);
				ufs.add(uf);
			}*/
			List<Localidade> local = new ArrayList<Localidade>();
			while (rs.next()) {
				Localidade loc = new Localidade();
				loc.setLocalidade(rs.getString(1));
				local.add(loc);
			}
			stmt.close();
			con.close();
			return local;
		}catch(SQLException e){
			e.printStackTrace();
			return null;
		}
	}
}
