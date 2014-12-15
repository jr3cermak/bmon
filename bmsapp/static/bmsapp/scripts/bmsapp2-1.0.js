// Generated by CoffeeScript 1.6.3
(function() {
  var update_bldg_list, update_chart_sensor_lists;

  window.AN = {};

  update_chart_sensor_lists = function() {
    var url;
    url = "" + ($("#BaseURL").text()) + "chart_sensor_list/" + ($("#select_group").val()) + "/" + ($("#select_bldg").val()) + "/";
    return $.getJSON(url, function(data) {
      $("#select_chart").html(data.charts);
      $("#select_sensor").html(data.sensors);
      $("#select_sensor_x").html(data.sensors);
      return $("#select_sensor_y").html(data.sensors);
    });
  };

  update_bldg_list = function() {
    return $("#select_bldg").load("" + ($("#BaseURL").text()) + "bldg_list/" + ($("#select_group").val()) + "/", function() {
      return $("#select_bldg").trigger("change");
    });
  };

  $(function() {
    var d;
    $("#time_period").buttonset();
    $("#start_date").datepicker({
      dateFormat: "mm/dd/yy"
    });
    d = new Date();
    $("#start_date").val((d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear());
    $("#end_date").datepicker({
      dateFormat: "mm/dd/yy"
    });
    $("#custom_dates").hide(0);
    $("#time_period").change(function() {
      if ($("input:radio[name=time_period]:checked").val() !== "custom") {
        return $("#custom_dates").hide();
      } else {
        return $("#custom_dates").show();
      }
    });
    $("#refresh").button();
    $("#normalize").button();
    $("#divide_date").datepicker({
      dateFormat: "mm/dd/yy"
    });
    $("#download_many").button();
    $("#select_group").change(update_bldg_list);
    return $("#select_bldg").change(update_chart_sensor_lists);
  });

}).call(this);
