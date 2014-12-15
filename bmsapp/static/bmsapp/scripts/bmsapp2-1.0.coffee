# my object to contain all global variables and functions.  Minimizes
# global namespace pollution.
window.AN = {}

# Updates the list of charts and sensors appropriate for the building selected.
update_chart_sensor_lists = ->
  # load the options from a AJAX query for the selected building
  url = "#{$("#BaseURL").text()}chart_sensor_list/#{$("#select_group").val()}/#{$("#select_bldg").val()}/"
  $.getJSON url, (data) ->
    $("#select_chart").html(data.charts)
    $("#select_sensor").html(data.sensors)
    $("#select_sensor_x").html(data.sensors)
    $("#select_sensor_y").html(data.sensors)
    # *** Update Results here
    # update_results()

# Updates the list of buildings associated with the Building Group selected.
update_bldg_list = ->
  # load the building choices from a AJAX query for the selected building group
  $("#select_bldg").load "#{$("#BaseURL").text()}bldg_list/#{$("#select_group").val()}/", ->
    # trigger the change event of the building selector to get the 
    # selected option to process.
    $("#select_bldg").trigger "change"

# function that runs when the document is ready.
$ ->
  # Configure many of the elements that commonly appear in chart configuration
  # form.
  $("#time_period").buttonset()

  # Related to selecting the range of dates to chart
  $("#start_date").datepicker dateFormat: "mm/dd/yy"
  d = new Date() # current date to use for a default for Start Date
  $("#start_date").val (d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear()
  $("#end_date").datepicker dateFormat: "mm/dd/yy"
  $("#custom_dates").hide 0 # hide custom dates element
  # Show and Hide custom date range selector
  $("#time_period").change ->
    unless $("input:radio[name=time_period]:checked").val() is "custom"
      $("#custom_dates").hide()
    else
      $("#custom_dates").show()

  $("#refresh").button()     # make refresh button a jQuery button
  $("#normalize").button()   # checkbox to create normalized (0-100%) hourly profile
  $("#divide_date").datepicker dateFormat: "mm/dd/yy"   # for xy plot
  $("#download_many").button()   # export to Excel Button

  # Set up controls and functions to respond to events
  $("#select_group").change update_bldg_list
  $("#select_bldg").change update_chart_sensor_lists
  # $("#select_chart").change AN.update_chart_html
