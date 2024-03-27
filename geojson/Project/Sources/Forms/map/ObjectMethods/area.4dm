var $item : Object

Case of 
	: (FORM Event:C1606.code=On Selection Change:K2:29)
		
		$item:=Form:C1466.GeoJSON.item
		
		If ($item#Null:C1517)
			WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; "map"; "addGeoJson"; *; $item.toObject())
		End if 
		
	: (FORM Event:C1606.code=On Double Clicked:K2:5)
		
		$item:=Form:C1466.GeoJSON.item
		
		If ($item#Null:C1517)
			SET TEXT TO PASTEBOARD:C523($item.data.geometry.properties.code)
		End if 
		
End case 