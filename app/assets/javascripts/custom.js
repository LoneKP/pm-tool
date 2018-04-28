
$(document).on('turbolinks:load', function() {


	//open and close menu
	$('.gear-menu').hide();
	$('.gear-menu-wrapper').each(function () {
		var wrapper = $(this);
		var gear = wrapper.find('.open-gear-menu').first();
		var close = wrapper.find('.close-gear-menu').first();
		var menu = wrapper.find('.gear-menu').first();
		var details = wrapper.find('.details').first();
		var riskAction = wrapper.find('.risk-action').first();
		var archive = wrapper.find('.archive-project').first();
		var deleteProject = wrapper.find('.delete-project').first();



		gear.on('click', function () {
			menu.show();
		});
		close.on('click', function () {
			menu.hide();
		});
		details.on('click', function () {
			menu.hide();
		});
		riskAction.on('click', function () {
			menu.hide();
		});
		archive.on('click', function () {
			menu.hide();
		});
		deleteProject.on('click', function () {
			menu.hide();
		});

	})

	


	//Open burgermenu
	$('#burger-menu').hide();
	$('#burger-menu-wrapper').each(function () {
		var wrapper = $(this);
		var openMenu = wrapper.find('#burger-icon').first();
		var burgerMenu = wrapper.find('#burger-menu').first();
		var closeBurgerMenu = wrapper.find('#burger-icon-in-menu').first();
		openMenu.on('click', function () {
			burgerMenu.show();
			closeBurgerMenu.on('click', function () {
				burgerMenu.hide();
			})
		})
	});

	$('#burger-icon').on('click', function () {
		'#burger-menu'.show();
	});


});

