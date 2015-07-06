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
    	        url:"process.php",
    	        success: function() {
    	            $('#commentForm :input').attr('disabled', 'disabled');
    	            $('#commentForm').fadeTo( "slow", 0.15, function() {
    	                $(this).find(':input').attr('disabled', 'disabled');
    	                $(this).find('label').css('cursor','default');
    	                $('#success').fadeIn();
    	            });
    	        },
    	        error: function() {
    	            $('#commentForm').fadeTo( "slow", 0.15, function() {
    	                $('#error').fadeIn();
    	            });
    	        }
    	    });
    	}
    });
  }); // end of document ready
})(jQuery); // end of jQuery name space