<!DOCTYPE html>
<html>
<head>
    <title>DTH Recharge</title>
    <style>
        body {
            font-family: Arial, sans-serif;

        }
        .container {
            width: 400px;
            border: 1px solid #ccc;
         	padding:30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .submit-btn {
            background-color: #3c455c;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
    	 <a href="LandingPage.jsp" ><img alt="not working" src="images/DigiPayNoBG.png" width="40px" height="40px" ></a> 
    
        <h2>Payment Details</h2>
        <form action="DTHRecharge" method="post">
            <div class="form-group">
                <label for="operator">Select Operator:</label>
                <select id="operator" name="operator">
                    <option value="sun_direct">Sun Direct</option>
                    <option value="videocon">Videocon</option>
                    <option value="airtel">Airtel</option>
                    <option value="tataPlay">Tata Play</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
            <div class="form-group">
                <label for="customerId">Customer ID:</label>
                <input type="text" id="customerId" name="customerId" maxlength="6" required>
            </div>
            <div class="form-group">
                <label for="amount">Amount:</label>
                <input type="number" id="amount" name="amount" required>
            </div>
            <button type="submit" class="submit-btn">Submit</button>
        </form>
    </div>
</body>
</html>