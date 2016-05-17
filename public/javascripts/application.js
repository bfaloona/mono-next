
gParams = {
	"gender": "a",
	"toggle": "collapse",
	"query": null,
	"play": ""
}

function registerGenderClick() {
	$('.monologue-controls > a.filter-gender').on('click',  function(event, data, status, xhr) {
		gParams['gender'] = $(this).attr('data_action');
		doSearch(gParams);
		// In all cases, prevent link click request
		event.preventDefault();
		return false;
	});
}

function registerToggleClick() {
	$('.monologue-controls > a.toggle-mono').on('click',  function(event, data, status, xhr) {
		gParams['toggle'] = $(this).attr('data_action');
		doSearch(gParams);
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
			if( !(elMonoBody.textContent.trim()) ) {

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

function createPlaceholderText() {
	var textPrefix;
	if(gParams['playTitle'] !== '') {
		textPrefix = 'Search ' + gParams['playTitle'];
	}
	else {
		textPrefix = "Search Shakespeare's"
	}
	if(gParams['gender'] === 'a')
	{
		return textPrefix + " Monologues";
	}
	else if(gParams['gender'] === 'w') {
		return textPrefix + " Women's Monologues";
	}
	else if(gParams['gender'] === 'm') {
		return textPrefix + " Men's Monologues";
	}
}

function updateDom(params, html) {
	$("#search-box")[0].placeholder = createPlaceholderText();
	updateGenderLinks();
	updateToggleLink();
	$( ".jquery-search-replace" ).replaceWith( html );
}

function updateToggleLink() {
	if(gParams["toggle"] == 'collapse')
	{
		$("a.mono-expand").show();
		$("a.mono-collapse").hide();
	}
	else
	{
		$("a.mono-collapse").show();
		$("a.mono-expand").hide();
	}
}

function updateGenderLinks() {
	$("a.filter-gender").removeClass("link-active");
	$("a.filter-gender[data_action='" + gParams['gender'] + "']").addClass("link-active");
}

function doSearch(data) {
	$(".searching").show();

	console.log("doSearch(): " + JSON.stringify(data));
	timer = setTimeout( function() {
		// Send ajax search request
		$.ajax({
			method: "POST",
			data: JSON.stringify(data),
			url: '/search',
			cache: false
		})
		.done(function( html ) {
			updateDom(data, html);
			$(".searching").hide();
		});
	},
	// Keyup timeout (ms)
	400)
}

function queryChanged() {
	var timer;
	var query;
	query = $('#search-box').val().trim();
	// Search only if text has changed or searchFlag is true
	if(query !== gParams['query']) {
		gParams['query'] = query;
		// Cancel pending calls
		if(timer) { clearTimeout(timer) }
		return true;
	}
}

$(document).ready( function() {

	$(".searching").hide();
	$( "#search-box" ).focus();
	$( "#search-form" ).submit(function( event ) {
		event.preventDefault();
		return false;
	});

	$('#search-box').keyup(function(){
		if(queryChanged()) {
			doSearch(gParams);
		}
	});
});