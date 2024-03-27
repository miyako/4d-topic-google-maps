//%attributes = {}
$queryParams:={}
$queryParams.attributes:={}
$queryParams.attributes.name:="data.geometry.properties.text"
$queryParams.parameters:={}
$queryParams.parameters.value:="東京都目黒区東が丘二丁目"

$es:=ds:C1482.GeoJSON.query(":name == :value"; $queryParams)

$es:=ds:C1482.GeoJSON.query("data.geometry.properties.text == :1"; "東京都目黒区東が丘二丁目")

