package com.chainsys.walletapplication.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.walletapplication.model.Users;

public class UserDetails implements RowMapper<Users>{

	@Override
	public Users mapRow(ResultSet rs, int rowNum) throws SQLException {
		Users users = new Users();
		users.setUserId(rs.getInt("user_id"));
		users.setFirstName(rs.getString("first_name"));
		users.setLastName(rs.getString("last_name"));
		users.setPassword(rs.getString("password"));
		users.setEmail(rs.getString("email"));
		System.err.println("from mapper ---> " + users.getEmail());
		return users;
	}
}
