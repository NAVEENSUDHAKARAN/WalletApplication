<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="com.chainsys.walletapplication.dao.WalletImpl" %>
<%@ page import="com.chainsys.walletapplication.model.Users" %>
<%@ page import="com.chainsys.walletapplication.model.BankAccounts" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Send Money</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <style>
        .container {
            width: 50%;
            margin: 30px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .form-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        label {
            width: 45%; 
            margin: 0;
        }

        input[type="text"],
        input[type="number"],
        input[type="password"],
        button {
            width: 45%; 
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            background-color: #3c445c;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #3c445c;
        }

        .custom-alert {
            width: 100%; 
            padding: 10px;
            text-align: center;
        }

        .btn-container {
            text-align: center; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Send Money</h1>

        <%
            HttpSession transfers = request.getSession();
            int id = (int) transfers.getAttribute("userid");
            ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
            WalletImpl walletImpl = (WalletImpl) context.getBean("walletImpl");
            List<Users> userDetails = walletImpl.readUserDetails(id);
            for(Users user : userDetails) {
        %>
        <form action="AccountTransfer" method="post"> 
            <div class="form-group">
                <label for="recipientName">Recipient Name:</label>
                <input type="text" id="recipientName" name="recipientName" value="<%= user.getFirstName() %>" required readonly="readonly">
            </div>
        <% } %>
        
        <% List<BankAccounts> accountDetails = walletImpl.readAccountDetails(id);
           for(BankAccounts accountInfo : accountDetails) {
        %>
            <div class="form-group">
                <label for="recipientWalletID">Recipient Account Number:</label>
                <input type="text" id="recipientWalletID" name="recipientAccountNumber" value="<%= accountInfo.getAccNo() %>" required readonly="readonly">
            </div>
        <% } %>
        
        <div class="form-group">
            <label for="amountToSend">Amount to Send:</label>
            <input type="number" id="amountToSend" name="amountToSend" step="1" min="0" required>
        </div>

        <div class="form-group">
            <label for="receiverWalletID">Receiver Wallet ID:</label>
            <input type="text" id="receiverWalletID" name="receiverWalletID" value="">
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        
        <div class="btn-container">
            <% String errorMessage = (String)request.getAttribute("invalidWalletIdMsg");
               if(errorMessage != null && !errorMessage.isEmpty()) {
            %>
            <div class="alert alert-danger custom-alert" role="alert">
                <%= errorMessage %>
            </div>
            <% } %>

            <button type="submit">Pay</button>
            <button type="button" onclick="window.location.href='LandingPage.jsp'">Cancel</button>
        </div>
        </form>
    </div>
    
    <script>
        // JavaScript code here
    </script>
</body>
</html>
