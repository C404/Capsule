
window.CapsuleCtrl = ($scope, Capsules, Sessions) ->
  $scope.capsules = Capsules.get()
#   console.log(Sessions.token)
  return true
  