package com.chainsys.walletapplication.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.RowMapper;

import com.chainsys.walletapplication.model.BankAccounts;
import com.chainsys.walletapplication.model.Cards;

public class CardDetails implements RowMapper<Cards> {

	@Override
	public Cards mapRow(ResultSet rs, int rowNum) throws SQLException {
		Cards cards = new Cards();
		cards.setId(rs.getInt("user_id"));
		cards.setCardNumber(rs.getLong("cardnumber"));
		cards.setAppliedDate(rs.getString("applied_date"));
		cards.setExpiryDate(rs.getString("expiry_date"));
		cards.setCvv(rs.getInt("cvv"));
		return cards;
	}

}
