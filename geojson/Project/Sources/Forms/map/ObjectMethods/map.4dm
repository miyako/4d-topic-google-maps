Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		
		OBJECT SET ENABLED:C1123(*; "MapType"; False:C215)
		
		WA OPEN URL:C1020(*; OBJECT Get name:C1087; File:C1566(File:C1566("/RESOURCES/html/map.html").platformPath; fk platform path:K87:2).platformPath)
		
	: (FORM Event:C1606.code=On End URL Loading:K2:47)
		
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; OBJECT Get name:C1087; "loadMap"; *; getApiKey)
		
End case 