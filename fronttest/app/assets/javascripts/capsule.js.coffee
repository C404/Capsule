
window.CapsuleCtrl = ($scope, Capsules, Sessions) ->
  $scope.capsules = Capsules.get((data) ->
    console.log(data.response))
  