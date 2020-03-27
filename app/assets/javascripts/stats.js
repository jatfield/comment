$(document).ready(function(){
var container = document.getElementById('stats_chart');
if (container) {
var series_data = Object.entries(JSON.parse(container.dataset.series))
console.log(series_data);
var series = [];
var max = 0;
for (var i = 0; i < series_data.length; i++) {

  series.push({name: series_data[i][0], data: [series_data[i][1]]})
  max = series_data[i][1] > max ? series_data[i][1] : max
}
console.log(series);
var data = {
    series: series
    };
    var options = {
        chart: {
            width: 800,
            height: 650,
            title: 'Hozzászólások',
            format: '1,000'
        },
        yAxis: {
            title: 'User'
        },
        xAxis: {
            title: 'Hsz',
            min: 0,
            max: max,
            suffix: 'db'
        },
        series: {
            showLabel: true
        },
	legend: {
	    showCheckbox: false
	},
	chartExportMenu: {
	    visible: false
	}
    };
    var theme = {
        series: {
            colors: [
                '#882000', '#68d0a8', '#a838a0', '#50b818', '#181090',
                '#f0e858', '#a04800', '#472b1b', '#c87870', '#484848',
		'#808080', '#98ff98', '#5090d0', '#b8b8b8'
            ]
        }
    };

    // For apply theme

    // tui.chart.registerTheme('myTheme', theme);
    // options.theme = 'myTheme';

    tui.chart.barChart(container, data, options);
}
});
