<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.chainsys.walletapplication.model.MobileRecharge" %>
<%@ page import="com.chainsys.walletapplication.model.Users" %>
<%@ page import="com.chainsys.walletapplication.model.EBConsumerData" %>
<%@ page import="com.chainsys.walletapplication.model.DTHRecharge" %>
<%@ page import="com.chainsys.walletapplication.model.WaterRecharge" %>
<%@ page import="com.chainsys.walletapplication.model.GasRecharge" %>
<%@ page import="com.chainsys.walletapplication.model.InsuranceRecharge" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <title>CodePen - Checkout Form / Payment Gateway</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <script src="https://unpkg.com/akar-icons-fonts"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="https://cdn.jsdelivr.net/npm/qrcode@latest"></script>
</head>
<style>
:root {
    --field-border: 1px solid #eeeeee;
    --field-border-radius: 0.5em;
    --secondary-text: #aaaaaa;
    --sidebar-color: #f1f1f1;
    --accent-color: #2962ff;
  }
  
  * {
    box-sizing: border-box;
  }
  
  .flex {
    display: flex;
  }
  .flex-center {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .flex-fill {
    display: flex;
    flex: 1 1;
  }
  .flex-vertical {
    display: flex;
    flex-direction: column;
  }
  .flex-vertical-center {
    display: flex;
    align-items: center;
  }
  .flex-between {
    display: flex;
    justify-content: space-between;
  }
  .p-sm {
    padding: 0.5em;
  }
  .pl-sm {
    padding-left: 0.5em;
  }
  .pr-sm {
    padding-right: 0.5em;
  }
  .pb-sm {
    padding-bottom: 0.5em;
  }
  .p-md {
    padding: 1em;
  }
  .pb-md {
    padding-bottom: 1em;
  }
  .p-lg {
    padding: 2em;
  }
  .m-md {
    margin: 1em;
  }
  .size-md {
    font-size: 0.85em;
  }
  .size-lg {
    font-size: 1.5em;
  }
  .size-xl {
    font-size: 2em;
  }
  .half-width {
    width: 50%;
  }
  
  .pointer {
    cursor: pointer;
  }
  .uppercase {
    text-transform: uppercase;
  }
  .ellipsis {
    text-overflow: ellipsis;
    overflow: hidden;
  }
  
  .f-main-color {
    color: #2962ff;
  }
  .f-secondary-color {
    color: var(--secondary-text);
  }
  .b-main-color {
    background: var(--accent-color);
  }
  .numbers::-webkit-outer-spin-button,
  .numbers::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
  }
  
  body {
    font-size: 14px;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen",
      "Ubuntu", "Cantarell", "Fira Sans", "Droid Sans", "Helvetica Neue",
      sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    margin: 0;
    padding: 0;
  }
  .bod-3 {
    border-radius: 30px;
  }
  .main-back {
    background: #fff !important;
    display: flex;
    position: absolute;
    width: 100%;
    height: 100vh;
 
  }
  .header {
    padding-bottom: 1em;
  }
  
  .header .title {
    font-size: 1.2em;
  }
  .header .title span {
    font-weight: 300;
  }
  
  .card-data > div {
    padding-bottom: 1.5em;
  }
  .card-data > div:first-child {
    padding-top: 1.5em;
  }
  
  .card-property-title {
    display: flex;
    flex-direction: column;
    flex: 1 1;
    margin-right: 0.5em;
  }
  .card-property-title strong {
    padding-bottom: 0.5em;
    font-size: 0.85em;
  }
  .card-property-title span {
    color: var(--secondary-text);
    font-size: 0.75em;
  }
  .card-property-value {
    flex: 1 1;
  }
  
  .card-number {
    background: #fafafa;
    border: var(--field-border);
    border-radius: var(--field-border-radius);
    padding: 0.5em 1em;
  }
  .card-number-field * {
    line-height: 1;
    margin: 0;
    padding: 0;
  }
  .card-number-field input {
    width: 100%;
    height: 100%;
    padding: 0.5em 1rem;
    margin: 0 0.75em;
    border: none;
    color: #888888;
    background: transparent;
    font-family: inherit;
    font-weight: 500;
  }
  
  .timer span {
    background: #311b92;
    color: #ffffff;
    width: 1.2em;
    padding: 4px 0;
    display: inline-block;
    text-align: center;
    border-radius: 3px;
  }
  .timer span + span {
    margin-left: 2px;
  }
  .timer em {
    font-style: normal;
  }
  
  .action button {
    padding: 1.1em;
    width: 100%;
    height: 100%;
    font-weight: 600;
    font-size: 1em;
    color: #ffffff;
    border: none;
    border-radius: 0.5em;
    transition: background-color 0.2s ease-in-out;
  }
  .action button:hover {
    background: #2979ff;
  }
  
  .input-container {
    position: relative;
    display: flex;
    align-items: center;
    height: 3em;
    overflow: hidden;
    border: var(--field-border);
    border-radius: var(--field-border-radius);
  }
  .input-container input,
  .input-container i {
    line-height: 1;
  }
  .input-container input {
    flex: 1 1;
    height: 100%;
    width: 100%;
    text-align: center;
    border: none;
    border-radius: var(--field-border-radius);
    font-family: inherit;
    font-weight: 800;
    font-size: 0.85em;
  }
  .input-container input:focus {
    background: #e3f2fd;
    color: #283593;
  }
  .input-container input::placeholder {
    color: #ddd;
  }
  .input-container input::-webkit-outer-spin-button,
  .input-container input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
  }
  .input-container i {
    position: absolute;
    right: 0.5em;
  }
  
