package com.chainsys.walletapplication.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.chainsys.walletapplication.model.Transactions;

public class TransactionDetails implements RowMapper<Transactions>{

	@Override
	public Transactions mapRow(ResultSet rs, int rowNum) throws SQLException {
		Transactions transaction = new Transactions();
		transaction.setTransactionId(rs.getString("transaction_id"));
		transaction.setSenderWalletID(rs.getString("sender_wallet_id"));
		transaction.setReceiverWalletID(rs.getString("receiver_wallet_id"));
		transaction.setDateAndTime(rs.getString("DataAndTime"));
		transaction.setAmountTransfered(rs.getDouble("amount"));
		return transaction;
	}

}
