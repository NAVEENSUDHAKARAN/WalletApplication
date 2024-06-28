package com.chainsys.walletapplication.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.walletapplication.model.Users;

public class Mapper implements RowMapper<Users>{

	@Override
	public Users mapRow(ResultSet rs, int rowNum) throws SQLException {
		Users users = new Users();
		users.getFirstName();
		users.getLastName();
		users.getPassword();
		users.getEmail();
		return users;
	}

}
