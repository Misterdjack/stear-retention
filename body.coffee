if Meteor.isClient
    Template.body.onRendered ->
         #Materialize event handlers
        $('.button-collapse').sideNav()
        $('.parallax').parallax()
        $('.modal-trigger').leanModal()
         #jQuery Validate event handler
        #$('#interestform').validate()
        #console.log $('#interestform')


    Template.body.events
        'submit #interestform': (e,t) ->
            #console.log e.target
            values = {}
            $.each $('#interestform').serializeArray(), (i, field) ->
                values[field.name] = field.value
            #console.log "values:",values

            requests = []
            $.each $('input[name="request"]:checked'), ->
                requests.push $(@).val()
            #console.log 'Request catagories are: ' + requests.join(', ')

            values.requests = requests

            Meteor.call 'sendEmail', values
            $('#modal1').closeModal()
            false

if Meteor.isServer
    Meteor.methods
        sendEmail: (values) ->
            @unblock()
            text = 'Name: ' + values.firstname + ' ' + values.lastname + '\n\n' +
                    'Institution: ' + values.institution + '\n\n' +
                    'Email: ' + values.email + '\n\n' +
                    'Message: ' + values.message + '\n\n' +
                    'Other Requests: ' + values.otherrequests + '\n\n' +
                    'Telephone: ' + values.telephone + '\n\n' +
                    'Title: ' + values.title + '\n\n' +
                    'Requests: ' + values.requests
            #console.log "about to send the email"
            #console.log values
            Email.send
                to: 'repjackson@gmail.com'
                from: 'test@sender.com'
                subject: 'Stear Retention Contact Form'
                text: text
    Meteor.startup ->
        process.env.MAIL_URL = 'smtp://postmaster%40sandbox1b77ad44ac3343d9bdf4c3ff681904c9.mailgun.org:e91e08eb4e58c4f79bd66e3dc25e5742@smtp.mailgun.org:587'