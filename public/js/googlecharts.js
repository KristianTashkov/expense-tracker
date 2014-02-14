 google.load("visualization", "1", {packages:["corechart"]});
function drawPieChart(chartData, elementId) {
	google.setOnLoadCallback(function () {
		var data = google.visualization.arrayToDataTable(chartData)
		var chart = new google.visualization.PieChart(document.getElementById(elementId));
		chart.draw(data);
	});
}