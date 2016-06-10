$(document).ready(function(){
  $('a.like').hover(function(){
    $(this).removeClass('btn-default').addClass('btn-danger');
  },function(){
    $(this).removeClass('btn-danger').addClass('btn-default');
  });

  $('a.attach-image-trigger').click(function(){
    $('#post_image').trigger('click');
  });

  function readURL(input) {

	    if (input.files && input.files[0]) {
	        var reader = new FileReader();

	        reader.onload = function (e) {
	        	$('img#blah').css('display','block');
	            $('img#blah').attr('src', e.target.result);
	        }

	        reader.readAsDataURL(input.files[0]);
	    }
	}

	$("#post_image").change(function(){
	    readURL(this);
	});

});


function likePost(data,event)
{
  jQuery.ajax({
  url: "http://localhost:3000/posts/"+data+"/like",
  type: "GET",
  dataType: "script"
  });  
}

function unlikePost(data,event)
{
  jQuery.ajax({
  url: "http://localhost:3000/posts/"+data+"/unlike",
  type: "GET",
  dataType: "script"
  });
}


$(window).scroll(function () {
   if ($(window).scrollTop() >= $(document).height() - $(window).height()) {
      $('a.load-more-profile').trigger('click');
   }
});

// $('a.load-more-profile').click(function(){
// 	$('#loader').show();
// 	$('a.load-more-profile').css('display','none!important');
// 	var last_id = $('.Post').last().attr('data-id');
// 	var username = $('a.load-more-profile').attr('data-id');
// 	$.ajax({
// 		type: "GET",
// 		url: 'http://localhost:3000/i/fetch',
// 		dataType: "script",
// 		data: {profilePost: last_id,username: username}
// 	});
// });

// if (window.location.href == "http://localhost:3000/dashboard")
// 	{  
// 	$(window).scroll(function (event) {
// 	   if ($(window).scrollTop() >= $(document).height() - $(window).height()) {
// 	      if ($('a.load_more_dash').attr('data-id')!="none")
// 	      {
// 	      	event.preventDefault()
// 	      $('a.load_more_dash').trigger('click');
// 	      }
// 	   }
// 	});
// 	}

function load_more_dash()
{
	$('#loader').show();
	var last_id = $('.Post').last().attr('data-id');
	$.ajax({
		type: "GET",
		url: 'http://localhost:3000/i/fetch',
		dataType: "script",
		data: {dashPost: last_id}
	});
}


function destroyPost(data,event)
{
	$.ajax({
		type: 'DELETE',
		url: 'http://localhost:3000/posts/'+data
	});
};