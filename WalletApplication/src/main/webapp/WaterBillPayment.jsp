<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Water Bill Payment</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        margin: 0;
        padding: 20px;
    }

    .container {
        width: 600px;
        margin: 0 auto;
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }

    .form-group input[type="text"] {
        width: calc(100% - 12px);
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .btn {
        background-color: #3c455c;
        color: #ffffff;
        border: none;
        padding: 12px 20px;
        font-size: 16px;
        cursor: pointer;
        border-radius: 4px;
    }

    .btn:hover {
        background-color: black;
        color: white;
    }
</style>
</head>
<body>
    <div class="container">
            	 <a href="LandingPage.jsp" ><img alt="not working" src="images/DigiPayNoBG.png" width="40px" height="40px" ></a> 
    
        <h2>Water Bill Payment</h2>
        
        <form action="WaterRecharge" method="post">
            <div class="form-group">
                <label for="serviceProvider">Service Provider:</label>
                <select id="serviceProvider" name="serviceProvider">
                    <option value="MWSB">Madurai Water Supply Board</option>
                    <option value="CWSB">Chennai Water Supply Board</option>
                    <option value="TNWSB">TamilNadu Water Supply Board</option>
                </select>
            </div>
            <div class="form-group">
                <label for="billNumber">Bill Number:</label>
                <input type="text" id="billNumber" name="billNumber" maxlength="8" required>
            </div>
            <div class="form-group">
                <label for="mobileNumber">Mobile Number:</label>
                <input type="text" id="mobileNumber" maxlength="10" name="mobileNumber" required>
            </div>
            <div class="form-group">
                <label for="amount">Amount:</label>
                <input type="text" id="amount" name="amount" required>
            </div>
            <button type="submit" class="btn">Proceed</button>
        </form>
    </div>
</body>
</html>
