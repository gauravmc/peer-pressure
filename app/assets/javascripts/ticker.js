//= require jquery.timeago

var offset;

function prepend_item_from(data) {
	var items = data.items;
	
	$.each(items, function(key, item) {
		var ticker_item = formatted_item(item);
		$(ticker_item).hide().prependTo("#items");
		if($('#items li').length > 1) {
			var item_height = $('#items li:first-child').height() + 20;
			$('#items li:nth-child(2)').animate({marginTop:item_height}, 1000, function(){
				$(this).css('margin-top', '0px').prev().fadeIn(2000);
			});
		} else {
			$('#items li:first-child').fadeIn(2000);
		}
		offset += 1;
	});
}

function formatted_item(item) {
	var code = '<li><a href=http://"'+item.shop.domain+'/products/'+item.product.handle+'"><div class="item"><img src="'+item.product.img_url+'" /><p class="ticker-message">'+item_message(item)+' <i>'+$.timeago(item.created_at)+'</i>.</p></div></a></li>';
	return code;
}

function item_message(item) {
	if(item.quantity == 1) {
		return "a "+ item.product.title +" was sold";
	} else {
		return item.quantity +" units of "+ item.product.title +" were sold";
	}
}
