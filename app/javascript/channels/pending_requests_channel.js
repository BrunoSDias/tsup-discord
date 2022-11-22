import consumer from "channels/consumer"

consumer.subscriptions.create("PendingRequestsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const content = data.total > 0 ? "<span class=\"badge\">" + data.total + "</span>" : ""

    document.querySelectorAll(".total_friendship_requests_received").forEach(el => {
      el.innerHTML = content;
    })

    document.querySelector("#total_pending").innerHTML = "Pendentes - " + data.total
  }
});
