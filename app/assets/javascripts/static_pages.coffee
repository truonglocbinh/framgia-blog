jQuery ->
  $("button.post").bind 'click', ->
    input = $("#comment-"+ $(@).attr('id')).val()
    if $.trim(input)
     $.ajax({
    	url:   "/comments",
    	type:  "POST",
    	data:  {value: input, entry_id: $(@).attr('id')}
       })
     $("#comment-"+ $(@).attr('id')).val("")
    else
      alert "Comment not allow null"

  $(".show-comment-text").bind 'click', ->
    entry_id = $(@).attr('id')


    