if Meteor.isClient

    Template.body.onRendered ->
        # Materialize event handlers
        $('.button-collapse').sideNav()
        $('.parallax').parallax()
        $('.modal-trigger').leanModal()
        # jQuery Validate event handler
        $('#commentForm').validate()