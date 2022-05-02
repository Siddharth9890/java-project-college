package com.project;

import TicketSystemInterface.DatabaseModel;
import javax.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class User implements DatabaseModel {
    // these local variables map to columns in database
    public String name, email, phone, password, role, address,id;
    public Database db;
    // table name is users
    String tableName = "users";

//    default constructor to initialize values
    public User() {
        this.name = this.email = this.phone = this.password = this.role = this.address =this.id= "";
        this.db = new Database();
    }

//    parameterized constructor to get the user takes argId as param
    /***
     * 
     * @param argId
     */
    public User(String argId) {
        this.name = this.email = this.phone = this.password = this.role = this.address =this.id= "";
        this.db = new Database();
        this.getUser(argId);
    }

//    get user method takes id as param
    /***
     * 
     * @param id
     */
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
                this.address = result.getString("address");
                
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }
    }

//    check whether user exists or not using email or phone
    /***
     * 
     * @param phoneOrEmail
     * @return
     */
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

//    takes email and password and returns  user id
    /***
     * 
     * @param email
     * @param password
     * @return
     */
    public long login(String email, String password) {
        long userId = 0;
        String sqlQuery = "SELECT id from " + this.GetTableName() + " WHERE email='" + email + "' AND password='"
                + password + "'";
        try {
            ResultSet result = (ResultSet) this.db.statement.executeQuery(sqlQuery);
            if (result.next()) {
                userId = Long.parseLong(result.getString("id"));
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return userId;
    }

    
    /***
     * 
     * @param sessionArg
     */
    public void SetUserSession(HttpSession sessionArg) {
    	
        sessionArg.setAttribute("user_id", this.id);
    }

    
    @Override
    public int Save() {
        return 0;
    }

//    updates the user password,address,name and returns userId
    @Override
    public int Update() {
    	int userId = 0;
        String sqlQuery = "UPDATE " + this.GetTableName()
        + " SET name='"+this.name+"', password='"+this.password+"', address='"+this.address+"', role='"+this.role+
        "' WHERE email='"+this.email+"'";
        try {
            this.db.statement.execute(sqlQuery);
            userId=1;
        } catch (SQLException e) {
            userId=0;
            e.printStackTrace();
        }

        return userId;
        
    }

    @Override
    public void Delete() {}

    @Override
    public String GetTableName() {
        return this.tableName;
    }

    
//    register new user and returns the user Id
    public long registerNewUser() {
        long userId = 0;
        if (this.checkUserExistsOrNot(email) || this.checkUserExistsOrNot(phone)) {
            return userId;
        }
        String sqlQquery = "INSERT INTO " + this.GetTableName()
                + "(name,email,phone,password,address,role) "
                + " VALUES('" + this.name + "','" + this.email + "','" + this.phone + "','" + this.password + "','"
                + this.address + "','" + this.role + "')";
        try {
        	userId = this.db.statement.executeUpdate(sqlQquery,Statement.RETURN_GENERATED_KEYS);
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return userId;
    }
    
//    performs basic null checks 
    public String CheckRegisValidation() {
		String message = null;
		if(this.name.equals(null) || this.name.equals("")) {
			message = "User  Name Required!";
		}else if(this.email.equals(null) || this.email.equals("")) {
			message = "Email is Required!";
		}else if(this.password.equals(null) || this.password.equals("")) {
			message = "Password is Required!";
		}else if(this.phone.equals(null) || this.phone.equals("")) {
			message = "Phone is Required!";
		}
		return message;
	}
    

}
