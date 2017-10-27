# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

App.main_panels =
  active_users: {}

  new_user: (user) ->
    @active_users[user.id] = user
    @render_active_users()

  remove_user: (user) ->
    delete @active_users[user.id]
    @render_active_users()

  render_active_users: () ->
    $('#active_users_list').html(
      ("<li>#{user.id}</li>" for id,user of @active_users).join("")
    )


  add_build: (new_build, label) ->
    chart = @build_chart() # Grab latest chart data
    month_name = App.ci_builds.getMonthLabel(new_build)

    @addData(chart, label, month_name)
#    @build_chart()

  addData: (chart, label, month_name) ->
    console.log('current_chart_data: ' + chart.data.datasets[0].data[0])
    month_index = MONTHS.indexOf(month_name)
    console.log('month_index: ' + month_index)
    console.log('before: ' + chart.data.datasets[0].data[month_index])
    chart.data.datasets[0].data[month_index] = chart.data.datasets[0].data[month_index] + 1
    console.log('after: ' + chart.data.datasets[0].data[month_index])
    chart.update()

  build_chart: () ->
    ctx = document.getElementById('myChart').getContext('2d')
    months = document.getElementById('panel_container').getAttribute('data')
    months = months.split('')
    i = 0
    while i < months.length
      months[i] = +months[i]
      i++

    console.log('months: ' + months)
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [{
          label: 'Successful Builds',
          data: months,
          backgroundColor: "rgba(75, 192, 192, 0.2)",
          borderColor: "rgba(75, 192, 192, 1)",
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        scales: {
          xAxes: [{
            scaleLabel: {
              display: true,
              labelString: "months"
            },
            gridLines: {
              display: true,
            },
            ticks: {
              beginAtZero: true,
              fontColor: "#9faeaf"
            }
          }],
          yAxes: [{
            stacked: true,
            scaleLabel: {
              display: true,
              labelString: "quantity"
            },
            ticks: {
              beginAtZero: true,
              fontColor: "#9faeaf",
              suggestedMin: 0
            }
          }]
        }
      }
    })