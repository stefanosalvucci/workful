function initialize() {
  $( ".add-perk-modal" ).on( "submit", function() {
    $(this).modal('hide');
  });

  $('[data-toggle="tooltip"]').tooltip()
}

$(document).ready(initialize);
$(document).on('page:load', initialize); // turbolinks changes