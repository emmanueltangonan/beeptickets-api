package com.beepevents.controller;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.beepevents.dao.ClientDao;
import com.beepevents.dao.EventDao;
import com.beepevents.dao.UserEventDao;
import com.beepevents.model.Client;
import com.beepevents.model.Event;
import com.beepevents.model.GenericResponse;
import com.beepevents.model.UserEvent;

@RestController
@RequestMapping("api/v1")
public class WebService {
	@Autowired
	private EventDao eventDao;
	
	@Autowired
	private ClientDao clientDao;
	
	@Autowired
	private UserEventDao userEventDao;

	//FOR USE BY ADMIN
	@RequestMapping(value = "/{secret_id}/events", method = RequestMethod.GET,headers="Accept=application/json") 
	public @ResponseBody Map<String,Object> getAllEvents(@PathVariable("secret_id") String secret_id) {
		
		Map<String,Object> response = new HashMap<>();
		Client client = clientDao.getClientBySecretId(secret_id);
		
		if(client != null){
			List<Event> eventList = eventDao.getAllEvents(client.getClient_id());
				response.put("res", new GenericResponse(true));
				response.put("data", eventList);
			}else{
				GenericResponse gr = new GenericResponse(false);
				gr.setMessage("AccessToken invalid");
				response.put("res", gr);
		}
		return response;
	}
	
	//FOR USE BY ADMIN
	@RequestMapping(value = "/{secret_id}/event/add", method = RequestMethod.POST, headers="Accept=application/json")
	public @ResponseBody Map<String,Object> addEvent(@RequestBody Event event, @PathVariable("secret_id") String secret_id){
		
		Map<String,Object> response = new HashMap<>();
		Client client = clientDao.getClientBySecretId(secret_id);
		GenericResponse gr = new GenericResponse(false);
		
		if(client != null){
			event.setClient_id(client.getClient_id());
			LocalDateTime start = LocalDateTime.parse(event.getStart());
			LocalDateTime end = LocalDateTime.parse(event.getEnd());
			event.setStart_datetime(start);
			event.setEnd_datetime(end);
			event.setEvent_passcode(generateRandomString());
			
			int event_id = eventDao.createEvent(event);
			Event newEvent = eventDao.getEventById(event_id);
			if(event_id == 0){
				gr.setMessage("Event cs_id already exists");
				response.put("res", gr);
			}else { //Successful creation
				response.put("res", new GenericResponse(true));
				response.put("data", newEvent);
			}
		}else{
			gr.setMessage("Secret id invalid");
			response.put("res", gr);
		}
		return response;
	}
	
	//FOR USE BY CLIENT ADMIN VIEW ALL EVENTS(called when getting into the app) used by "/events?passcode={enter passcode}"
	@RequestMapping(value = "/events", method = RequestMethod.GET, headers="Accept=application/json")
	public @ResponseBody Map<String,Object> getEventsByPasscode(@RequestParam("passcode") String passcode){
		
		Map<String,Object> response = new HashMap<>();
		Client client = clientDao.getClientByPasscode(passcode);

		if(client != null){
			List<Event> eventsList = eventDao.getAllEvents(client.getClient_id());
			response.put("res", new GenericResponse(true));
			response.put("data", eventsList);
		}else{
			GenericResponse gr = new GenericResponse(false);
			gr.setMessage("Invalid secret_id");
			response.put("res", gr);
		}
		return response;
	}
	
	//FOR USE BY SUPERADMIN IN ADDING USEREVENTS(PAYMENT APP)
	@RequestMapping(value = "/{admin_secret_id}/client/{client_id}/cs_id/{cs_id}/card/{card_id}/seatinfo/{seatinfo}", method = RequestMethod.POST, headers="Accept=application/json")
	public @ResponseBody Map<String,Object> getUserEvent(@PathVariable("client_id") int client_id, @PathVariable("cs_id") String cs_id,
	@PathVariable("card_id") String card_id, @PathVariable("admin_secret_id") String admin_secret_id,
	@PathVariable("seatinfo")String seat_number, UserEvent userEvent){
		
		Client admin = clientDao.getAdmin();
		Event event = eventDao.getEventByClientIdCsId(client_id, cs_id);
		Map<String,Object> response = new HashMap<>();
		if(admin.getSecret_id().equals(admin_secret_id)){
			userEvent.setIs_valid(1);
			userEvent.setSeat_number(seat_number);
			userEvent.setCard_id(card_id);
			userEvent.setEvent_id(event.getEvent_id());
			int id = userEventDao.createUserEvent(userEvent);
			
			if(id == 0){
				GenericResponse gr = new GenericResponse(false);
				gr.setMessage("Card already registered.");
				response.put("res", gr);
			}else{
				GenericResponse gr = new GenericResponse(true);
				gr.setMessage("Card successfully registered.");
				response.put("res", gr);
			}
		}else{
			GenericResponse gr = new GenericResponse(false);
			gr.setMessage("Invalid admin id.");
			response.put("res", gr);
		}
		return response;
	}
	
	//TAPPING ON ENTRANCE (CHECKING IF CARD IS REGISTERED)
	@RequestMapping(value = "/event/{event_id}/{card_id}", method = RequestMethod.GET, headers="Accept=application/json")
	public @ResponseBody Map<String,Object> checkUserEvent(@PathVariable("event_id") int event_id
			, @PathVariable("card_id") String card_id){
		
		Map<String,Object> response = new HashMap<>();
		UserEvent userEvent = userEventDao.getUserEvent(card_id, event_id);
		
		if(userEvent != null){
			if(userEvent.getIs_valid() == 0){ //not valid, already tapped
				response.put("valid", false);
				response.put("res", new GenericResponse(true));
				response.put("data", userEvent);
			}else{ //still valid
				response.put("valid", true);
				response.put("res", new GenericResponse(true));
				response.put("data", userEvent);
				invalidateBeepCard(userEvent);
			}
		}else{
			GenericResponse gr = new GenericResponse(false);
			gr.setMessage("Card is not registered for the specified event");
			response.put("res", gr);
		}
		return response;
	}
	
	// GET EVENT-SPECIFIC DETAILS BY ENTRANCE APP(used by /event?event_passcode={event_passcode})
	@RequestMapping(value = "/event", method = RequestMethod.GET, headers="Accept=application/json")
	public @ResponseBody Map<String,Object> getEventDetails(@RequestParam("event_passcode") String event_passcode){
		Map<String,Object> response = new HashMap<>();
		Event event = eventDao.getEventByPasscode(event_passcode);
		List<Event> eventList = new ArrayList<>();
		if(event != null){
			response.put("res", new GenericResponse(true));
			eventList.add(event);
			response.put("data", eventList);
		}else{
			GenericResponse gr = new GenericResponse(false);
			gr.setMessage("Event passcode is invalid.");
			response.put("res", gr);
		}
		return response;
	}
	
	//FOR USE BY ENTRANCE APP(invalidate beep card for the specified event)
	public void invalidateBeepCard(UserEvent userEvent){
		userEvent.setIs_valid(0);
		userEventDao.createOrUpdateUserEvent(userEvent);
	}
	
	public String generateRandomString(){
		SecureRandom random = new SecureRandom();
		return new BigInteger(80, random).toString(16);
	}
	
}
