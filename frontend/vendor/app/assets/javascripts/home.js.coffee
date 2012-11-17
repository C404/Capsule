# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$("document").ready ->
    jQuery.ias({
        container : '#allCapsules',
        item: '.video-view',
        pagination: '#content .navigation',
        next: '.next-infinite-loader',
        loader: false,
        history: false
    })