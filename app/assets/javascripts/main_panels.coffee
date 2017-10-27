# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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

  add_build: (new_build, label, data) ->
    chart = @build_chart()
    @addData(chart, label, data)
    @build_chart()

  addData: (chart, label, data) ->
    chart.data.labels.push label
    chart.data.datasets.forEach (dataset) ->
      dataset.data.push data
      return
    chart.update()

  build_chart: () ->
    ctx = document.getElementById('myChart').getContext('2d')
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [{
          label: 'Successful Builds',
          data: [],
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