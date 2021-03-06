youstars.factory('userService', ['$http', ($http) ->
  return {
    currentChannel: null # to be populated
    afterInit: $.Deferred()
    loggedIn: $("#ys-app").is(".ys-logged-in")
    # user's remembered volume settings
    volumeSettings:
      muted: (newValue)->
        if newValue?
          localStorage.setItem('youstars:muted', angular.toJson(newValue))
          return newValue
        stored = angular.fromJson(localStorage.getItem('youstars:muted')) 
        return stored if stored?
        true
      volume: (newValue)->
        if newValue?
          localStorage.setItem('youstars:volume', angular.toJson(newValue))
          return newValue
        stored = angular.fromJson(localStorage.getItem('youstars:volume'))
        return stored if stored?
        100
    checkUserValidity: (user) ->
      userUrl = "https://gdata.youtube.com/feeds/api/users/#{user}?alt=json"
      $http.get(userUrl).then (data) ->
        data.entry

  }
])

youstars.directive('suggestedchannels', ['channelsService', (channelsService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', ($scope) ->
      channelsService.channelModalFirstShown.then ->
        if $scope.loggedIn
          channelsService.fetchSuggestedchannels().then (data) ->
            $scope.suggestedChannelsArray = data
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations ys-recommendations-channel">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="channel in suggestedChannelsArray" ng-mouseenter="enter($event);" ng-mouseleave="leave($event);">
            <a class="ys-recommendation-info" href="#/{{channel.name}}">
              <h3>{{channel.title}}</h3>
              <h4>{{channel.view_count | number: 0}} views</h4>
              <h4>{{channel.subscriber_count | number: 0}} subs</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="{{ channel.thumbnails.medium.url || channel.thumbnails.default.url }}" />
              <h3>{{channel.title}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])

youstars.directive('similarrecentchannels', ['channelsService', (channelsService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', ($scope) ->
      channelsService.channelModalFirstShown.then ->
        if $scope.loggedIn
          channelsService.fetchSimilarrecentchannels().then (data) ->
            $scope.similarrecentChannelsArray = data
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations ys-recommendations-channel">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="channel in similarrecentChannelsArray" ng-mouseenter="enter($event);" ng-mouseleave="leave($event);">
            <a class="ys-recommendation-info" href="#/{{channel.name}}">
              <h3>{{channel.title}}</h3>
              <h4>{{channel.view_count | number: 0}} views</h4>
              <h4>{{channel.subscriber_count | number: 0}} subs</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="{{ channel.thumbnails.medium.url || channel.thumbnails.default.url }}" />
              <h3>{{channel.title}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])

youstars.directive('mostsubscribedchannels', ['channelsService', (channelsService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', ($scope) ->
      channelsService.channelModalFirstShown.then ->
        channelsService.fetchMostsubscribedchannels().then (data) ->
          $scope.mostsubscribedChannelsArray = data
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations ys-recommendations-channel">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="channel in mostsubscribedChannelsArray">
            <a class="ys-recommendation-info" href="#/{{channel.name}}">
              <h3>{{channel.title}}</h3>
              <h4>{{channel.view_count | number: 0}} views</h4>
              <h4>{{channel.subscriber_count | number: 0}} subs</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="{{ channel.thumbnails.medium.url || channel.thumbnails.default.url }}" />
              <h3>{{channel.title}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])

youstars.directive('mostviewedchannels', ['channelsService', (channelsService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', ($scope) ->
      channelsService.channelModalFirstShown.then ->
        channelsService.fetchMostviewedchannels().then (data) ->
          $scope.mostviewedChannelsArray = data
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations ys-recommendations-channel">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="channel in mostviewedChannelsArray" ng-mouseenter="enter($event);" ng-mouseleave="leave($event);">
            <a class="ys-recommendation-info" href="#/{{channel.name}}">
              <h3>{{channel.title}}</h3>
              <h4>{{channel.view_count | number: 0}} views</h4>
              <h4>{{channel.subscriber_count | number: 0}} subs</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="{{ channel.thumbnails.medium.url || channel.thumbnails.default.url }}" />
              <h3>{{channel.title}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])

youstars.directive('recentchannels', ['channelsService', (channelsService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', ($scope) ->
      channelsService.channelModalFirstShown.then ->
        if $scope.loggedIn
          channelsService.fetchRecentchannels().then (data) ->
            $scope.recentChannelsArray = data
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations ys-recommendations-channel">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="channel in recentChannelsArray" ng-mouseenter="enter($event);" ng-mouseleave="leave($event);">
            <a class="ys-recommendation-info" href="#/{{channel.name}}">
              <h3>{{channel.title}}</h3>
              <h4>{{channel.view_count | number: 0}} views</h4>
              <h4>{{channel.subscriber_count | number: 0}} subs</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="{{ channel.thumbnails.medium.url || channel.thumbnails.default.url }}" />
              <h3>{{channel.title}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])

youstars.directive('similarchannels', ['channelsService', (channelsService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', ($scope) ->
      channelsService.channelModalFirstShown.then ->
        channelsService.fetchSimilarchannels().then (data) ->
          $scope.similarChannelsArray = data
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations ys-recommendations-channel">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="channel in similarChannelsArray" ng-mouseenter="enter($event);" ng-mouseleave="leave($event);">
            <a class="ys-recommendation-info" href="#/{{channel.name}}">
              <h3>{{channel.title}}</h3>
              <h4>{{channel.view_count | number: 0}} views</h4>
              <h4>{{channel.subscriber_count | number: 0}} subs</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="{{ channel.thumbnails.medium.url || channel.thumbnails.default.url }}" />
              <h3>{{channel.title}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])

youstars.directive('mychannel', ['channelsService', (channelsService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', ($scope) ->
      channelsService.channelModalFirstShown.then ->
        if $scope.loggedIn
          channelsService.fetchSimilarmychannel().then (data) ->
            $scope.similarMyChannelsArray = data
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations ys-recommendations-channel">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="channel in MyChannelsArray" ng-mouseenter="enter($event);" ng-mouseleave="leave($event);">
            <a class="ys-recommendation-info" href="#/{{channel.name}}">
              <h3>{{channel.title}}</h3>
              <h4>{{channel.view_count | number: 0}} views</h4>
              <h4>{{channel.subscriber_count | number: 0}} subs</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="{{ channel.thumbnails.medium.url || channel.thumbnails.default.url }}" />
              <h3>{{channel.title}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])


youstars.directive('mostwatchedvideos', ['videosService', (videosService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', 'videosService', ($scope, videosService) ->
      videosService.videoModalFirstShown.then ->
        if $scope.loggedIn
          videosService.fetchMostwatchedvideos().then (data) ->
            # no spaces please
            $scope.mostwatchedVideosArray = (piece for piece in data when piece.channel_name.indexOf(' ') < 0)
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="video in mostwatchedVideosArray" ng-mouseenter="enter($event);" ng-mouseleave="leave($event);">
            <a class="ys-recommendation-info" href="#/{{video.channel_name}}?currentVideo={{video.id}}">
              <h3>{{video.title}}</h3>
              <h4>{{video.statistics.views | number: 0}} views&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{{video.statistics.likes | number: 0}} likes</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="https://i1.ytimg.com/vi/{{video.id}}/mqdefault.jpg" />
              <h4>{{video.title}}</h4>
              <h3>{{video.channel_name}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])



youstars.directive('suggestedvideos', ['videosService', (videosService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', 'videosService', ($scope, videosService) ->
      videosService.videoModalFirstShown.then ->
        if $scope.loggedIn
          videosService.fetchSuggestedvideos().then (data) ->
            # only want ones that don't contain spaces. spaces can suck a dick.
            $scope.suggestedVideosArray = (piece for piece in data when piece.channel_name.indexOf(' ') < 0)
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="video in suggestedVideosArray" ng-mouseenter="enter($event);" ng-mouseleave="leave($event);">
            <a class="ys-recommendation-info" href="#/{{video.channel_name}}?currentVideo={{video.id}}">
              <h3>{{video.title}}</h3>
              <h4>{{video.statistics.views | number: 0}} views&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{{video.statistics.likes | number: 0}} likes</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="https://i1.ytimg.com/vi/{{video.id}}/mqdefault.jpg" />
              <h4>{{video.title}}</h4>
              <h3>{{video.channel_name}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])


youstars.directive('trendingvideos', ['videosService', (videosService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', 'videosService', ($scope, videosService) ->
      videosService.videoModalFirstShown.then ->
        videosService.fetchTrendingvideos().then (data) ->
          # no spaces please
          $scope.trendingVideosArray = (piece for piece in data when piece.channel_name.indexOf(' ') < 0)
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="video in trendingVideosArray" ng-mouseenter="enter($event);" ng-mouseleave="leave($event);">
            <a class="ys-recommendation-info" href="#/{{video.channel_name}}?currentVideo={{video.id}}">
              <h3>{{video.title}}</h3>
              <h4>{{video.statistics.views | number: 0}} views&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{{video.statistics.likes | number: 0}} likes</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="https://i1.ytimg.com/vi/{{video.id}}/mqdefault.jpg" />
              <h4>{{video.title}}</h4>
              <h3>{{video.channel_name}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])


youstars.directive('featuredvideos', ['videosService', (videosService) ->
  return {
    restrict: 'E'
    replace: true
    controller: ['$scope', 'videosService', ($scope, videosService) ->
      videosService.videoModalFirstShown.then ->
        videosService.fetchFeaturedvideos().then (data) ->
          # no spaces please
          $scope.featuredVideosArray = (piece for piece in data when piece.channel_name.indexOf(' ') < 0)
    ]
    link: (scope, element, attr) ->
      scope.enter = (e) ->
        currClass = $(e.currentTarget).attr("class").split(" ")[0]
        $('.' + currClass).removeClass('slideUp currentSelection')
        $(e.currentTarget).addClass('slideUp currentSelection')
      scope.leave = (e) ->
        $(e.currentTarget).removeClass('slideUp')
    template:
      """
      <div class="ys-recommendations">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="video in featuredVideosArray" ng-mouseenter="enter($event);" ng-mouseleave="leave($event);">
            <a class="ys-recommendation-info" href="#/{{video.channel_name}}?currentVideo={{video.id}}">
              <h3>{{video.title}}</h3>
              <h4>{{video.statistics.views | number: 0}} views&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{{video.statistics.likes | number: 0}} likes</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img ng-src="https://i1.ytimg.com/vi/{{video.id}}/mqdefault.jpg" />
              <h4>{{video.title}}</h4>
              <h3>{{video.channel_name}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])



youstars.factory('channelsService', ['$http', 'userService', '$location',
  ($http, userService, $location) ->
    hash =
      channels: []
      popular_channels: []
      channelModalFirstShown: $.Deferred()
      fetchSuggestedchannels: () ->
        $http.get('/suggest/channels.json').then (response) ->
          response.data
      fetchRecentchannels: () ->
        $http.get('/suggest/channels/recently_watched.json').then (response) ->
          response.data
      fetchSimilarmychannel: () ->
        $http.get('/suggest/channels/my_channel.json').then (response) ->
          response.data
      fetchSimilarrecentchannels: () ->
        $http.get('/suggest/channels/similar_to_recently_watched.json').then (response) ->
          response.data
      fetchMostsubscribedchannels: () ->
        $http.get('/suggest/channels/most_subscribed.json').then (response) ->
          response.data
      fetchMostviewedchannels: () ->
        $http.get('/suggest/channels/most_viewed.json').then (response) ->
          response.data
      fetchSimilarchannels: () ->
        $http.get('/suggest/channels/related/' + userService.currentChannel + '.json').then (response) ->
          response.data


    hash.fetch_channels = ->
      # storing results of this request in session storage, so back-and-
      # forth navigation can be faster
      channel = userService.currentChannel
      key = "fetch_channels:#{channel}"
      cache = sessionStorage.getItem(key)
      if cache && !$location.search().skip_cache
        d = $.Deferred()
        data = angular.fromJson(cache) 
        d.resolve(data)
        hash.channels = data
        return d
      else 
        return $http.get("/suggest/channels/related/#{channel}").then (res) ->
          sessionStorage.setItem(key, angular.toJson(res.data))
          hash.channels = res.data

    hash.fetch_popular = ->
      $http.get('https://gdata.youtube.com/feeds/api/channelstandardfeeds/most_subscribed?v=2&alt=json&max-results=50&time=this_month').then (res) ->
        res.data.feed.entry

    hash.suggestChannel = (query) ->
      $http.get("http://gdata.youtube.com/feeds/api/channels?q=#{query}&v=2&alt=json&max-results=50").then (res) ->
        suggestion = null
        resEntry = res.data.feed.entry
        return null unless resEntry
        resEntry.forEach (entry, ind, entries) ->
          author = entry.author
          name = author[0].uri.$t.match(/users\/(.*)$/)[1].toLowerCase()
          suggestion ?= name if name.match(new RegExp('^' + query,'i'))
        return suggestion

    return hash
])



youstars.factory('videosService', ['$http', 'userService', '$location', 'myvideosService', '$timeout', ($http, userService, $location, myvideosService, $timeout) ->
  hash = 
    videos: []
    responseData: {}
    videoModalFirstShown: $.Deferred()
    fetchTrendingvideos: () ->
      $http.get('/suggest/videos/trending.json').then (response) ->
        response.data
    fetchFeaturedvideos: () ->
      $http.get('/suggest/videos/featured.json').then (response) ->
        response.data
    fetchSuggestedvideos: () ->
        $http.get('/suggest/videos/suggested.json').then (response) ->
          response.data
    fetchMostwatchedvideos: () ->
        $http.get('/suggest/videos/most_watched.json').then (response) ->
          response.data

  hash.fetch_videos = (nextPage)->
    channel = userService.currentChannel
    key = "fetch_videos:#{channel}:#{nextPage}:#{hash.responseData.next_page_token}"
    cache = sessionStorage.getItem(key)
    if cache && !$location.search().skip_cache
      d = $.Deferred()
      data = angular.fromJson(cache) 
      hash.responseData = data
      d.resolve(hash.responseData)
      if nextPage
        hash.videos.push.apply(hash.videos, data.videos)
        hash.responseData.next_page_token = data.next_page_token
        hash.current_page_token = data.next_page_token
      else
        hash.videos = data.videos
      return d
    else 
      pageToken = hash.responseData.next_page_token if nextPage
      if nextPage and !pageToken? # return if we've reached the end of the line!
        emptyDeferred = $.Deferred()
        emptyDeferred.resolve(hash.responseData) # NOTHIN
        console.log "You have reached the end of the video results, dear sir."
        return emptyDeferred
      return $http.get("/channel/#{userService.currentChannel}/videos?page_token=#{pageToken || ''}").then (res) ->
        sessionStorage.setItem(key, angular.toJson(res.data))
        hash.responseData = res.data
        if nextPage
          hash.videos.push.apply(hash.videos, res.data.videos)
          hash.responseData.next_page_token = res.data.next_page_token
        else
          hash.videos = res.data.videos
        hash.current_page_token = res.data.next_page_token
        hash.responseData

  return hash
])

youstars.factory('mastheadService', [ () ->
  return {
    animateMasthead: () ->
      $('#ys-header span').addClass('ys-header-after')
  }
])

youstars.factory('statsService', ['$routeParams', '$filter', '$http', ($routeParams, $filter, $http) ->
  return {
    getStats: () ->
      channel = $routeParams.currentChannel
      $http.get("/channel/#{channel}/stream").then (res) ->
        res.data
  }
])

youstars.factory('myvideosService', ['$timeout', ($timeout) ->
  return {
    animateMyvideos: () ->
      $('#ys-videos ul#ys-videos-list li.ys-video-tile').addClass('ys-video-tile-after')
      $('#ys-videos').addClass('ys-video-after')
      $('#ys-content').addClass('ys-content-after')
    removeDelayFromMyvideos: () ->
      $('#ys-videos ul#ys-videos-list li.ys-video-tile').removeAttr('style')
    moveMyvideosBackwards: () ->
      $('#ys-videos').removeClass('ys-move-myvideos-forwards')
    moveMyvideosForwards: () ->
      $('#ys-videos').addClass('ys-move-myvideos-forwards')
  }
])

youstars.factory('mysubscribersService', [ () ->
  return {
    sizeMysubscribers: () ->
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(10n + 1)').toggleClass('ys-profile-tile-medium', true).toggleClass('ys-profile-tile-small', false)
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(10n + 7)').toggleClass('ys-profile-tile-medium', true).toggleClass('ys-profile-tile-small', false)
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(10n + 0)').toggleClass('ys-profile-tile-large', true).toggleClass('ys-profile-tile-small', false)
      # subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(11n)').toggleClass('ys-profile-tile-medium', true).toggleClass('ys-profile-tile-small', false)
    positionMysubscribers: () ->
      $('#ys-player-controls').addClass('ys-player-controls-before')
      $('#ys-profiles').addClass('ys-profiles-before')
    repositionMysubscribers: () ->
      $('#ys-player-controls').addClass('ys-player-controls-after')
      $('#ys-profiles').addClass('ys-profiles-after')

  }
])

youstars.directive('stats', ['userService', 'statsService', '$timeout', '$routeParams', '$filter', (userService, statsService, $timeout, $routeParams, $filter) ->
  return {
    restrict: "E"
    replace: true
    link: (scope, element, attr) ->
      scope.currentChannel = null
      userService.afterInit.then (currentChannel) ->
        scope.currentChannel = userService.currentChannel

      scope.views = 0
      scope.subscribers = 0
      statsService.getStats().then (data) ->
        $timeout ->
          scope.real_views = data.view_count
          scope.real_subscribers = data.subscriber_count
          element.find('span').addClass("visible")
          ['views', 'subscribers'].forEach (val, index) ->
            bg = element.find("#ys-#{val}-bg")
            holder = element.find("#ys-#{val} span")
            targetNum = scope['real_' + val]
            baseNum = scope[val]
            incrementBy = (if Math.abs(targetNum) < 10 then 1 else Math.abs(Math.round(targetNum / 10)))
            interval = setInterval(->
              if targetNum > 0
                scope[val] = $filter('number')(baseNum)
                baseNum += incrementBy
                if baseNum > targetNum
                  scope[val] = $filter('number')(targetNum)
                  clearInterval interval
              else if targetNum < 0
                scope[val] = $filter('number')(baseNum)
                baseNum -= incrementBy
                if baseNum < targetNum
                  scope[val] = $filter('number')(targetNum)
                  clearInterval interval
              else
                scope[val] = $filter('number')(targetNum)
              scope.$apply()
            , 50)
        , 2500

      streamStats = (d) ->
        scope.views = $filter('number')(d.view_count)
        scope.subscribers = $filter('number')(d.subscriber_count)

      $timeout ->
        setInterval ->
          scope.$apply ->
              statsService.getStats().then(streamStats)
        , 10000 # How fast to check stats
      , 5000 # Delay to start the streaming (must start after initial animation)

    template: """
    <div id="ys-stats">
      <div id="ys-views">
        <span><strong>{{views}}</strong> views</span>
          <ul id="ys-social-links">
            <li class="ys-social-link"><a href="http://www.facebook.com/sharer/sharer.php?s=100&p[url]=http://youstars.herokuapp.com/{{currentChannel}}&p[images][0]=&p[title]=YouStars%20-%20{{currentChannel}}&p[summary]=Just%20watched%20some%20awesome%20videos%20from%20{{currentChannel}}%20on%20YouStars!"><i class="ss-icon ss-social">Facebook</i></i></a></li>
            <li class="ys-social-link"><a href="http://twitter.com/home?status=Just%20watched%20some%20awesome%20videos%20from%20{{currentChannel}}%20on%20YouStars!%20http://youstars.herokuapp.com/{{currentChannel}}"><i class="ss-icon ss-social">Twitter</i></a></li>
            <li class="ys-social-link"><a href="https://plus.google.com/share?url=http://youstars.herokuapp.com/{{currentChannel}}"><i class="ss-icon ss-social">GooglePlus</i></a></li>
            <li class="ys-social-link"><a href="http://www.tumblr.com/share/link?url=http%3A%2F%2Fyoustars.herokuapp.com%2F{{currentChannel}}&name=YouStars%20-%20{{currentChannel}}&description=Just%20watched%20some%20awesome%20videos%20from%20{{currentChannel}}%20on%20YouStars!"><i class="ss-icon ss-social">Tumblr</i></a></li>
            <li class="ys-social-link"><a href="http://www.linkedin.com/shareArticle?mini=true&url=http://youstars.herokuapp.com/{{currentChannel}}&title=YouStars%20-%20{{currentChannel}}&summary=Just%20watched%20some%20awesome%20videos%20from%20{{currentChannel}}%20on%20YouStars!"><i class="ss-icon ss-social">LinkedIn</i></a></li>
            <li><a class="ys-claim">Claim This Channel</a></li>
          </ul>
        <div id="ys-views-bg" ng-class="{'adjusted': real_views}"><strong>{{real_views | number}}</strong> views</div>
      </div>
      <!-- #ys-views -->
      <!-- #ys-social-links -->
      <br />
      <div id="ys-subscribers">
        <span><strong>{{subscribers}}</strong> subs</span>
        <div id="ys-subscribers-bg" ng-class="{'adjusted': real_subscribers}"><strong>{{real_subscribers | number}}</strong> subs</div>
      </div>
      <!-- #ys-subs -->
    </div>
    """
  }
])


youstars.directive('masthead', ['userService', 'mastheadService', '$timeout', '$routeParams', (userService, mastheadService, $timeout, $routeParams) ->
  return {
    restrict: "E"
    replace: true
    link: (scope, element, attr) ->
      scope.headerArray = $routeParams.currentChannel.split("")
      $timeout( mastheadService.animateMasthead, 1000 )
    template:
      """
      <div id="ys-header">
        <span ng-repeat="letter in headerArray track by $index" style=" transition-delay: {{$index * 50}}ms">{{letter}}</span>
      </div>
      """
  }
])


youstars.directive('myvideos', ['videosService', 'myvideosService', '$timeout', 'youtubeInit', (videosService, myvideosService, $timeout, youtubeInit) ->
  restrict: "E"
  replace: true
  link: (scope, element, attr) ->
    scope.enter = (e) ->
      currClass = $(e.currentTarget).attr("class").split(" ")[0]
      $('.' + currClass).removeClass('slideUp currentSelection')
      $(e.currentTarget).addClass('slideUp currentSelection')
    scope.leave = (e) ->
      $(e.currentTarget).removeClass('slideUp')
    scope.zIndexBackwards = () ->
      $timeout( myvideosService.moveMyvideosBackwards, 200 )
    scope.zIndexForwards = () ->
      $timeout( myvideosService.moveMyvideosForwards, 0 )
    scope.videosArray = ({} for ignored in [1..20]) #need empty videos at bottom
    scope.$on '$destroy', ->
      scope.destroyed = true
    videosService.fetch_videos().then ->
      unless scope.destroyed # for if they click fast between channels
        scope.page_token = videosService.current_page_token
        scope.$watch(->
          videosService.current_page_token
        , (newVal) ->
          scope.page_token = newVal
        )
        scope.videosArray = videosService.videos
        scope.animatePromise = $timeout( myvideosService.animateMyvideos, 500 )
        scope.removeDelayPromise = $timeout ->
          myvideosService.removeDelayFromMyvideos()
          scope.alreadyAnimated = true
        , 1000
    # $timeout( myvideosService.animateMyvideos, 200 )
    # $timeout( myvideosService.removeDelayFromMyvideos, 500 )
  controller: ['$scope', ($scope) ->
    $scope.playVideo = youtubeInit.playVideo
    $scope.$on('playVideoMayne', (ev, arg) ->
      $scope.playVideo(arg)
    )
  ]
  template:
    """
    <div id="ys-videos">
      <ul id="ys-videos-list">
        <li data-video-id="{{video.video_id}}" ng-class="{'ys-video-tile-after': alreadyAnimated}" class="ys-video-tile" ng-mouseenter="enter($event); zIndexForwards();" ng-mouseleave="leave($event); zIndexBackwards();" ng-repeat="video in videosArray">
          <a ng-click="playVideo('{{video.video_id}}')" class="ys-video-info">
            <h3>{{video.title}}</h3>
            <h4>{{video.view_count | number: 0}} views&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{{video.published_at | date: 'mediumDate'}}</h4>
            <ul class="ys-video-actions">
              <li>1</li>
              <li>2</li>
              <li>3</li>
            </ul>
          </a>
          <a ng-click="playVideo('{{video.video_id}}')" class="ys-video-content" style="transition-delay: {{$index * 100}}ms">
            <h3>{{video.title}}</h3>
            <img ng-src="{{ video.thumbnails.medium.url || video.thumbnails.default.url }}" />
          </a>
        </li>
        <li class="video-spinner" ng-class="{'more-results': page_token}"></li>
      </ul>
    </div>
    """
])


youstars.directive('mysubscribers', ['userService', 'channelsService', 'mysubscribersService', '$timeout', '$http', (userService, channelsService, mysubscribersService, $timeout, $http) ->
  restrict: "E"
  replace: true
  link: (scope, element, attr) ->
    scope.channelsArray = channelsService.channels
    mysubscribersService.positionMysubscribers
    $timeout( mysubscribersService.sizeMysubscribers, 0 )
    # scope.hideMysubscribers = () ->
    #   $timeout( mysubscribersService.repositionMysubscribers, 0 )
    scope.subscribe = (ev, channel) ->
      if userService.loggedIn
        $http.get('/channel/' + channel + '/subscribe.json')
          .success $(ev.target).removeClass('ss-addheart').addClass('ss-check')
  controller: ['$scope', '$element', '$attrs', ($scope,$element,$attrs) ->
    $scope.nameIsntPoop = (item) ->
      !item.name.match(/[ .]/)?
    channelsService.fetch_channels().then (res) ->
      $scope.channelsArray = res
      $timeout( mysubscribersService.sizeMysubscribers, 0 )
      $timeout( mysubscribersService.repositionMysubscribers, 1500 )
  ]
  template:
    """
    <div id="ys-profiles" class="ys-long-profile-list">
      <ul id="ys-profiles-list">
        <li class="ys-profile-tile-small" ng-repeat="channel in channelsArray | filter:nameIsntPoop">
          <a href="#/{{channel.name}}" class="ys-profile-tile-content">
            <div class="ys-profile-tile-info">
              <span>{{channel.title}}</span>
            </div>
            <div class="ys-profile-tile-door-1"><img ng-src="{{channel.thumbnails.medium.url || channel.thumbnails.default.url}}" /></div>
            <div class="ys-profile-tile-door-2"><img ng-src="{{channel.thumbnails.medium.url || channel.thumbnails.default.url}}" /></div>
            <div class="ys-profile-tile-door-3"><img ng-src="{{channel.thumbnails.medium.url || channel.thumbnails.default.url}}" /></div>
            <div class="ys-profile-tile-door-4"><img ng-src="{{channel.thumbnails.medium.url || channel.thumbnails.default.url}}" /></div>
          </a>
          <a class="ys-profile-action ss-icon" ng-class="{'ss-addheart': loggedIn, 'ss-heart': !loggedIn}" ng-click="subscribe($event, '{{channel.name}}')"></a>
        </li>
      </ul>
    </div>
    """
])
youstars.service('youtubeInit', ['$window', '$q', '$routeParams', 'userService', '$location', '$rootScope', ($window, $q, $routeParams, userService, $location, $rootScope) ->
  tag = document.createElement("script")
  tag.src = "https://www.youtube.com/player_api"
  firstScriptTag = document.getElementsByTagName("script")[0]
  resize = ->
    width = $(window).width()
    pWidth = undefined
    # player width, to be defined
    height = $(window).height()
    pHeight = undefined
    # player height, tbd
    currentPlayer = $("#ys-player")
    return unless currentPlayer.length > 0
    
    # when screen aspect ratio differs from video, video must center and underlay one dimension
    if width / (16 / 9) < height # if new video height < window height (gap underneath)
      pWidth = Math.ceil(height * (16 / 9)) # get new player width
      currentPlayer.width(pWidth).height(height).css # player width is greater, offset left; reset top
        left: (width - pWidth) / 2
        top: 0

    else # new video width < window width (gap to right)
      pHeight = Math.ceil(width / (16 / 9)) # get new player height
      currentPlayer.width(width).height(pHeight).css # player height is greater, offset top; reset left
        left: 0
        top: (height - pHeight) / 2

  firstScriptTag.parentNode.insertBefore tag, firstScriptTag

  hash = 
    playerAPIReady: null
    afterPlayerAPIReady: $.Deferred()
    onPlayerReady: $.Deferred()
    player: null
    resize: resize
    currentChannel: userService.currentChannel

  hash.playVideo = (currentVideo) ->
    hash.onPlayerReady.then ->
      playlist = hash.player.getPlaylist()
      playerState = hash.player.getPlayerState()
      currentIndex = hash.player.getPlaylistIndex()
      index = playlist.indexOf(currentVideo)
      # make video first to play only if playlist is cued.
      #   playlist gets cued when ?currentVideo= parameter exists, and page
      #   first loads. "cue" means load playlist but don't play it yet.
      currentIndex++ unless playerState == YT.PlayerState.CUED
      if index >= 0
        # found video in playlist, cut it out, and insert to play
        playlist.splice(index,1)
      playlist.splice(currentIndex,0,currentVideo)
      hash.player.loadPlaylist(playlist, currentIndex)

  hash.videoStateChange = (ev) ->
    if ev.data is 1
      vidId = hash.player.getVideoData().video_id
      $location.search('currentVideo', vidId).replace()
      $rootScope.$apply()
      $.ajax
        url: "https://gdata.youtube.com/feeds/api/videos/" + vidId + "?v=2&alt=json"
        success: (data) ->
          $('.video-title').text(data.entry.title.$t)
    # playlist loaded and ready, but not playing
    # (for trying to determine index of ?currentVideo=... URLS
    else if ev.data is 5
      hash.playVideo $location.search().currentVideo # should exist

  formatTime = (num) ->
    sec_num = parseInt(num, 10)
    hours = Math.floor(sec_num / 3600)
    minutes = Math.floor((sec_num - (hours * 3600)) / 60)
    seconds = sec_num - (hours * 3600) - (minutes * 60)
    seconds = "0" + seconds  if seconds < 10
    time = if parseInt(hours) > 0
      minutes = "0" + minutes  if minutes < 10
      hours + ":" + minutes + ":" + seconds
    else if parseInt(minutes) > 0
      minutes + ":" + seconds
    else
      ":" + seconds
    time

  hash.onPlayerReady.then ->
    loadingBar = setInterval(->
      loadingBar = $(".ys-loading-bar")
      return unless hash.player && typeof( hash.player.getDuration ) != "undefined"
      duration = hash.player.getDuration()
      currentTime = hash.player.getCurrentTime()
      percentLoaded = currentTime / duration
      if hash.player.getPlayerState() is 1 # playing
        loadingBar.width (percentLoaded * 100) + "%"
      # unstarted (between videos)
      else loadingBar.width "100%" if hash.player.getPlayerState() is -1 and percentLoaded > 0

      currentTimeFormatted = formatTime(Math.floor(currentTime))
      durationFormatted = formatTime(duration)
      $('.time-passed').text(currentTimeFormatted + "/")
      $('.time-total').text(durationFormatted)
    , 100)

  $window.onYouTubePlayerAPIReady = ->
    hash.playerAPIReady = true
    hash.afterPlayerAPIReady.resolve()

  return hash
])

youstars.controller('indexController', ['$window', '$scope', '$routeParams', 'userService', 'youtubeInit', 'videosService', 'channelsService', ($window, $scope, $routeParams, userService, youtubeInit, videosService, channelsService)->
  $scope.showVideoRecommendations   = false
  $scope.showVideoModal = ->
    $scope.showVideoRecommendations = true
    videosService.videoModalFirstShown.resolve()
  $scope.showChannelRecommendations = false
  $scope.showChannelModal = ->
    $scope.showChannelRecommendations = true
    channelsService.channelModalFirstShown.resolve()

  $scope.showTutorial               = false
  if $routeParams.currentChannel
    #oof, too fast, too little knowledge of angular going around
    youtubeInit.currentChannel = $routeParams.currentChannel
    userService.currentChannel = $routeParams.currentChannel
    userService.afterInit.resolve $routeParams.currentChannel
  player = youtubeInit.player
  
  $scope.loggedIn = userService.loggedIn

  $scope.toggleVideo = ->
    $scope.visibleVideo = !$scope.visibleVideo

  $scope.visibleVideo = false
  $scope.muted = userService.volumeSettings.muted()

  # Load the IFrame Player API code asynchronously.

  # Replace the 'ys-player' element with an <iframe> and
  # YouTube player after the API code downloads.
  youtubeInit.afterPlayerAPIReady.then(->    
    settings = userService.volumeSettings
    player = youtubeInit.player = new YT.Player("ys-player",
      playerVars:
        enablejsapi: 1
        controls: 0
        iv_load_policy: 3
        showinfo: 0
        loop: 1
        modestbranding: 1

      events:
        onReady: ->
          player = youtubeInit.player
          youtubeInit.resize()
          if settings.muted()
            player.mute()
            $scope.muted = true
          else
            player.setVolume settings.volume()
            $scope.volume = settings.volume()
            $(".volume-indicator").width(settings.volume() * 1.5)
            $('.volume').val(settings.volume())
          if $routeParams.currentVideo
            player.cuePlaylist
              listType: "user_uploads"
              list: youtubeInit.currentChannel
          else
            player.loadPlaylist
              listType: "user_uploads"
              list: youtubeInit.currentChannel
          youtubeInit.onPlayerReady.resolve()
          player.setLoop(true)
        onStateChange: youtubeInit.videoStateChange
    )

    $(window).on "resize", youtubeInit.resize
    $(".mute-container").on "click", (e) ->
      if player.isMuted()
        player.unMute()
        settings.muted(false)
        $scope.muted = false
        $(this).find(".ss-ban").hide();
        $(".volume-indicator").width(settings.volume() * 1.5)
        $(".volume").val settings.volume()
      else
        $(".volume").val 0
        player.mute()
        settings.muted(true)
        $scope.muted = true
        $(this).find(".ss-ban").show();
        $(".volume-indicator").width(0)

    $(".previous").on "click", ->
      player.previousVideo()

    $(".next").on "click", ->
      player.nextVideo()

    $(".pause").on "click", (e) ->
      if player.getPlayerState() is 1
        player.pauseVideo()
        $(this).text "Play"
      else
        player.playVideo()
        $(this).text "Pause"

    # stop the video on any menu click, play when overlay closed
    $("#ys-menu a").on "click", (e) ->
      if player.getPlayerState() != 2
        player.pauseVideo()
        $(".pause").text "Play"

    $(".ys-overlay-close, #ys-keyboard").on "click", (e) ->
      if player.getPlayerState() == 2
        player.playVideo()
        $(".pause").text "Pause"

    $("#ys-player-controls").on "change", ".volume", ->
      newVolume = @valueAsNumber
      if newVolume > 0
        settings.muted(false)
        $scope.muted = false
        $(".mute-container").find(".ss-ban").hide();
      else
        settings.muted(true)
        $scope.muted = true
        $(".mute-container").find(".ss-ban").show();
      player.setVolume newVolume
      settings.volume(newVolume)
      $(".volume-indicator").width( (newVolume / 100) * 150 )

    $("#ys-player-bar").on "click", (e) ->
      clickedPos = e.pageX
      width = $(this).width()
      percentOfWidth = clickedPos / width
      duration = player.getDuration()
      pointInVideo = Math.floor(duration * percentOfWidth)

      player.seekTo(pointInVideo)

    $("#ys-player-bar").on "mousemove", (e) ->
      $("#ys-seek-bar").css("left", e.pageX )

    $("#ys-player-bar").on "mouseleave", (e) ->
      $("#ys-seek-bar").css("left", "0px")

    $("#ys-videos").on "scroll", (e) ->
      if e.target.scrollLeft >= e.target.scrollWidth - (e.target.clientWidth * 2)
        return if $scope.makingARequest
        $scope.makingARequest = true
        videosService.fetch_videos(true).then () ->
          $scope.makingARequest = false
          $scope.$apply()

    $("#ys-profiles-list").on "scroll", (e) ->
      if e.target.scrollTop >= e.target.scrollHeight - e.target.clientHeight
        $("#ys-profiles").removeClass("ys-long-profile-list")
      else
        $("#ys-profiles").addClass("ys-long-profile-list")
  )


])

youstars.controller('homeController', ['$scope', 'channelsService', '$location', '$timeout', '$filter', 'userService', ($scope, channelsService, $location, $timeout, $filter, userService) ->
  timeout = null
  $scope.pendingSuggestion = null
  $scope.goToChannel = (ev) ->
    targ = $(ev.target)
    val = targ.val()
    if ev.which == 13 # enter key
      chan = '/' + val
      userService.checkUserValidity(val).then ->
        $location.path(chan)
      , -> # error callback, 404 means bad user
        targ.addClass('error')
        $timeout ->
          targ.removeClass('error')
        , 200
    else if [9,39,40].indexOf(ev.which) >= 0 && $scope.suggestion
      $scope.query = $scope.suggestion
      ev.preventDefault()
    # else
    #   # REQUEST-BASED SUGGESTIONS
    #   $timeout.cancel timeout
    #   $scope.suggestion = null
    #   timeout = $timeout ->
    #     val = targ.val()
    #     unless val
    #       $scope.suggestion = null
    #       return
    #     channelsService.suggestChannel(val).then (suggestion) ->
    #       return if targ.val() != val
    #       $scope.suggestion = suggestion
    #   , 350
      

  $scope.channels = []
  channelsService.fetch_popular().then (channels) ->
    names = []
    channels.forEach (ele, ind, arr) ->
      ele.username = ele.author[0].uri.$t.match(/users\/(.*)$/)[1].toLowerCase()
      names.push ele.username
      thumbs = ele.media$group.media$thumbnail
      thumbs.forEach (thumb, ind) ->
        if thumb.yt$name == 'hqdefault'
          ele.starsImage = thumb.url
      unless ele.starsImage?
        ele.starsImage = thumbs[0].url 

    $scope.channelNames = names
    $scope.channels = channels
  $scope.$watch 'query', ->
    return unless $scope.channelNames?
    newSuggestion = null
    if $scope.query && $scope.channelNames
      regex = new RegExp('^' + $scope.query, 'i')
      for name in $scope.channelNames when name.match(regex)
        newSuggestion = name
        break
    $scope.suggestion = newSuggestion
])
