If (FORM Event:C1606.code=On Clicked:K2:4)
	
	$queryParams:={}
	$queryParams.attributes:={}
	$queryParams.attributes.name:="data.properties.name"
	$queryParams.attributes.type:="type"
	$queryParams.parameters:={}
	$queryParams.parameters.value:="東京都目黒区東が丘二丁目"
	$queryParams.parameters.small:="基本単位区"
	
	Form:C1466.GeoJSON:={col: ds:C1482.GeoJSON.query(":type == :small and :name == :value"; $queryParams); sel: Null:C1517; item: Null:C1517; pos: Null:C1517}
	
End if 