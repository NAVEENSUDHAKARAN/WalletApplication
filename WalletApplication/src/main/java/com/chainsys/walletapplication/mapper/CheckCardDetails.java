package com.chainsys.walletapplication.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.walletapplication.model.Cards;

public class CheckCardDetails implements RowMapper<Cards>{

	@Override
	public Cards mapRow(ResultSet rs, int rowNum) throws SQLException {
		Cards cards = new Cards();
		cards.setCardNumber(rs.getLong("cardnumber"));
		System.out.println("from mapper ---> " + cards.getCardNumber());
		cards.setExpiryDate(rs.getString("expiry_date"));
		System.out.println(cards.getExpiryDate());
		cards.setCvv(rs.getInt("cvv"));
		System.out.println(cards.getCvv());
		return cards;
	}

}
