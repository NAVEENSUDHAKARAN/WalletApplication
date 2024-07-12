<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Electricity Bill Payment</title>
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
  	position: relative;
  	right: 10%;
    width: 100%;
    height: 85%;
    max-width: 600px;
    background-color: white;
    padding: 20px;
  	box-shadow: 0 0 10px grey;
    border-radius: 5px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  }

  .form-group {
    margin-bottom: 10px;
  }

  label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
  }

  .inp {
    width: 90%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    transition: border-color 0.3s;
  }

  .inp:focus,
  .inp:hover {
    outline: none;
    border-color: #3c455c;
    cursor: pointer;
  }

  .select {
    width: 90%;
    padding: 10px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: white;
    color: #333;
    transition: border-color 0.3s;
  }

  .select:focus,
  .select:hover {
    outline: none;
    border-color: #3c455c;
    cursor: pointer;
  }

  .getButton {
    background-color: #3c455c;
    color: white;
    border: none;
    position: relative;
    left:80%;
    top:20px;
    padding: 8px 10px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s;
  }

  .getButton:hover {
    background-color: #353535;
  }

  .box {
    margin-top: 20px;
    width:20%;
    padding: 5px;
    background-color: white;
    color: #3c455c;
   	padding-left: 20px;
    box-shadow: 0 0 10px grey;
    border-radius: 5px;
    font-size: 1.5em;
  }

  .foot {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    background-color: #333;
    color: white;
    text-align: center;
    padding: 10px 0;
  }

  .navbar-brand {
    font-size: 0.9em;
  }
</style>
</head>
<body>

<div class="container">
  <h2 style="text-align: center;">Electricity Bill Payment</h2>
  <form action="#box" role="form" name="elecForm" class="form">
  	
    <div class="form-group">
      <label for="curr">Current Reading</label>
      <input class="inp" name="curr" type="number" value="" placeholder="Units in kWh">
    </div>

    <div class="form-group">
      <label for="prev">Previous Reading</label>
      <input class="inp" name="prev" type="number" value="" placeholder="Units in kWh">
    </div>

    <div class="form-group">
      <label for="startDate">Start Date</label>
      <input class="inp" name="startDate" type="date">
    </div>

    <div class="form-group">
      <label for="endDate">End Date</label>
      <input class="inp" name="endDate" type="date">
    </div>

    <div class="form-group">
      <label for="sancLoad">Sanctioned Load</label>
      <select class="select" name="sancLoad">
        <option>2 kW</option>
        <option>>2-5 kW</option>
      </select>
    </div>

    <div class="form-group">
      <button class="getButton" type="button" onClick="calcBill(this.form)">Get Bill</button>
    </div>
  </form>
</div>

<div class="box" id="box">
  <h2>Bill:</h2>
  <form action="ElectricityRecharge" method="post">
  		<span class="change" name="billAmount"  id="change"></span>
	  <input type="hidden" class="change" name="billAmount"  id="change1" >
	  <span><input type="submit" value="Proceed" ></span>
  </form>

</div>
<script>
Date.prototype.monthDays = function() {
  var d = new Date(this.getFullYear(), this.getMonth()+1, 0);
  return d.getDate();
}

function getSlab(sDate, eDate) {
  var slab = 0;
  if (sDate.getMonth() === eDate.getMonth()) {
    slab += (eDate.getDate() + 1 - sDate.getDate()) / sDate.monthDays();
  } else {
    slab += (sDate.monthDays() + 1 - sDate.getDate()) / sDate.monthDays();
    slab += eDate.getDate() / eDate.monthDays();
  }
  return slab;
}

function unitsPrice(units, slab) {
  var pay = 0;
  if (units < 0) {
    return pay;
  }

  if (units === 0) {
    return pay;
  }

  if (units > 1200) {
    pay += ((units - 1200) * slab) * 8.75;
    units = 1200;
    return pay + unitsPrice(units, slab);
  } else if (units > 800) {
    pay += ((units - 800) * slab) * 8.10;
    units = 800;
    return pay + unitsPrice(units, slab);
  } else if (units > 400) {
    pay += ((units - 400) * slab) * 7.30;
    units = 400;
    return pay + unitsPrice(units, slab);
  } else if (units > 200) {
    pay += ((units - 200) * slab) * 5.95;
    units = 200;
    return pay + unitsPrice(units, slab);
  } else {
    pay += (units * slab) * 4.00;
    units = 0;
    return pay + unitsPrice(units, slab);
  }
}

function calcBill(f) {
  var units = parseFloat(f.curr.value) - parseFloat(f.prev.value);
  units = parseInt(units);
  var startDate = new Date(f.startDate.value);
  var endDate = new Date(f.endDate.value);
  
  var slab = getSlab(startDate, endDate);
  var bill = 0;

  if (f.sancLoad.value === "2 kW") {
    bill += 40 * slab * 1.08;
  }
  if (f.sancLoad.value === ">2-5 kW") {
    bill += 100 * slab * 1.08;
  }

  bill += unitsPrice(units, slab);
  bill = bill * 1.06;
  bill = bill * 1.08;
  bill = bill * 1.05;

  bill = bill.toFixed(2);

  if (!units) {
    document.getElementById("change").innerHTML = "Wrong Input";
    return;
  }

  document.getElementById("change").innerHTML = "&#8377;" + bill + " (incl. taxes)";
  document.getElementById("change1").value =bill;
  var scrollPos = document.getElementById("box").offsetTop;
  window.scrollTo(0, scrollPos);
}
</script>

</body>
</html>
