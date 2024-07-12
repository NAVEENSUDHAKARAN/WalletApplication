<%@page import="java.time.LocalDate"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@ page import="com.chainsys.walletapplication.dao.WalletImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Insurance Form</title>
   
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            width: 600px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin: auto;
        }
        h2 {
            text-align: center;
            color: #3c455c;
        }
        .form-field {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }
        input[type="text"],
        input[type="date"],
        select {
            width: 90%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
       #btn {
            background-color: #3c455c;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }


        #details {
            margin-top: 20px;
            padding: 10px;
            background-color:white;
        }
    </style>
</head>
<body>

<div class="container">
 <%
    ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
 	WalletImpl walletImpl = (WalletImpl) context.getBean("walletImpl");
 	double amount =0;
 	LocalDate validDate = null;
 	String tillDate = "";
 %>
  <a href="LandingPage.jsp" id="backBtn" ><img alt="not working" style="padding-left: -30px;" src="images/backArrow.png" width="30px" height="30px" ></a> 
    <h2>Insurance Payment</h2>
    <form action="InsurancePayment" method="post">
        <div class="form-field">
            <label for="insuranceCompany">Insurance Company Name:</label>
            <select id="insuranceCompany" name="insuranceCompany" required>
                <option value="">Select Company</option>
                <option value="Adithya Birla">Adithya Birla Health Insurance</option>
                <option value="Bajaj">Bajaj Allianz General Insurance</option>
                <option value="Acko(Motor)">Acko General Insurance Motor</option>
                <option value="HDFC">HDFC Life Insurance</option>
            </select>
        </div>
        <div class="form-field">
            <label for="policyNumber">Policy Number:</label>
            <input type="text" id="policyNumber" name="policyNumber" required>
        </div>
        <div class="form-field">
            <label for="dob">Date of Birth:</label>
            <input type="date" id="dob" name="dob" onchange="showDetails()" required>
        </div>
		<input type="hidden" name="amount" id="amount"  >
		<input type="hidden" name="validDate" id="validDate"  >
		<%System.out.println("tillDate--> " + tillDate); %>
        <div id="details"></div>

        <div class="form-field">
            <button id="btn" type="submit">Submit</button>
        </div>
    </form>
     <script>
        function showDetails() {
            const dob = document.getElementById("dob").value;
	console.log(dob);

            if (dob) {
            	console.log('');
                <%
                amount = walletImpl.amountGenerator();
                LocalDate date = LocalDate.now();
                validDate = date.plusMonths(1);
                 tillDate = validDate.toString();
                String details = "Policy valid till: ";
                %>
              
                document.getElementById("amount").value= <%= amount%>;
                document.getElementById("validDate").value= <%= tillDate%>;
                document.getElementById("details").innerHTML = `
                    <p>Amount: $<%= amount%></p>
                    <p><%= details + validDate%></p>
                `;
                
            } else {
                document.getElementById("details").innerHTML = "";
            }
        }
    </script>
</div>

</body>
</html>
