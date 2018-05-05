package com.beepevents.dao;

import com.beepevents.model.Client;

public interface ClientDao {
	public int createClient(Client client);
	public Client getAdmin();
	public Client updateClient(Client client);
	public Client getClientById(int id);
	public Client getClientByEmailPw(Client client);
	public Client getClientByEmail(Client client);
	public Client getClientBySecretId(String secret_id);
	public Client getClientByPasscode(String passcode);
}
