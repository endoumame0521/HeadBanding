document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room: $('#room').data('room_id') },
    connected: ->

    disconnected: ->

    received: (data) ->
      if ($('#room').data('member_id') == data['message_member_id'])
        $.ajax
          url: "/my_message"
          type: "get"  #HTTPメソッドの指定
          dataType: "script" #レスポンスのデータタイプ指定
          async: true #非同期通信フラグ
          data: { message : data['message'] }
        .done (response) ->

      else
        $.ajax
          url: "/message"
          type: "get"  #HTTPメソッドの指定
          dataType: "script" #レスポンスのデータタイプ指定
          async: true #非同期通信フラグ
          data: { message : data['message'] }
        .done (response) ->

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
