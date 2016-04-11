// Put your application scripts herevar window.


// Set global gender to all
globalViewGender = "a"; //Global variable declaration with window.

function registerMonologueClick() {
	$('td.monologue-firstline-table > a').on('click',  function(event, data, status, xhr) {
		var elMonoBody = $(event.target).parent().find('.monologue-body-inline')[0];

		if( $(elMonoBody).is(':hidden') ) {

			$(elMonoBody).show(400);

			if( !(elMonoBody.textContent) ) {
				var elLoading = $("<img src='/images/book-animated.gif' class='monologue-body-loading' />")
				$(elMonoBody).append(elLoading);
				$.get(
					$(this).attr('href'),
					function(data){
						elMonoBody.innerHTML=data;
					}
				)
				.done( function(){
					$(elLoading).remove();
				});

			};
		}
		else {
			$(elMonoBody).hide(200);
			// Prevent link click request
			event.preventDefault();
			return false;
		}
	});
}

$(document).ready( function() {
	$( "#search-box" ).focus();
	$( "#search-box" ).click(function( event ) {
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
		if( query !== $('#search-box').val() ){

			// Get new value
			query = $('#search-box').val();

			// Two or more characters required
			if(query.length > 1) {

				// Cancel pending calls
				if(timer) { clearTimeout(timer) }

				timer = setTimeout( function() {

					// Send ajax search request
					$.ajax({
						url: "/search/" + query + "/" + window.globalViewGender,
						cache: false
					})
					.done(function( html ) {
						// Replace html in div
						$( ".jquery-search-replace" ).replaceWith( html );
					});
				},
				// Keyup timeout (ms)
				400
			)}
		}
	});
});