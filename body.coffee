if Meteor.isClient

    Template.body.onRendered ->
         #Materialize event handlers
        $('.button-collapse').sideNav()
        $('.parallax').parallax()
        $('.modal-trigger').leanModal()
         #jQuery Validate event handler
        $('#commentForm').validate()

    Template.body.events
        'submit #interestform': (e,t) ->
            console.log e.target
            values = {}
            $.each $('#interestform').serializeArray(), (i, field) ->
                values[field.name] = field.value
            console.log "values:",values
            false

#if Meteor.isServer
    #Meteor.methods
        #sendEmail: (doc) ->
         #Important server-side check for security and data integrity
        #check doc, Schemas.contacts
         #Build the e-mail text
        #text = 'Name: ' + doc.name + '\n\n' + 'Email: ' + doc.email + '\n\n\n\n' + doc.message
        #@unblock()
        #console.log "about to send the email"
         #Send the e-mail
        #Email.send
            #to: 'someone@somewhere.com'
            #from: doc.email
            #subject: 'Website Contact Form - Message From ' + doc.name
            #text: text
