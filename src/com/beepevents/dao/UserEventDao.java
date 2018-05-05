package com.beepevents.dao;

import java.util.List;

import com.beepevents.model.UserEvent;

public interface UserEventDao {
	public UserEvent getUserEvent(String card_id, int event_id);
	public UserEvent createOrUpdateUserEvent(UserEvent userEvent);
	public int createUserEvent(UserEvent userEvent);
	public List<UserEvent> getAllUserEvents(int event_id);
	public void deleteUserEvent(UserEvent userEvent);
}	
