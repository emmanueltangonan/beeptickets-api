package com.beepevents.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SessionFactory;
import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.beepevents.model.Client;
import com.beepevents.model.Event;

@Component
@Transactional
public class EventDaoImpl implements EventDao {
	private final Logger logger = Logger.getLogger("Info");
	
	@Autowired
    private SessionFactory sessionFactory;

	@SuppressWarnings("unchecked")
	@Override
	public List<Event> getAllEvents(int client_id) {
		List<Event> events = new ArrayList<>();
		events = (List<Event>) sessionFactory.getCurrentSession().createQuery("FROM Event WHERE client_id = :id")
				.setParameter("id", client_id).getResultList();
		return events;
	}

	@SuppressWarnings("unchecked")
	@Override
	public int createEvent(Event event) {
		List<Event> events = new ArrayList<Event>();
		String sql = "FROM Event WHERE UPPER(cs_id)=:cs_id AND UPPER(client_id)=:client_id";
		events = (List<Event>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("cs_id", event.getCs_id())
				.setParameter("client_id", event.getClient_id())
				.getResultList();
		if(events.size() <= 0) {
			int id = (int)sessionFactory.getCurrentSession()
					.save(event);
			logger.info("Successfully created event");
			return id;
		} else {
			logger.error("Event cs_id already exists");
			return 0;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Event getEventById(int event_id) {
		String sql = "FROM Event WHERE id=:id";
		List<Event> events = (ArrayList<Event>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("id", event_id)
				.getResultList();
		if(events.size() > 0) {
			return events.get(0);
		} else {
			logger.error("Id does not exist");
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Event getEventByPasscode(String event_passcode) {
		String sql = "FROM Event WHERE event_passcode=:event_passcode";
		List<Event> events = (ArrayList<Event>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("event_passcode", event_passcode)
				.getResultList();
		if(events.size() > 0) {
			return events.get(0);
		} else {
			logger.error("Event passcode does not exist");
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Event getEventByClientIdCsId(int client_id, String cs_id) {
		String sql = "FROM Event WHERE client_id=:client_id AND cs_id=:cs_id";
		List<Event> events = (ArrayList<Event>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("client_id", client_id)
				.setParameter("cs_id", cs_id)
				.getResultList();
		if(events.size() > 0) {
			return events.get(0);
		} else {
			logger.error("No match for client_id: " + client_id + " and cs_id: " + cs_id);
			return null;
		}
	}
	

	
	

}
