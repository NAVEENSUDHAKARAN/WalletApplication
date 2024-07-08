<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="UTF-8">
    <title>Mobile Recharge</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color:white;
            margin: 10px;
        }
        .container {
            width: 50%;
            margin: 5px;
            height: 530px;
            background-color: #fff;
            padding: 5px;
            border-radius: 10px;
            box-shadow: 0 0 10px grey;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
        	position:relative;
            left: 50px;
            display: block;
            margin-bottom: 10px;
        }
        .form-control {
            width: 80%;
            padding: 5px;
            position:relative;
            left: 50px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        
        input[type = radio],
        span
        {
        	 position:relative;
            left: 80px;
        }
        
        
        
        .btn {
        	position:relative;
            left: -80px;
            background-color: #3c455c;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            float: right;
        }
        .btn:hover {
            background-color: black;
        }
        
        #rightDiv{
        	width: 40%;
        	margin: 10px;
            height: 500px;
            padding: 20px;
            border-radius: 10px;
        }
        
        #mainDiv{
        	display: flex;
        }
        
        .promotion-card {
        	font-family: "Montserrat", sans-serif;
        	background: black;
        	width: 500px;
        	height: 200px;
        	position: relative;
        	overflow: hidden;
        	box-shadow: 0 0 30px 0px rgba(0, 0, 0, 0.15);
        	border-radius: 4px;
        	transition: .8s ease;
        }
        
        .promotion-content {
        	color: white;
        	padding: 1em;
        	max-width: 50%;
        	position: relative;
        	z-index: 2;
        }
        
        .promotion-blob {
        	position: absolute;
        	right: -80px;
        	top: -80px;
        	width: 240px;
        	height: 240px;
        	background: lighten(green, 20%);
        	border-radius: 240px;
        	opacity: 0.8;
        	transition: 0.2s ease;
        }
        
        .promotion-blob::before {
        	content: "";
        	position: absolute;
        	right: 0;
        	top: 0;
        	width: 160px;
        	height: 160px;
        	background: lighten(green, 10%);
        	border-radius: 160px;
        	opacity: 0.9;
        	transition: 0.25s ease;
        }
        
        .promotion-blob::after {
        	content: "";
        	position: absolute;
        	right: 0;
        	top: 0;
        	width: 80px;
        	height: 80px;
        	background: green;
        	border-radius: 80px;
        	transition: 0.27s ease;
        }
        
        .promotion-card:hover {
        	transform: translateY(-5%);
        }
        
        .promotion-card:hover .promotion-blob {
        	width: 360px;
        	height: 360px;
        }
        
        .promotion-card:hover .promotion-blob::after {
        	width: 240px;
        	height: 240px;
        }
        
        .promotion-card:hover .promotion-blob::before {
        	width: 320px;
        	height: 320px;
        }
        
        .promotion-card-deck {
        	display: flex;
        	gap: 1em;
        	position: absolute;
        	top: 50%;
        	left: 50%;
        	transform: translate(-50%, -50%);
        }
        
    </style>
</head>
<body>
	<div id="mainDiv">
		<div class="container">
			<h2>Mobile Recharge</h2>
			<form action="MobileRecharge" method="post">
				<label for="type">Select Type:</label>
				<input type="radio" id="prepaid" name="type" value="prepaid" checked> <span>PrePaid</span>
				<input type="radio" id="postpaid" name="type" value="postpaid"> <span>PostPaid</span><br><br>

				<label for="mobileNumber">Mobile Number:</label>
				<input type="text" id="mobileNumber" name="mobileNumber" class="form-control" required><br><br>

				<label for="network">Select Network:</label>
				<select id="network" name="network" class="form-control" required>
					<option value="">-- Select Network --</option>
					<option value="Airtel">Airtel</option>
					<option value="Vodafone">Vodafone</option>
					<option value="Idea">Idea</option>
					<option value="Jio">Jio</option>
					<!-- Add more options as needed -->
				</select><br><br>

				<label for="rechargePlan">Select Recharge Plan:</label>
				<select id="rechargePlan" name="rechargePlan" class="form-control" required>
					<option value="">-- Select Recharge Plan --</option>
					<option value="19">19rupees</option>
					<option value="99">99rupees</option>
					<option value="699">699rupees</option>
					<!-- Add more options as needed -->
				</select><br><br>

				<label for="paymentMethod">Select Payment Method:</label>
				<select id="paymentMethod" name="paymentMethod" class="form-control" required>
					<option value="">-- Select Payment Method --</option>
					
					<option value="Digipay Card Transfer">Digipay Card Transfer</option>
					<!-- Add more options as needed -->
				</select><br><br>
				
				<button type="submit" class="btn">Submit</button>
			</form>
		</div>

		<div id="rightDiv">
			<div class="promotion-card">
				<div class="promotion-content">
					<h3>Special Offer</h3>
					<p>Get 10% cashback on your first recharge using Digipay!</p>
				</div>
				<div class="promotion-blob"></div>
			</div>
		</div>
	</div>
</body>
</html>
