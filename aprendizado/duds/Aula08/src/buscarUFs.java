import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class buscarUFs {

	public static void main(String[] args) {

		try {

			Class.forName("org.postgresql.Driver");

		} catch (ClassNotFoundException e) {

			System.out.println("Where is your PostgreSQL JDBC Driver? " + "Include in your library path!");
			e.printStackTrace();
			return;

		}

		String uf = "RJ";
		Connection connection = null;

		try {
			connection = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/postgres", "postgres", "123456");

			Statement st = connection.createStatement();

			ResultSet rs = st.executeQuery("select no_localidade from endereco.uf t1 , "
					+ "endereco.localidade t2 where t1.nu_uf = t2.nu_uf and t1.sg_uf = '"+uf+ "' order by no_localidade");

			while (rs.next()) {
				String no_localidade = rs.getString("no_localidade");
				System.out.println("Localidade de "+uf+": " + no_localidade);
			}

		} catch (SQLException e) {

			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			return;

		}

	}
}
