<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gas Bill Payment</title>
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

    .form-group input[type="text"], .form-group select {
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
    
        <h2>Gas Provider Payment</h2>
        <form action="GasRecharge" method="post">
            <div class="form-group">
                <label for="gasProvider">Gas Provider:</label>
                <select id="gasProvider" name="gasProvider">
                    <option value="Bharat Gas (BPCL)">Bharat Gas (BPCL)</option>
                    <option value="Bharat Gas (BPCL) - commercial">Bharat Gas (BPCL) - commercial</option>
                    <option value="Hpcl lpg gas">Hpcl lpg gas</option>
                    <option value="Indane gas">Indane gas</option>
                </select>
            </div>
            <div class="form-group">
                <label for="mobileNumber">Mobile Number:</label>
                <input type="text" id="mobileNumber" name="mobileNumber" required>
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
