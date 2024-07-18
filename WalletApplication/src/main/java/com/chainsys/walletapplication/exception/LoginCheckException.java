package com.chainsys.walletapplication.exception;

import org.springframework.stereotype.Repository;

@Repository
public class LoginCheckException extends Exception {

		public LoginCheckException(String message) {
			super(message);
		}
		
		public LoginCheckException() {
			super();
		}
		
}
