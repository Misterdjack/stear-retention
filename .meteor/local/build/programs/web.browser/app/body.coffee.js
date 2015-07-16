(function(){__coffeescriptShare = typeof __coffeescriptShare === 'object' ? __coffeescriptShare : {}; var share = __coffeescriptShare;
if (Meteor.isClient) {
  Template.body.onRendered(function() {
    $('.button-collapse').sideNav();
    $('.parallax').parallax();
    return $('.modal-trigger').leanModal();
  });
  Template.body.events({
    'submit #interestform': function(e, t) {
      var requests, values;
      console.log(e.target);
      values = {};
      $.each($('#interestform').serializeArray(), function(i, field) {
        return values[field.name] = field.value;
      });
      console.log("values:", values);
      requests = [];
      $.each($('input[name="request"]:checked'), function() {
        return requests.push($(this).val());
      });
      console.log('Request catagories are: ' + requests.join(', '));
      values.requests = requests;
      Meteor.call('sendEmail', values);
      return false;
    }
  });
}

if (Meteor.isServer) {
  Meteor.methods({
    sendEmail: function(values) {
      var text;
      text = 'Name: ' + values.firstname + ' ' + values.lastname + '\n\n' + 'Institution: ' + values.institution + '\n\n' + 'Email: ' + values.email + '\n\n' + 'Message: ' + values.message + '\n\n' + 'Other Requests: ' + values.otherrequests + '\n\n' + 'Telephone: ' + values.telephone + '\n\n' + 'Title: ' + values.title + '\n\n' + 'Requests: ' + values.requests;
      console.log("about to send the email");
      console.log(values);
      return Email.send({
        to: 'repjackson@gmail.com',
        from: 'test@sender.com',
        subject: 'Website Contact Form - Message From ',
        text: text
      });
    }
  });
}

})();
