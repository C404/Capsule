
pageNb = 0

window.CapsuleCtrl = ($scope, Capsules, Sessions) ->
  console.log Capsules
  $scope.items = []

  $scope.loadMore = ->
    Capsules.getCapsules(++pageNb, (data) ->
        $scope.items = $scope.items.concat(data.response)
    )
  $scope.loadMore()
