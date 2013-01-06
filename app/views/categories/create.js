$('#category').prepend('<%=escape_javascript(render(@category)) %>');
$('#form > form')[0].reset();
