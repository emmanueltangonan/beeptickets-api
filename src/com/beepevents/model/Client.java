package com.beepevents.model;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
@Table(name="client")
public class Client implements Serializable{
	
	private static final long serialVersionUID = -2827477566742241808L;
	
	@Id
	@Column
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int client_id;
	
	@Column
	private String name;
	
	@Column
	private String domain_name;
	
	@Column
	@NotEmpty(message = "Please enter your email.")
	private String email;
	
	@Column
	@NotEmpty(message = "Please enter your password.")
	private String password;
	
	@Column
	private Date reg_date;
	
	@Column
	private String secret_id;
	
	@Column
	private String passcode;
	
	public int getClient_id() {
		return client_id;
	}
	public void setClient_id(int client_id) {
		this.client_id = client_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDomain_name() {
		return domain_name;
	}
	public void setDomain_name(String domain_name) {
		this.domain_name = domain_name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public String getPasscode() {
		return passcode;
	}
	public void setPasscode(String passcode) {
		this.passcode = passcode;
	}
	public String getSecret_id() {
		return secret_id;
	}
	public void setSecret_id(String secret_id) {
		this.secret_id = secret_id;
	}
	
	@Override
	public String toString() {
		return "name: " + name + ", domain_name: " + domain_name + ", reg_date: " + reg_date + ", passcode: " + passcode;
	}
}
