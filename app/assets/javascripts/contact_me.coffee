# Contact Form Scripts
$ ->
  $('#contactForm input,#contactForm textarea').jqBootstrapValidation
    preventSubmit: true
    submitError: ($form, event, errors) ->
      # additional error messages or events
      return
    submitSuccess: ($form, event) ->
      event.preventDefault()
      # prevent default submit behaviour
      # get values from FORM
      name = $('input#name').val()
      email = $('input#email').val()
      phone = $('input#phone').val()
      message = $('textarea#message').val()
      firstName = name
      # For Success/Failure Message
      # Check for white space in name for Success/Fail message
      if firstName.indexOf(' ') >= 0
        firstName = name.split(' ').slice(0, -1).join(' ')
      $.ajax
        url: '././mail/contact_me.php'
        type: 'POST'
        data:
          name: name
          phone: phone
          email: email
          message: message
        cache: false
        success: ->
          # Success message
          $('#success').html '<div class=\'alert alert-success\'>'
          $('#success > .alert-success').html('<button type=\'button\' class=\'close\' data-dismiss=\'alert\' aria-hidden=\'true\'>&times;').append '</button>'
          $('#success > .alert-success').append '<strong>Your message has been sent. </strong>'
          $('#success > .alert-success').append '</div>'
          #clear all fields
          $('#contactForm').trigger 'reset'
          return
        error: ->
          # Fail message
          $('#success').html '<div class=\'alert alert-danger\'>'
          $('#success > .alert-danger').html('<button type=\'button\' class=\'close\' data-dismiss=\'alert\' aria-hidden=\'true\'>&times;').append '</button>'
          $('#success > .alert-danger').append '<strong>Sorry ' + firstName + ', it seems that my mail server is not responding. Please try again later!'
          $('#success > .alert-danger').append '</div>'
          #clear all fields
          $('#contactForm').trigger 'reset'
          return
      return
    filter: ->
      $(this).is ':visible'
  $('a[data-toggle="tab"]').click (e) ->
    e.preventDefault()
    $(this).tab 'show'
    return
  return

###When clicking on Full hide fail/success boxes ###

$('#name').focus ->
  $('#success').html ''
  return
