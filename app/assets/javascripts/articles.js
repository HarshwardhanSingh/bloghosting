function upvote(blog,article,event)
{
  jQuery.ajax({
  url: "http://localhost:3000/blogs/"+blog+"/articles/"+article+"/upvote",
  type: "GET"
  });  
};

function downvote(blog,article,event)
{
  jQuery.ajax({
  url: "http://localhost:3000/blogs/"+blog+"/articles/"+article+"/downvote",
  type: "GET"
  });
};

function destroyArticle(data,event)
{
	$.ajax({
		type: 'DELETE',
		url: 'http://localhost:3000/articles/'+data
	});
};

$(document).ready(function(){
	$("#article_image").change(function(){
	    readURL(this);
	});

	$('a.attach-image-trigger').click(function(){
		$('#article_image').trigger('click');
	});
});