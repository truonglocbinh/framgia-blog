jQuery ->
  $(document).on 'click', "button.post", ->
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

  $(document).on 'click',".show-all-comment",  ->
    entry_id = $(@).attr('id')
    $.ajax({
      url: "/entries/" + entry_id + "/all_comment",
      type: "POST",
      data: {entry_id: entry_id}
    })
    $(@).hide

  if show == undefined
      show = true

  $(document).on 'click', ".show-comments", ->
    
    id = $(@).attr("id")
    if show
      $("#entry-comment-id-" + id).css("display", "inline")
      show = false
    else
      $("#entry-comment-id-" + id).css("display", "none")
      show = true



    