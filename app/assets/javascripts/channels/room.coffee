document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room: $('#room').data('room_id') },
    connected: ->

    disconnected: ->

    received: (data) ->
      if ($('#room').data('member_id') == data['message_member_id'])
        $('#messages').prepend data['my_message']
      else
        $('#messages').prepend data['message']

    speak: (message) ->
      @perform 'speak', message: message

  $('#chat-input').on 'keypress', (event) ->
    if event.keyCode is 13
      if event.target.value.match(/[^\s\t]/) #空白、もしくはスペース(全・半)だけの場合、アラート表示
        App.room.speak(event.target.value)
      else
        alert('文字を入力してください')
      event.target.value = ''
      event.preventDefault()
