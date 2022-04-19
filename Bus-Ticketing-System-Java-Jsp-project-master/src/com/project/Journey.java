package com.project;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import TicketSystemInterface.DatabaseModel;

public class Journey implements DatabaseModel {
	private String table_name = "journeys";
	public String id,fromLocation,toLocation,flightId,departureTime,status,price,seatRange;
	public Database db;
	public Journey() {
		id=fromLocation=toLocation=flightId=departureTime=status=price=seatRange="";
		db = new Database();
	}

	public Journey(String argId) {
		db = new Database();
		String sql = "SELECT * FROM "+this.GetTableName()+" WHERE id = '"+argId+"'";
		try {
			ResultSet result = this.db.statement.executeQuery(sql);
			if(result.next()) {
				this.id = result.getString("id");
				this.fromLocation = result.getString("fromLocation");
				this.toLocation = result.getString("toLocation");
				this.flightId = result.getString("flightId");
				this.departureTime = result.getString("departureTime");
				this.status = result.getString("status");
				this.price = result.getString("price");
				this.seatRange = result.getString("seatRange");
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	public ArrayList<HashMap<String,String>> getAll(String stationFrom ,String trainId){
		 ArrayList<HashMap<String,String>> list = new  ArrayList<HashMap<String,String>>();
		 String queryString = null;
		 if(trainId == null) {
			 queryString = "SELECT * FROM "+this.GetTableName() + " WHERE station_from ='"+stationFrom+"'"; 
		 }else {
			 queryString = "SELECT * FROM "+this.GetTableName() + " WHERE station_from ='"+stationFrom+"' AND train_id = '"+trainId+"'";
		 }
		 
		 try {
			ResultSet result = this.db.statement.executeQuery(queryString);
			
			while(result.next()) {
				HashMap<String,String> tempData = new HashMap<String,String>();
				tempData.put("fromLocation", result.getString("fromLocation"));
				tempData.put("id", result.getString("id"));
				tempData.put("toLocation", result.getString("toLocation"));
				tempData.put("flightId", result.getString("flightId"));
				tempData.put("departureTime", result.getString("departureTime"));
				tempData.put("status", result.getString("status"));
				tempData.put("price", result.getString("price"));
				tempData.put("seatRange", result.getString("seatRange"));
				list.add(tempData);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return list;
	}
	public ArrayList<HashMap<String,String>> getAll(String stationFrom){
		return this.getAll(stationFrom,null);
	}
	@Override
	public int Save() {
		int destinationId = 0;
		destinationId = this.InsertNew();
		return 0;
	}

	@Override
	public int Update() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void Delete() {
		String querySting = "DELETE FROM "+this.GetTableName()+ " WHERE id='"+this.id+"'";
		System.out.println(this.id);
		try {
			db.statement.executeUpdate(querySting);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public String GetTableName() {
		// TODO Auto-generated method stub
		return this.table_name;
	}
	
	private int InsertNew() {
		String sqlQury = "INSERT INTO "+this.GetTableName()+" (station_from,station_to,train_id,time,status,fare,seat_range,type) "
				+ " VALUES('"+this.fromLocation+"','"+this.toLocation+"','"+this.flightId+"','"+departureTime+"','"+status+"','"+price+"','"+"','"+seatRange+"','"+"')";
		try {
			return this.db.statement.executeUpdate(sqlQury,Statement.NO_GENERATED_KEYS);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
}
