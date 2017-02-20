package com.chetan.source.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class User {

	private int roll_no;
	private String name;
	private String college_name;
	private double marks;
	private String email;
	
	public User() {
		super();
	}

	public User(int roll_no, String name, String college_name, double marks, String email) {
		super();
		this.roll_no = roll_no;
		this.name = name;
		this.college_name = college_name;
		this.marks = marks;
		this.email = email;
	}

	public int getRoll_no() {
		return roll_no;
	}

	public void setRoll_no(int roll_no) {
		this.roll_no = roll_no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCollege_name() {
		return college_name;
	}

	public void setCollege_name(String college_name) {
		this.college_name = college_name;
	}

	public double getMarks() {
		return marks;
	}

	public void setMarks(double marks) {
		this.marks = marks;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
