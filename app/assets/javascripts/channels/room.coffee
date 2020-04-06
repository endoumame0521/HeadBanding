document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room: $('#room').data('room_id') },
    connected: ->

    disconnected: ->

    received: (data) ->
      roomMemberId = $('#room').data('member_id')
      roomId = $('#room').data('room_id')

      # メッセージルームにアクセスした際に非同期通信でbroadcastされてきたall_read_flagがtrueの場合(=メッセージルームにアクセスした時)
      if data['all_read_flag'] == true

        # 相手の画面のメッセージ全てに{既読}を表示する
        if data['other_member_id'] == roomMemberId
          $('.read-message').html '既読'
        else
          return

      else
        message = JSON.parse(data['message'])

        # BroadCastされてきたメッセージのroom_idと自分が今いるroom_idが一致している時のみ以下を実行
        if roomId == message.room_id

          # BroadCastされてきたdelete_flagがtrueの時のみ、messageのHTMLの要素を消す
          if data['delete_flag'] == true
            $("#message-#{message.id}").remove()

          # BroadCastされてきたメッセージが既読じゃない時（＝messagesテーブルのreadカラムがfalseの時）
          else if message.read == false
            # BroadCastされてきたmessageが自分のmessageの場合は右寄せの吹き出しを表示
            if roomMemberId == message.member_id
              $('#messages').prepend data['my_message']
            # BroadCastされてきたmessageが相手のmessageの場合は左寄せの吹き出しを表示
            else
              $('#messages').prepend data['other_message']
              # メッセージを既読にする
              @perform 'read', message_id: message.id
          # BroadCastされてきたメッセージが既読の時はHTML要素を、{既読}にする
          else
            $("#read-#{message.id}").html '既読'

    speak: (message) ->
      @perform 'speak', message: message

    remove: (message_id) ->
      @perform 'remove', message_id: message_id

  $('#chat-input').on 'keypress', (event) ->
    if event.keyCode is 13
      #空白、もしくはスペース(全・半)だけの場合、アラート表示
      if event.target.value.match(/[^\s\t]/) && event.target.value.length <= 300
        App.room.speak(event.target.value)
      else if event.target.value.length > 300
        return alert('300文字以内で入力してください')
      else
        alert('文字を入力してください')

      event.target.value = ''
      event.preventDefault()

  $(document).on 'click', '.delete_button', ->
    App.room.remove($(this).data('message_id'))
