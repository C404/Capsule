window.UsersCtrl = ($scope, $location, Users, Sessions) ->
  if ((token = window.readCookie('capsuleauthtoken')) != null)
    Sessions.token = token
    $scope.currentUser = Users.getUser(window.readCookie('capsuleuserid'))
  else
    Sessions.token = null
    $scope.currentUser = null

  $scope.isLogged = () ->
    if Sessions.token == null
      return false
    return true
  $scope.newUser = Users.getNewUser()
  $scope.users = Users.get()
  $scope.saveNewUser = () ->
    Users.save($scope.newUser.response)
      
  $scope.login = () ->
    callback = (data) ->
      if (data.error == "unauthenticated")
        console.log("Error login")
      else
        Sessions.token = data.response.token
        window.createCookie('capsuleauthtoken', data.response.token, 1)
        window.createCookie('capsuleuserid', data.response.user_id, 1)
        $location.path('capsule')

    Sessions.login($scope.newUser.response, callback)
    
  $scope.logout = () ->
    Sessions.logout()

