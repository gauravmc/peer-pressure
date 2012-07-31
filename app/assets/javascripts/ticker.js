//= require jquery.timeago

function append_item_from(data) {
	var items = data.items;
	$.each(items, function(key, item){
		if (typeof(item.created_at) != "undefined") {
			$(formatted_item(item)).hide().prependTo("#items").fadeIn(2000);
			update_item(item);
		}
	});
}

function formatted_item(item) {
	var code = '<li><a href=http://"'+ item.shop.domain +'/products/'+ item.product.handle +'"><div class="item"><img src="' + item.product.img_url +'" /><p class="ticker-message">'+ item_message(item) +' <i>'+ $.timeago(item.created_at) +'</i>.</p></div></a></li>';
	return code;
}

function item_message(item) {
	if(item.quantity == 1) {
		return "a "+ item.product.title +" was sold";
	} else {
		return item.quantity +"units of "+ item.product.title +" were sold";
	}
}

function update_item(item) {
	$.ajax({
		url: '/sold_items/' + item.id,
		data: { item: { status: "pushed" } },
		type: 'PUT'
	});
}
