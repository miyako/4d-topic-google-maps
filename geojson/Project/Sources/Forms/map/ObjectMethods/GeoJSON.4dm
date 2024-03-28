var $item : Object

Case of 
	: (FORM Event:C1606.code=On Selection Change:K2:29)
		
		$item:=Form:C1466.GeoJSON.item
		
		If ($item#Null:C1517)
			$object:=$item.toObject()
			WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; "map"; "addGeoJson"; *; $object)
			If ($object.data.properties.code=Null:C1517)
				WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; "map"; "setZoom"; *; 11)
			Else 
				WA EXECUTE JAVASCRIPT FUNCTION:C1043(*; "map"; "setZoom"; *; 18)
			End if 
			
			SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($object; *))
		End if 
		
End case 