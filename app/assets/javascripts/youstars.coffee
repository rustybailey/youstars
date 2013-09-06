youstars.factory('userService', ['$http', ($http) ->
  return {
    userName: "devinsupertramp"		# STATIC PLACEHOLDER.
    currentChannel: null
  }
])



youstars.factory('channelsService', ['$http', 'userService', ($http, userService) ->
  return {
    fetch_channels: ->
      $http.get("/suggest/channels/#{userService.currentChannel}")
    channels: [
      {
        "id": 3
        "name": "smosh"
        "youtube_id": "Y30JRSgfhYXA6i6xX1erWg"
        "created_at": "2012-05-03T19:35:05Z"
        "updated_at": "2013-09-03T08:00:07Z"
        "title": "Smosh"
        "gender": null
        "location": "US"
        "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1"
        "tracking": true
        "published_at": "2005-11-19T10:25:07Z"
        "data":
          "views": 0
          "video_views": 2610612808
          "subscribers": 12271323
          "monthly_delta_views": -267398966
          "monthly_delta_video_views": 48332320
          "monthly_delta_subscribers": 582890
          "weekly_delta_views": 0
          "weekly_delta_video_views": -2466323
          "weekly_delta_subscribers": 118863
          "daily_delta_views": 0
          "daily_delta_video_views": 0
          "daily_delta_subscribers": 22343
          "monthly_growth_views": -100.0
          "monthly_growth_video_views": 1.9
          "monthly_growth_subscribers": 5.0
          "weekly_growth_views": 0.0
          "weekly_growth_video_views": -0.1
          "weekly_growth_subscribers": 1.0
          "daily_growth_views": 0.0
          "daily_growth_video_views": 0.0
          "daily_growth_subscribers": 0.2
          "quarterly_delta_views": -266815806
          "quarterly_delta_video_views": 210975767
          "quarterly_delta_subscribers": 2005181
          "quarterly_growth_views": -100.0
          "quarterly_growth_video_views": 8.9
          "quarterly_growth_subscribers": 19.5
          "sharebutton_totals": {}
          "external_referral_totals": {}
          "embedded_view_totals": {}
      }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }
      { "id": 3, "name": "smosh", "youtube_id": "Y30JRSgfhYXA6i6xX1erWg", "created_at": "2012-05-03T19:35:05Z", "updated_at": "2013-09-03T08:00:07Z", "title": "Smosh", "gender": null, "location": "US", "thumbnail": "http://i1.ytimg.com/i/Y30JRSgfhYXA6i6xX1erWg/1.jpg?v=519198b1", "tracking": true, "published_at":"2005-11-19T10:25:07Z", "data": { "views": 0, "video_views": 2610612808, "subscribers": 12271323, "monthly_delta_views": -267398966, "monthly_delta_video_views": 48332320, "monthly_delta_subscribers": 582890, "weekly_delta_views": 0, "weekly_delta_video_views": -2466323, "weekly_delta_subscribers": 118863, "daily_delta_views": 0, "daily_delta_video_views": 0, "daily_delta_subscribers": 22343, "monthly_growth_views": -100.0, "monthly_growth_video_views": 1.9, "monthly_growth_subscribers": 5.0, "weekly_growth_views": 0.0, "weekly_growth_video_views": -0.1, "weekly_growth_subscribers": 1.0, "daily_growth_views": 0.0, "daily_growth_video_views": 0.0, "daily_growth_subscribers": 0.2, "quarterly_delta_views": -266815806, "quarterly_delta_video_views": 210975767, "quarterly_delta_subscribers": 2005181, "quarterly_growth_views": -100.0, "quarterly_growth_video_views": 8.9, "quarterly_growth_subscribers": 19.5, "sharebutton_totals": {}, "external_referral_totals": {}, "embedded_view_totals": {} } }      
    ]
  }
])



