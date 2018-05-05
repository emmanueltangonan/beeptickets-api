package com.beepevents.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SessionFactory;
import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.beepevents.model.Client;
import com.beepevents.model.UserEvent;

@Component
@Transactional
public class UserEventDaoImpl implements UserEventDao {
	Logger logger = Logger.getLogger("Info");
	
	@Autowired
    private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	@Override
	public UserEvent getUserEvent(String card_id, int event_id) {
		List<UserEvent> userEvents = new ArrayList<UserEvent>();
		String sql = "FROM UserEvent WHERE card_id=:card_id AND event_id=:event_id";
		userEvents = (List<UserEvent>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("card_id", card_id)
				.setParameter("event_id", event_id)
				.getResultList();
		if(userEvents.size() > 0) {
			return userEvents.get(0);
		} else {
			logger.info("Card is not registered on the specified event");
			return null;
		}
	}

	@Override
	public UserEvent createOrUpdateUserEvent(UserEvent userEvent) {
		sessionFactory.getCurrentSession()
				.saveOrUpdate(userEvent);
		return userEvent;
	}

	@SuppressWarnings("unchecked")
	@Override
	public int createUserEvent(UserEvent userEvent) {
		String sql = "FROM UserEvent WHERE card_id=:card_id AND event_id=:event_id";
		List<UserEvent> userEvents = (ArrayList<UserEvent>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("card_id", userEvent.getCard_id())
				.setParameter("event_id", userEvent.getEvent_id())
				.getResultList();
		if(userEvents.size() == 0) {
			int id = (int)sessionFactory.getCurrentSession()
					.save(userEvent);
			logger.info("Successfully created userEvent");
			return id;
		} else {
			logger.error("UserEvent already exists");
			return 0;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<UserEvent> getAllUserEvents(int event_id) {
		String sql = "FROM UserEvent WHERE event_id=:event_id";
		List<UserEvent> userEvents = (ArrayList<UserEvent>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("event_id", event_id)
				.getResultList();
		
		return userEvents;
	}

	@Override
	public void deleteUserEvent(UserEvent userEvent) {
		sessionFactory.getCurrentSession().delete(userEvent);
	}

}
