import consumer from "channels/consumer"

consumer.subscriptions.create("FriendshipChannel", {
  connected() {
    console.log("FriendshipChannel Connected")
  },

  disconnected() {
    console.log("FriendshipChannel Disconnected")
  },

  received(data) {
    document.getElementById("friend_" + data.id).className = "status status__" + data.status
  }
});
