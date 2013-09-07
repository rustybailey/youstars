youstars.factory('userService', ['$http', ($http) ->
  return {
    userName: "devinsupertramp"   # STATIC PLACEHOLDER.
    currentChannel: null
  }
])


youstars.factory('trendingvideosService', ['$http', ($http) ->
  return {
    fetchTrendingvideos: () ->
      $http.get('/suggest/videos/trending.json').then (response) ->
        response.data
  }
])

youstars.factory('featuredvideosService', ['$http', ($http) ->
  return {
    fetchFeaturedvideos: () ->
      $http.get('/suggest/videos/featured.json').then (response) ->
        response.data
  }
])

youstars.factory('suggestedvideosService', ['$http', ($http) ->
  return {
    fetchSuggestedvideos: () ->
      if $("#ys-app").is(".ys-logged-in")
        $http.get('/suggest/videos/suggested.json').then (response) ->
          response.data
      else
        $.Deferred().resolve([])
  }
])

youstars.factory('mostwatchedvideosService', ['$http', ($http) ->
  return {
    fetchMostwatchedvideos: () ->
      if $("#ys-app").is(".ys-logged-in")
        $http.get('/suggest/videos/most_watched.json').then (response) ->
          response.data
      else
        $.Deferred().resolve([])
  }
])