.container{
    width: 100%;
}

.row{
    width: 100%;
    height: 100vh;
    display: flex;
    justify-content: space-evenly;
    align-items: center;
}

#name{
width:40%;
background: #DCDCDC;
padding: 20px;
border-radius: 10px;
}

#name1{
    width: 35%;
}

  .purchase-section {
    position: relative;
    overflow: visible;
    padding: 0 1em 1em 1em;
    background: var(--sidebar-color);
    border-top-left-radius: 0.8em;
    border-top-right-radius: 0.8em;
  }
  .purchase-section:before {
    content: "";
    position: absolute;
    width: 1.6em;
    height: 1.6em;
    border-radius: 50%;
    left: -0.8em;
    bottom: -0.8em;
    background: #ffffff;
  }
  .purchase-section:after {
    content: "";
    position: absolute;
    width: 1.6em;
    height: 1.6em;
    border-radius: 50%;
    right: -0.8em;
    bottom: -0.8em;
    background: #ffffff;
  }
  
  .card-mockup {
    position: relative;
    margin: 3em 1em 1.5em 1em;
    padding: 1.5em 1.2em;
    border-radius: 0.6em;
    background: #6c7484;
    color: #fff;
    box-shadow: 0 0.5em 1em 0.125em rgba(0, 0, 0, 0.1);
  }
  .card-mockup:after {
    content: "";
    position: absolute;
    width: 25%;
    top: -0.2em;
    left: 37.5%;
    height: 0.2em;
    background: var(--accent-color);
    border-top-left-radius: 0.2em;
    border-top-right-radius: 0.2em;
  }
  .card-mockup:before {
    content: "";
    position: absolute;
    top: 0;
    width: 25%;
    left: 37.5%;
    height: 0.5em;
    background: #2962ff36;
    border-bottom-left-radius: 0.2em;
    border-bottom-right-radius: 0.2em;
    box-shadow: 0 2px 15px 5px #2962ff4d;
  }
  
  .purchase-props {
    margin: 0;
    padding: 0;
    font-size: 0.8em;
    width: 100%;
  }
  .purchase-props li {
    width: 100%;
    line-height: 2.5;
  }
  .purchase-props li span {
    color: var(--secondary-text);
    font-weight: 600;
  }
  
  .separation-line {
    border-top: 1px dashed #aaa;
    margin: 0 0.8em;
  }
  
  .total-section {
    position: relative;
    overflow: hidden;
  
    padding: 1em;
    background: var(--sidebar-color);
    border-bottom-left-radius: 0.8em;
    border-bottom-right-radius: 0.8em;
  }
  .total-section:before {
    content: "";
    position: absolute;
    width: 1.6em;
    height: 1.6em;
    border-radius: 50%;
    left: -0.8em;
    top: -0.8em;
    background: #ffffff;
  }
  .total-section:after {
    content: "";
    position: absolute;
    width: 1.6em;
    height: 1.6em;
    border-radius: 50%;
    right: -0.8em;
    top: -0.8em;
    background: #ffffff;
  }
  .total-label {
    font-size: 0.8em;
    padding-bottom: 0.5em;
  }
  .total-section strong {
    font-size: 1.5em;
    font-weight: 800;
  }
  .total-section small {
    font-weight: 600;
  }
	
