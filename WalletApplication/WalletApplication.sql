CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name varchar(255) not null,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE bank_accounts (
    user_id INT,
	account_number varchar(9) PRIMARY KEY,
    account_balance DECIMAL(15, 2) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

ALTER TABLE bank_accounts
ADD CONSTRAINT account_number UNIQUE (account_number);

alter table bank_accounts
ADD balance INT DEFAULT 500;

ALTER TABLE bank_accounts
DROP COLUMN account_balance;

CREATE TABLE wallets (
    wallet_id varchar(100) PRIMARY KEY,
    user_id INT,
    balance DECIMAL(15, 2) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_wallet_id varchar(100),
    receiver_wallet_id varchar(100),
    amount DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (sender_wallet_id) REFERENCES wallets(wallet_id),
    FOREIGN KEY (receiver_wallet_id) REFERENCES wallets(wallet_id)
);

CREATE TABLE cards (
    user_id INT,
    cardnumber VARCHAR(16) UNIQUE,
    applied_date DATE,
    expiry_date DATE,
    cvv INT,
    pin INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


use wallet_application;
select * from users;
select * from bank_accounts;
select * from wallets;
select * from transactions;
select * from cards;

delete from users where user_id = 36;
delete from bank_accounts where account_number = 100202460;
delete from bank_accounts where user_id = 31;
delete from wallets where user_id = 25;
delete from cards where user_id = 25; 
delete from transactions where amount = 300.00;
update wallets set balance = 0.00;

Alter table transactions
add column DataAndTime varchar(30) after receiver_wallet_id;

ALTER TABLE transactions
MODIFY transaction_id BIGINT AUTO_INCREMENT;

Alter Table Wallets
add column qr longblob;
drop table Cards;
SELECT balance FROM wallets WHERE user_id = 2;
SELECT user_id, first_name, last_name, password, email FROM users WHERE user_id = 2;
alter table cards
modify user_id int unique;