package com.chainsys.walletapplication.model;

import org.springframework.stereotype.Repository;

@Repository
public class GasRecharge {
	
	String gasProvider;
	String mobileNumber;
	double amount;
	
	public String getGasProvider() {
		return gasProvider;
	}
	public void setGasProvider(String gasProvider) {
		this.gasProvider = gasProvider;
	}
	public String getMobileNumber() {
		return mobileNumber;
	}
	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	
}
