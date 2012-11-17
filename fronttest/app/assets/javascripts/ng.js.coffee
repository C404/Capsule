# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

api = '/api/1'                

angular.module('events', ['ngResource']).factory 'Events', ($resource) ->
  Events = $resource('/api/1/hire/events/:id')
  Events.update = (cb) ->
    return Events.update({id: this._id.$oid}, angular.extend({}, this, {_id:undefined}), cb)
  Events.destroy = (cb) ->
    return Events.remove({id: this._id.$oid}, cb)
  Events.newEvent = (cb) ->
    return $resource('/api/1/hire/events/new').get()
  Events.getContainers = (cb) ->
    return $resource('/api/1/hire/events/containers/:id').get()
  return Events

angular.module('Capsule', ['ui', 'ui.directives', 'events']).config ($routeProvider) =>
  $routeProvider.when '/', {templateUrl:'/'}
  $routeProvider.when '/capsule', {controller:CapsuleCtrl, templateUrl:'/ng/capsule'}
  $routeProvider.otherwise {redirectTo:'/'}
