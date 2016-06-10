// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

jQuery.ajaxSetup({
   'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
 });

$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip(); 
});

function update_avatar()
{
  $('input[type=file]#user_avatar').trigger('click');
};

$(document).ready(function(){
  $('input[type=file]#user_avatar').on('change',function(){
    $('form.update-avatar').ajaxSubmit({url: 'http://localhost:3000/i/updateAvatar', type: 'post'});
  });
});

function ShowTitle()
{
  $('#post_title').css('display','block');
  $('a.title-trigger').css('display','none');
  $('a.title-trigger-hide').css('display','block');
};

function HideTitle()
{
  $('#post_title').css('display','none');
  $('a.title-trigger-hide').css('display','none');
  $('a.title-trigger').css('display','block');
};



function checkUsernameAvailability() {
  jQuery.ajax({
  url: "check_availability",
  data:'username='+$("#user_username").val(),
  type: "POST"
  });
};

