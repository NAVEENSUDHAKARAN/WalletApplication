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
		cards.setExpiryDate(rs.getString("expiry_date"));
		cards.setCvv(rs.getInt("cvv"));
		return cards;
	}

}
