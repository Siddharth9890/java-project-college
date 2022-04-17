package com.project;

import TicketSystemInterface.DatabaseModel;
import javax.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

import com.mysql.*;

public class User implements DatabaseModel {
    // these local variables map to columns in database
    public String name, email, phone, password, role, address,id;
    public Database db;
    // table name is users
    String dbTable = "users";

    public User() {
        this.name = this.email = this.phone = this.password = this.role = this.address =this.id= "";
        this.db = new Database();
    }

    public User(String argId) {
        this.name = this.email = this.phone = this.password = this.role = this.address =this.id= "";
        this.db = new Database();
        this.getUser(argId);
    }

    public void getUser(String id) {
        String sqlQuery = "SELECT * FROM " + this.GetTableName() + " WHERE id='" + id + "'";
        try {
            ResultSet result = (ResultSet) this.db.statement.executeQuery(sqlQuery);
            while (result.next()) {
                this.name = result.getString("name");
                this.id = result.getString("id");
                this.email = result.getString("email");
                this.phone = result.getString("phone");
                this.role = result.getString("role");
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }

    public boolean checkUserExistsOrNot(String phoneOrEmail) {
        boolean isExist = false;
        String sqlQuery = "SELECT * FROM " + this.GetTableName() + " WHERE phone = '" + phoneOrEmail
                + "' OR email = '" + phoneOrEmail + "'";
        try {
            ResultSet result = (ResultSet) this.db.statement.executeQuery(sqlQuery);
            if (result.next())
                isExist = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isExist;
    }

    public long login(String email, String password) {
        long returnData = 0;
        String sqlQuery = "SELECT id from " + this.GetTableName() + " WHERE email='" + email + "' AND password='"
                + password + "'";
        try {
            ResultSet result = (ResultSet) this.db.statement.executeQuery(sqlQuery);
            if (result.next()) {
                returnData = Long.parseLong(result.getString("id"));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return returnData;
    }

    public void SetUserSession(HttpSession sessionArg) {
    	
        sessionArg.setAttribute("user_id", this.id);
    }

    @Override
    public int Save() {
        String sqlQuery = "INSERT";
        return 0;
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
        return this.dbTable;
    }

    

    public long registerNewUser() {
        long lastUserId = 0;
        if (this.checkUserExistsOrNot(email) || this.checkUserExistsOrNot(phone)) {
            return lastUserId;
        }
        
        String sqlQquery = "INSERT INTO " + this.GetTableName()
                + "(name,email,phone,password,address,role) "
                + " VALUES('" + this.name + "','" + this.email + "','" + this.phone + "','" + this.password + "','"
                + this.address + "','" + this.role + "')";

        try {
        	lastUserId = this.db.statement.executeUpdate(sqlQquery,Statement.RETURN_GENERATED_KEYS);
        	

        } catch (Exception e) {
            System.out.println("User.InsertNew: " + e.getMessage());
        }

        return lastUserId;
    }
    public String CheckRegisValidation() {
		String msmessage = null;
		if(this.name.equals(null) || this.name.equals("")) {
			msmessage = "User Full Name Required!";
		}else if(this.email.equals(null) || this.email.equals("")) {
			msmessage = "Email is Required!";
		}else if(this.password.equals(null) || this.password.equals("")) {
			msmessage = "Password is Required!";
		}else if(this.phone.equals(null) || this.phone.equals("")) {
			msmessage = "Phone is Required!";
		}
		return msmessage;
	}
    

}
