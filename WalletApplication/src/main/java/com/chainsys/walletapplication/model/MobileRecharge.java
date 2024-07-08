package com.chainsys.walletapplication.model;

import org.springframework.stereotype.Repository;

@Repository
public class MobileRecharge {
	String mobileNumber;
	String rechargeType;
	double plan;
	String network;
	public String getMobileNumber() {
		return mobileNumber;
	}
	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}
	public String getRechargeType() {
		return rechargeType;
	}
	public void setRechargeType(String rechargeType) {
		this.rechargeType = rechargeType;
	}
	public double getPlan() {
		return plan;
	}
	public void setPlan(double plan) {
		this.plan = plan;
	}
	public String getNetwork() {
		return network;
	}
	public void setNetwork(String network) {
		this.network = network;
	}
	
		
}
