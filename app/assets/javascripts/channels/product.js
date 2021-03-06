$(document).on('turbolinks:load', function() {
  App.product.listen_to_comments();
});

App.product = App.cable.subscriptions.create("ProductChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel

    $('#broadcast-info').show();
    animate($('#broadcast-info'), "animated slideInRight");

    var wait = setTimeout(function() {
      animate($('#broadcast-info'), "animated bounceOutRight");
      
      setTimeout(function() {$('#broadcast-info').hide();}, 1000);

    }, 5000);
    
    fetch('/api/v1/userinfo.json')
      .then((response) => {return response.json()})
      .then((userdata) => {
        if (userdata.is_admin == false) {
          $('#trash' + data.comment_id).remove();
        }
      });

    $('.product-reviews').prepend(data.comment);
    animate($('#comment' + data.comment_id), "animated bounceInRight");

    $("#average-rating").attr('data-score', data.average_rating);
    refreshRating();

  },

  listen_to_comments: function() {
    return this.perform('listen', {
      product_id: $("[data-product-id]").data("product-id")
    });
  }

});
