package com.beepevents.dao;

import java.util.List;

import com.beepevents.model.Event;

public interface EventDao {
	public List<Event> getAllEvents(int client_id);
	public Event getEventById(int event_id);
	public int createEvent(Event event);
	public Event getEventByPasscode(String event_passcode);
	public Event getEventByClientIdCsId(int client_id, String cs_id);
}
