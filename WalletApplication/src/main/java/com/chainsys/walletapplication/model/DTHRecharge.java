package com.chainsys.walletapplication.model;

import org.springframework.stereotype.Repository;

@Repository
public class DTHRecharge {

	String operator;
	int customerId;
	double amount;
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public int getCustomerId() {
		return customerId;
	}
	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	
	
}
