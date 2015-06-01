// need to access the items in the video list
// need to set up variables to use on the page
// need to populate the page with the data sent back from the server + append it

  var newSong = $('#title').val();
  var newDescription = $('#description').val();
  var newURL = $('#url').val();
  var newGenre = $('#genre').val();
  var videoList = $('#video-list');

function getVideos(){
  // Ajax request to retrieve all the items from the database
   $.ajax({
    type: 'GET',
    url: '/videos',
    dataType: 'json'
   }).done(function(data) {
      $.each(data,function(index, video){
        addNewVideo(video);
      })
   })
}
 // Append new video on page
  function addNewVideo(data) {
    $('<li class="' + data.genre + 
      '" data-id="' + data.id + 
      '"><h3>' + data.title + 
      '</h3><p>' + data.genre + 
      '</p><iframe width="560" height="315" src="https://www.youtube.com/embed/' + data.url + 
      '" frameborder="0" allowfullscreen></iframe>' + 
      '<button class="edit" id="' + data.id + 
      '">Edit</button>' + 
      '<button class="delete" id="' + data.id + 
      '">Delete</button></li>').prependTo(videoList);
  }


$(document).ready(function(){
  $('#submit').on('click', function(event){    // when clicked, the submit button should append the new data to the page
  });
  $('#genre').on('keypress', function(event){
  // if we press enter we will create a new item
  (event.which === 13);
    console.log('hellllo');
  });
   getVideos();
  })