package com.chainsys.walletapplication.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.walletapplication.mapper.AccountDetail;
import com.chainsys.walletapplication.mapper.AccountNumber;
import com.chainsys.walletapplication.mapper.BankBalance;
import com.chainsys.walletapplication.mapper.CardDetails;
import com.chainsys.walletapplication.mapper.CardUserID;
import com.chainsys.walletapplication.mapper.CheckLogin;
import com.chainsys.walletapplication.mapper.CheckPassword;
import com.chainsys.walletapplication.mapper.CheckWalletId;
import com.chainsys.walletapplication.mapper.GetEmail;
import com.chainsys.walletapplication.mapper.GetUserId;
import com.chainsys.walletapplication.mapper.GetUserName;
import com.chainsys.walletapplication.mapper.GetWalletBalance;
import com.chainsys.walletapplication.mapper.GetWalletId;
import com.chainsys.walletapplication.mapper.TransactionDetails;
import com.chainsys.walletapplication.mapper.UserDetails;
import com.chainsys.walletapplication.mapper.CheckCardDetails;
import com.chainsys.walletapplication.model.BankAccounts;
import com.chainsys.walletapplication.model.Cards;
import com.chainsys.walletapplication.model.Transactions;
import com.chainsys.walletapplication.model.Users;
import com.chainsys.walletapplication.model.Wallets;

@Repository
public class WalletImpl implements WalletDAO {

	@Autowired
	JdbcTemplate jdbcTemplate;

	static String password = "password";
	static String balanceText = "balance";
	static String mail = "email";
	static String walId = "wallet_id";

	Scanner scan = new Scanner(System.in);
	Random random = new Random();

	public int accountNumberGeneration() {
		String accountNumber = null;
		accountNumber = "1002024" + random.nextInt(100);
		return Integer.parseInt(accountNumber);
	}

	public Long transactionIdGenerator() {

		LocalDateTime currentDateandTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		String formattedDateTime = currentDateandTime.format(formatter);
		String transactionId = formattedDateTime + random.nextInt(1000);
		return Long.parseLong(transactionId);
	}

	public long digipayCardNumberGenerator() {
		String prefix = "10002024";
		StringBuilder strBuilder = new StringBuilder(prefix);
		for (int i = 1; i <= 8; i += 1) {
			strBuilder.append(random.nextInt(10));
		}
		return Long.parseLong(strBuilder.toString());
	}

	public int cvvGenerator() {
		StringBuilder strBuilder = new StringBuilder();
		for (int i = 1; i <= 3; i += 1) {
			strBuilder.append(random.nextInt(10));
		}
		return Integer.parseInt(strBuilder.toString());
	}

	public void setUserDetails(Users user) {
		String query = "insert into users values (?,?,?,?,?)";
		Object[] params = { 0, user.getFirstName(), user.getLastName(), user.getPassword(), user.getEmail() };
		jdbcTemplate.update(query, params);
		System.out.println("Inserted Successfully!!!");
	}

	public boolean retrieveUserCred(Users user) throws EmptyResultDataAccessException {
		String query = "SELECT email FROM users WHERE email = ?";
		try {
			System.out.println("in retrieve user cred");
			return jdbcTemplate.queryForObject(query, new GetMail(), user.getEmail()) != null;
		} catch (IncorrectResultSizeDataAccessException e) {
			return false;
		}
	}

	public boolean checkLogin(String email, String password) {
		String query = "SELECT email, password FROM users WHERE email = ? AND password = ?";
		Object[] params = { email, password };
		try {
			System.out.println("in retrieve user cred");
			return jdbcTemplate.queryForObject(query, new CheckLogin(), params) != null;
			} catch (IncorrectResultSizeDataAccessException e) {
			return false;
		}
	}

	public int getUserID(Users user) {
		String query = "Select user_id from users where email = ?";
		System.err.println("in the get userid --->" + user.getEmail());
		try {
			return jdbcTemplate.queryForObject(query, new GetUserId(), user.getEmail());
		} catch (NullPointerException | IncorrectResultSizeDataAccessException e) {
			return 0;
		}
	}

	public Users getUserIDFromAccountTable(Users user) {
		String query = "SELECT user_id FROM users WHERE email = ?";
		return jdbcTemplate.queryForObject(query, new UserDetails(), user.getEmail());
	}
	
