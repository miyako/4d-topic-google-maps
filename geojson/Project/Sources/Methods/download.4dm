//%attributes = {"invisible":true}
TRUNCATE TABLE:C1051([GeoJSON:1])
SET DATABASE PARAMETER:C642([GeoJSON:1]; Table sequence number:K37:31; 0)

$file:=File:C1566("/RESOURCES/geojson/東京都.geojson")
$geojson:=JSON Parse:C1218($file.getText())

For each ($feature; $geojson.features)
	$e:=ds:C1482.GeoJSON.new()
	$e.data:=$feature
	$e.data.properties.point:={lat: $e.data.geometry.coordinates[0][0][1]; lng: $e.data.geometry.coordinates[0][0][0]}
	$e.type:="市区町村"
	$e.save()
End for each 

$file:=File:C1566("/RESOURCES/geojson/東京都目黒区.geojson")
$geojson:=JSON Parse:C1218($file.getText())

For each ($feature; $geojson.features)
	$e:=ds:C1482.GeoJSON.new()
	$e.data:=$feature
	$e.data.properties.point:={lat: $e.data.geometry.coordinates[0][0][1]; lon: $e.data.geometry.coordinates[0][0][0]}
	$e.type:="町丁字"
	$e.save()
End for each 

$file:=File:C1566("/RESOURCES/gml/r2kb13110.gml")

$GML:=cs:C1710.GML.new($file)

For each ($GeoJSON; $GML.GeoJSON)
	
	$e:=ds:C1482.GeoJSON.new()
	$e.data:=$GeoJSON
	$e.type:="基本単位区"
	$e.save()
	
End for each 