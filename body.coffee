if Meteor.isClient
    Template.body.onRendered ->
         #Materialize event handlers
        $('.button-collapse').sideNav()
        $('.parallax').parallax()
        $('.modal-trigger').leanModal()


    Template.body.events
        'submit #interestform': (e,t) ->
            console.log e.target
            values = {}
            $.each $('#interestform').serializeArray(), (i, field) ->
                values[field.name] = field.value
            console.log "values:",values

            requests = []
            $.each $('input[name="request"]:checked'), ->
                requests.push $(@).val()
            console.log 'Request catagories are: ' + requests.join(', ')

            values.requests = requests

            Meteor.call 'sendEmail', values
            false

if Meteor.isServer
    Meteor.methods
        sendEmail: (values) ->
            text = 'Name: ' + values.firstname + ' ' + values.lastname + '\n\n' +
                    'Institution: ' + values.institution + '\n\n' +
                    'Email: ' + values.email + '\n\n' +
                    'Message: ' + values.message + '\n\n' +
                    'Other Requests: ' + values.otherrequests + '\n\n' +
                    'Telephone: ' + values.telephone + '\n\n' +
                    'Title: ' + values.title + '\n\n' +
                    'Requests: ' + values.requests
            console.log "about to send the email"
            console.log values
            Email.send
                to: 'repjackson@gmail.com'
                from: 'test@sender.com'
                subject: 'Website Contact Form - Message From '
                text: text
