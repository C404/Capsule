# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

api = '/1'

angular.module('capsules', ['ngResource']).factory 'Capsules', ($resource) ->
  Capsules = $resource(api + '/capsules')
  return Capsules

angular.module('sessions', ['ngResource']).factory 'Sessions', ($resource) ->
  Sessions = $resource(api + '/sessions')
  Sessions.token = null
  Sessions.login = (user, Sessions) ->
    Sessions.token = $resource(api + '/sessions').get()
  return Sessions

angular.module('Capsule', ['ui', 'ui.directives', 'capsules', 'sessions']).config ($routeProvider) =>
  $routeProvider.when '/', {templateUrl:'/'}
  $routeProvider.when '/capsule', {controller:CapsuleCtrl, templateUrl:'/ng/capsule'}
  $routeProvider.otherwise {redirectTo:'/'}
