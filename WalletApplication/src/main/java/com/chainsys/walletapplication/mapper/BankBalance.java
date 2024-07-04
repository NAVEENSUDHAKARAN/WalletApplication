package com.chainsys.walletapplication.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class BankBalance implements RowMapper<Double>{

	@Override
	public Double mapRow(ResultSet rs, int rowNum) throws SQLException {
		return rs.getDouble("balance");
	}

}
