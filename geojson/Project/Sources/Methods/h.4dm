//%attributes = {}
$GeoJSONs:=ds:C1482.GeoJSON.searchByCodes(["1102595-1-00"; "1102596-1-00"; "1102597-1-00"])

$parameters:=[]
$parameters.push({name: "size"; value: "600x300"})
$parameters.push({name: "maptype"; value: "roadmap"})

For each ($GeoJSON; $GeoJSONs)
	$coordinates:=$GeoJSON.data.geometry.coordinates[0][0]
	$pts:=[]
	For each ($coordinate; $coordinates)
		$pts.push([$coordinate[1]; $coordinate[0]].join(","))
	End for each 
	$parameters.push({name: "path"; value: "fillcolor:0xAA000033|color:0xFFFFFF00|"+$pts.join("|")})
End for each 

$url:="https://maps.googleapis.com/maps/api/staticmap?key="+getApiKey.key

For each ($parameter; $parameters)
	$url+="&"+$parameter.name+"="+$parameter.value
End for each 

var $picutre : Picture
$status:=HTTP Get:C1157($url; $picutre)

SET PICTURE TO PASTEBOARD:C521($picutre)