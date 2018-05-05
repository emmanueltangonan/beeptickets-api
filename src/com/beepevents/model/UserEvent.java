package com.beepevents.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="user_event")
public class UserEvent {
	@Id
	@Column
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int ue_id;
	
	@Column
	private int event_id;
	
	@Column
	private String card_id;
	
	@Column
	private String seat_number;
	
	@Column
	private int is_valid;
	
	public UserEvent(){}
	
	public UserEvent(int event_id, String card_id, String seat_number) {
		this.event_id = event_id;
		this.card_id = card_id;
		this.seat_number = seat_number;
	}
	
	public int getUe_id() {
		return ue_id;
	}

	public void setUe_id(int ue_id) {
		this.ue_id = ue_id;
	}

	public int getEvent_id() {
		return event_id;
	}

	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}

	public String getCard_id() {
		return card_id;
	}
	
	public void setCard_id(String card_id) {
		this.card_id = card_id;
	}
	
	public String getSeat_number() {
		return seat_number;
	}
	
	public void setSeat_number(String seat_number) {
		this.seat_number = seat_number;
	}

	public int getIs_valid() {
		return is_valid;
	}

	public void setIs_valid(int is_valid) {
		this.is_valid = is_valid;
	}

	
}
