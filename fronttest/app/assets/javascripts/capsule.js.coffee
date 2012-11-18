
window.CapsuleCtrl = ($scope, Capsules, Sessions) ->
  $scope.capsules = Capsules.getCapsules((data) ->
    console.log(data.response))
  