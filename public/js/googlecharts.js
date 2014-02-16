 google.load("visualization", "1", {packages:["corechart"]});
function drawPieChart(rawData, elementId) {
	google.setOnLoadCallback(function () {
		var data = google.visualization.arrayToDataTable(rawData)
		var chart = new google.visualization.PieChart(document.getElementById(elementId));
		chart.draw(data);
	});
}

function drawBarChart(rawData, elementId) {
	google.setOnLoadCallback(function () {
		var data = google.visualization.arrayToDataTable(rawData)
		var chart = new google.visualization.BarChart(document.getElementById(elementId));
		chart.draw(data);
	});
}

function drawLineChart(rawData, elementId) {
	google.setOnLoadCallback(function () {
		var data = google.visualization.arrayToDataTable(rawData)
		var chart = new google.visualization.LineChart(document.getElementById(elementId));
		chart.draw(data);
	});
}