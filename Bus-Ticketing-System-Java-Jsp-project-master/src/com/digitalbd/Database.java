package com.digitalbd;
import java.sql.*;
public class Database {
	private String hostName = "jdbc:postgresql://localhost:5432/test";
	private String userName = "postgres";
	private String userPassword = "demo";
	public Statement statement;
	private Connection con;
	public Database() {
		this.con = null;
		this.statement = null;
		try {
			Class.forName("org.postgresql.Driver");
			this.con = DriverManager.getConnection(hostName,userName,userPassword);
			this.statement = this.con.createStatement();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
