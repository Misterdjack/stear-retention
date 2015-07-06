(function($){
  $(function(){

  	// Materialize event handlers
    $('.button-collapse').sideNav();
    $('.parallax').parallax();
    $('.modal-trigger').leanModal();

    // jQuery Validate event handler
    $('#commentForm').validate();
  }); // end of document ready
})(jQuery); // end of jQuery name space