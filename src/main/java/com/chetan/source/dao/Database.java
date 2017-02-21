package com.chetan.source.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.chetan.source.model.User;

public class Database {

	public List<User> getAllUsers() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List<User> userList = new ArrayList<>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/test","root","");
			
			if(!conn.isClosed())
				System.out.println("Connection successfull..!!!!");
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from practice");
			
			while(rs.next()){
				int roll_no = rs.getInt("roll_no");
				String name = rs.getString("name");
				String college_name = rs.getString("college_name");
				String email = rs.getString("email");
				Double marks = rs.getDouble("marks");
				
				User user = new User(roll_no, name, college_name, marks, email);
				userList.add(user);
			}
		} catch (ClassNotFoundException | SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		return userList;
	}
	
	public User getUser(int id) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		User user = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/test","root","");
			
			if(!conn.isClosed())
				System.out.println("Connection successfull..!!!!");
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from practice where roll_no = "+id);
			
			while(rs.next()){
				int roll_no = rs.getInt("roll_no");
				String name = rs.getString("name");
				String college_name = rs.getString("college_name");
				String email = rs.getString("email");
				Double marks = rs.getDouble("marks");
				
				user = new User(roll_no, name, college_name, marks, email);
			}
		} catch (ClassNotFoundException | SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		return user;
	}
	
	public void insertUser(User user) {
		Connection conn = null;
		Statement stmt = null;
		int rs = 0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/test","root","");
			
			if(!conn.isClosed())
				System.out.println("Connection successfull..!!!!");
			
			stmt = conn.createStatement();
			String sql = "insert into practice (name,college_name,email,marks) values ('"+user.getName()+"','"+user.getCollege_name()+"','"+user.getEmail()+"',"+user.getMarks()+")";
			rs = stmt.executeUpdate(sql);
		
		} catch (ClassNotFoundException | SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
	}
	
	public void deleteUser(int id) {
		Connection conn = null;
		Statement stmt = null;
		int rs = 0;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/test","root","");
			
			if(!conn.isClosed())
				System.out.println("Connection successfull..!!!!");
			
			stmt = conn.createStatement();
			rs = stmt.executeUpdate("delete from practice where roll_no = "+id);
		
		} catch (ClassNotFoundException | SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
	}
	
	public void updateUser(int id,User user) {
		Connection conn = null;
		Statement stmt = null;
		int rs = 0;
		String qry = "";
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost/test","root","");
			
			if(!conn.isClosed())
				System.out.println("Connection successfull..!!!!");
			
			stmt = conn.createStatement();
			
			if(!user.getName().equals(""))
			{
				qry = "update practice set name = '"+user.getName()+"' where roll_no = "+id;
				rs = stmt.executeUpdate(qry);
			}
			
			if(!user.getCollege_name().equals(""))
			{
				qry = "update practice set college_name = '"+user.getCollege_name()+"' where roll_no = "+id;
				rs = stmt.executeUpdate(qry);
			}
			
			if(!user.getEmail().equals(""))
			{
				qry = "update practice set email = '"+user.getEmail()+"' where roll_no = "+id;
				rs = stmt.executeUpdate(qry);
			}
			
			if(user.getMarks() != 0.00)
			{
				qry = "update practice set marks = "+user.getMarks()+" where roll_no = "+id;
				rs = stmt.executeUpdate(qry);
			}
		} catch (ClassNotFoundException | SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
	}
	
}
