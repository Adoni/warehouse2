$('#items').prepend('<%= escape_javascript(render(@item)) %>');
$('#form > form')[0].reset();
$('#main_list').html('<%= escape_javascript(render(@main_list))%>');
