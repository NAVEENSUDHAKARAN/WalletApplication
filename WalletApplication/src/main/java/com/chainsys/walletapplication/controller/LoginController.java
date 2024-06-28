package com.chainsys.walletapplication.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.walletapplication.dao.ServerManager;
import com.chainsys.walletapplication.model.BankAccounts;
import com.chainsys.walletapplication.model.Users;

@Controller
public class LoginController {

	@Autowired
	ServerManager manager;
	
	@RequestMapping("/")
	public String home() {
		return "LandingPage.jsp";
	}
	
	@PostMapping("/Register")
	public String register(@RequestParam("firstName") String fName, @RequestParam("lastName") String lName, @RequestParam("email") String email, @RequestParam("phoneNumber") String phoneNumber,
			@RequestParam("password") String password, @RequestParam("dateOfBirth") String dateOfBirth, @RequestParam("aadhaarNumber") long aadhaarNumber, @RequestParam("panNumber") String panNumber,
			@RequestParam("residentialAddress") String residentialAddress) {
		Users users = new Users();
		BankAccounts account = new BankAccounts();
		users.setFirstName(fName);
		users.setLastName(lName);
		users.setPassword(password);
		users.setEmail(email);
		manager.setUserDetails(users);
		account.setPhoneNumber(phoneNumber);
		account.setDOB(dateOfBirth);
		account.setAadharNumber(aadhaarNumber);
		account.setAddress(residentialAddress);
		manager.createAccount(account, 27);
		return "LoginPage.jsp";
	}
}
