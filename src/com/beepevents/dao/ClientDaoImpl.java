package com.beepevents.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SessionFactory;
import org.jboss.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.beepevents.model.Client;

@Component
@Transactional
public class ClientDaoImpl implements ClientDao {
	private final Logger logger = Logger.getLogger("Info");
	
	@Autowired
    private SessionFactory sessionFactory;
	
	@SuppressWarnings("unchecked")
	@Override
	public Client getAdmin(){
		String sql = "FROM Client WHERE email='admin@gmail.com'";
		List<Client> admins = (ArrayList<Client>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.getResultList();
		if(admins.size() > 0) {
			return admins.get(0);
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public int createClient(Client client) {
		String sql = "FROM Client WHERE email=:email";
		List<Client> clients = (ArrayList<Client>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("email", client.getEmail())
				.getResultList();
		if(clients.size() == 0) {
			int id = (int)sessionFactory.getCurrentSession()
					.save(client);
			logger.info("Successfully created user");
			return id;
		} else {
			logger.info("User is registered");
			return 0;
		}
	}

	@Override
	public Client updateClient(Client client) {
		sessionFactory.getCurrentSession()
		.update(client);
		
		return client;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Client getClientBySecretId(String secret_id) {
		List<Client> clients = new ArrayList<Client>();
		String sql = "FROM Client WHERE secret_id=:secret_id";
		clients = (List<Client>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("secret_id", secret_id)
				.getResultList();
		if(clients.size() > 0) {
			return clients.get(0);
		} else {
			logger.error("Access token does not exist");
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Client getClientById(int id) {
		List<Client> clients = new ArrayList<Client>();
		String sql = "FROM Client WHERE UPPER(id)=:id";
		clients = (List<Client>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("id", id)
				.getResultList();
		if(clients.size() > 0) {
			return clients.get(0);
		} else {
			logger.error("Id does not exist");
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Client getClientByPasscode(String passcode) {
		List<Client> clients = new ArrayList<Client>();
		String sql = "FROM Client WHERE UPPER(passcode)=:passcode";
		clients = (List<Client>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("passcode", passcode)
				.getResultList();
		if(clients.size() > 0) {
			return clients.get(0);
		} else {
			logger.error("Invalid passcode");
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public Client getClientByEmailPw(Client client) {
		List<Client> clients = new ArrayList<Client>();
		String sql = "FROM Client WHERE email=:email AND password=:password";
		clients = (List<Client>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("email", client.getEmail())
				.setParameter("password", client.getPassword())
				.getResultList();
		if(clients.size() > 0) {
			return clients.get(0);
		} else {
			logger.error("Invalid email or password");
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Client getClientByEmail(Client client) {
		List<Client> clients = new ArrayList<Client>();
		String sql = "FROM Client WHERE email=:email";
		clients = (List<Client>) sessionFactory.getCurrentSession()
				.createQuery(sql)
				.setParameter("email", client.getEmail())
				.getResultList();
		if(clients.size() > 0) {
			return clients.get(0);
		} else {
			logger.error("Email does not exist in database.");
			return null;
		}
	}
	
}
