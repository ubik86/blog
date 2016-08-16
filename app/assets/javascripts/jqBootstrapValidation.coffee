### jqBootstrapValidation
# A plugin for automating validation on Twitter Bootstrap formatted forms.
#
# v1.3.6
#
# License: MIT <http://opensource.org/licenses/mit-license.php> - see LICENSE file
#
# http://ReactiveRaven.github.com/jqBootstrapValidation/
###

(($) ->
  createdElements = []
  defaults = 
    options:
      prependExistingHelpBlock: false
      sniffHtml: true
      preventSubmit: true
      submitError: false
      submitSuccess: false
      semanticallyStrict: false
      autoAdd: helpBlocks: true
      filter: ->
        # return $(this).is(":visible"); // only validate elements you can see
        true
        # validate everything
    methods:
      init: (options) ->
        settings = $.extend(true, {}, defaults)
        settings.options = $.extend(true, settings.options, options)
        $siblingElements = this
        uniqueForms = $.unique($siblingElements.map(->
          $(this).parents('form')[0]
        ).toArray())
        $(uniqueForms).bind 'submit', (e) ->
          $form = $(this)
          warningsFound = 0
          $inputs = $form.find('input,textarea,select').not('[type=submit],[type=image]').filter(settings.options.filter)
          $inputs.trigger('submit.validation').trigger 'validationLostFocus.validation'
          $inputs.each (i, el) ->
            $this = $(el)
            $controlGroup = $this.parents('.form-group').first()
            if $controlGroup.hasClass('warning')
              $controlGroup.removeClass('warning').addClass 'error'
              warningsFound++
            return
          $inputs.trigger 'validationLostFocus.validation'
          if warningsFound
            if settings.options.preventSubmit
              e.preventDefault()
            $form.addClass 'error'
            if $.isFunction(settings.options.submitError)
              settings.options.submitError $form, e, $inputs.jqBootstrapValidation('collectErrors', true)
          else
            $form.removeClass 'error'
            if $.isFunction(settings.options.submitSuccess)
              settings.options.submitSuccess $form, e
          return
        @each ->
          # Get references to everything we're interested in
          $this = $(this)
          $controlGroup = $this.parents('.form-group').first()
          $helpBlock = $controlGroup.find('.help-block').first()
          $form = $this.parents('form').first()
          validatorNames = []
          # create message container if not exists
          if !$helpBlock.length and settings.options.autoAdd and settings.options.autoAdd.helpBlocks
            $helpBlock = $('<div class="help-block" />')
            $controlGroup.find('.controls').append $helpBlock
            createdElements.push $helpBlock[0]
          # =============================================================
          #                                     SNIFF HTML FOR VALIDATORS
          # =============================================================
          # *snort sniff snuffle*
          if settings.options.sniffHtml
            message = ''
            # ---------------------------------------------------------
            #                                                   PATTERN
            # ---------------------------------------------------------
            if $this.attr('pattern') != undefined
              message = 'Not in the expected format<!-- data-validation-pattern-message to override -->'
              if $this.data('validationPatternMessage')
                message = $this.data('validationPatternMessage')
              $this.data 'validationPatternMessage', message
              $this.data 'validationPatternRegex', $this.attr('pattern')
            # ---------------------------------------------------------
            #                                                       MAX
            # ---------------------------------------------------------
            if $this.attr('max') != undefined or $this.attr('aria-valuemax') != undefined
              max = if $this.attr('max') != undefined then $this.attr('max') else $this.attr('aria-valuemax')
              message = 'Too high: Maximum of \'' + max + '\'<!-- data-validation-max-message to override -->'
              if $this.data('validationMaxMessage')
                message = $this.data('validationMaxMessage')
              $this.data 'validationMaxMessage', message
              $this.data 'validationMaxMax', max
            # ---------------------------------------------------------
            #                                                       MIN
            # ---------------------------------------------------------
            if $this.attr('min') != undefined or $this.attr('aria-valuemin') != undefined
              min = if $this.attr('min') != undefined then $this.attr('min') else $this.attr('aria-valuemin')
              message = 'Too low: Minimum of \'' + min + '\'<!-- data-validation-min-message to override -->'
              if $this.data('validationMinMessage')
                message = $this.data('validationMinMessage')
              $this.data 'validationMinMessage', message
              $this.data 'validationMinMin', min
            # ---------------------------------------------------------
            #                                                 MAXLENGTH
            # ---------------------------------------------------------
            if $this.attr('maxlength') != undefined
              message = 'Too long: Maximum of \'' + $this.attr('maxlength') + '\' characters<!-- data-validation-maxlength-message to override -->'
              if $this.data('validationMaxlengthMessage')
                message = $this.data('validationMaxlengthMessage')
              $this.data 'validationMaxlengthMessage', message
              $this.data 'validationMaxlengthMaxlength', $this.attr('maxlength')
            # ---------------------------------------------------------
            #                                                 MINLENGTH
            # ---------------------------------------------------------
            if $this.attr('minlength') != undefined
              message = 'Too short: Minimum of \'' + $this.attr('minlength') + '\' characters<!-- data-validation-minlength-message to override -->'
              if $this.data('validationMinlengthMessage')
                message = $this.data('validationMinlengthMessage')
              $this.data 'validationMinlengthMessage', message
              $this.data 'validationMinlengthMinlength', $this.attr('minlength')
            # ---------------------------------------------------------
            #                                                  REQUIRED
            # ---------------------------------------------------------
            if $this.attr('required') != undefined or $this.attr('aria-required') != undefined
              message = settings.builtInValidators.required.message
              if $this.data('validationRequiredMessage')
                message = $this.data('validationRequiredMessage')
              $this.data 'validationRequiredMessage', message
            # ---------------------------------------------------------
            #                                                    NUMBER
            # ---------------------------------------------------------
            if $this.attr('type') != undefined and $this.attr('type').toLowerCase() == 'number'
              message = settings.builtInValidators.number.message
              if $this.data('validationNumberMessage')
                message = $this.data('validationNumberMessage')
              $this.data 'validationNumberMessage', message
            # ---------------------------------------------------------
            #                                                     EMAIL
            # ---------------------------------------------------------
            if $this.attr('type') != undefined and $this.attr('type').toLowerCase() == 'email'
              message = 'Not a valid email address<!-- data-validator-validemail-message to override -->'
              if $this.data('validationValidemailMessage')
                message = $this.data('validationValidemailMessage')
              else if $this.data('validationEmailMessage')
                message = $this.data('validationEmailMessage')
              $this.data 'validationValidemailMessage', message
            # ---------------------------------------------------------
            #                                                MINCHECKED
            # ---------------------------------------------------------
            if $this.attr('minchecked') != undefined
              message = 'Not enough options checked; Minimum of \'' + $this.attr('minchecked') + '\' required<!-- data-validation-minchecked-message to override -->'
              if $this.data('validationMincheckedMessage')
                message = $this.data('validationMincheckedMessage')
              $this.data 'validationMincheckedMessage', message
              $this.data 'validationMincheckedMinchecked', $this.attr('minchecked')
            # ---------------------------------------------------------
            #                                                MAXCHECKED
            # ---------------------------------------------------------
            if $this.attr('maxchecked') != undefined
              message = 'Too many options checked; Maximum of \'' + $this.attr('maxchecked') + '\' required<!-- data-validation-maxchecked-message to override -->'
              if $this.data('validationMaxcheckedMessage')
                message = $this.data('validationMaxcheckedMessage')
              $this.data 'validationMaxcheckedMessage', message
              $this.data 'validationMaxcheckedMaxchecked', $this.attr('maxchecked')
          # =============================================================
          #                                       COLLECT VALIDATOR NAMES
          # =============================================================
          # Get named validators
          if $this.data('validation') != undefined
            validatorNames = $this.data('validation').split(',')
          # Get extra ones defined on the element's data attributes
          $.each $this.data(), (i, el) ->
            parts = i.replace(/([A-Z])/g, ',$1').split(',')
            if parts[0] == 'validation' and parts[1]
              validatorNames.push parts[1]
            return
          # =============================================================
          #                                     NORMALISE VALIDATOR NAMES
          # =============================================================
          validatorNamesToInspect = validatorNames
          newValidatorNamesToInspect = []
          loop
            # Uppercase only the first letter of each name
            $.each validatorNames, (i, el) ->
              validatorNames[i] = formatValidatorName(el)
              return
            # Remove duplicate validator names
            validatorNames = $.unique(validatorNames)
            # Pull out the new validator names from each shortcut
            newValidatorNamesToInspect = []
            $.each validatorNamesToInspect, (i, el) ->
              if $this.data('validation' + el + 'Shortcut') != undefined
                # Are these custom validators?
                # Pull them out!
                $.each $this.data('validation' + el + 'Shortcut').split(','), (i2, el2) ->
                  newValidatorNamesToInspect.push el2
                  return
              else if settings.builtInValidators[el.toLowerCase()]
                # Is this a recognised built-in?
                # Pull it out!
                validator = settings.builtInValidators[el.toLowerCase()]
                if validator.type.toLowerCase() == 'shortcut'
                  $.each validator.shortcut.split(','), (i, el) ->
                    el = formatValidatorName(el)
                    newValidatorNamesToInspect.push el
                    validatorNames.push el
                    return
              return
            validatorNamesToInspect = newValidatorNamesToInspect
            unless validatorNamesToInspect.length > 0
              break
          # =============================================================
          #                                       SET UP VALIDATOR ARRAYS
          # =============================================================
          validators = {}
          $.each validatorNames, (i, el) ->
            `var message`
            # Set up the 'override' message
            message = $this.data('validation' + el + 'Message')
            hasOverrideMessage = message != undefined
            foundValidator = false
            message = if message then message else '\'' + el + '\' validation failed <!-- Add attribute \'data-validation-' + el.toLowerCase() + '-message\' to input to change this message -->'
            $.each settings.validatorTypes, (validatorType, validatorTemplate) ->
              if validators[validatorType] == undefined
                validators[validatorType] = []
              if !foundValidator and $this.data('validation' + el + formatValidatorName(validatorTemplate.name)) != undefined
                validators[validatorType].push $.extend(true, {
                  name: formatValidatorName(validatorTemplate.name)
                  message: message
                }, validatorTemplate.init($this, el))
                foundValidator = true
              return
            if !foundValidator and settings.builtInValidators[el.toLowerCase()]
              validator = $.extend(true, {}, settings.builtInValidators[el.toLowerCase()])
              if hasOverrideMessage
                validator.message = message
              validatorType = validator.type.toLowerCase()
              if validatorType == 'shortcut'
                foundValidator = true
              else
                $.each settings.validatorTypes, (validatorTemplateType, validatorTemplate) ->
                  if validators[validatorTemplateType] == undefined
                    validators[validatorTemplateType] = []
                  if !foundValidator and validatorType == validatorTemplateType.toLowerCase()
                    $this.data 'validation' + el + formatValidatorName(validatorTemplate.name), validator[validatorTemplate.name.toLowerCase()]
                    validators[validatorType].push $.extend(validator, validatorTemplate.init($this, el))
                    foundValidator = true
                  return
            if !foundValidator
              $.error 'Cannot find validation info for \'' + el + '\''
            return
          # =============================================================
          #                                         STORE FALLBACK VALUES
          # =============================================================
          $helpBlock.data 'original-contents', if $helpBlock.data('original-contents') then $helpBlock.data('original-contents') else $helpBlock.html()
          $helpBlock.data 'original-role', if $helpBlock.data('original-role') then $helpBlock.data('original-role') else $helpBlock.attr('role')
          $controlGroup.data 'original-classes', if $controlGroup.data('original-clases') then $controlGroup.data('original-classes') else $controlGroup.attr('class')
          $this.data 'original-aria-invalid', if $this.data('original-aria-invalid') then $this.data('original-aria-invalid') else $this.attr('aria-invalid')
          # =============================================================
          #                                                    VALIDATION
          # =============================================================
          $this.bind 'validation.validation', (event, params) ->
            value = getValue($this)
            # Get a list of the errors to apply
            errorsFound = []
            $.each validators, (validatorType, validatorTypeArray) ->
              if value or value.length or params and params.includeEmpty or ! !settings.validatorTypes[validatorType].blockSubmit and params and ! !params.submitting
                $.each validatorTypeArray, (i, validator) ->
                  if settings.validatorTypes[validatorType].validate($this, value, validator)
                    errorsFound.push validator.message
                  return
              return
            errorsFound
          $this.bind 'getValidators.validation', ->
            validators
          # =============================================================
          #                                             WATCH FOR CHANGES
          # =============================================================
          $this.bind 'submit.validation', ->
            $this.triggerHandler 'change.validation', submitting: true
          $this.bind [
            'keyup'
            'focus'
            'blur'
            'click'
            'keydown'
            'keypress'
            'change'
          ].join('.validation ') + '.validation', (e, params) ->
            value = getValue($this)
            errorsFound = []
            $controlGroup.find('input,textarea,select').each (i, el) ->
              oldCount = errorsFound.length
              $.each $(el).triggerHandler('validation.validation', params), (j, message) ->
                errorsFound.push message
                return
              if errorsFound.length > oldCount
                $(el).attr 'aria-invalid', 'true'
              else
                original = $this.data('original-aria-invalid')
                $(el).attr 'aria-invalid', if original != undefined then original else false
              return
            $form.find('input,select,textarea').not($this).not('[name="' + $this.attr('name') + '"]').trigger 'validationLostFocus.validation'
            errorsFound = $.unique(errorsFound.sort())
            # Were there any errors?
            if errorsFound.length
              # Better flag it up as a warning.
              $controlGroup.removeClass('success error').addClass 'warning'
              # How many errors did we find?
              if settings.options.semanticallyStrict and errorsFound.length == 1
                # Only one? Being strict? Just output it.
                $helpBlock.html errorsFound[0] + (if settings.options.prependExistingHelpBlock then $helpBlock.data('original-contents') else '')
              else
                # Multiple? Being sloppy? Glue them together into an UL.
                $helpBlock.html '<ul role="alert"><li>' + errorsFound.join('</li><li>') + '</li></ul>' + (if settings.options.prependExistingHelpBlock then $helpBlock.data('original-contents') else '')
            else
              $controlGroup.removeClass 'warning error success'
              if value.length > 0
                $controlGroup.addClass 'success'
              $helpBlock.html $helpBlock.data('original-contents')
            if e.type == 'blur'
              $controlGroup.removeClass 'success'
            return
          $this.bind 'validationLostFocus.validation', ->
            $controlGroup.removeClass 'success'
            return
          return
      destroy: ->
        @each ->
          $this = $(this)
          $controlGroup = $this.parents('.form-group').first()
          $helpBlock = $controlGroup.find('.help-block').first()
          # remove our events
          $this.unbind '.validation'
          # events are namespaced.
          # reset help text
          $helpBlock.html $helpBlock.data('original-contents')
          # reset classes
          $controlGroup.attr 'class', $controlGroup.data('original-classes')
          # reset aria
          $this.attr 'aria-invalid', $this.data('original-aria-invalid')
          # reset role
          $helpBlock.attr 'role', $this.data('original-role')
          # remove all elements we created
          if createdElements.indexOf($helpBlock[0]) > -1
            $helpBlock.remove()
          return
      collectErrors: (includeEmpty) ->
        errorMessages = {}
        @each (i, el) ->
          $el = $(el)
          name = $el.attr('name')
          errors = $el.triggerHandler('validation.validation', includeEmpty: true)
          errorMessages[name] = $.extend(true, errors, errorMessages[name])
          return
        $.each errorMessages, (i, el) ->
          if el.length == 0
            delete errorMessages[i]
          return
        errorMessages
      hasErrors: ->
        errorMessages = []
        @each (i, el) ->
          errorMessages = errorMessages.concat(if $(el).triggerHandler('getValidators.validation') then $(el).triggerHandler('validation.validation', submitting: true) else [])
          return
        errorMessages.length > 0
      override: (newDefaults) ->
        defaults = $.extend(true, defaults, newDefaults)
        return
    validatorTypes:
      callback:
        name: 'callback'
        init: ($this, name) ->
          {
            validatorName: name
            callback: $this.data('validation' + name + 'Callback')
            lastValue: $this.val()
            lastValid: true
            lastFinished: true
          }
        validate: ($this, value, validator) ->
          if validator.lastValue == value and validator.lastFinished
            return !validator.lastValid
          if validator.lastFinished == true
            validator.lastValue = value
            validator.lastValid = true
            validator.lastFinished = false
            rrjqbvValidator = validator
            rrjqbvThis = $this
            executeFunctionByName validator.callback, window, $this, value, (data) ->
              if rrjqbvValidator.lastValue == data.value
                rrjqbvValidator.lastValid = data.valid
                if data.message
                  rrjqbvValidator.message = data.message
                rrjqbvValidator.lastFinished = true
                rrjqbvThis.data 'validation' + rrjqbvValidator.validatorName + 'Message', rrjqbvValidator.message
                # Timeout is set to avoid problems with the events being considered 'already fired'
                setTimeout (->
                  rrjqbvThis.trigger 'change.validation'
                  return
                ), 1
                # doesn't need a long timeout, just long enough for the event bubble to burst
              return
          false
      ajax:
        name: 'ajax'
        init: ($this, name) ->
          {
            validatorName: name
            url: $this.data('validation' + name + 'Ajax')
            lastValue: $this.val()
            lastValid: true
            lastFinished: true
          }
        validate: ($this, value, validator) ->
          if '' + validator.lastValue == '' + value and validator.lastFinished == true
            return validator.lastValid == false
          if validator.lastFinished == true
            validator.lastValue = value
            validator.lastValid = true
            validator.lastFinished = false
            $.ajax
              url: validator.url
              data: 'value=' + value + '&field=' + $this.attr('name')
              dataType: 'json'
              success: (data) ->
                if '' + validator.lastValue == '' + data.value
                  validator.lastValid = ! !data.valid
                  if data.message
                    validator.message = data.message
                  validator.lastFinished = true
                  $this.data 'validation' + validator.validatorName + 'Message', validator.message
                  # Timeout is set to avoid problems with the events being considered 'already fired'
                  setTimeout (->
                    $this.trigger 'change.validation'
                    return
                  ), 1
                  # doesn't need a long timeout, just long enough for the event bubble to burst
                return
              failure: ->
                validator.lastValid = true
                validator.message = 'ajax call failed'
                validator.lastFinished = true
                $this.data 'validation' + validator.validatorName + 'Message', validator.message
                # Timeout is set to avoid problems with the events being considered 'already fired'
                setTimeout (->
                  $this.trigger 'change.validation'
                  return
                ), 1
                # doesn't need a long timeout, just long enough for the event bubble to burst
                return
          false
      regex:
        name: 'regex'
        init: ($this, name) ->
          { regex: regexFromString($this.data('validation' + name + 'Regex')) }
        validate: ($this, value, validator) ->
          !validator.regex.test(value) and !validator.negative or validator.regex.test(value) and validator.negative
      required:
        name: 'required'
        init: ($this, name) ->
          {}
        validate: ($this, value, validator) ->
          ! !(value.length == 0 and !validator.negative) or ! !(value.length > 0 and validator.negative)
        blockSubmit: true
      match:
        name: 'match'
        init: ($this, name) ->
          element = $this.parents('form').first().find('[name="' + $this.data('validation' + name + 'Match') + '"]').first()
          element.bind 'validation.validation', ->
            $this.trigger 'change.validation', submitting: true
            return
          { 'element': element }
        validate: ($this, value, validator) ->
          value != validator.element.val() and !validator.negative or value == validator.element.val() and validator.negative
        blockSubmit: true
      max:
        name: 'max'
        init: ($this, name) ->
          { max: $this.data('validation' + name + 'Max') }
        validate: ($this, value, validator) ->
          parseFloat(value, 10) > parseFloat(validator.max, 10) and !validator.negative or parseFloat(value, 10) <= parseFloat(validator.max, 10) and validator.negative
      min:
        name: 'min'
        init: ($this, name) ->
          { min: $this.data('validation' + name + 'Min') }
        validate: ($this, value, validator) ->
          parseFloat(value) < parseFloat(validator.min) and !validator.negative or parseFloat(value) >= parseFloat(validator.min) and validator.negative
      maxlength:
        name: 'maxlength'
        init: ($this, name) ->
          { maxlength: $this.data('validation' + name + 'Maxlength') }
        validate: ($this, value, validator) ->
          value.length > validator.maxlength and !validator.negative or value.length <= validator.maxlength and validator.negative
      minlength:
        name: 'minlength'
        init: ($this, name) ->
          { minlength: $this.data('validation' + name + 'Minlength') }
        validate: ($this, value, validator) ->
          value.length < validator.minlength and !validator.negative or value.length >= validator.minlength and validator.negative
      maxchecked:
        name: 'maxchecked'
        init: ($this, name) ->
          elements = $this.parents('form').first().find('[name="' + $this.attr('name') + '"]')
          elements.bind 'click.validation', ->
            $this.trigger 'change.validation', includeEmpty: true
            return
          {
            maxchecked: $this.data('validation' + name + 'Maxchecked')
            elements: elements
          }
        validate: ($this, value, validator) ->
          validator.elements.filter(':checked').length > validator.maxchecked and !validator.negative or validator.elements.filter(':checked').length <= validator.maxchecked and validator.negative
        blockSubmit: true
      minchecked:
        name: 'minchecked'
        init: ($this, name) ->
          elements = $this.parents('form').first().find('[name="' + $this.attr('name') + '"]')
          elements.bind 'click.validation', ->
            $this.trigger 'change.validation', includeEmpty: true
            return
          {
            minchecked: $this.data('validation' + name + 'Minchecked')
            elements: elements
          }
        validate: ($this, value, validator) ->
          validator.elements.filter(':checked').length < validator.minchecked and !validator.negative or validator.elements.filter(':checked').length >= validator.minchecked and validator.negative
        blockSubmit: true
    builtInValidators:
      email:
        name: 'Email'
        type: 'shortcut'
        shortcut: 'validemail'
      validemail:
        name: 'Validemail'
        type: 'regex'
        regex: '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}'
        message: 'Not a valid email address<!-- data-validator-validemail-message to override -->'
      passwordagain:
        name: 'Passwordagain'
        type: 'match'
        match: 'password'
        message: 'Does not match the given password<!-- data-validator-paswordagain-message to override -->'
      positive:
        name: 'Positive'
        type: 'shortcut'
        shortcut: 'number,positivenumber'
      negative:
        name: 'Negative'
        type: 'shortcut'
        shortcut: 'number,negativenumber'
      number:
        name: 'Number'
        type: 'regex'
        regex: '([+-]?\\d+(\\.\\d*)?([eE][+-]?[0-9]+)?)?'
        message: 'Must be a number<!-- data-validator-number-message to override -->'
      integer:
        name: 'Integer'
        type: 'regex'
        regex: '[+-]?\\d+'
        message: 'No decimal places allowed<!-- data-validator-integer-message to override -->'
      positivenumber:
        name: 'Positivenumber'
        type: 'min'
        min: 0
        message: 'Must be a positive number<!-- data-validator-positivenumber-message to override -->'
      negativenumber:
        name: 'Negativenumber'
        type: 'max'
        max: 0
        message: 'Must be a negative number<!-- data-validator-negativenumber-message to override -->'
      required:
        name: 'Required'
        type: 'required'
        message: 'This is required<!-- data-validator-required-message to override -->'
      checkone:
        name: 'Checkone'
        type: 'minchecked'
        minchecked: 1
        message: 'Check at least one option<!-- data-validation-checkone-message to override -->'

  formatValidatorName = (name) ->
    name.toLowerCase().replace /(^|\s)([a-z])/g, (m, p1, p2) ->
      p1 + p2.toUpperCase()

  getValue = ($this) ->
    # Extract the value we're talking about
    value = $this.val()
    type = $this.attr('type')
    if type == 'checkbox'
      value = if $this.is(':checked') then value else ''
    if type == 'radio'
      value = if $('input[name="' + $this.attr('name') + '"]:checked').length > 0 then value else ''
    value

  regexFromString = (inputstring) ->
    new RegExp('^' + inputstring + '$')

  ###*
  # Thanks to Jason Bunting via StackOverflow.com
  #
  # http://stackoverflow.com/questions/359788/how-to-execute-a-javascript-function-when-i-have-its-name-as-a-string#answer-359910
  # Short link: http://tinyurl.com/executeFunctionByName
  *
  ###

  executeFunctionByName = (functionName, context) ->
    args = Array::slice.call(arguments).splice(2)
    namespaces = functionName.split('.')
    func = namespaces.pop()
    i = 0
    while i < namespaces.length
      context = context[namespaces[i]]
      i++
    context[func].apply this, args

  $.fn.jqBootstrapValidation = (method) ->
    if defaults.methods[method]
      defaults.methods[method].apply this, Array::slice.call(arguments, 1)
    else if typeof method == 'object' or !method
      defaults.methods.init.apply this, arguments
    else
      $.error 'Method ' + method + ' does not exist on jQuery.jqBootstrapValidation'
      null

  $.jqBootstrapValidation = (options) ->
    $(':input').not('[type=image],[type=submit]').jqBootstrapValidation.apply this, arguments
    return

  return
) jQuery
