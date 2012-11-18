window.UsersCtrl = ($scope, Users, Sessions) ->

  $scope.newUser = Users.getNewUser()
  $scope.users = Users.get()
  $scope.saveNewUser = () ->
    Users.save($scope.newUser.response)
    $location.path('/users')
  $scope.login = () ->
    Sessions.login($scope.newUser)
