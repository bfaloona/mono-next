// Put your application scripts herevar window.
$(document).ready( function() {

	$(".searching").hide();

});

// Set global gender to all
globalViewGender = "a"; //Global variable declaration with window.

function registerMonologueClick() {

	// Register click event
	$('td.monologue-firstline-table > a').on('click',  function(event, data, status, xhr) {

		// Find monologue body div for this monologue
		var elMonoBody = $(event.target).parent().find('.monologue-body-inline')[0];

		if( $(elMonoBody).is(':hidden') ) {

			// Show element, with animation
			$(elMonoBody).show(400);

			// If element is empty
			if( !(elMonoBody.textContent) ) {

				// Create progress image
				var elLoading = $("<img src='/images/book-animated.gif' class='monologue-body-loading' />")
				// Add image element
				$(elMonoBody).append(elLoading);

				// Make background search request
				$.get(
					$(this).attr('href'),
					function(data){
						elMonoBody.innerHTML=data;
					}
				)
				.done( function(){
					// Remove progress image
					$(elLoading).remove();
				});
			};
		}
		else {
			// Hide monologue body
			$(elMonoBody).hide(200);
		}
		// In all cases, prevent link click request
		event.preventDefault();
		return false;
	});
}

$(document).ready( function() {
	$( "#search-box" ).focus();
	$( "#search-form" ).submit(function( event ) {
		event.preventDefault();
		return false;
	});

	// ---
	// Live search ajax with delay 
	//   to prevent searching every keystroke
	// ---
	var timer;
	var query;
	$('#search-box').keyup(function(){

		// Search only if text has changed
		if( query !== $('#search-box').val().trim() ){

			// Get new value
			query = $('#search-box').val().trim();

			// Cancel pending calls
			if(timer) { clearTimeout(timer) }

			var queryPath;
			// Handle empty search box
			if(query.length === 0) {
				// HACK - search for letter e to get all results
				queryPath = "/search/e/" + window.globalViewGender
			}
			else{
				queryPath = "/search/" + query + "/" + window.globalViewGender;
			}

			// Show spinner
			$(".searching").show();
			timer = setTimeout( function() {

				// Send ajax search request
				$.ajax({
					url: queryPath,
					cache: false
				})
				.done(function( html ) {
					// Replace html in div
					$( ".jquery-search-replace" ).replaceWith( html );
					// Hide spinner
					$(".searching").hide();
				});
			},
			// Keyup timeout (ms)
			400)
		}
	});
});