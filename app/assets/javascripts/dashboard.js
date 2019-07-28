// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function () {

  let chartConfig = {
    type: 'hbar',
    fontFamily: 'Arial',
    title: {
      text: 'Overall App Rating',
      backgroundColor: 'none',
      fontColor: '#A4A4A4',
      fontFamily: 'Arial',
      fontSize: '18px'
    },
    plot: {
      animation: {
        delay: 300,
        effect: 'ANIMATION_EXPAND_TOP',
        method: 'ANIMATION_LINEAR',
        sequence: 'ANIMATION_BY_PLOT_AND_NODE',
        speed: '500'
      },
      barsOverlap: '100%',
      borderRadius: '8px',
      hoverState: {
        visible: false
      }
    },
    plotarea: {
      margin: '60px 10px 10px 140px'
    },
    scaleX: {
      values: ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'],
      guide: {
        visible: false
      },
      item: {
        paddingRight: '20px',
        autoAlign: true,
        fontSize: '14px',
        rules: [
          {
            fontColor: '#FA8452',
            rule: '%i==0'
          },
          {
            fontColor: '#FCAE48',
            rule: '%i==1'
          },
          {
            fontColor: '#FCCC65',
            rule: '%i==2'
          },
          {
            fontColor: '#A0BE4A',
            rule: '%i==3'
          },
          {
            fontColor: '#6FA6DF',
            rule: '%i==4'
          }
        ]
      },
      lineColor: 'none',
      tick: {
        visible: false
      }
    },
    scaleY: {
      guide: {
        visible: false
      },
      visible: false
    },
    arrows: [
      {
        backgroundColor: '#CCCCCC',
        borderWidth: '0px',
        direction: 'bottom',
        to: {
          x: '6%',
          y: '27%'
        },
        from: {
          x: '6%',
          y: '79%'
        }
      }
    ],
    labels: [
      {
        text: 'DAYS',
        fontColor: '#9d9d9d',
        fontSize: '12px',
        x: '11.5%',
        y: '10%'
      },
      {
        text: 'CUSTOMERS',
        fontColor: '#9d9d9d',
        fontSize: '12px',
        x: '20%',
        y: '10%'
      },
      {
        text: 'GOAL',
        fontColor: '#9d9d9d',
        fontSize: '12px',
        x: '4%',
        y: '10%'
      }
    ],
    shapes: [
      {
        type: 'circle',
        backgroundColor: 'white',
        borderColor: '#6FA6DF',
        borderWidth: '3px',
        size: 14,
        x: '45px',
        y: '99px'
      },
      {
        type: 'circle',
        backgroundColor: '#6FA6DF',
        size: 2,
        x: '40px',
        y: '95px'
      },
      {
        type: 'circle',
        backgroundColor: '#6FA6DF',
        size: 2,
        x: '50px',
        y: '95px'
      },
      {
        type: 'pie',
        angleStart: 0,
        angleEnd: 180,
        backgroundColor: '#5297b6',
        size: 8,
        x: '45px',
        y: '100px'
      },
      {
        type: 'pie',
        angleStart: 0,
        angleEnd: 180,
        backgroundColor: '#fff',
        size: 6,
        x: '45px',
        y: '100px'
      },
      {
        type: 'circle',
        backgroundColor: 'white',
        borderColor: '#FA8452',
        borderWidth: '3px',
        size: 14,
        x: '45px',
        y: '433px'
      },
      {
        type: 'circle',
        backgroundColor: '#FA8452',
        size: 2,
        x: '40px',
        y: '429px'
      },
      {
        type: 'circle',
        backgroundColor: '#FA8452',
        size: 2,
        x: '50px',
        y: '429px'
      },
      {
        type: 'pie',
        angleStart: 170,
        angleEnd: 10,
        backgroundColor: '#FA8452',
        size: 8,
        x: '45px',
        y: '439px'
      },
      {
        type: 'pie',
        angleStart: 170,
        angleEnd: 10,
        backgroundColor: '#fff',
        size: 5,
        x: '45px',
        y: '440px'
      }
    ],
    series: [
      {
        values: [1200, 1200, 1200, 1200, 1200],
        tooltip: {
          visible: false
        },
        backgroundColor: '#f2f2f2',
        barWidth: '40px',
        borderColor: '#e8e3e3',
        borderWidth: '2px',
        fillAngle: 90
      },
      {
        values: [42, 56, 77, 44, 81],
        valueBox: {
          text: '%v',
          alpha: 0.5,
          decimals: 0,
          fontColor: '#111111',
          fontSize: '14px',
          placement: 'top-out',
        },
        barWidth: '32px',
        maxTrackers: 0,
        rules: [
          {
            backgroundColor: '#FA8452',
            rule: '%i==0'
          },
          {
            backgroundColor: '#FCAE48',
            rule: '%i==1'
          },
          {
            backgroundColor: '#FCCC65',
            rule: '%i==2'
          },
          {
            backgroundColor: '#A0BE4A',
            rule: '%i==3'
          },
          {
            backgroundColor: '#6FA6DF',
            rule: '%i==4'
          }
        ]
      }
    ]
  };

  let chartConfig2 = {
    type: 'area',
    stacked: true,
    title: {
      text: 'Sentiment Analysis by Version',
      adjustLayout: true,
      marginTop: '15px',
      fontColor: '#424242'
    },
    plot: {
      alphaArea: 0.6,
      aspect: 'spline'
    },
    plotarea: {
      margin: 'dynamic'
    },
    scaleX: {
      item: {
        paddingTop: '5px',
        fontColor: '#616161'
      },
      label: {
        text: 'Versions',
        fontColor: '#616161'
      },
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
      lineColor: '#AAA5A5',
      tick: {
        lineColor: '#AAA5A5'
      }
    },
    scaleY: {
      guide: {
        lineColor: '#AAA5A5',
        lineStyle: 'dotted'
      },
      item: {
        paddingRight: '5px',
        fontColor: '#616161'
      },
      label: {
        text: 'Sentiment Score',
        fontColor: '#616161'
      },
      lineColor: '#AAA5A5',
      short: true,
      tick: {
        lineColor: '#AAA5A5'
      }
    },
    crosshairX: {
      lineColor: '#AAA5A5',
      plotLabel: {
        backgroundColor: '#EBEBEC',
        borderColor: '#AAA5A5',
        borderRadius: '2px',
        borderWidth: '2px',
        fontColor: '#616161',
        thousandsSeparator: ','
      },
      scaleLabel: {
        backgroundColor: '#EBEBEC',
        borderColor: '#AAA5A5',
        fontColor: '#424242'
      }
    },
    tooltip: {
      visible: false
    },
    series: [
      {
        text: 'Positive Sentiments',
        values: [3435, 4212, 1627, 3189, 2325, 1334, 1567, 2685],
        backgroundColor: '#4CAF50',
        lineColor: '#4CAF50',
        marker: {
          backgroundColor: '#4CAF50',
          borderColor: '#4CAF50'
        }
      },
      {
        text: 'Negative Sentiments',
        values: [2221, 3535, 4340, 2232, 4212, 1259, 3611, 4230],
        backgroundColor: '#E53935',
        lineColor: '#E53935',
        marker: {
          backgroundColor: '#E53935',
          borderColor: '#E53935'
        }
      },
    ]
  };

  let settings = {
    // entries: entries,
    // width: 480,
    // height: 480,
    width: '100%',
    height: '100%',
    radius: '65%',
    radiusMin: 75,
    bgDraw: true,
    bgColor: '#0000',
    opacityOver: 1.00,
    opacityOut: 0.05,
    opacitySpeed: 6,
    fov: 800,
    speed: 1,
    fontSize: '20px',
    fontColor: '#111',
    fontWeight: 'normal',
    fontStyle: 'normal',
    fontStretch: 'normal',
    fontToUpperCase: true
  };
  $.ajax({
    url: '/get_chart_data',
    type: 'GET',
    success: function (data) {
      chartConfig.series[1]["values"] = data.chart1;
      zingchart.render({
        id: 'myChart1',
        data: chartConfig
      });
      chartConfig2.series[0]["values"] = data.chart2.positives;
      chartConfig2.series[1]["values"] = data.chart2.negatives;
      chartConfig2.scaleX["labels"] = data.chart2.keys;
      zingchart.render({
        id: 'myChart2',
        data: chartConfig2
      });
      debugger;
      settings.entries = data.cloud_entries.map(tag => ({'label': tag, 'target': '_top'}));
      $( '#holder' ).svg3DTagCloud( settings );
    },
    contentType: false,
    processData: false
  });

});
