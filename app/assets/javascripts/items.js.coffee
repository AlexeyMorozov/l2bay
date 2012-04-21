jQuery ->
  $('abbr.timeago').timeago();
  $('#server_param').change ->
    window.location = $(this).val();
