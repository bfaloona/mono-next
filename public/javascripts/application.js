
// Set global gender to all
globalViewGender = "a"; //Global variable declaration with window.
query = '';


function playFromLocation(location) {
	var regex, matches;
	regex = /^\/plays\/(\d+)$/;
	matches = regex.exec(location);
	if(matches && matches[1])
	{
		return parseInt(matches[1]);
	}
	else {
		return "";
	};
}

function registerGenderClick() {

	// Register click event
	$('.gender-filter > a').on('click',  function(event, data, status, xhr) {
		globalViewGender = $(this).attr('href');
		var params = getSearchParams(true);
		if(params) {
			doSearch(params);
		}
		// In all cases, prevent link click request
		event.preventDefault();
		return false;
	});
}

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

function createPlaceholderText(data) {
	var textPrefix;
	if(globalPlayTitle !== '') {
		return textPrefix = 'Search ' + globalPlayTitle + ' Monologues';
	}
	else {
		textPrefix = "Search Shakespeares's"
	}
	if(globalViewGender === 'a')
	{
		return textPrefix + " Monologues";
	}
	else if(globalViewGender === 'w') {
		return textPrefix + " Women's Monologues";
	}
	else if(globalViewGender === 'm') {
		return textPrefix + " Men's Monologues";
	}
}

function updateDom(params, html) {
	// search placeholdre
	$("#search-box")[0].placeholder = createPlaceholderText(params);
	updateGenderLinks();
	// results
	$( ".jquery-search-replace" ).replaceWith( html );
}

function updateGenderLinks() {
	// gender link style
	$(".gender-filter > a").removeClass("link-active");
	$(".gender-filter > a.gender-" + window.globalViewGender).addClass("link-active");
	// results
}

function doSearch(data) {
	// Show spinner
	$(".searching").show();
	console.log(data);
	timer = setTimeout( function() {

		// Send ajax search request
		$.ajax({
			method: "POST",
			data: data,
			url: '/search',
			cache: false
		})
		.done(function( html ) {
			updateDom(data, html);
			// Hide spinner
			$(".searching").hide();
		});
	},
	// Keyup timeout (ms)
	400)
}

function getSearchParams(searchFlag = false) {
	var timer;

	// Search only if text has changed or searchFlag is true
	if( (query !== $('#search-box').val().trim()) || searchFlag == true ){

		// Get new value
		query = $('#search-box').val().trim();

		// Cancel pending calls
		if(timer) { clearTimeout(timer) }

		// Handle empty search box
		if(query.length === 0) {
			// HACK - search for letter e to get all results
			query = "e";
		}

		var data = '{"query": "' +
						query +
						'", "play": "' +
						playFromLocation(document.location.pathname) +
						'", "gender": "' +
						window.globalViewGender +
						'"}';
		return data;
	}
}

$(document).ready( function() {

	registerGenderClick();

	$(".searching").hide();

	$( "#search-box" ).focus();
	$( "#search-form" ).submit(function( event ) {
		event.preventDefault();
		return false;
	});

	// ---
	// Live search ajax with delay 
	//   to prevent searching every keystroke
	// ---
	$('#search-box').keyup(function(){
		var params = getSearchParams();
		if(params) {
			doSearch(params);
		}
	});
});