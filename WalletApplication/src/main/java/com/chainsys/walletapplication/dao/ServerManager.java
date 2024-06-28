package com.chainsys.walletapplication.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.chainsys.walletapplication.mapper.Mapper;
import com.chainsys.walletapplication.model.BankAccounts;
import com.chainsys.walletapplication.model.Cards;
import com.chainsys.walletapplication.model.Transactions;
import com.chainsys.walletapplication.model.Users;
import com.chainsys.walletapplication.model.Wallets;

@Repository
public class ServerManager {

	@Autowired
	JdbcTemplate connect;

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
		Object[] params = {26, user.getFirstName(), user.getLastName(), user.getPassword(), user.getEmail() };
		connect.update(query, params);
		System.out.println("Inserted Successfully!!!");
	}

	public Users getUserID(Users user){
		String query = "Select user_id from users where email = ?";
		return connect.queryForObject(query, new Mapper(),user.getEmail());
	}

	public Users getUserIDFromAccountTable(Users user){
		String query = "SELECT user_id FROM users WHERE email = ?";
		return connect.queryForObject(query, new Mapper(),user.getEmail());
	}

	public boolean checkUserId(int id){
		String query = "SELECT user_id FROM bank_accounts WHERE user_id = ?";
		return connect.queryForObject(query, new Mapper(),id) != null;
	}

	public void createAccount(BankAccounts detail, int id){
		String query = "INSERT INTO bank_accounts (user_id, account_number, phonenumber, dateofbirth, aadhaarnumber, residential_address, balance) VALUES (?, ?, ?, ?, ?, ?, ?)";
		Object[] params = {id,  accountNumberGeneration(), detail.getPhoneNumber(), detail.getDOB(), detail.getAadharNumber(), detail.getAddress(), 500};
		connect.update(query, params);
	}

	public Users getUserName(Users user) throws ClassNotFoundException, SQLException {
		String query = "SELECT first_name FROM users WHERE email = ?";
		String userName = "";
		return connect.queryForObject(query, new Mapper(), user.getEmail());
	}
}