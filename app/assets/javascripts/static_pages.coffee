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

  show = true
  count = 0;  
  $(document).on 'click', ".show-comments", ->
    id = $(@).attr("id")
    value = $(@).html()
    if value == "Comments"
      $("#entry-comment-id-" + id).css("display", "inline")
      $("#"+id).html("Hide Comments")
    else
      $("#entry-comment-id-" + id).css("display", "none")
      $("#"+id).html("Comments")



    