	public boolean getUserIdFromCards(int userId) {
		String query = "select user_id from cards where user_id = ?";
		System.err.println("in getUserIdFromCards" + userId);
		try {
			return jdbcTemplate.queryForObject(query, new CardUserID(), userId) != 0;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean checkUserId(int id) {
		String query = "SELECT user_id FROM bank_accounts WHERE user_id = ?";
		return jdbcTemplate.queryForObject(query, new UserDetails(), id) != null;
	}

	public void createAccount(BankAccounts detail, int id) {
		String query = "INSERT INTO bank_accounts (user_id, account_number, phonenumber, dateofbirth, aadhaarnumber, residential_address, balance) VALUES (?, ?, ?, ?, ?, ?, ?)";
		Object[] params = { id, accountNumberGeneration(), detail.getPhoneNumber(), detail.getDOB(),
				detail.getAadharNumber(), detail.getAddress(), 500 };
		jdbcTemplate.update(query, params);
	}

	public String getUserName(Users user) {
		String query = "SELECT first_name FROM users WHERE email = ?";
		return jdbcTemplate.queryForObject(query, new GetUserName(), user.getEmail());
	}
	
	public String getUserName(int id) {
		String query = "SELECT first_name FROM users WHERE user_id = ?";
		return jdbcTemplate.queryForObject(query, new GetUserName(), id);
	}

	public double getWalletBalance(int id) {
		String query = "SELECT balance FROM wallets WHERE user_id = ?";
		try {
			System.out.println("From Get wallet Balance : " + id);
			return jdbcTemplate.queryForObject(query, new GetWalletBalance(), id);
		} catch (NullPointerException | IncorrectResultSizeDataAccessException e) {
			return 0;
		}
	}
	
	public List<Users> readUserDetails(int id) {
		System.out.println("read details --->" + id);
		String query = "SELECT user_id, first_name, last_name, password, email FROM users WHERE user_id = ?";
		return jdbcTemplate.query(query, new UserDetails(), id);
	
	}
	
	public List<BankAccounts> readAccountDetails(int id) {
		String query = "SELECT user_id, account_number, phonenumber, dateofbirth, aadhaarnumber, residential_address, balance FROM bank_accounts WHERE user_id = ?";
		return jdbcTemplate.query(query, new AccountDetail(), id);
	}
	
	public List<Wallets> readWalletDetails(int id) {
		List<Wallets> walletDetailsList = new ArrayList<>();
		String query = "SELECT wallet_id, user_id, balance, qr FROM wallets WHERE user_id = ?";
		jdbcTemplate.query(query, new UserDetails(), id);
		return walletDetailsList;
	}
	
	public List<Wallets> readWalletDetails(String walletId) {
		List<Wallets> walletDetailsList = new ArrayList<>();
		String query = "SELECT wallet_id, user_id, balance, qr FROM wallets WHERE wallet_id = ?";
		jdbcTemplate.query(query, new UserDetails(), walletId);
		return walletDetailsList;
	}
	
	public List<Transactions> readTransactionHistory(String walletId) {
		String query = "SELECT transaction_id, sender_wallet_id, receiver_wallet_id, DataAndTime, amount "
				+ "FROM transactions WHERE sender_wallet_id = ? ORDER BY DataAndTime DESC";
		return jdbcTemplate.query(query, new TransactionDetails(), walletId);
		
	}
	
	public List<Cards> readCardDetails(int userId) {
		String query = "select user_id, cardnumber, applied_date, expiry_date, cvv, pin from cards where user_id = ?";
		return jdbcTemplate.query(query, new CardDetails(), userId);
	}
	
	public boolean checkAccountNumber(int id, String accNo) {
		String query = "SELECT account_number FROM bank_accounts WHERE user_id = ?";
		String dbAcc = jdbcTemplate.queryForObject(query, new AccountNumber(), id).toString();
		System.out.println("dbAcc --> " + dbAcc);
		System.out.println("Acc --> " + accNo);
		return accNo.equals(dbAcc);
	}
	
	public boolean checkPassword(int userId, String password) {
		String query = "SELECT password FROM users WHERE user_id = ?";
		String dbPassword =  jdbcTemplate.queryForObject(query, new CheckPassword(), userId);
		return password.equals(dbPassword);
	}

	public boolean checkPassword(String walletId, String password) {
		String query = "SELECT password FROM users WHERE email = ?";
		String dbPassword =  jdbcTemplate.queryForObject(query, new CheckPassword(), walletId);
		 return password.equals(dbPassword);
	}
	
	public void depositAmount(String accNo, double amount) {
		String query = "UPDATE bank_accounts SET balance = ? WHERE account_number = ?";
		Object[] params = {amount, accNo};
		jdbcTemplate.update(query, params);
	}
	
	public double getAvailableBalance(String accNo) {
		String query = "SELECT balance FROM bank_accounts WHERE account_number = ?";
		return jdbcTemplate.queryForObject(query, new BankBalance(), accNo);
	}
	
	public double getBalance(int id) {
		String query = "SELECT balance FROM bank_accounts WHERE user_id = ?";
		return jdbcTemplate.queryForObject(query, new BankBalance(), id);
	}
	
	public boolean checkWalletId(String walletId){
		String query = "SELECT wallet_id FROM wallets WHERE wallet_id = ?";
		try {
			return jdbcTemplate.queryForObject(query, new CheckWalletId(), walletId) != null;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public void deductBankBalance(int id, double amount) {
		String query = "UPDATE bank_accounts SET balance = ? WHERE user_id = ?";
		double updatedAmount = getBalance(id) - amount;
		jdbcTemplate.update(query, updatedAmount, id);	
	}
	
	public double getWalletBalance(String walletId) {
		String query = "SELECT balance FROM wallets WHERE wallet_id = ?";
		return jdbcTemplate.queryForObject(query, new GetWalletBalance(), walletId);
	}
	
	public void updateWalletBalance(double balance, String walletId) {
		String query = "update wallets set balance = ? where wallet_id = ?";
		double amountToUpdate = balance + getWalletBalance(walletId);
		Object[] params = {amountToUpdate, walletId};
		jdbcTemplate.update(query, params);
	}
	
	public void createWalletId(Wallets wallets) {
		String query = "INSERT INTO wallets (wallet_id, user_id, balance, qr) VALUES (?, ?, ?, ?)";
		Object[] params = {wallets.getWalletId(), wallets.getId(), 0, wallets.getImage()};
		jdbcTemplate.update(query, params);
	}

	public boolean checkWalletId(int id) {
		String query = "SELECT wallet_id FROM wallets WHERE user_id = ?";
		try {
			return jdbcTemplate.queryForObject(query, new CheckWalletId(), id) != null;
		}catch(Exception e) {
			return false;
		}
	}

	public String getWalletId(int id) {
		String query = "SELECT wallet_id FROM wallets WHERE user_id = ?";
		try {
			return jdbcTemplate.queryForObject(query, new GetWalletId(), id);
		}catch(Exception e) {
			return null;
		}
	}
	
	public String getEmail(int id){
		String query = "SELECT email FROM users WHERE user_id = ?";
		return jdbcTemplate.queryForObject(query, new GetEmail(), id);
	}
	
	
	public void deductWalletBalance(String walletId, double amount) {
		String query = "update wallets set balance = ? where wallet_id = ?";
		double updatedAmount = getWalletBalance(walletId) - amount;
		jdbcTemplate.update(query,updatedAmount, walletId);
	}
	
	public void updateTransactionHistory(String senderId, String receiverId, double amount) {
		String query = "INSERT INTO transactions (transaction_id, sender_wallet_id, receiver_wallet_id, DataAndTime, amount) VALUES (?,?,?,?,?)";
		Object[] params = {transactionIdGenerator(), senderId, receiverId, LocalDateTime.now(), amount};
		jdbcTemplate.update(query, params);
	}
	
	public void setCardDetails(Cards cards) {
		String query = "insert into cards (user_id, cardnumber, applied_date, expiry_date, cvv) values (?,?,?,?,?)";
		Object[] params = {cards.getId(), cards.getCardNumber(), cards.getAppliedDate(), cards.getExpiryDate(), cards.getCvv()};
		jdbcTemplate.update(query, params);
	}
	
	public void deductionForCardApply(int userId) {
		String query = "update wallets set balance = ? where user_id = ?";
		double updatedAmount = getWalletBalance(userId) - 200;
		jdbcTemplate.update(query, updatedAmount, userId);
	}

	@Override
	public List<Cards> checkCard(String cardNumber, String expiryYear, int cvv) {
		String query = "select cardnumber, expiry_date, cvv from cards where cardnumber =? and expiry_date = ? and cvv =?";
		Object[] params = {cardNumber, expiryYear, cvv};
		System.out.println("in check cards");
		try {
			return jdbcTemplate.query(query, new CheckCardDetails(), params);
		}catch(Exception e) {
			
			return null;
		}
	}
}