package model;

public class MemberDTO {
	private String id;
	private String name;
	private String pass;
	private String phone_number;
	private String cell_number;
	private String email;
	private String subs;
	private String address;
	private java.sql.Date regi_date;
	private String uflag;
	
	
	public String getSubs() {
		return subs;
	}
	public void setSubs(String subs) {
		this.subs = subs;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getPhone_number() {
		return phone_number;
	}
	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	public String getCell_number() {
		return cell_number;
	}
	public void setCell_number(String cell_number) {
		this.cell_number = cell_number;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public java.sql.Date getRegi_date() {
		return regi_date;
	}
	public void setRegi_date(java.sql.Date regi_date) {
		this.regi_date = regi_date;
	}
	public String getUflag() {
		return uflag;
	}
	public void setUflag(String uflag) {
		this.uflag = uflag;
	}
	
	
	
}
