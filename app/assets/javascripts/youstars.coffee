youstars.factory('userService', ['$http', ($http) ->
  return {
    userName: "devinsupertramp"		# STATIC PLACEHOLDER.
  }
])

youstars.factory('mastheadService', [ () ->
  return {
    animateMasthead: () ->
      $('#ys-header span').addClass('ys-header-before')
  }
])


youstars.directive('masthead', ['userService', 'mastheadService', '$timeout', (userService, mastheadService, $timeout) ->
  return {
    restrict: "E"
    replace: true
    link: (scope, element, attr) ->
      scope.headerArray = userService.userName.split("")
      $timeout( mastheadService.animateMasthead, 0 )
    template:
      """
      <div id="ys-header">
      <span ng-repeat="letter in headerArray track by $index"style=" transition-delay: {{$index * 50}}ms">{{letter}}</span>
      </div>
      """
  }
])




















