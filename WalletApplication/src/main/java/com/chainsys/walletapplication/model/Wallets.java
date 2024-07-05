package com.chainsys.walletapplication.model;

import org.springframework.stereotype.Repository;

@Repository
public class Wallets {

	String walletId;
	int id;
	byte[] image;

	
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	public String getWalletId() {
		return walletId;
	}
	public void setWalletId(String walletId) {
		this.walletId = walletId;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
}
