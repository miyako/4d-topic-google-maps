Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		
		$queryParams:={}
		$queryParams.attributes:={}
		$queryParams.attributes.name:="data.geometry.properties.text"
		$queryParams.parameters:={}
		$queryParams.parameters.value:="東京都目黒区東が丘二丁目"
		
		Form:C1466.GeoJSON:={col: ds:C1482.GeoJSON.query(":name == :value"; $queryParams); sel: Null:C1517; item: Null:C1517; pos: Null:C1517}
		
End case 