youstars.directive('mostwatchedvideos', ['mostwatchedvideosService', (mostwatchedvideosService) ->
  return {
    restrict: 'E'
    replace: true
    link: (scope, element, attr) ->
      mostwatchedvideosService.fetchMostwatchedvideos().then (data) ->
        scope.mostwatchedVideosArray = data
    template:
      """
      <div class="ys-recommendations">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="video in mostwatchedVideosArray">
            <a class="ys-recommendation-info" href="#">
              <h3>{{video.title}}</h3>
              <h4>{{video.statistics.views | number: 0}} views&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{{video.statistics.likes | number: 0}} likes</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img src="https://i1.ytimg.com/vi/{{video.id}}/mqdefault.jpg" />
              <h3>{{video.channel_name}}</h3>
              <h4>{{video.title}}</h4>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])



youstars.directive('suggestedvideos', ['suggestedvideosService', (suggestedvideosService) ->
  return {
    restrict: 'E'
    replace: true
    link: (scope, element, attr) ->
      suggestedvideosService.fetchSuggestedvideos().then (data) ->
        scope.suggestedVideosArray = data
    template:
      """
      <div class="ys-recommendations">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="video in suggestedVideosArray">
            <a class="ys-recommendation-info" href="#">
              <h3>{{video.title}}</h3>
              <h4>{{video.statistics.views | number: 0}} views&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{{video.statistics.likes | number: 0}} likes</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img src="https://i1.ytimg.com/vi/{{video.id}}/mqdefault.jpg" />
              <h3>{{video.channel_name}}</h3>
              <h4>{{video.title}}</h4>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])


youstars.directive('trendingvideos', ['trendingvideosService', (trendingvideosService) ->
  return {
    restrict: 'E'
    replace: true
    link: (scope, element, attr) ->
      trendingvideosService.fetchTrendingvideos().then (data) ->
        scope.trendingVideosArray = data
    template:
      """
      <div class="ys-recommendations">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="video in trendingVideosArray">
            <a class="ys-recommendation-info" href="#">
              <h3>{{video.title}}</h3>
              <h4>{{video.statistics.views | number: 0}} views&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{{video.statistics.likes | number: 0}} likes</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img src="https://i1.ytimg.com/vi/{{video.id}}/mqdefault.jpg" />
              <h4>{{video.title}}</h4>
              <h3>{{video.channel_name}}</h3>
            </a>
          </li>
        </ul>
      </div>
      """
  }
])


youstars.directive('featuredvideos', ['featuredvideosService', (featuredvideosService) ->
  return {
    restrict: 'E'
    replace: true
    link: (scope, element, attr) ->
      featuredvideosService.fetchFeaturedvideos().then (data) ->
        scope.featuredVideosArray = data
    template:
      """
      <div class="ys-recommendations">
        <ul class="ys-recommendations-list">
          <li class="ys-recommendation" ng-repeat="video in featuredVideosArray">
            <a class="ys-recommendation-info" href="#">
              <h3>{{video.title}}</h3>
              <h4>{{video.statistics.views | number: 0}} views&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;{{video.statistics.likes | number: 0}} likes</h4>
            </a>
            <a class="ys-recommendation-content" href="#">
              <img src="https://i1.ytimg.com/vi/{{video.id}}/mqdefault.jpg" />
              <h3>{{video.channel_name}}</h3>
              <h4>{{video.title}}</h4>
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
        return $http.get("/suggest/channels/#{channel}").then (res) ->
          sessionStorage.setItem(key, angular.toJson(res.data))
          hash.channels = res.data

    hash.fetch_popular = ->
      $http.get('https://gdata.youtube.com/feeds/api/channelstandardfeeds/most_subscribed?v=2&alt=json&max-results=50').then (res) ->
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

youstars.factory('statsService', ['$routeParams', '$filter', ($routeParams, $filter) ->
  return {
    getStats: () ->
      channel = $routeParams.currentChannel
      $.ajax
        url: "/channel/" + channel + "/stream"
        success: (data) =>
          stats =
            views: Math.floor(data.view_count)
            subs: Math.floor(data.subscriber_count)
          $('#ys-views strong').data('stat', stats.views)
          $('#ys-subs strong').data('stat', stats.subs)

    animateStats: () ->
      $('#ys-views strong, #ys-subs strong').each (index) ->
        target = this
        targetNum = parseInt($(target).data('stat'))
        baseNum = 0
        incrementBy = (if Math.abs(targetNum) < 50 then 1 else Math.abs(Math.round(targetNum / 50)))
        interval = setInterval(->
          if targetNum > 0
            $(target).html $filter('number')(baseNum)
            baseNum += incrementBy
            if baseNum > targetNum
              $(target).html $filter('number')(targetNum)
              clearInterval interval
          else if targetNum < 0
            $(target).html $filter('number')(baseNum)
            baseNum -= incrementBy
            if baseNum < targetNum
              $(target).html $filter('number')(targetNum)
              clearInterval interval
          else
            $(target).html $filter('number')(targetNum)
        , 10)
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
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(1)').toggleClass('ys-profile-tile-medium', true).toggleClass('ys-profile-tile-small', false)
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(8n)').toggleClass('ys-profile-tile-medium', true).toggleClass('ys-profile-tile-small', false)
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(10n)').toggleClass('ys-profile-tile-large', true).toggleClass('ys-profile-tile-small', false)
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(11n)').toggleClass('ys-profile-tile-medium', true).toggleClass('ys-profile-tile-small', false)
    positionMysubscribers: () ->
      $('#ys-player-controls').addClass('ys-player-controls-before')
      $('#ys-profiles').addClass('ys-profiles-before')
    repositionMysubscribers: () ->
      $('#ys-player-controls').addClass('ys-player-controls-after')
      $('#ys-profiles').addClass('ys-profiles-after')
  }
])

youstars.directive('stats', ['userService', 'statsService', '$timeout', '$routeParams', (userService, statsService, $timeout, $routeParams) ->
  return {
    restrict: "E"
    replace: true
    link: (scope, element, attr) ->
      $timeout( statsService.getStats, 0 )
      $timeout( statsService.animateStats, 1000 )
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
      $('.ys-video-tile').removeClass('slideUp currentSelection')
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
            <img src="{{ video.thumbnails.medium.url || video.thumbnails.medium.url }}" />
          </a>
        </li>
        <li class="video-spinner" ng-class="{'more-results': page_token}"></li>
      </ul>
    </div>
    """
])


youstars.directive('mysubscribers', ['channelsService', 'mysubscribersService', '$timeout', (channelsService, mysubscribersService, $timeout) ->
  restrict: "E"
  replace: true
  link: (scope, element, attr) ->
    scope.channelsArray = channelsService.channels
    mysubscribersService.positionMysubscribers
    channelsService.fetch_channels().then (res) ->
      scope.channelsArray = res
      $timeout( mysubscribersService.sizeMysubscribers, 0 )
      $timeout( mysubscribersService.repositionMysubscribers, 1500 )
    $timeout( mysubscribersService.sizeMysubscribers, 0 )
    # scope.hideMysubscribers = () ->
    #   $timeout( mysubscribersService.repositionMysubscribers, 0 )
  controller: ['$scope', '$element', '$attrs', ($scope,$element,$attrs) ->
    $scope.nameIsntPoop = (item) ->
      !item.name.match(/[ .]/)?
  ]
  template:
    """
    <div id="ys-profiles">
      <ul id="ys-profiles-list">
        <li class="ys-profile-tile-small" ng-repeat="channel in channelsArray | filter:nameIsntPoop">
          <a href="#/{{channel.name}}" class="ys-profile-tile-content">
            <div class="ys-profile-tile-info">
              <span>{{channel.title}}</span>
            </div>
            <div class="ys-profile-tile-door-1"><img src="{{channel.thumbnails.medium.url || channel.thumbnails.default.url}}" /></div>
            <div class="ys-profile-tile-door-2"><img src="{{channel.thumbnails.medium.url || channel.thumbnails.default.url}}" /></div>
            <div class="ys-profile-tile-door-3"><img src="{{channel.thumbnails.medium.url || channel.thumbnails.default.url}}" /></div>
            <div class="ys-profile-tile-door-4"><img src="{{channel.thumbnails.medium.url || channel.thumbnails.default.url}}" /></div>
          </a>
          <a class="ys-profile-action" href="#"></a>
        </li>
      </ul>
    </div>
    """
])
youstars.service('youtubeInit', ['$window', '$q', '$routeParams', 'userService', ($window, $q, $routeParams, userService) ->
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

  hash.playVideo = (videoId) ->
    hash.onPlayerReady.then ->
      hash.interruptedIndex = hash.player.getPlaylistIndex()
      hash.player.loadVideoById(videoId)

  hash.videoStateChange = (ev) ->
    if ev.data is 1
      vidId = hash.player.getVideoData().video_id
      $.ajax
        url: "https://gdata.youtube.com/feeds/api/videos/" + vidId + "?v=2&alt=json"
        success: (data) ->
          $('.video-title').text(data.entry.title.$t)
    return unless ev.data is 0
    hash.player.loadPlaylist
      listType: "user_uploads"
      list: hash.currentChannel
      index: hash.interruptedIndex

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

youstars.controller('indexController', ['$window', '$scope', '$routeParams', 'userService', 'youtubeInit', 'videosService', ($window, $scope, $routeParams, userService, youtubeInit, videosService)->
  $scope.showVideoRecommendations = false
  if $routeParams.currentChannel
    #oof, too fast, too little knowledge of angular going around
    youtubeInit.currentChannel = $routeParams.currentChannel
    userService.currentChannel = $routeParams.currentChannel
  player = youtubeInit.player
  
  $scope.loggedIn = $("#ys-app").is(".ys-logged-in")

  $scope.toggleVideo = ->
    $scope.visibleVideo = !$scope.visibleVideo

  $scope.visibleVideo = false

  # Load the IFrame Player API code asynchronously.

  # Replace the 'ys-player' element with an <iframe> and
  # YouTube player after the API code downloads.
  youtubeInit.afterPlayerAPIReady.then(->    
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
          player.mute()
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
        $(".volume").val 100
        player.unMute()
        $(this).find(".ss-ban").hide();
        $(".volume-indicator").width("100%")
      else
        $(".volume").val 0
        player.mute()
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

    $("#ys-player-controls").on "change", ".volume", ->
      newVolume = @valueAsNumber
      if newVolume > 0
        $(".mute-container").find(".ss-ban").hide();
      else
        $(".mute-container").find(".ss-ban").show();
      player.setVolume newVolume
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


  )


])

youstars.controller('homeController', ['$scope', 'channelsService', '$location', '$timeout', '$filter', ($scope, channelsService, $location, $timeout, $filter) ->
  timeout = null
  $scope.pendingSuggestion = null
  $scope.goToChannel = (ev) ->
    targ = $(ev.target)
    val = targ.val()
    if ev.which == 13
      chan = '/' + val
      $location.path(chan)
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
    regex = new RegExp('^' + $scope.query, 'i')
    filtered = $filter('filter')($scope.channelNames, (name) ->
      name.match(regex)
    )
    if filtered
      $scope.suggestion = filtered[0]
    else
      $scope.suggestion = null
])
