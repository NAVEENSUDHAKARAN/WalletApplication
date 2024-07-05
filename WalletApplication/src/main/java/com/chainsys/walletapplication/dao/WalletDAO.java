package com.chainsys.walletapplication.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.chainsys.walletapplication.model.Cards;

@Repository
public interface WalletDAO {

	public double getBalance(int id);
	public boolean checkWalletId(String walletId);
	public void deductBankBalance(int id, double amount);
	public List<Cards> checkCard(String cardNumber, String expiryYear, int cvv);
}
