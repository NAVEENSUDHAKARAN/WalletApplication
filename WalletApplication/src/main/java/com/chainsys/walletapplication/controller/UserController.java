package com.chainsys.walletapplication.controller;

import java.io.IOException;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.walletapplication.dao.WalletImpl;
import com.chainsys.walletapplication.model.BankAccounts;
import com.chainsys.walletapplication.model.Users;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller

public class UserController {

	@Autowired
	WalletImpl manager;

	@Autowired
	Users users;
	
	@RequestMapping("/")
	public String home() {
		return "LandingPage.jsp";
	}

	@PostMapping("/Register")
	public String register(@RequestParam("firstName") String fName, @RequestParam("lastName") String lName,
			@RequestParam("email") String email, @RequestParam("phoneNumber") String phoneNumber,
			@RequestParam("password") String password, @RequestParam("dateOfBirth") String dateOfBirth,
			@RequestParam("aadhaarNumber") long aadhaarNumber, @RequestParam("panNumber") String panNumber,
			@RequestParam("residentialAddress") String residentialAddress, Model model) {
		BankAccounts account = new BankAccounts();
		users.setFirstName(fName);
		users.setLastName(lName);
		users.setPassword(password);
		String lowerCaseEmail = email.toLowerCase();
		users.setEmail(lowerCaseEmail);
		account.setPhoneNumber(phoneNumber);
		account.setDOB(dateOfBirth);
		account.setAadharNumber(aadhaarNumber);
		account.setAddress(residentialAddress);

		if (!manager.retrieveUserCred(users)) {
			manager.setUserDetails(users);
			manager.createAccount(account, manager.getUserID(users));
			return "LoginPage.jsp";
		} else {
			model.addAttribute("message", "Account Already Exist");
			return "Register.jsp";
		}
	}

	@PostMapping("/Login")
	public String login(@RequestParam("email") String mail, @RequestParam("loginPassword") String password,
			HttpSession session, Model model) {
		users.setEmail(mail);
		users.setPassword(password);

		if (manager.checkLogin(mail, password)) {
			session.setAttribute("userName", manager.getUserName(users));
			session.setAttribute("userid", manager.getUserID(users));
			int userId = manager.getUserID(users);
			session.setAttribute("accountDetails", manager.readAccountDetails(userId));
			session.setAttribute("userIdFromCards", manager.getUserIdFromCards(userId));
			session.setAttribute("cardDetails", manager.readCardDetails(userId));
			return "redirect:/LandingPage.jsp";
		} else {
			model.addAttribute("error", "Invalid Email or Password");
			return "LoginPage.jsp";
		}

	}
	
	@PostMapping("CreateAccount")
	public String createAccount(@RequestParam("accountNumber") String accountNumber, @RequestParam("amount") double amount, 
			@RequestParam("password") String password) {
		
		return "";
	}
	
	@PostMapping("/Logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession(false);
		
		if(session != null)
		{
			 session.invalidate();
		}
		return "redirect:/LandingPage.jsp";	
	}
}
