package com.chainsys.walletapplication.dao;

import org.springframework.stereotype.Repository;

@Repository
public interface WalletDAO {

	public double getBalance(int id);
	public boolean checkWalletId(String walletId);
	public void deductBankBalance(int id, double amount);
}
