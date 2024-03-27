//%attributes = {"invisible":true}
TRUNCATE TABLE:C1051([GeoJSON:1])
SET DATABASE PARAMETER:C642([GeoJSON:1]; Table sequence number:K37:31; 0)

/*

データソース: 総務省統計局
https://www.e-stat.go.jp/

トップページ / 統計地理情報システム / 境界データダウンロード / 小地域 / 国勢調査 / 2020年 / 小地域（基本単位区）（JGD2011） / 世界測地系緯度経度・GML 

仕様書:
https://www.e-stat.go.jp/help/data-definition-information/download#003

注意事項: 国勢調査の「小地域」は番地ではない

TL;DR
日本の住所や所在地の情報は表記ゆれが大きく
デジタル化を推進する上で大きな障壁となっている
https://www.digital.go.jp/policies/base_registry_address/

c.f.
法務局の登記所備付地図データ（ログイン必要）
https://www.geospatial.jp/
番地よりも細かい区分

c.f.
Linked Open Addresses Japan
https://uedayou.net/loa-geojson-downloader/
番地よりも1段階おおきな区分

*/

$file:=File:C1566("/RESOURCES/gml/r2kb13110.gml")

$GML:=cs:C1710.GML.new($file)

For each ($GeoJSON; $GML.GeoJSON)
	
	$e:=ds:C1482.GeoJSON.new()
	$e.data:=$GeoJSON
	$e.save()
	
End for each 