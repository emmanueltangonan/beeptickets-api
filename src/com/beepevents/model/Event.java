package com.beepevents.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="event")
public class Event implements Serializable{

	private static final long serialVersionUID = -6562075553231207339L;
	
	@Id
	@Column
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int event_id;
	
	@Column
	private int client_id;
	
	@Column
	private String cs_id;
	
	@Column
	private String title;
	
	@Column
	private String img_url;
	
	@Transient
	private String start;
	
	@Transient
	private String end;

	@Column
	private LocalDateTime start_datetime;
	
	@Column
	private LocalDateTime end_datetime;
	
	@Column
	private String event_passcode;
	
	public Event(){}
	
	public Event(int client_id, String cs_id, String title, String img_url) {
		this.client_id = client_id;
		this.cs_id = cs_id;
		this.title = title;
		this.img_url = img_url;
	}

	public int getEvent_id() {
		return event_id;
	}
	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}
	public int getClient_id() {
		return client_id;
	}
	public void setClient_id(int client_id) {
		this.client_id = client_id;
	}
	
	public String getCs_id() {
		return cs_id;
	}

	public void setCs_id(String cs_id) {
		this.cs_id = cs_id;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImg_url() {
		return img_url;
	}
	public void setImg_url(String img_url) {
		this.img_url = img_url;
	}

	public LocalDateTime getStart_datetime() {
		return start_datetime;
	}

	public void setStart_datetime(LocalDateTime start_datetime) {
		this.start_datetime = start_datetime;
	}

	public LocalDateTime getEnd_datetime() {
		return end_datetime;
	}

	public void setEnd_datetime(LocalDateTime end_datetime) {
		this.end_datetime = end_datetime;
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getEvent_passcode() {
		return event_passcode;
	}

	public void setEvent_passcode(String event_passcode) {
		this.event_passcode = event_passcode;
	}

	
	
}
