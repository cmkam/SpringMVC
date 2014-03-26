<!DOCTYPE html>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<html>
<head>
	<title>Page Title</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="//code.jquery.com/mobile/1.4.1/jquery.mobile-1.4.1.min.css" />
    <!-- link rel="stylesheet" href="//rawgithub.com/arschmitz/jquery-mobile-datepicker-wrapper/v0.1.1/jquery.mobile.datepicker.css" />
    	    <script id="mobile-datepicker" src="//rawgithub.com/arschmitz/jquery-mobile-datepicker-wrapper/v0.1.1/jquery.mobile.datepicker.js"></script>
    <script src="//rawgithub.com/jquery/jquery-ui/1.10.4/ui/jquery.ui.datepicker.js"></script-->
	
	
	<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<script src="//code.jquery.com/mobile/1.4.1/jquery.mobile-1.4.1.min.js"></script>
    

  	
</head>

<body>

  <div>

  </div>
 
  <script>
	$( document ).on( "pageinit", "#myPage", function() {
		$( "#autocomplete" ).on( "listviewbeforefilter", function ( e, data ) {
			var $ul = $( this ),
				$input = $( data.input ),
				value = $input.val(),
				html = "";
			$ul.html( "" );
			if ( value && value.length > 2 ) {
				$ul.html( "<li><div class='ui-loader'><span class='ui-icon ui-icon-loading'></span></div></li>" );
				$ul.listview( "refresh" );
				$.ajax({
					url: "<c:url value='testTags' />",
					dataType: "json",
					crossDomain: true,
					data: {
					    tagName: $input.val()
					}
				})
				.then( function ( response ) {
					$.each( response, function ( i, val ) {
						html += "<li class='tag_url_hide'><a class='tag_url' href='#'>" + val.tagName + "</a></li>";
					});
					$ul.html( html );
					$ul.listview( "refresh" );
					$ul.trigger( "updatelayout");
					$(".tag_url").on("click tap", function (){					    
					    $input.val($(this).html());
					    $(".tag_url_hide").remove();
					    
					});
				});
			}
		});
	});
  </script>


<div id="myPage" data-role="page">




	<div data-role="header">
		<h1>Page Title</h1>
	</div>

	<div role="main" class="ui-content">

	
			<ul id="autocomplete" data-role="listview" data-inset="true" data-filter="true" data-filter-placeholder="Find a city..." data-filter-theme="d"></ul>
	</div>

	<div idata-role="footer">
		<h4>Page Footer</h4>
	</div>
</div>
</body>
</html>