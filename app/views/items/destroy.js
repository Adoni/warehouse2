$('#<%= dom_id(@item) %>').hide();
$('#main_list').html('<%= escape_javascript(render(@main_list))%>');
