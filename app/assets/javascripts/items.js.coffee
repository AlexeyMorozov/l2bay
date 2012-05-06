jQuery ->
  $('abbr.timeago').timeago();
  $('#server_param').change ->
    window.location = $(this).val();
  $('.others_toggler').click ->
    $(this).siblings().andSelf().toggle();
