@Contacts = new Meteor.Collection('contacts')
Schemas = {}
Schemas.Contacts = new SimpleSchema
    webdemo:
        type: Boolean
        optional: true
        label: 'Request a Web Demonstration'

    alert:
        type: Boolean
        optional: true
        label: 'Request Early Alert Information'

    retention:
        type: Boolean
        optional: true
        label: 'Request Retention Services'

    visit:
        type: Boolean
        optional: true
        label: 'Contact Sales / Schedule A Site Visit'

    joint:
        type: Boolean
        optional: true
        label: 'Learn About Joint Development Partnerships'
    other:
        type: Boolean
        optional: true
        label: 'Other (please specify below)'

    firstName:
        type: String
        min: 2

    lastName:
        type: String
        min: 2

    institution:
        type: String
        min: 2

    telephone:
        type: String
        min: 2

    title:
        type: String
        min: 2

    email:
        type: String
        regEx: SimpleSchema.RegEx.Email
        label: "E-mail address"
        autoform:
            placeholder: "John@doe.com"

    message:
        type: String
        max: 400
        optional: true
        autoform:
            placeholder: "Message"
            rows: 3

Contacts.attachSchema(Schemas.Contacts)





if Meteor.isClient
    AutoForm.debug()
    #AutoForm.setDefaultTemplate('materialize')
    Template.body.onRendered ->
         #Materialize event handlers
        $('.button-collapse').sideNav()
        $('.parallax').parallax()
        $('.modal-trigger').leanModal()
         #jQuery Validate event handler
        $('#interestform').validate()

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

            Meteor.call 'sendEmail', values, (err, result) ->

                if err
                    alert "Didn't send"
                    console.log 'what is this: ', @
                $('#modal1').closeModal()
            false

    Template.body.helpers
        contactFormSchema: ->
            Schemas.Contacts

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
    Meteor.startup ->
        process.env.MAIL_URL = 'smtp://postmaster%40sandbox1b77ad44ac3343d9bdf4c3ff681904c9.mailgun.org:e91e08eb4e58c4f79bd66e3dc25e5742@smtp.mailgun.org:587'
