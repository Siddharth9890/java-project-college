package com.project;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import AllLayout.Flight;

public class Flights {
	public String name,id,code,type="NORMAL",totalSeats="";
	String table = "flight";
	Database db;
	public Flights(){
		this.totalSeats=this.name=this.id=this.code = "";
		db = new Database();
		
	}
	public Flights(String trnId) {
		db = new Database();
		String sql = "SELECT * FROM "+this.table+" WHERE id='"+trnId+"'";
		try {
			ResultSet result = this.db.statement.executeQuery(sql);
			while(result.next()) {
				this.name = result.getString("name");
				this.id = result.getString("id");
				this.type = result.getString("type");
				this.code = result.getString("code");
				this.totalSeats = result.getString("totalSeats");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void findFlight(String code) {
		db = new Database();
		String sql = "SELECT * FROM "+this.table+" WHERE code='"+code+"'";
		
		try {
			ResultSet result = this.db.statement.executeQuery(sql);
			while(result.next()) {
				System.out.println(result.getString("id"));
				this.name = result.getString("name");
				this.id = result.getString("id");
				this.type = result.getString("type");
				this.code = result.getString("code");
				this.totalSeats = result.getString("totalSeats");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public ArrayList<Flight> getAll() {
		ArrayList<Flight> trains = new ArrayList<Flight>();
		String sqlQuery = "SELECT * FROM " + this.table;
		try {
			ResultSet result = db.statement.executeQuery(sqlQuery);
			while(result.next()) {
				Flight temp = new Flight();
				temp.id = result.getString("id");
				temp.name = result.getString("name");
				temp.code = result.getString("code");
				temp.type = result.getString("type");
				temp.totalSeats = Integer.parseInt(result.getString("totalSeats"));
				trains.add(temp);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return trains;
	}
	public void Save() {
		if(this.id.equals("")) {
			this.CreateNew();
		}else {
			this.CreateNew();
		}
		
	}
	public void Delete (String trnId) {
		String sql = "DELETE FROM "+this.table+" WHERE id = '"+trnId+"'";
		try {
			this.db.statement.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/*Search Destinations trains*/
	
	public ArrayList<HashMap<String,String>> SearchTrainFromTo(String from,String to,String coach){
		ArrayList<HashMap<String,String>> trains = new ArrayList<HashMap<String,String>>();
		String sql = null;
		if(coach != null && !coach.equals("any")) {
			 sql = "SELECT journeys.*,flight.type as coach,flight.id as flightId,flight.name,flight.code,flight.type,flight.\"totalSeats\" FROM flight"
					+ " INNER JOIN journeys ON "
					+ " flight.code = journeys.\"flightId\""
					+ " WHERE journeys.\"fromLocation\" = '"+from+"'"
					+ " AND journeys.\"toLocation\" = '"+to+"'"
					+ " AND flight.type = '"+coach+"'"
					+ " ORDER BY name ASC";
		}else {
			 sql = "SELECT journeys.*,flight.type as coach,flight.id as flightId,flight.name,flight.code,flight.type,flight.\"totalSeats\"FROM flight"
					+ " INNER JOIN journeys ON "
					+ " flight.code = journeys.\"flightId\""
					+ " WHERE journeys.\"fromLocation\" = '"+from+"'"
					+ " AND journeys.\"toLocation\" = '"+to+"'"
					+ " ORDER BY name ASC";
		}
		
		try {
			System.out.println(sql);
			ResultSet result = this.db.statement.executeQuery(sql);
			while(result.next()) {
				System.out.println(result.getString("name"));
				HashMap<String,String> tempTrain = new HashMap<String,String>();
				tempTrain.put("name", result.getString("name"));
				tempTrain.put("id", result.getString("id"));
				tempTrain.put("type", result.getString("type"));
				tempTrain.put("flightId", result.getString("flightId"));
				tempTrain.put("code", result.getString("code"));
				tempTrain.put("departureTime", result.getString("departureTime"));
				tempTrain.put("status", result.getString("status"));
				tempTrain.put("price", result.getString("price"));
				tempTrain.put("totalSeats", result.getString("totalSeats"));
				
				trains.add(tempTrain);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return trains;
	}
	
	private int CreateNew() {
		String sqlQquery = "";
		sqlQquery = "INSERT INTO "+this.table+"(name,code,total_seat,type)"
				+ " VALUES('"+this.name+"','"+this.code+"','"+this.totalSeats+"','"+this.type+"')";
					
		try {
			return  this.db.statement.executeUpdate(sqlQquery,Statement.RETURN_GENERATED_KEYS);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			//System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return 0;
	}
}