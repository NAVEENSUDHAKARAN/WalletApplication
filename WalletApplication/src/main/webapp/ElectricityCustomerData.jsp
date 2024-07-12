<%@page import="org.springframework.web.bind.annotation.RequestParam"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.chainsys.walletapplication.model.Users" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Consumer Details</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
    color: #333;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
  }

  .container {
    width: 100%;
    max-width: 600px;
    background-color: white;
    padding: 30px;
    border-radius: 5px;
    box-shadow: 0 4px 8px grey;
  }

  .form-group {
    margin-bottom: 20px;
  }

  label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
  }

  #consumerNumber,#consumerName,#serviceNumber,#contactNumber{
    width: 95%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    transition: border-color 0.3s;
  }

  .inp:focus,
  .inp:hover {
    outline: none;
    cursor: pointer;
    border-color: #3c455c;
  }

  .getButton {
	position:relative;
	left: 85%;
    background-color: #3c455c;
    color: white;
    border: none;
    padding: 12px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s;
  }

  .getButton:hover {
    background-color: #353535;
  }
</style>
</head>
<body>

<div class="container">

	 <a href="LandingPage.jsp" ><img alt="not working" src="images/DigiPayNoBG.png" width="40px" height="40px" ></a> 
  <h2 style="text-align: center;">Consumer Details</h2>
  <form action="ConsumerData" method="post">
    <div class="form-group">
      <label for="consumerNumber">Consumer Number</label>
      <input class="inp" id="consumerNumber" name="consumerNumber" type="text" placeholder="Enter Consumer Number" required="required">
    </div>

    <div class="form-group">
      <label for="consumerName">Name of Consumer</label>
      <input class="inp" id="consumerName" name="consumerName" type="text" placeholder="Enter Name" required>
    </div>

    <div class="form-group">
      <label for="serviceNumber">Service Number</label>
      <input class="inp" id="serviceNumber" name="serviceNumber" type="text" placeholder="Enter Service Number" required>
    </div>

    <div class="form-group">
      <label for="contactNumber">Contact Number</label>
      <input class="inp" id="contactNumber" name="contactNumber" type="text" placeholder="Enter Contact Number" required>
    </div>

    <div class="form-group">
      <button onclick="" class="getButton" type="submit">Next</button>
    </div>
  </form>
</div>

</body>
</html>
