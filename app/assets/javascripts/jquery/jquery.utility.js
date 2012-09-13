jQuery.utility = {
	getFileName: function(obj) {
		var pos;
		pos = obj.lastIndexOf(".") * 1;
		return obj.substring(0, pos);
	}
}