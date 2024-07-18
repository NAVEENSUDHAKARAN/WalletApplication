package com.chainsys.walletapplication.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.walletapplication.model.BankAccounts;

public class AccountDetail implements RowMapper<BankAccounts> {

	@Override
	public BankAccounts mapRow(ResultSet rs, int rowNum) throws SQLException {
		BankAccounts accounts = new BankAccounts();
		accounts.setUserId(rs.getInt("user_id"));
		accounts.setAccNo(rs.getString("account_number"));
		accounts.setPhoneNumber(rs.getString("phonenumber"));
		accounts.setDOB(rs.getString("dateofbirth"));
		accounts.setAadharNumber(rs.getLong("aadhaarnumber"));
		accounts.setAddress(rs.getString("residential_address"));
		accounts.setAmount(rs.getDouble("balance"));
		return accounts;
	}
}