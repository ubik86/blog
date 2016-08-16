# Floating label headings for the contact form
$ ->
  $('body').on('input propertychange', '.floating-label-form-group', (e) ->
    $(this).toggleClass 'floating-label-form-group-with-value', ! !$(e.target).val()
    return
  ).on('focus', '.floating-label-form-group', ->
    $(this).addClass 'floating-label-form-group-with-focus'
    return
  ).on 'blur', '.floating-label-form-group', ->
    $(this).removeClass 'floating-label-form-group-with-focus'
    return
  return
# Navigation Scripts to Show Header on Scroll-Up
jQuery(document).ready ($) ->
  MQL = 1170
  #primary navigation slide-in effect
  if $(window).width() > MQL
    headerHeight = $('.navbar-custom').height()
    $(window).on 'scroll', { previousTop: 0 }, ->
      currentTop = $(window).scrollTop()
      #check if user is scrolling up
      if currentTop < @previousTop
        #if scrolling up...
        if currentTop > 0 and $('.navbar-custom').hasClass('is-fixed')
          $('.navbar-custom').addClass 'is-visible'
        else
          $('.navbar-custom').removeClass 'is-visible is-fixed'
      else if currentTop > @previousTop
        #if scrolling down...
        $('.navbar-custom').removeClass 'is-visible'
        if currentTop > headerHeight and !$('.navbar-custom').hasClass('is-fixed')
          $('.navbar-custom').addClass 'is-fixed'
      @previousTop = currentTop
      return
  return
