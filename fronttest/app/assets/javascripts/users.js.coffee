window.UsersCtrl = ($scope, $location, Users, Sessions) ->

  $scope.isLogged = () ->
    if Sessions.token == null
      return false
    return true
  $scope.newUser = Users.getNewUser()
  $scope.users = Users.get()
  $scope.saveNewUser = () ->
    Users.save($scope.newUser.response, (data) ->
      console.log(data))
      
  $scope.login = () ->
    Sessions.login($scope.newUser.response)
    $location.path('/users')

  $scope.logout = () ->
    Sessions.logout()
