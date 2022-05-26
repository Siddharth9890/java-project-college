package com.project;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import AllLayout.Flight;
import TicketSystemInterface.DatabaseModel;

public class Booking implements DatabaseModel{
	// table name is booking
	private String tableName = "booking";
//	these local variables map to columns in database
	public String id, destinationId, bookingDate, journeyDate, flightId, seatNumbers, userId, numberOfSeat, paymentStatus, status, type;
	Database db;
	
//	default constructor to initialize values	
	public Booking() {
		db = new Database();
	}
	
//	find the booking by id
	/***
	 * 
	 * @param id
	 */
	public void findByBookingId(Long id) {
		String sql = "SELECT * FROM "+this.tableName+ " WHERE id = "+id;
		try {
			
			ResultSet result = this.db.statement.executeQuery(sql);
			while(result.next())
			{
				this.id=result.getString("id");
				this.destinationId=result.getString("destinationId");
				this.bookingDate=result.getString("bookingDate");
				this.journeyDate=result.getString("journeyDate");
				this.flightId=result.getString("flightId");
				this.seatNumbers=result.getString("seatNumbers");
				this.userId=result.getString("userId");
				this.numberOfSeat=result.getString("numberOfSeat");
				this.paymentStatus=result.getString("paymentStatus");
				this.status=result.getString("status");
				this.type=result.getString("type");
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
//	find by user id and not by booking id
	/***
	 * 
	 * @param userId
	 * @return
	 */
	public ResultSet FindByUser(String userId){
		ResultSet result = null;
		String sql = "SELECT * FROM "+this.tableName+ " WHERE \"userId\"='"+userId+"' ORDER BY id DESC";
		try {
			
			result = this.db.statement.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
//	
	/***
	 * 
	 * @param destination
	 * @param date
	 * @param totalSeat
	 * @return
	 */
	public HashMap<String,String> Find(String destination,String date,String totalSeat){
		HashMap<String,String> result = new HashMap<String,String>();
		result.put("message", "Seat Is Not Available!");
		result.put("is_avaiable","no");
		result.put("j_date", date);
		String query = null;
		query = "SELECT journeys.*,flight.name as flightName,flight.code as flightCode, flight.type as flightType,flight.\"totalSeats\" from journeys"
				+ " INNER JOIN flight ON"
				+ " journeys.\"flightId\" = flight.code"
				+ " WHERE journeys.id = '"+destination+"'";
		try {
			
			ResultSet resultset = this.db.statement.executeQuery(query);
			while(resultset.next()) {
				result.put("id",resultset.getString("id"));
				result.put("flightName",resultset.getString("flightName"));
				result.put("flightId",resultset.getString("flightId"));
				result.put("flightType",resultset.getString("flightType"));
				result.put("fromLocation",resultset.getString("fromLocation"));
				result.put("toLocation",resultset.getString("toLocation"));
				result.put("departureTime",resultset.getString("departureTime"));
				result.put("price",resultset.getString("price"));
				result.put("totalSeats",resultset.getString("totalSeats"));
				result.put("seatRange",resultset.getString("seatRange"));
				result.put("is_avaiable","yes");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

//	get all the info about booking and do the booking and also we need to subtract seats as well
	/***
	 * 
	 * @param journey
	 * @param flight
	 * @param userId
	 * @param date
	 * @param totalSeat
	 * @return
	 */
	public long BookNow(Journey journey,Flights flight,String userId,String date,String totalSeat) {
		long bookId = 0;
		this.seatNumbers=(Integer.parseInt(flight.totalSeats)-Integer.parseInt(totalSeat))+"";
		
		this.destinationId = journey.id;
		this.bookingDate = new Date().toLocaleString();
		this.journeyDate = new Date().toLocaleString();
		this.flightId = flight.code;
		this.userId = userId;
		this.numberOfSeat = totalSeat;
		this.paymentStatus = "INCOMPLETE";
		this.status = "SUCCESS";
		this.type = "BUSINESS";
		// Insert the seats
		String sql="UPDATE flight SET \"totalSeats\"= '"+this.seatNumbers+"' where flight.code ='"+flight.code+"'";
		String sqlBooking = "INSERT INTO booking(\"destinationId\",\"bookingDate\",\"journeyDate\",\"flightId\",\"seatNumbers\",\"userId\",\"numberOfSeat\",\"paymentStatus\",status,type)"
				+ " VALUES('"+this.destinationId+"','"+this.bookingDate+"','"+this.journeyDate+"','"+this.flightId+"','"+this.seatNumbers+"','"+this.userId+"','"+this.numberOfSeat+"','"+this.paymentStatus+"','"+this.status+"','"+this.type+"')";
		String findBooking="SELECT * from booking where \"userId\"= "+this.userId+" order by id desc limit 1";
		System.out.println(sqlBooking);
		try {
			
			 this.db.statement.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			
			 this.db.statement.executeUpdate(sqlBooking);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			
			ResultSet rs= this.db.statement.executeQuery(findBooking);
			while(rs.next())
				bookId=Integer.parseInt(rs.getString("id"));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return bookId;
	}
	
	
//	checks for seats are available or not
	/***
	 * 
	 * @param flight
	 * @param totalSeat
	 * @return
	 */
	public boolean IsAvailable(Flights flight,String totalSeat) {
		int seatNeed = Integer.parseInt(totalSeat);
		boolean isAvailable = true;
		
			
				
		if(Integer.parseInt(flight.totalSeats)-seatNeed<0)
		{
			isAvailable=false;
		}
			
		
		return isAvailable;
	}
	
	@Override
	public int Save() {return 0;}
	
	@Override
	public int Update() {return 0;}

	@Override
	public void Delete() {}
	
//	delete the booking using booking id
	/***
	 * 
	 * @param bookingId
	 */
	public void delete(int bookingId) {
		String sql = "DELETE FROM "+this.tableName+" WHERE id = '"+bookingId+"'";
		try {
			this.db.statement.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

	@Override
	public String GetTableName() {
		// TODO Auto-generated method stub
		return this.tableName;
	}
	
	
	
}
