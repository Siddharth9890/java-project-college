package com.project;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import AllLayout.Airport;
import AllLayout.Flight;
import TicketSystemInterface.DatabaseModel;

public class Airports implements DatabaseModel {
	String tableName;
	public String id, name, contact, address;
	Database db;
	public Airports() {
		id = name = contact= address = "";
		db = new Database();
		this.tableName = "airports";
	}
	public Airport getStation(String staionId) {
		Airport station = new Airport();
		String sqlQuery = "SELECT * FROM "+this.GetTableName()+" WHERE id='"+staionId+"'";
		ResultSet result;
		try {
			result = this.db.statement.executeQuery(sqlQuery);
			while(result.next()) {
				station.name = result.getString("name").toString();
				station.id = result.getString("id").toString();
				station.address = result.getString("address").toString();
				station.contact = result.getString("contact").toString();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return station;
	}
	public ArrayList<Airport> getAll() {
		ArrayList<Airport> stations = new ArrayList<Airport>();
		String sqlQuery = "SELECT * FROM " + this.GetTableName()+" ORDER BY name ASC";
		try {
			ResultSet result = db.statement.executeQuery(sqlQuery);
			while(result.next()) {
				Airport temp = new Airport();
				temp.id = result.getString("id");
				temp.name = result.getString("name");
				temp.contact = result.getString("contact");
				temp.address = result.getString("address");
				stations.add(temp);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return stations;
	}
	@Override
	public int Save() {
		int newId = this.InsertNew();
		return newId;
	}

	@Override
	public int Update() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void Delete() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String GetTableName() {
		// TODO Auto-generated method stub
		return this.tableName;
	}
	
	private int getId() {
		String query="SELECT MAX(\"id\") FROM \"airports\"";

		try {
			ResultSet result = this.db.statement.executeQuery(query);
			while(result.next())
				return result.getInt("max");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
		
	}
	
	private int InsertNew() {
		//System.out.println(getId());
		String  query = "INSERT INTO "+this.GetTableName()+ "(name, contact,address) "
				+ " VALUES('"+this.name+"','"+this.contact+"','"+this.address+"')";
		try {
			return this.db.statement.executeUpdate(query,Statement.RETURN_GENERATED_KEYS);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
		
	}

}
