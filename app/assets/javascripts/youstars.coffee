youstars.factory('userService', ['$http', ($http) ->
	return {
		userName: "devinsupertramp"		# STATIC PLACEHOLDER.
	}
])


youstars.directive('masthead', ['userService', '$timeout', (userService, $timeout) ->
	return {
		restrict: "E"
		replace: true
		link: (scope, element, attr) ->

			# scope.headerString = userService.userName.split("")
			scope.headerArray = userService.userName.split("")
			# $(document).ready($('#ys-header span').addClass('ys-header-before'))
			$timeout( () ->
				$('#ys-header span').addClass('ys-header-before')
			, 0
			)
			
		template:
			"""
			<div id="ys-header">
				<span ng-repeat="letter in headerArray track by $index"style=" transition-delay: {{$index * 50}}ms">{{letter}}</span>
			</div>
			"""
	}
])




















