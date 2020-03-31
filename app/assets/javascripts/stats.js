$(document).ready(function(){
var barContainer = document.getElementById('stats_barchart');
var lineContainer = document.getElementById('stats_linechart');
if (barContainer) {
var series_data = Object.entries(JSON.parse(barContainer.dataset.series))
var line_series_data = Object.entries(JSON.parse(lineContainer.dataset.series))
var barSeries = [];
var max = 0;
for (var i = 0; i < series_data.length; i++) {

  barSeries.push({name: series_data[i][0], data: [series_data[i][1]]})
  max = series_data[i][1] > max ? series_data[i][1] : max
}
var data = {
    series: barSeries
    };
    var options = {
        chart: {
            width: 800,
            height: 650,
            format: '1,000'
        },
        yAxis: {
            title: 'Hozzászólások'
        },
        xAxis: {
            title: 'User',
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

    tui.chart.registerTheme('myTheme', theme);
    options.theme = 'myTheme';

    tui.chart.columnChart(barContainer, data, options);
}
if (lineContainer) {
var line_series_data = Object.entries(JSON.parse(lineContainer.dataset.series))
var lineSeries = [{name: 'Hozzászólások', data: []}];
var max = 0;
for (var i = 0; i < line_series_data.length; i++) {
  lineSeries[0].data.push(line_series_data[i][1].post_count);
}
for (var i = lineSeries[0].data.length; i < 12; i++) {
  lineSeries[0].data.push(0);
}
var data = {
    categories: ['Január', 'Február', 'Március', 'Április', 'Május', 'Június', 'Július', 'Augusztus', 'Szeptember', 'Október', 'November', 'December'],
    series: lineSeries
    };
    var options = {
        chart: {
            width: 800,
            height: 650,
        },
        yAxis: {
            title: 'Hozzászólások'
        },
        xAxis: {
            title: 'Hónap',
        },
        series: {
	    showDot: true,
            showLabel: true
        },
	legend: {
	    visible: false
	},
	tooltip: {
	    suffix: 'db'
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

    tui.chart.lineChart(lineContainer, data, options);
}
});
