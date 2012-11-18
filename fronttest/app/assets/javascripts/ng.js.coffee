# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

api = 'http://127.0.0.1/1'

angular.module('capsules', ['ngResource']).factory 'Capsules', ($resource) ->
  Capsules = $resource(api + '/capsules')
  Capsules.getCapsules = (pageNum = 0, callback) ->
    res = $resource(api + '/capsules/?page=#{pageNum}').get( (res) => callback?(res))
  Capsules
.directive("whenScrolled", ->
    (scope, elm, attr) ->
        raw = elm[0];
        $(window).scroll( (e) ->
            if $(document).scrollTop() + $(window).height() >= $(document).height()
                scope.$apply(attr.whenScrolled)
        )
    )

angular.module('users', ['ngResource']).factory 'Users', ($resource) ->

  Users = $resource(api + '/users/:id')
  Users.getUser = (id) ->
    return $resource(api + '/users/' + id).get((data) ->
      console.log(data))

  Users.getNewUser = () ->
    return $resource(api + '/users/new').get()
  return Users

angular.module('sessions', ['ngResource']).factory 'Sessions', ($resource) ->

  Sessions = $resource(api + '/sessions')
  Sessions.token = null
  
  Sessions.login = (user, callback) ->
    delete user.passwordConfirm
    delete user._id
    $resource(api + '/sessions').save(user, callback)
      
  Sessions.logout = () ->
    $resource(api + '/sessions?token=' + Sessions.token).remove()
    Sessions.token = null
    window.eraseCookie('capsuleauthtoken')
    window.eraseCookie('capsuleuserid')

  return Sessions

angular.module('Capsule', ['ui', 'ui.directives', 'capsules', 'sessions', 'users']).config ($routeProvider) =>
  $routeProvider.when '/capsule', {controller:CapsuleCtrl, templateUrl:'/ng/capsule'}
  $routeProvider.when '/users', {controller:UsersCtrl, templateUrl:'/ng/users'}
  $routeProvider.when '/user', {controller:UsersCtrl, templateUrl:'/ng/user'}
  $routeProvider.when '/profil', {controller:ProfilCtrl, templateUrl:'/ng/profil'}
  $routeProvider.when '/newuser', {controller:UsersCtrl, templateUrl:'/ng/newuser'}
  $routeProvider.when '/session', {controller:UsersCtrl, templateUrl:'/ng/session'}
  $routeProvider.otherwise {redirectTo:'/capsule'}
