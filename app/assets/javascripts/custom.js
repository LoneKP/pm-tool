
$(document).on('turbolinks:load', function() {
console.log('loaded');
	//open and close menu
	$('.gear-menu').hide();
	$('.gear-menu-wrapper').each(function () {
		var wrapper = $(this);
		var gear = wrapper.find('.open-gear-menu').first();
		var close = wrapper.find('.close-gear-menu').first();
		var menu = wrapper.find('.gear-menu').first();
		gear.on('click', function () {
			menu.show();
		});
		close.on('click', function () {
			menu.hide();
		});
	})

	//Open burgermenu
	$('#menu').hide();
	$('#burger-icon').on('click', function () {
		'#menu'.show();
	});

$(document).mouseup(function(e) {
	
});
	
 
	

});