youstars.factory('videosService', ['$http', 'userService', ($http, userService) ->
  hash = 
    videos: [
      {
        "title": "TEST 1: Angry Birds All 27 Golden Eggs Locations Guide"
        "youtube_id": "w__7apOnsYk"
        "tier": 1
        "channel_name": "tinygalaxy"
        "data":
          "comments": 96
          "created_at": "2013-09-05T02:02:20Z"
          "dislikes": 989
          "favorites": null
          "id": 1638752524
          "likes": 1494
          "video_id": 3122710
          "views": 2381116
      }
      { "title": "TEST 2: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 3: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 4: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 5: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 6: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 7: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 8: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 9: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 10: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 11: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 12: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 13: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 14: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 15: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 16: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 17: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 18: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 19: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 20: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 21: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 22: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 23: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 24: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 25: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 26: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 27: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 28: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 29: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 30: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 31: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 32: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 33: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 34: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 35: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 36: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 37: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 38: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 39: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
      { "title": "TEST 40: Angry Birds All 27 Golden Eggs Locations Guide", "youtube_id": "w__7apOnsYk", "tier": 1, "channel_name": "tinygalaxy", "data": { "comments": 96, "created_at": "2013-09-05T02:02:20Z", "dislikes": 989, "favorites": null, "id": 1638752524, "likes": 1494, "video_id": 3122710, "views": 2381116 } }
    ]

  hash.fetch_videos = ->
    $http.get("/channel/#{userService.currentChannel}/videos").then (res) ->
      hash.videos = res.data
  return hash
])

youstars.factory('mastheadService', [ () ->
  return {
    animateMasthead: () ->
      $('#ys-header span').addClass('ys-header-after')
  }
])

youstars.factory('myvideosService', [ () ->
  return {
    animateMyvideos: () ->
      $('#ys-videos ul#ys-videos-list li.ys-video-tile').addClass('ys-video-tile-after')
      $('#ys-videos').addClass('ys-video-after')
      $('#ys-content').addClass('ys-content-after')
    removeDelayFromMyvideos: () ->
      $('#ys-videos ul#ys-videos-list li.ys-video-tile').removeAttr('style')
  }
])

youstars.factory('mysubscribersService', [ () ->
  return {
    sizeMysubscribers: () ->
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(1)').toggleClass('ys-profile-tile-medium', true).toggleClass('ys-profile-tile-small', false)
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(8n)').toggleClass('ys-profile-tile-medium', true).toggleClass('ys-profile-tile-small', false)
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(10n)').toggleClass('ys-profile-tile-large', true).toggleClass('ys-profile-tile-small', false)
      subscribersArray = $('#ys-profiles ul#ys-profiles-list li.ys-profile-tile-small:nth-child(11n)').toggleClass('ys-profile-tile-medium', true).toggleClass('ys-profile-tile-small', false)
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
    scope.videosArray = videosService.videos
    videosService.fetch_videos().then (res) ->
      scope.videosArray = res.videos
      $timeout( myvideosService.animateMyvideos, 200 )
      $timeout( myvideosService.removeDelayFromMyvideos, 500 )
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
        <li data-video-id="{{video.video_id}}" class="ys-video-tile" ng-mouseenter="enter($event)" ng-mouseleave="leave($event)" ng-repeat="video in videosArray">
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
      </ul>
    </div>
    """
])


youstars.directive('mysubscribers', ['channelsService', 'mysubscribersService', '$timeout', (channelsService, mysubscribersService, $timeout) ->
  restrict: "E"
  replace: true
  link: (scope, element, attr) ->
    scope.channelsArray = channelsService.channels
    channelsService.fetch_channels().then (res) ->
      scope.channelsArray = res.data
      $timeout( mysubscribersService.sizeMysubscribers, 0 )
    $timeout( mysubscribersService.sizeMysubscribers, 0 )
    # $timeout( myvideosService.animateMyvideos, 0 )
    # $timeout( myvideosService.removeDelayFromMyvideos, 200 )
  template:
    """
    <div id="ys-profiles">
      <ul id="ys-profiles-list">
        <li class="ys-profile-tile-small" ng-repeat="channel in channelsArray">
          <a href="/{{channel.name}}" class="ys-profile-tile-content">
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

youstars.controller('indexController', ['$window', '$scope', '$routeParams', 'userService', 'youtubeInit', ($window, $scope, $routeParams, userService, youtubeInit)->
  if $routeParams.currentChannel
    #oof, too fast, too little knowledge of angular going around
    youtubeInit.currentChannel = $routeParams.currentChannel
    userService.currentChannel = $routeParams.currentChannel
  player = youtubeInit.player

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
      else
        $(".volume").val 0
        player.mute()
        $(this).find(".ss-ban").show();

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


  )
])
