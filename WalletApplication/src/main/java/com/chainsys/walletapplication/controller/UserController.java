package com.chainsys.walletapplication.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.time.YearMonth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chainsys.walletapplication.dao.DynamicQR;
import com.chainsys.walletapplication.dao.WalletImpl;
import com.chainsys.walletapplication.exception.CheckBankBalance;
import com.chainsys.walletapplication.exception.ExistingAccountException;
import com.chainsys.walletapplication.exception.LoginCheckException;
import com.chainsys.walletapplication.model.BankAccounts;
import com.chainsys.walletapplication.model.Cards;
import com.chainsys.walletapplication.model.DTHRecharge;
import com.chainsys.walletapplication.model.EBConsumerData;
import com.chainsys.walletapplication.model.GasRecharge;
import com.chainsys.walletapplication.model.InsuranceRecharge;
import com.chainsys.walletapplication.model.MobileRecharge;
import com.chainsys.walletapplication.model.Users;
import com.chainsys.walletapplication.model.Wallets;
import com.chainsys.walletapplication.model.WaterRecharge;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	WalletImpl walletImpl;

	@Autowired
	Users users;
	
	@Autowired
	Cards cards;
	
	@Autowired
	Wallets wallets;
	
	@Autowired
	MobileRecharge mobile;
	
	@Autowired
	EBConsumerData consumerData;
	
	@Autowired
	DTHRecharge dthRecharge;
	
	@Autowired
	GasRecharge gasRecharge;
	
	@Autowired
	WaterRecharge waterRecharge;
	
	@Autowired
	InsuranceRecharge insuranceRecharge;
	
	static String landingPageJsp = "LandingPage.jsp";
	static String depositAmountJsp = "DepositAmount.jsp";
	static String cardPaymentJsp = "CardPayment.jsp";
	
	@RequestMapping("/")
	public String home() {
		return landingPageJsp;
	}

	@PostMapping("/Register")
	public String register(@RequestParam("firstName") String fName, @RequestParam("lastName") String lName,
			@RequestParam("email") String email, @RequestParam("phoneNumber") String phoneNumber,
			@RequestParam("password") String password, @RequestParam("dateOfBirth") String dateOfBirth,
			@RequestParam("aadhaarNumber") long aadhaarNumber, @RequestParam("panNumber") String panNumber,
			@RequestParam("residentialAddress") String residentialAddress, Model model) throws ExistingAccountException {
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
			return "/CreateWalletId";
		} else {
			/*
			 * model.addAttribute("message", "Account Already Exist"); return
			 * "Register.jsp";
			 */
			throw new ExistingAccountException("Account Already Exist!!");
		}
	}

	@PostMapping("/Login")
	public String login(@RequestParam("email") String mail, @RequestParam("loginPassword") String password,
			HttpSession session, Model model) throws LoginCheckException {
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
			throw new LoginCheckException("invalid password");

		}

	}
	
	@PostMapping("/CreateWalletId")
	public String createWalletId(Model model) throws UnknownHostException {
		int userId = walletImpl.getUserID(users);
		
		String email = walletImpl.getEmail(userId);
		String[] splitedEmail = email.split("@");
		String walletId = splitedEmail[0] + "@digipay";
		
		model.addAttribute("walletID", walletId);
		if(!walletImpl.checkWalletId(userId))
		{
			InetAddress localhost = InetAddress.getLocalHost();
	        DynamicQR.generateQr(walletImpl.getUserName(userId),localhost.getHostAddress()+":8080/WalletApplication/MobileTransaction.jsp?id=" + userId+"&walletId="+ walletId,wallets);
	       				        
			wallets.setId(userId);
			wallets.setWalletId(walletId);
			
			walletImpl.createWalletId(wallets);
			return landingPageJsp;
		}
		return landingPageJsp;

	}
	
	@PostMapping("/DepositAmount")
	public String createAccount(@RequestParam("accountNumber") String accountNumber, @RequestParam("amount") double amount, 
			@RequestParam("password") String password, Model model) {
		int userId = walletImpl.getUserID(users);
	
		if(walletImpl.checkAccountNumber(userId, accountNumber) && walletImpl.checkPassword(userId, password)) {
			amount += walletImpl.getAvailableBalance(accountNumber);
			walletImpl.depositAmount(accountNumber, amount);
			double balance = walletImpl.getAvailableBalance(accountNumber);
			model.addAttribute("balance", balance);
		}
		else if(!walletImpl.checkPassword(userId, password))
		{
			
			model.addAttribute("message", "Invalid Password");
			return depositAmountJsp;		
		}
		else if(!walletImpl.checkAccountNumber(userId,accountNumber))
		{
			model.addAttribute("message", "Invalid AccountNumber");
			return depositAmountJsp;		
		}
		else if(!walletImpl.checkPassword(userId, password) && !walletImpl.checkAccountNumber(userId,accountNumber))
		{
			model.addAttribute("message", "Invalid AccountNumber and Password");
			return depositAmountJsp;		
		}
		return "";
	}
	
	@PostMapping("/AccountTransfer")
	public String accountTransfer(@RequestParam("recipientAccountNumber") String senderAccNo, @RequestParam("amountToSend") double amountToSend,
			@RequestParam("receiverWalletID") String receiverWalletId,@RequestParam("password") String password, Model model){
			int userId = walletImpl.getUserID(users);
		
		if(walletImpl.checkWalletId(receiverWalletId) && walletImpl.checkAccountNumber(userId, senderAccNo) && walletImpl.checkPassword(userId, password)) {
			walletImpl.deductBankBalance(userId, amountToSend);
			amountToSend += walletImpl.getWalletBalance(receiverWalletId);
			walletImpl.updateWalletBalance(amountToSend, receiverWalletId);
			return landingPageJsp;
		}
		else if(senderAccNo == null) {
			model.addAttribute("invalidWalletIdMsg", "Create Account");
			return "AccountTransferPage.jsp";
		}
		else if(!walletImpl.checkPassword(userId, password)) {
			model.addAttribute("invalidWalletIdMsg", "Invalid Password");
			return "AccountTransferPage.jsp";
		}
		else
		{
			 model.addAttribute("invalidWalletIdMsg", "Can't Find The WalletID");
			 return "AccountTransferPage.jsp";
		}
	}
	
	@PostMapping("/WalletTransfer")
	public String walletTransfer(@RequestParam("userId") int userId, @RequestParam("amountToSend") double amountToSend, @RequestParam("senderWalletId") String senderId,
				@RequestParam("receiverWalletId") String receiverId, @RequestParam("password") String password, Model model) throws CheckBankBalance {
		
		if(walletImpl.checkWalletId(receiverId) && walletImpl.checkWalletId(senderId) && walletImpl.checkPassword(userId, password) && (walletImpl.getWalletBalance(senderId)-amountToSend)>0) {
			double amountToUpdateHistory = amountToSend;
			if(amountToSend >= 100) {
				walletImpl.updateCredits(senderId);
			}
			walletImpl.deductWalletBalance(senderId, amountToSend);
			amountToSend += walletImpl.getWalletBalance(receiverId);
			walletImpl.updateWalletBalance(amountToSend, receiverId);
			
			walletImpl.updateTransactionHistory(senderId, receiverId, amountToUpdateHistory);
			return landingPageJsp;
		}
		else if(!walletImpl.checkPassword(userId, password)){
			model.addAttribute("alertMessage", "Invalid Password");
			return "WalletTransfer.jsp";
		}
		else if(!walletImpl.checkWalletId(receiverId)) {
			model.addAttribute("alertMessage", "Invalid WalletID");
			return "WalletTransfer.jsp";		
		}
		else if((walletImpl.getWalletBalance(senderId)-amountToSend)<=0){
			throw new CheckBankBalance("Unavailable Wallet Balance!");
		}
		return "";
	}
	
	@PostMapping("/CreateCard")
	public String createCard() {
		int userId = walletImpl.getUserID(users);
		
		walletImpl.deductionForCardApply(userId);
		cards.setId(userId);
		cards.setCardNumber(walletImpl.digipayCardNumberGenerator());
		YearMonth appliedDate = YearMonth.now();
		cards.setAppliedDate(appliedDate.toString());
		YearMonth expiryDate = appliedDate.plusYears(3);
		cards.setExpiryDate(expiryDate.toString());
		cards.setCvv(walletImpl.cvvGenerator());
		walletImpl.setCardDetails(cards);
		
		return "profile.jsp";
	}
	
	@PostMapping("/CardPayment")
	public String cardPayment(@RequestParam("cardNumber") String cardNumber, @RequestParam("expiryMonth") String expiryMonth, @RequestParam("expiryYear") String expiryYear,
			@RequestParam("cvv") int cvv, Model model, @RequestParam("totalAmount") double totalAmount) {
		int userId = walletImpl.getUserID(users);
		String trimmedCardNumber = cardNumber.replace(" ", "");

		String expiryYearMonth = expiryYear + "-" + expiryMonth;

		if(walletImpl.checkCard(trimmedCardNumber, expiryYearMonth, cvv)) {
			 walletImpl.deductWalletBalance(walletImpl.getWalletId(userId), totalAmount);
			 return landingPageJsp;
		}
		else {
					model.addAttribute("errorMessage", "Invalid Credentials");
					return cardPaymentJsp;
	}
		
	}
	
	@PostMapping("/MobileRecharge")
	public String mobileRecharge(@RequestParam("type") String rechargeType, @RequestParam("network") String network,@RequestParam("mobileNumber") String mobileNumber,@RequestParam("rechargePlan") double plan,
			Model model, HttpSession session) {
		
		mobile.setRechargeType(rechargeType);
		mobile.setNetwork(network);
		mobile.setPlan(plan);
		mobile.setMobileNumber(mobileNumber);
		double taxAmount = plan + (plan/100)*5;
		session.setAttribute("taxAmount", taxAmount);
		session.setAttribute("rechargeType", "mobileRecharge");
		session.setAttribute("rechargeDetails",mobile);
		
		return cardPaymentJsp;
	}
	
	@PostMapping("/ConsumerData")
	public String consumerData(@RequestParam("consumerName") String name, @RequestParam("consumerNumber") String consumerNumber, @RequestParam("serviceNumber") String serviceNumber,
			HttpSession session) {
		consumerData.setName(name);
		consumerData.setConsumerNumber(consumerNumber);
		consumerData.setSerialNumber(serviceNumber);
		session.setAttribute("ebDetails",consumerData);
		return "ElectricityPayment.jsp";
	}
	
	@PostMapping("/ElectricityRecharge")
	public String electricityRecharge(@RequestParam("billAmount") String amount, Model model,HttpSession session) {
		session.setAttribute("rechargeType", "electricityRecharge");
		double billAmount = Double.parseDouble(amount);
		consumerData.setBillAmount(billAmount);
		double taxAmount = billAmount + (billAmount/100)*5;
		session.setAttribute("taxAmount", taxAmount);
		return cardPaymentJsp;
	}
	
	@PostMapping("/DTHRecharge")
	public String dthRecharge(@RequestParam("operator") String operator, @RequestParam("customerId") int customerId,
			@RequestParam("amount") double amount, Model model,HttpSession session) {
		session.setAttribute("rechargeType", "dthRecharge");
		dthRecharge.setOperator(operator);
		dthRecharge.setCustomerId(customerId);
		dthRecharge.setAmount(amount);
		double taxAmount = amount + (amount/100)*5;
		session.setAttribute("taxAmount", taxAmount);
		session.setAttribute("dthDetails", dthRecharge);
		return cardPaymentJsp;
	}
	
	
	@PostMapping("/WaterRecharge")
	public String waterRecharge(@RequestParam("serviceProvider") String serviceProvider, @RequestParam("billNumber") String billNumber,
			@RequestParam("mobileNumber") String mobileNumber, @RequestParam("amount") double amount,Model model, HttpSession session) {
		session.setAttribute("rechargeType","waterRecharge");
		waterRecharge.setServiceProvider(serviceProvider);
		waterRecharge.setBillNumber(billNumber);
		waterRecharge.setMobileNumber(mobileNumber);
		waterRecharge.setAmount(amount);
		double taxAmount = amount + (amount/100)*5;
		session.setAttribute("taxAmount", taxAmount);
		session.setAttribute("waterRechargeDetails",waterRecharge);
		return cardPaymentJsp;
	}
	
	@PostMapping("/GasRecharge")
	public String gasRecharge(@RequestParam("gasProvider") String gasProvider, @RequestParam("mobileNumber") String mobileNumber,
			@RequestParam("amount") double amount, Model model,HttpSession session) {
		session.setAttribute("rechargeType","gasRecharge");
		gasRecharge.setGasProvider(gasProvider);
		gasRecharge.setMobileNumber(mobileNumber);
		gasRecharge.setAmount(amount);
		double taxAmount = amount + (amount/100)*5;
		session.setAttribute("taxAmount", taxAmount);
		session.setAttribute("gasRechargeDetails",gasRecharge);
		return cardPaymentJsp;	
	}
	
	@PostMapping("/InsurancePayment")
	public String insurancePayment(@RequestParam("insuranceCompany") String insuranceCompany,@RequestParam("policyNumber") String policyNumber,@RequestParam("dob") String dob,@RequestParam("amount") double amount ,
			@RequestParam("validDate") String localValidDate, HttpSession session) {
		System.err.println("In insurance payment");
		session.setAttribute("rechargeType","insuranceRecharge");
		insuranceRecharge.setInsuranceCompany(insuranceCompany);
		insuranceRecharge.setPolicyNumber(policyNumber);
		insuranceRecharge.setDob(dob);
		insuranceRecharge.setAmount(amount);
		String validDate = localValidDate;
		insuranceRecharge.setValidDate(validDate);
		double taxAmount = amount + (amount/100)*5;
		session.setAttribute("taxAmount", taxAmount);
		session.setAttribute("insuranceRechargeDetails",insuranceRecharge);
		return cardPaymentJsp;
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
