(function($){
  $(function(){

  	// Materialize event handlers
    $('.button-collapse').sideNav();
    $('.parallax').parallax();
    $('.modal-trigger').leanModal();

    // jQuery Validate event handler
    $('#commentForm').validate({
    	submitHandler: function(form) {
    	    $(form).ajaxSubmit({
    	        type:"POST",
    	        data: $(form).serialize(),
    	        url:"index.php",
    	        success: function() {
    	            alert('Thank you, your message was sent successfully! We will be in touch shortly');
    	        },
    	        error: function() {
    	            alert('Something went wrong, try refreshing and submitting the form again.');
    	        }
    	    });
    	}
    });
  }); // end of document ready
})(jQuery); // end of jQuery name space