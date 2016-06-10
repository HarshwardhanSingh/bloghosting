// Check Notification Feature Every 5 Seconds

setInterval(function () {
  $.ajax({
    url: "http://localhost:3000/checkNotification",
    type: "GET"
  });
}, 5000);

// Fadeout and Remove notice

setInterval(function () {
  $('.notice').fadeOut('slow',function(){
  	$(this).remove();
  });
}, 3000);

// Trigger Update Blog avatar form with click

$(document).ready(function(){
	$('a#update-blog-avatar-trigger').click(function(){
		$('#blog_avatar').trigger('click');
	});
});

// Update Blog avatar form with AJAX

function update_blog_avatar(data,event)
{
  $('input[type=file]#blog_avatar').on('change',function(){
    $('form.update-avatar').ajaxSubmit({url: 'http://localhost:3000/i/blogs/'+data+'/updateAvatar', type: 'patch'});
  });
}

// Check Blog link availability

function checkAvailability() {
  jQuery.ajax({
  url: "http://localhost:3000/blogs/check_availability",
  data:'blog_link='+$("#blog_link").val(),
  type: "POST"
  });
};


// Follow and Unfollow user functions

function follow(data,event)
{
  jQuery.ajax({
  url: "http://localhost:3000/"+data+"/follow",
  type: "GET",
  dataType: "script"
  });
}

function unfollow(data,event)
{
  jQuery.ajax({
  url: "http://localhost:3000/"+data+"/unfollow",
  type: "GET",
  dataType: "script"
  });
}



