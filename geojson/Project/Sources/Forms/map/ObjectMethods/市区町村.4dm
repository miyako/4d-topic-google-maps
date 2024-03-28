If (FORM Event:C1606.code=On Clicked:K2:4)
	
	$queryParams:={}
	$queryParams.attributes:={}
	$queryParams.attributes.name:="data.properties.name"
	$queryParams.attributes.type:="type"
	$queryParams.parameters:={}
	$queryParams.parameters.value:="東京都@"
	$queryParams.parameters.medium:="市区町村"
	
	Form:C1466.GeoJSON:={col: ds:C1482.GeoJSON.query(":type == :medium and :name == :value"; $queryParams); sel: Null:C1517; item: Null:C1517; pos: Null:C1517}
	
End if 