package com.beepevents.controller;

import java.io.IOException;
import java.math.BigInteger;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beepevents.dao.ClientDao;
import com.beepevents.dao.EventDao;
import com.beepevents.dao.UserEventDao;
import com.beepevents.model.Client;
import com.beepevents.model.Event;
import com.beepevents.model.FbUser;
import com.beepevents.model.UserEvent;
import com.beepevents.validator.Validator;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;

@Controller
@SessionAttributes(value={"event","client"})
public class MainController {
	@Autowired
	private ClientDao clientDao;
	
	@Autowired
	private EventDao eventDao;
	
	@Autowired
	private Validator validator;
	
	@Autowired
	private UserEventDao userEventDao;
	
	private final Logger logger = Logger.getLogger("Info");
	
	private RequestToken requestToken;
	
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	    binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,false));
	    binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
	}
	
	@RequestMapping("/sign-in")
	public ModelAndView renderSignIn(Client client){
		ModelAndView model = new ModelAndView("sign-in");
		
		return model;
	}
	
	@RequestMapping("/sign-up")
	public ModelAndView renderSignUp(Client client){
		ModelAndView model = new ModelAndView("sign-up");
		
		return model;
	}
	
	@RequestMapping("/sign-out")
	public String signOut(HttpServletRequest request, Client client, SessionStatus status){
		status.setComplete();
		request.getSession().invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/home")
	public String renderHome(Client client, HttpServletRequest request){
		return "home";
	}
	
	@RequestMapping("/dev")
	public ModelAndView renderUserPage(Client client){
		if(client.getEmail() != null){
			client = clientDao.getClientByEmailPw(client);
			ModelAndView model = new ModelAndView("dev");
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			String date = df.format(client.getReg_date());
			
			String identity = getIdentity(client.getEmail());
			
			Client clientResult = clientDao.getClientByEmailPw(client);
			model.addObject("client", clientResult);
			model.addObject("identity", identity);
			model.addObject("reg_date", date);
			return model;
		}else{
			return new ModelAndView("sign-in");
		}
		
	}
	
	@RequestMapping("/docs")
	public ModelAndView renderDocs(){
		ModelAndView model = new ModelAndView("docs");
		
		return model;
	}
	
	@RequestMapping("/events")
	public ModelAndView renderProducts(Client client){
		ModelAndView model = new ModelAndView("events");
		
		List<Event> eventList = eventDao.getAllEvents(client.getClient_id());
		model.addObject("client_id", client.getClient_id());
		model.addObject("eventList", eventList);
		model.addObject("name", client.getName());
		return model;
	}
	
	@RequestMapping("/sign-up/createAccount")
	public String registerClient(@RequestParam("password_confirm") String pw_confirm, @Valid Client client, BindingResult result,
			Errors errors){
		validator.validateEmail(client, errors);
		if(result.hasErrors()){
			return "sign-up";
		}else{
			if(client.getPassword().equals(pw_confirm)){
				client.setReg_date(new Date());
				client.setPasscode(generateRandomString());
				client.setSecret_id(generateRandomString());
				int id = clientDao.createClient(client);
				if(id == 0){
					errors.rejectValue("email", "error", "Email already in use.");
					return "sign-up";
				}else{
					return "redirect:dev";
				}
			}else{
				errors.rejectValue("password", "error", "Passwords do not match.");
				return "sign-up";
			}
		}
	}
	
	@RequestMapping("/authenticate")
	public String authenticate(@Valid Client client, BindingResult result, Errors errors, SessionStatus status, HttpSession session){
		
		validator.validateEmail(client, errors);
		if(result.hasErrors()){
			status.setComplete();
			return "sign-in";
		}else{
			client = clientDao.getClientByEmailPw(client);
			
			if(client != null){
				session.setAttribute("logged-in", "true");
				return "redirect:dev";
			}else{
				errors.rejectValue("password", "password", "Invalid email and/or password.");
				status.setComplete();
				return "sign-in";
			}
		}
	}
	
	@RequestMapping("/client/{client_id}/event/{event_id}")
	public ModelAndView renderUserEvents(Client client, Event event, @PathVariable("event_id") int event_id){
		ModelAndView model = new ModelAndView("userEvent");
		client = clientDao.getClientById(client.getClient_id());
		event = eventDao.getEventById(event.getEvent_id());
		List<UserEvent> userEventList = userEventDao.getAllUserEvents(event.getEvent_id());
		
		model.addObject("userEventList", userEventList);
		model.addObject(event);
		return model;
	}
	
	
	@RequestMapping("/userEvent/delete")
	public String deleteUserEvent(UserEvent userEvent, Client client, Event event){
//		System.out.println(userEvent.getUe_id());
		userEventDao.deleteUserEvent(userEvent);
		return "redirect:/client/" + client.getClient_id() + "/event/" + event.getEvent_id();
	}
	
	@RequestMapping("/updateClientInfo")
	public String updateClientInfo(Client client, RedirectAttributes ra){
		clientDao.updateClient(client);
		ra.addFlashAttribute("save_success", "true");
		return "redirect:dev";
	}
	
	@RequestMapping("/newSecretId")
	public String newSecretId(Client client){
		client.setSecret_id(generateRandomString());
		clientDao.updateClient(client);
		return "redirect:dev";
	}
	
	@RequestMapping("/newPasscode")
	public String newPasscode(Client client){
		client.setPasscode(generateRandomString());
		clientDao.updateClient(client);
		return "redirect:dev";
	}
	
	public String generateRandomString(){
		SecureRandom random = new SecureRandom();
		return new BigInteger(80, random).toString(16);
	}
	
	
	
	@RequestMapping(value="twitterLogin")
	public void twitterService(HttpServletRequest request, HttpServletResponse response) throws IOException{
		int index = request.getRequestURL().toString().lastIndexOf('/') + 1;
		String path = request.getRequestURL().toString().substring(0, index);
		
		 try {
			 Twitter twitter = new TwitterFactory().getInstance();
			 twitter.setOAuthConsumer("TU9RuZ9yE4RpGf4AQgIPwJtnM", "X44sWRSn4gASS7WDIZKHWO4yRUClo40WrOE7ZsrSTYXMrq86ed");
			 requestToken = twitter.getOAuthRequestToken(path + "/twitterAuth");
			 String authURL = requestToken.getAuthenticationURL();

			 response.sendRedirect(authURL);
		 } catch (TwitterException  twitterException) {
			 twitterException.printStackTrace();
		 }
	}
		
	@RequestMapping(value="/twitterAuth")
	public String twitterAuth(HttpServletRequest request, Client client) throws TwitterException{
		
		Twitter twitter = new TwitterFactory().getInstance();

        twitter.setOAuthConsumer("TU9RuZ9yE4RpGf4AQgIPwJtnM", "X44sWRSn4gASS7WDIZKHWO4yRUClo40WrOE7ZsrSTYXMrq86ed");
        String verifier = request.getParameter("oauth_verifier");
       
        AccessToken accessToken = twitter.getOAuthAccessToken(requestToken, verifier);
        twitter.setOAuthAccessToken(accessToken);
        twitter4j.User twitterUser = (twitter4j.User) twitter.verifyCredentials();
        
        client.setPassword("twitter-" + String.valueOf(twitterUser.getId()));
        client.setEmail("twitter-" + String.valueOf(twitterUser.getId()));
        client.setReg_date(new Date());
		client.setPasscode(generateRandomString());
		client.setSecret_id(generateRandomString());
		
		int id = clientDao.createClient(client);
		
		if(id == 0){
			logger.info("Client from twitter already exists");
		}else{
			logger.info("Twitter account registered");
		}
		return "redirect:/dev";
	}
	
	@RequestMapping(value="/fbLogin", method = RequestMethod.POST)
	public String fbLogin(Client client, FbUser fbUser) {
		
		client.setPassword("fb-" + fbUser.getId());
		client.setEmail("fb-" + fbUser.getId());
		client.setReg_date(new Date());
		client.setPasscode(generateRandomString());
		client.setSecret_id(generateRandomString());
		int id = clientDao.createClient(client);
		
		if(id==0) { //already exists
			logger.info("Client from fb already exists");
		} else {
			logger.info("Fb account registered");
		}
		return "redirect:dev";
	}
	
	@RequestMapping(value="/googleLogin", method = RequestMethod.POST)
	public String googleLogin(Client client) {
		
		client.setReg_date(new Date());
		client.setPasscode(generateRandomString());
		client.setSecret_id(generateRandomString());
		int id = clientDao.createClient(client);
		
		if(id==0) { //already exists
			logger.info("Client from google already exists");
		} else {
			logger.info("Google account successfully registered");
		}
		return "redirect:dev";
	}
	
	public String getIdentity(String email){
		String prefix = email.split("-")[0];
		
		switch(prefix){
			case "fb":
				return "Facebook Account";
			case "twitter":
				return "Twitter Account";
			case "google":
				return "Google Account";
			default:
				return email;
		}
	}
	
	
}
