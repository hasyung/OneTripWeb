jQuery.utility = 
	getFileName: (obj)->
		pos = obj.lastIndexOf(".") * 1
		return obj.substring(0, pos)
	insertImageToTextarea: (textarea)->
		html = ""
		$("#upload-modal").find("#pictures .image-box.selected").map(->
			image = $(this).find(".image-thumb").val()
			html += "<img src=\"" + image + "\" style=\"cursor: default;\" /><br />"
		)
		textarea.insertHtml(html)