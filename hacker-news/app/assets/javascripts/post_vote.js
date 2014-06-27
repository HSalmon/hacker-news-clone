$(document).ready(function() {
  $("a.vote-button").on("click", function (event) {
    event.preventDefault();
    var post = $(this).parents('article');
    var post_id = post.attr('id');
    $.ajax({
      url: "/post_votes",
      type: "POST",
      data: { id: post_id },
      success: function(data) {
        post.find('.upvotes').html(data['upvotes'])
        post.find('a.vote-button').addClass('red')
      }
    });
  });
});
