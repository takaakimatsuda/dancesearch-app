// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery3
//= require popper
//= require bootstrap
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require cocoon
//= require_tree .
require("@rails/ujs").start()
require("@rails/activestorage").start()
require('channels')
require('custom/jquery_raty')


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$('.js-project').on('cocoon:before-insert', function(e, task_to_be_added) {
  console.log('before insert');
  return task_to_be_added.fadeIn('slow');
}).on('cocoon:after-insert', function(e, added_task) {
  console.log('after insert');
  return added_task.css("background", "red");
}).on('cocoon:before-remove', function(e, task_to_be_removed) {
  console.log('before remove');
  return task_to_be_removed.fadeOut('slow');
}).on('cocoon:after-remove', function(e, removed_task) {
  return console.log('after remove');
});