</style>
<body>

  <div class="main-back">
    <div class="container m-auto bg-white p-5 bod-3">
      <div class="row">
        <!-- CARD FORM -->
        <div class="col-lg-8 col-md-12" id="name">
          <form action="CardPayment" method="post">
       
          <% double amount= (double) session.getAttribute("taxAmount"); %>
          <input type="hidden" name="totalAmount" value="<%= amount %>" >
            <div class="header flex-between flex-vertical-center">
              <div class="flex-vertical-center">
                <a href="LandingPage.jsp" ><img alt="not working" src="images/DigiPayNoBG.png" width="50px" height="50px" ></a>
                <span class="title">&nbsp; 
                 <strong>Digi</strong><span>Pay</span>
                </span>
              </div>
            </div>
            <div class="card-data flex-fill flex-vertical">
              <!-- Card Number -->
              <div class="flex-between flex-vertical-center">
                <div class="card-property-title">
                  <strong>Card Number</strong>
                  <span>Enter 16-digit card number on the card</span>
                </div>
              </div>

              <!-- Card Field -->
              <div class="flex-between">
                <div class="card-number flex-vertical-center flex-fill">
                  <div class="card-number-field flex-vertical-center flex-fill">
                    <img alt="not working" src="images/DigiPayNoBG.png"  width="24px" height="24px">
                    <input type="text" placeholder="Card Number" class="form-control" id="cardNumber" onkeypress="return onlyNumberKey(event)" maxlength="19" name="cardNumber" data-bound="carddigits_mock" data-def="0000 0000 0000 0000" required />
                  </div>
                  <i class="ai-circle-check-fill size-lg f-main-color"></i>
                </div>
              </div>

              <!-- Expiry Date -->
              <div class="flex-between">
                <div class="card-property-title">
                  <strong>Expiry Date</strong>
                  <span>Enter the expiration date of the card</span>
                </div>
                <div class="card-property-value flex-vertical-center">
                  <div class="input-container half-width">
                    <input class="numbers month-own" data-def="00" type="text" name="expiryMonth" data-bound="mm_mock" placeholder="MM" />
                  </div>
                  <span class="m-md">/</span>
                  <div class="input-container half-width">
                    <input class="numbers year-own" data-def="01" type="text" name="expiryYear" data-bound="yy_mock" placeholder="YYYY" />
                  </div>
                </div>
              </div>

              <!-- CCV Number -->
              <div class="flex-between">
                <div class="card-property-title">
                  <strong>CVC Number</strong>
                  <span>Enter card verification code from the back of the
                    card</span>
                </div>
                <div class="card-property-value">
                  <div class="input-container">
                    <input id="cvc" placeholder="Card CVV" maxlength="3" onkeypress="return onlyNumberKey(event)" name="cvv" type="password" />
                    <i id="cvc_toggler" data-target="cvc" class="ai-eye-open pointer"></i>
                  </div>
                </div>
              </div>

              <!-- Name -->
              <div class="flex-between">
                <div class="card-property-title">
                  <strong>Cardholder Name</strong>
                  <span>Enter cardholder's name</span>
                </div>
                <div class="card-property-value">
                  <div class="input-container">
                    <input id="name" data-bound="name_mock" data-def="Mr. Cardholder" type="text" class="uppercase" placeholder="CARDHOLDER NAME" />
                    <i class="ai-person"></i>
                  </div>
                </div>
              </div>

              <div class="flex-between">
                <div class="card-property-title">
                  <strong>Mobile No.</strong>
                  <span>Enter Mobile No.</span>
                </div>
                <div class="card-property-value">
                  <div class="input-container">
                    <input id="phone" type="text" placeholder="Your Mobile No." />
                    <i class="ai-phone"></i>
                  </div>
                </div>
              </div>
            </div>
            <div class="action flex-center">
              <button type="submit" class="b-main-color pointer" style="background-color: #3c455c">
                Pay Now
              </button>
            </div>
          </form>
        </div>

	<%
		
	  try{ 
			String rechargeType = (String) session.getAttribute("rechargeType");
			System.err.println("rechargeType ---> " + rechargeType);
			if(rechargeType.equals("mobileRecharge")){
		%>
				
				<div class="col-lg-4 col-md-12 py-5" id="name1">
	          <div class="purchase-section flex-fill flex-vertical">
	            <div class="card-mockup flex-vertical">
	              <img src="images/DigiPayNoBG.png" alt="not working" width="40px" height="40px" ><br>
	              <div>
	                <strong>
	                  <div id="name_mock" class="size-md pb-sm uppercase ellipsis">
	                    mr. Cardholder
	                  </div>
	                </strong>
	                <div class="size-md pb-md">
	                  <strong>
	                    <span id="carddigits_mock">0000 0000 0000 0000</span>
	                  </strong>
	                </div>
	                <div class="flex-between flex-vertical-center">
	                  <strong class="size-md">
	                    <span>Expiry Date : </span><span id="mm_mock">00</span> / <span id="yy_mock">00</span>
	                  </strong>
					  <strong class="size-md snipcss0-3-9-10">
	               		 <span class="snipcss0-4-10-11">CVV : </span><span id="mm_mock" class="snipcss0-4-10-12">000</span>
	            	</strong>
	                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px">
	                    <path fill="#1565C0" d="M45,35c0,2.209-1.791,4-4,4H7c-2.209,0-4-1.791-4-4V13c0-2.209,1.791-4,4-4h34c2.209,0,4,1.791,4,4V35z" />
	                    <path fill="#FFF" d="M15.186 19l-2.626 7.832c0 0-.667-3.313-.733-3.729-1.495-3.411-3.701-3.221-3.701-3.221L10.726 30v-.002h3.161L18.258 19H15.186zM17.689 30L20.56 30 22.296 19 19.389 19zM38.008 19h-3.021l-4.71 11h2.852l.588-1.571h3.596L37.619 30h2.613L38.008 19zM34.513 26.328l1.563-4.157.818 4.157H34.513zM26.369 22.206c0-.606.498-1.057 1.926-1.057.928 0 1.991.674 1.991.674l.466-2.309c0 0-1.358-.515-2.691-.515-3.019 0-4.576 1.444-4.576 3.272 0 3.306 3.979 2.853 3.979 4.551 0 .291-.231.964-1.888.964-1.662 0-2.759-.609-2.759-.609l-.495 2.216c0 0 1.063.606 3.117.606 2.059 0 4.915-1.54 4.915-3.752C30.354 23.586 26.369 23.394 26.369 22.206z" />
	                    <path fill="#FFC107" d="M12.212,24.945l-0.966-4.748c0,0-0.437-1.029-1.573-1.029c-1.136,0-4.44,0-4.44,0S10.894,20.84,12.212,24.945z" />
	                  </svg>
	                </div>
	              </div>
	            </div>
				<% 
					MobileRecharge mobile = (MobileRecharge) session.getAttribute("rechargeDetails");
				%>
	            <ul class="purchase-props">
	              <li class="flex-between">
	                <span>NetWork</span>
	                <strong><%= mobile.getNetwork() %></strong>
	              </li>
	              <li class="flex-between">
	                <span>Mobile Number</span>
	                <strong><%= mobile.getMobileNumber() %></strong>
	              </li>
	              <li class="flex-between">
	                <span>Plan Type</span>
	                <strong><%= mobile.getRechargeType() %></strong>
	              </li>
	              <li class="flex-between">
	                <span>Tax (5%)</span>
	                <%
	                	double tax = (mobile.getPlan() / 100) * 5;
	                %>
	                <strong><%= tax %></strong>
	              </li>
	            </ul>
	          </div>
	          <div class="separation-line"></div>
	          <div class="total-section flex-between flex-vertical-center">
	            <div class="flex-fill flex-vertical">
	              <div class="total-label f-secondary-color">You have to Pay</div>
	              <div>
	                <strong><%= mobile.getPlan() + tax %></strong>
	                <small><span class="f-secondary-color">Rupees</span></small>
	              </div>
	            </div>
	            <i class="ai-coin size-lg"></i>
	          </div>
	        </div>
				
				
		<%}else if(rechargeType.equals("electricityRecharge")){
			System.err.println("in eb type");
			%>
			<div class="col-lg-4 col-md-12 py-5" id="name1">
          <div class="purchase-section flex-fill flex-vertical">
            <div class="card-mockup flex-vertical">
              <img src="images/DigiPayNoBG.png" alt="not working" width="40px" height="40px" ><br>
              <div>
                <strong>
                  <div id="name_mock" class="size-md pb-sm uppercase ellipsis">
                    mr. Cardholder
                  </div>
                </strong>
                <div class="size-md pb-md">
                  <strong>
                    <span id="carddigits_mock">0000 0000 0000 0000</span>
                  </strong>
                </div>
                <div class="flex-between flex-vertical-center">
                  <strong class="size-md">
                    <span>Expiry Date : </span><span id="mm_mock">00</span> / <span id="yy_mock">00</span>
                  </strong>
				  <strong class="size-md snipcss0-3-9-10">
               		 <span class="snipcss0-4-10-11">CVV : </span><span id="mm_mock" class="snipcss0-4-10-12">000</span>
            	</strong>
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px">
                    <path fill="#1565C0" d="M45,35c0,2.209-1.791,4-4,4H7c-2.209,0-4-1.791-4-4V13c0-2.209,1.791-4,4-4h34c2.209,0,4,1.791,4,4V35z" />
                    <path fill="#FFF" d="M15.186 19l-2.626 7.832c0 0-.667-3.313-.733-3.729-1.495-3.411-3.701-3.221-3.701-3.221L10.726 30v-.002h3.161L18.258 19H15.186zM17.689 30L20.56 30 22.296 19 19.389 19zM38.008 19h-3.021l-4.71 11h2.852l.588-1.571h3.596L37.619 30h2.613L38.008 19zM34.513 26.328l1.563-4.157.818 4.157H34.513zM26.369 22.206c0-.606.498-1.057 1.926-1.057.928 0 1.991.674 1.991.674l.466-2.309c0 0-1.358-.515-2.691-.515-3.019 0-4.576 1.444-4.576 3.272 0 3.306 3.979 2.853 3.979 4.551 0 .291-.231.964-1.888.964-1.662 0-2.759-.609-2.759-.609l-.495 2.216c0 0 1.063.606 3.117.606 2.059 0 4.915-1.54 4.915-3.752C30.354 23.586 26.369 23.394 26.369 22.206z" />
                    <path fill="#FFC107" d="M12.212,24.945l-0.966-4.748c0,0-0.437-1.029-1.573-1.029c-1.136,0-4.44,0-4.44,0S10.894,20.84,12.212,24.945z" />
                  </svg>
                </div>
              </div>
            </div>
			<%
			EBConsumerData consumerData = (EBConsumerData)	session.getAttribute("ebDetails");
			double finalAmount = (double) session.getAttribute("taxAmount");
			%>
            <ul class="purchase-props">
              <li class="flex-between">
                <span>Consumer Number</span>
                <strong><%= consumerData.getConsumerNumber() %></strong>
              </li>
              <li class="flex-between">
                <span>Service Number</span>
                <strong><%= consumerData.getSerialNumber() %></strong>
              </li>
              <li class="flex-between">
                <span>Tax (5%)</span>
                <strong><%= (consumerData.getBillAmount()/100)*5  %></strong>
              </li>
            </ul>
          </div>
          <div class="separation-line"></div>
          <div class="total-section flex-between flex-vertical-center">
            <div class="flex-fill flex-vertical">
              <div class="total-label f-secondary-color">You have to Pay</div>
              <div>
                <strong><%= finalAmount %></strong>
                <small> <span class="f-secondary-color">Rupees</span></small>
              </div>
            </div>
            <i class="ai-coin size-lg"></i>
          </div>
        </div>
			
		<%}else if(rechargeType.equals("dthRecharge"))
		{ %>
			
				<div class="col-lg-4 col-md-12 py-5" id="name1">
          <div class="purchase-section flex-fill flex-vertical">
            <div class="card-mockup flex-vertical">
              <img src="images/DigiPayNoBG.png" alt="not working" width="40px" height="40px" ><br>
              <div>
                <strong>
                  <div id="name_mock" class="size-md pb-sm uppercase ellipsis">
                    mr. Cardholder
                  </div>
                </strong>
                <div class="size-md pb-md">
                  <strong>
                    <span id="carddigits_mock">0000 0000 0000 0000</span>
                  </strong>
                </div>
                <div class="flex-between flex-vertical-center">
                  <strong class="size-md">
                    <span>Expiry Date : </span><span id="mm_mock">00</span> / <span id="yy_mock">00</span>
                  </strong>
				  <strong class="size-md snipcss0-3-9-10">
               		 <span class="snipcss0-4-10-11">CVV : </span><span id="mm_mock" class="snipcss0-4-10-12">000</span>
            	</strong>
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px">
                    <path fill="#1565C0" d="M45,35c0,2.209-1.791,4-4,4H7c-2.209,0-4-1.791-4-4V13c0-2.209,1.791-4,4-4h34c2.209,0,4,1.791,4,4V35z" />
                    <path fill="#FFF" d="M15.186 19l-2.626 7.832c0 0-.667-3.313-.733-3.729-1.495-3.411-3.701-3.221-3.701-3.221L10.726 30v-.002h3.161L18.258 19H15.186zM17.689 30L20.56 30 22.296 19 19.389 19zM38.008 19h-3.021l-4.71 11h2.852l.588-1.571h3.596L37.619 30h2.613L38.008 19zM34.513 26.328l1.563-4.157.818 4.157H34.513zM26.369 22.206c0-.606.498-1.057 1.926-1.057.928 0 1.991.674 1.991.674l.466-2.309c0 0-1.358-.515-2.691-.515-3.019 0-4.576 1.444-4.576 3.272 0 3.306 3.979 2.853 3.979 4.551 0 .291-.231.964-1.888.964-1.662 0-2.759-.609-2.759-.609l-.495 2.216c0 0 1.063.606 3.117.606 2.059 0 4.915-1.54 4.915-3.752C30.354 23.586 26.369 23.394 26.369 22.206z" />
                    <path fill="#FFC107" d="M12.212,24.945l-0.966-4.748c0,0-0.437-1.029-1.573-1.029c-1.136,0-4.44,0-4.44,0S10.894,20.84,12.212,24.945z" />
                  </svg>
                </div>
              </div>
            </div>
			<%
				DTHRecharge recharge = (DTHRecharge) session.getAttribute("dthDetails");
				double finalAmount = (double) session.getAttribute("taxAmount");
			%>
            <ul class="purchase-props">
              <li class="flex-between">
                <span>Company</span>
                <strong><%= recharge.getOperator() %></strong>
              </li>
              <li class="flex-between">
                <span>Order number</span>
                <strong><%= recharge.getCustomerId() %></strong>
              </li>
              <li class="flex-between">
                <span>Product</span>
                <strong><%= recharge.getAmount() %></strong>
              </li>
              <li class="flex-between">
                <span>Tax (5%)</span>
                <strong><%= (recharge.getAmount()/100)*5 %></strong>
              </li>
            </ul>
  
          </div>
          <div class="separation-line"></div>
          <div class="total-section flex-between flex-vertical-center">
            <div class="flex-fill flex-vertical">
              <div class="total-label f-secondary-color">You have to Pay</div>
              <div>
                <strong><%= finalAmount %></strong>
                <small> <span class="f-secondary-color">Rupees</span></small>
              </div>
            </div>
            <i class="ai-coin size-lg"></i>
          </div>
        </div>
				
	
	<%	}
		else if(rechargeType.equals("waterRecharge")){ %>
			<div class="col-lg-4 col-md-12 py-5" id="name1">
          <div class="purchase-section flex-fill flex-vertical">
            <div class="card-mockup flex-vertical">
              <img src="images/DigiPayNoBG.png" alt="not working" width="40px" height="40px" ><br>
              <div>
                <strong>
                  <div id="name_mock" class="size-md pb-sm uppercase ellipsis"> mr. Cardholder</div>
                </strong>
                <div class="size-md pb-md">
                  <strong>
                    <span id="carddigits_mock">0000 0000 0000 0000</span>
                  </strong>
                </div>
                <div class="flex-between flex-vertical-center">
                  <strong class="size-md">
                    <span>Expiry Date : </span><span id="mm_mock">00</span> / <span id="yy_mock">00</span>
                  </strong>
				  <strong class="size-md snipcss0-3-9-10">
               		 <span class="snipcss0-4-10-11">CVV : </span><span id="mm_mock" class="snipcss0-4-10-12">000</span>
            	</strong>
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px">
                    <path fill="#1565C0" d="M45,35c0,2.209-1.791,4-4,4H7c-2.209,0-4-1.791-4-4V13c0-2.209,1.791-4,4-4h34c2.209,0,4,1.791,4,4V35z" />
                    <path fill="#FFF" d="M15.186 19l-2.626 7.832c0 0-.667-3.313-.733-3.729-1.495-3.411-3.701-3.221-3.701-3.221L10.726 30v-.002h3.161L18.258 19H15.186zM17.689 30L20.56 30 22.296 19 19.389 19zM38.008 19h-3.021l-4.71 11h2.852l.588-1.571h3.596L37.619 30h2.613L38.008 19zM34.513 26.328l1.563-4.157.818 4.157H34.513zM26.369 22.206c0-.606.498-1.057 1.926-1.057.928 0 1.991.674 1.991.674l.466-2.309c0 0-1.358-.515-2.691-.515-3.019 0-4.576 1.444-4.576 3.272 0 3.306 3.979 2.853 3.979 4.551 0 .291-.231.964-1.888.964-1.662 0-2.759-.609-2.759-.609l-.495 2.216c0 0 1.063.606 3.117.606 2.059 0 4.915-1.54 4.915-3.752C30.354 23.586 26.369 23.394 26.369 22.206z" />
                    <path fill="#FFC107" d="M12.212,24.945l-0.966-4.748c0,0-0.437-1.029-1.573-1.029c-1.136,0-4.44,0-4.44,0S10.894,20.84,12.212,24.945z" />
                  </svg>
                </div>
              </div>
            </div>
			<%
				WaterRecharge waterRecharge = (WaterRecharge) session.getAttribute("waterRechargeDetails");
				double finalAmount = (double) session.getAttribute("taxAmount");
			%>
            <ul class="purchase-props">
              <li class="flex-between">
                <span>Company</span>
                <strong><%= waterRecharge.getServiceProvider() %></strong>
              </li>
              <li class="flex-between">
                <span>Order number</span>
                <strong><%= waterRecharge.getBillNumber() %></strong>
              </li>
              <li class="flex-between">
                <span>Product</span>
                <strong><%= waterRecharge.getMobileNumber() %></strong>
              </li>
              <li class="flex-between">
                <span>Tax (5%)</span>
                <strong><%= (waterRecharge.getAmount()/100)*5 %></strong>
              </li>
            </ul>
          </div>
          <div class="separation-line"></div>
          <div class="total-section flex-between flex-vertical-center">
            <div class="flex-fill flex-vertical">
              <div class="total-label f-secondary-color">You have to Pay</div>
              <div>
                <strong><%= finalAmount %></strong>
                <small> <span class="f-secondary-color">Rupees</span></small>
              </div>
            </div>
            <i class="ai-coin size-lg"></i>
          </div>
        </div>
			
	<%
		}else if(rechargeType.equals("gasRecharge")){ %>
		
					<div class="col-lg-4 col-md-12 py-5" id="name1">
          <div class="purchase-section flex-fill flex-vertical">
            <div class="card-mockup flex-vertical">
              <img src="images/DigiPayNoBG.png" alt="not working" width="40px" height="40px" ><br>
              <div>
                <strong>
                  <div id="name_mock" class="size-md pb-sm uppercase ellipsis"> mr. Cardholder</div>
                </strong>
                <div class="size-md pb-md">
                  <strong>
                    <span id="carddigits_mock">0000 0000 0000 0000</span>
                  </strong>
                </div>
                <div class="flex-between flex-vertical-center">
                  <strong class="size-md">
                    <span>Expiry Date : </span><span id="mm_mock">00</span> / <span id="yy_mock">00</span>
                  </strong>
				  <strong class="size-md snipcss0-3-9-10">
               		 <span class="snipcss0-4-10-11">CVV : </span><span id="mm_mock" class="snipcss0-4-10-12">000</span>
            	</strong>
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px">
                    <path fill="#1565C0" d="M45,35c0,2.209-1.791,4-4,4H7c-2.209,0-4-1.791-4-4V13c0-2.209,1.791-4,4-4h34c2.209,0,4,1.791,4,4V35z" />
                    <path fill="#FFF" d="M15.186 19l-2.626 7.832c0 0-.667-3.313-.733-3.729-1.495-3.411-3.701-3.221-3.701-3.221L10.726 30v-.002h3.161L18.258 19H15.186zM17.689 30L20.56 30 22.296 19 19.389 19zM38.008 19h-3.021l-4.71 11h2.852l.588-1.571h3.596L37.619 30h2.613L38.008 19zM34.513 26.328l1.563-4.157.818 4.157H34.513zM26.369 22.206c0-.606.498-1.057 1.926-1.057.928 0 1.991.674 1.991.674l.466-2.309c0 0-1.358-.515-2.691-.515-3.019 0-4.576 1.444-4.576 3.272 0 3.306 3.979 2.853 3.979 4.551 0 .291-.231.964-1.888.964-1.662 0-2.759-.609-2.759-.609l-.495 2.216c0 0 1.063.606 3.117.606 2.059 0 4.915-1.54 4.915-3.752C30.354 23.586 26.369 23.394 26.369 22.206z" />
                    <path fill="#FFC107" d="M12.212,24.945l-0.966-4.748c0,0-0.437-1.029-1.573-1.029c-1.136,0-4.44,0-4.44,0S10.894,20.84,12.212,24.945z" />
                  </svg>
                </div>
              </div>
            </div>
			<%
				GasRecharge gasRecharge = (GasRecharge) session.getAttribute("gasRechargeDetails");
				double finalAmount = (double) session.getAttribute("taxAmount");
			%>
            <ul class="purchase-props">
              <li class="flex-between">
                <span>Gas Provider</span>
                <strong><%= gasRecharge.getGasProvider() %></strong>
              </li>
              <li class="flex-between">
                <span>Mobile Number</span>
                <strong><%= gasRecharge.getMobileNumber() %></strong>
              </li>
              <li class="flex-between">
                <span>Tax (5%)</span>
                <strong><%= (gasRecharge.getAmount()/100)*5 %></strong>
              </li>
            </ul>
          </div>
          <div class="separation-line"></div>
          <div class="total-section flex-between flex-vertical-center">
            <div class="flex-fill flex-vertical">
              <div class="total-label f-secondary-color">You have to Pay</div>
              <div>
                <strong><%= finalAmount %></strong>
                <small><span class="f-secondary-color">Rupees</span></small>
              </div>
            </div>
            <i class="ai-coin size-lg"></i>
          </div>
        </div>
		
	<%	}
		else if(rechargeType.equals("insuranceRecharge")){
	%>
			<div class="col-lg-4 col-md-12 py-5" id="name1">
          <div class="purchase-section flex-fill flex-vertical">
            <div class="card-mockup flex-vertical">
              <img src="images/DigiPayNoBG.png" alt="not working" width="40px" height="40px" ><br>
              <div>
                <strong>
                  <div id="name_mock" class="size-md pb-sm uppercase ellipsis"> mr. Cardholder</div>
                </strong>
                <div class="size-md pb-md">
                  <strong>
                    <span id="carddigits_mock">0000 0000 0000 0000</span>
                  </strong>
                </div>
                <div class="flex-between flex-vertical-center">
                  <strong class="size-md">
                    <span>Expiry Date : </span><span id="mm_mock">00</span> / <span id="yy_mock">00</span>
                  </strong>
				  <strong class="size-md snipcss0-3-9-10">
               		 <span class="snipcss0-4-10-11">CVV : </span><span id="mm_mock" class="snipcss0-4-10-12">000</span>
            	</strong>
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px">
                    <path fill="#1565C0" d="M45,35c0,2.209-1.791,4-4,4H7c-2.209,0-4-1.791-4-4V13c0-2.209,1.791-4,4-4h34c2.209,0,4,1.791,4,4V35z" />
                    <path fill="#FFF" d="M15.186 19l-2.626 7.832c0 0-.667-3.313-.733-3.729-1.495-3.411-3.701-3.221-3.701-3.221L10.726 30v-.002h3.161L18.258 19H15.186zM17.689 30L20.56 30 22.296 19 19.389 19zM38.008 19h-3.021l-4.71 11h2.852l.588-1.571h3.596L37.619 30h2.613L38.008 19zM34.513 26.328l1.563-4.157.818 4.157H34.513zM26.369 22.206c0-.606.498-1.057 1.926-1.057.928 0 1.991.674 1.991.674l.466-2.309c0 0-1.358-.515-2.691-.515-3.019 0-4.576 1.444-4.576 3.272 0 3.306 3.979 2.853 3.979 4.551 0 .291-.231.964-1.888.964-1.662 0-2.759-.609-2.759-.609l-.495 2.216c0 0 1.063.606 3.117.606 2.059 0 4.915-1.54 4.915-3.752C30.354 23.586 26.369 23.394 26.369 22.206z" />
                    <path fill="#FFC107" d="M12.212,24.945l-0.966-4.748c0,0-0.437-1.029-1.573-1.029c-1.136,0-4.44,0-4.44,0S10.894,20.84,12.212,24.945z" />
                  </svg>
                </div>
              </div>
            </div>
			<%
				InsuranceRecharge insuranceRecharge = (InsuranceRecharge) session.getAttribute("insuranceRechargeDetails");
				double finalAmount = (double) session.getAttribute("taxAmount");
			%>
            <ul class="purchase-props">
              <li class="flex-between">
                <span>Company</span>
                <strong><%= insuranceRecharge.getInsuranceCompany() %></strong>
              </li>
              <li class="flex-between">
                <span>Policy Number</span>
                <strong><%= insuranceRecharge.getPolicyNumber() %></strong>
              </li>
              <li class="flex-between">
                <span>Valid Till</span>
                <strong><%= insuranceRecharge.getValidDate() %></strong>
              </li>
              <li class="flex-between">
                <span>Tax (5%)</span>
                <strong><%= (insuranceRecharge.getAmount()/100)*5 %></strong>
              </li>
            </ul>
          </div>
          <div class="separation-line"></div>
          <div class="total-section flex-between flex-vertical-center">
            <div class="flex-fill flex-vertical">
              <div class="total-label f-secondary-color">You have to Pay</div>
              <div>
                <strong><%= finalAmount %></strong>
                <small><span class="f-secondary-color">Rupees</span></small>
              </div>
            </div>
            <i class="ai-coin size-lg"></i>
          </div>
        </div>
	<%	}
	}catch(Exception e){
	%>

		<div class="col-lg-4 col-md-12 py-5" id="name1">
          <div class="purchase-section flex-fill flex-vertical">
            <div class="card-mockup flex-vertical">
              <img src="images/DigiPayNoBG.png" alt="not working" width="40px" height="40px" ><br>
              <div>
                <strong>
                  <div id="name_mock" class="size-md pb-sm uppercase ellipsis"> mr. Cardholder</div>
                </strong>
                <div class="size-md pb-md">
                  <strong>
                    <span id="carddigits_mock">0000 0000 0000 0000</span>
                  </strong>
                </div>
                <div class="flex-between flex-vertical-center">
                  <strong class="size-md">
                    <span>Expiry Date : </span><span id="mm_mock">00</span> / <span id="yy_mock">00</span>
                  </strong>
				  <strong class="size-md snipcss0-3-9-10">
               		 <span class="snipcss0-4-10-11">CVV : </span><span id="mm_mock" class="snipcss0-4-10-12">000</span>
            	</strong>
                  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px">
                    <path fill="#1565C0" d="M45,35c0,2.209-1.791,4-4,4H7c-2.209,0-4-1.791-4-4V13c0-2.209,1.791-4,4-4h34c2.209,0,4,1.791,4,4V35z" />
                    <path fill="#FFF" d="M15.186 19l-2.626 7.832c0 0-.667-3.313-.733-3.729-1.495-3.411-3.701-3.221-3.701-3.221L10.726 30v-.002h3.161L18.258 19H15.186zM17.689 30L20.56 30 22.296 19 19.389 19zM38.008 19h-3.021l-4.71 11h2.852l.588-1.571h3.596L37.619 30h2.613L38.008 19zM34.513 26.328l1.563-4.157.818 4.157H34.513zM26.369 22.206c0-.606.498-1.057 1.926-1.057.928 0 1.991.674 1.991.674l.466-2.309c0 0-1.358-.515-2.691-.515-3.019 0-4.576 1.444-4.576 3.272 0 3.306 3.979 2.853 3.979 4.551 0 .291-.231.964-1.888.964-1.662 0-2.759-.609-2.759-.609l-.495 2.216c0 0 1.063.606 3.117.606 2.059 0 4.915-1.54 4.915-3.752C30.354 23.586 26.369 23.394 26.369 22.206z" />
                    <path fill="#FFC107" d="M12.212,24.945l-0.966-4.748c0,0-0.437-1.029-1.573-1.029c-1.136,0-4.44,0-4.44,0S10.894,20.84,12.212,24.945z" />
                  </svg>
                </div>
              </div>
            </div>

            <ul class="purchase-props">
              <li class="flex-between">
                <span>Company</span>
                <strong>Apple</strong>
              </li>
              <li class="flex-between">
                <span>Order number</span>
                <strong>429252965</strong>
              </li>
              <li class="flex-between">
                <span>Product</span>
                <strong>MacBook Air</strong>
              </li>
              <li class="flex-between">
                <span>Tax (20%)</span>
                <strong>$100.00</strong>
              </li>
            </ul>
          </div>
          <div class="separation-line"></div>
          <div class="total-section flex-between flex-vertical-center">
            <div class="flex-fill flex-vertical">
              <div class="total-label f-secondary-color">You have to Pay</div>
              <div>
                <strong>549</strong>
                <small>.99 <span class="f-secondary-color">Rupees</span></small>
              </div>
            </div>
            <i class="ai-coin size-lg"></i>
          </div>
        </div>
        <%} %>

      </div>
    </div>
  </div>

  <script>

  const bounds = document.querySelectorAll("[data-bound]");

  for (let i = 0; i < bounds.length; i++) {
    const targetId = bounds[i].getAttribute("data-bound");
    const defValue = bounds[i].getAttribute("data-def");
    const targetEl = document.getElementById(targetId);
    bounds[i].addEventListener(
      "blur",
      () => (targetEl.innerText = bounds[i].value || defValue)
    );
  }

  const cvc_toggler = document.getElementById("cvc_toggler");

  cvc_toggler.addEventListener("click", () => {
    const target = cvc_toggler.getAttribute("data-target");
    const el = document.getElementById(target);
    el.setAttribute("type", el.type === "text" ? "password" : "text");
  });

  function onlyNumberKey(evt) {
    var ASCIICode = evt.which ? evt.which : evt.keyCode;
    if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57)) return false;
    return true;
  }

  $(function () {
    $("#cardNumber").on("keyup", function (e) {
      var val = $(this).val();
      var newval = "";
      val = val.replace(/\s/g, "");
      for (var i = 0; i < val.length; i++) {
        if (i % 4 == 0 && i > 0) newval = newval.concat(" ");
        newval = newval.concat(val[i]);
      }
      $(this).val(newval);
    });

    $(".year-own").datepicker({
      minViewMode: 2,
      format: "yyyy"
    });

    $(".month-own").datepicker({
      format: "MM",
      minViewMode: "months",
      maxViewMode: "months",
      startView: "months"
    });
  });

  </script>
  <script>

<% 
	String alertMessage = (String) request.getAttribute("errorMessage");
	System.out.println("alertMsg : " + alertMessage);
	if(alertMessage != null && !alertMessage.isEmpty()){
	    if(alertMessage.equals("Invalid Credentials")){
	%>
	Swal.fire({
	title: '<%= alertMessage %>',
	type: 'error',
	confirmButtonColor: '#3c445c',
	confirmButtonText: 'Ok'
	})
	<% }else if(alertMessage.equals("Invalid WalletID")){ %>
	Swal.fire({
	  title: '<%= alertMessage %>',
	  type: 'error',
	  confirmButtonColor: '#3c445c',
	  confirmButtonText: 'Ok'
	})
	<%}
	}%>
</script>
</body>

</html>