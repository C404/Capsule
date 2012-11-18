window.UsersCtrl = ($scope, $location, Users, Sessions) ->

  $scope.newUser = Users.getNewUser()
  $scope.users = Users.get()
  $scope.saveNewUser = () ->
    Users.save($scope.newUser.response, (data) ->
      console.log(data))
#     $location.path('/users')
  $scope.login = () ->
    Sessions.login($scope.newUser.response)
