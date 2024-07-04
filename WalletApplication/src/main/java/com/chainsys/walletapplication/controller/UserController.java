package com.chainsys.walletapplication.controller;

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
	WalletImpl walletImpl;

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

		if (!walletImpl.retrieveUserCred(users)) {
			walletImpl.setUserDetails(users);
			walletImpl.createAccount(account, walletImpl.getUserID(users));
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

		if (walletImpl.checkLogin(mail, password)) {
			session.setAttribute("userName", walletImpl.getUserName(users));
			session.setAttribute("userid", walletImpl.getUserID(users));
			int userId = walletImpl.getUserID(users);
			session.setAttribute("accountDetails", walletImpl.readAccountDetails(userId));
			session.setAttribute("userIdFromCards", walletImpl.getUserIdFromCards(userId));
			session.setAttribute("cardDetails", walletImpl.readCardDetails(userId));
			return "redirect:/LandingPage.jsp";
		} else {
			model.addAttribute("error", "Invalid Email or Password");
			return "LoginPage.jsp";
		}

	}
	
	@PostMapping("/CreateAccount")
	public String createAccount(@RequestParam("accountNumber") String accountNumber, @RequestParam("amount") double amount, 
			@RequestParam("password") String password, Model model) {
		int userId = walletImpl.getUserID(users);

		if(walletImpl.checkAccountNumber(userId, accountNumber) && walletImpl.checkPassword(userId, password)) {
			amount += walletImpl.getAvailableBalance(accountNumber);
			walletImpl.depositAmount(accountNumber, amount);
			double balance = walletImpl.getAvailableBalance(accountNumber);
			model.addAttribute("balance", balance);
			return "LandingPage.jsp";
		}
		else if(!walletImpl.checkPassword(userId, password))
		{
			
			model.addAttribute("message", "Invalid Password");
			return "DepositAmount.jsp";		
		}
		else if(!walletImpl.checkAccountNumber(userId,accountNumber))
		{
			model.addAttribute("message", "Invalid AccountNumber");
			return "DepositAmount.jsp";		
		}
		else if(!walletImpl.checkPassword(userId, password) && !walletImpl.checkAccountNumber(userId,accountNumber))
		{
			model.addAttribute("message", "Invalid AccountNumber and Password");
			return "DepositAmount.jsp";		
		}
		return "";
	}
	
	@PostMapping("AccountTransfer")
	public String accountTransfer(@RequestParam("recipientAccountNumber") String senderAccNo, @RequestParam("amountToSend") double amountToSend,
			@RequestParam("receiverWalletID") String receiverWalletId) throws ClassNotFoundException, SQLException {
		int userId = walletImpl.getUserID(users);
		
		if(walletImpl.checkWalletId(receiverWalletId) && walletImpl.checkAccountNumber(userId, senderAccNo)) {
			walletImpl.deductBankBalance(userId, amountToSend);
			amountToSend += walletImpl.getWalletBalance(receiverWalletId);
			walletImpl.updateWalletBalance(amountToSend, receiverWalletId);
			return "LandingPage.jsp";
		}
		return "";
	}
	
	@PostMapping("WalletTransfer")
	public String walletTransfer() {
		
		return "LandingPage.jsp";
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
