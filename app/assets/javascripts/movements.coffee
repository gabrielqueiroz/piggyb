# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('.mov-button').on "click", ->
    movement = (Number) $(this).text()
    value = (Number) $('#mov-value').val()
    $('#mov-value').val((value + movement).toFixed 2)
