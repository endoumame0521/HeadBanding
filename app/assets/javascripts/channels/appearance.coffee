$(document).on 'turbolinks:load', ->
  App.appearance = App.cable.subscriptions.create { channel: 'AppearanceChannel'},
    connected: ->

    disconnected: ->

    received: (data) ->
      member = JSON.parse(data['member'])

      if member.online == true
        $("#member-online-#{member.id}").html data['online']

      if member.online == false
        $("#member-online-#{member.id}").html data['offline']