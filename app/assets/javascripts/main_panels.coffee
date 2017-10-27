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

  addData: (chart, label, month_name) ->
    month_index = MONTHS.indexOf(month_name)

    chart.data.datasets[0].data[month_index]++
    chart.update()

    builds_string = @getCookie('builds')
    builds_array = @stringToArray(builds_string)
    builds_array[month_index]++
    builds_string = builds_array.join('')
    console.log(builds_array)
    @setCookie('builds', builds_string, 365)

  stringToArray: (string) ->
    array = string.split('')
    i = 0
    while i < array.length
      array[i] = +array[i]
      i++
    return array

  setCookie: (cname, cvalue, exdays) ->
    d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    console.log(d)
    expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";

  getCookie: (cname) ->
    name = cname + '='
    decodedCookie = decodeURIComponent(document.cookie)
    ca = decodedCookie.split(';')
    i = 0
    while i < ca.length
      c = ca[i]
      while c.charAt(0) == ' '
        c = c.substring(1)
      if c.indexOf(name) == 0
        return c.substring(name.length, c.length)
      i++
    ''

  build_chart: () ->
    ctx = document.getElementById('myChart').getContext('2d')
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        datasets: [{
          label: 'Successful Builds',
          data: @stringToArray(@getCookie('builds')),
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