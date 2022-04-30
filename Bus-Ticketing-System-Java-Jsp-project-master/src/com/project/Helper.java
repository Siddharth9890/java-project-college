package com.project;

import java.util.HashMap;

public class Helper {
	public static String baseUrl = "http://localhost:8080/Train_Ticket_System/";
	public static String TestName="T ruon";
	public static String Currency = "INR";
	public static HashMap<String,String> TrainsCoach(){
		HashMap<String,String> coach = new HashMap<String,String>();
		coach.put("BUSINESS", "BUSINESS");
		coach.put("NORMAL", "NORMAL");
		
		return coach;
	}
}
