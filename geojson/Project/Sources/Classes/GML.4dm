property GeoJSON : Collection

Class constructor($file : 4D:C1709.File)
	
	If (OB Instance of:C1731($file; 4D:C1709.File)) && ($file.exists)
		
		var $stringValue : Text
		var $intValue : Integer
		
		$dom:=DOM Parse XML source:C719($file.platformPath)
		
		$FeatureCollection:=DOM Find XML element:C864($dom; "/gml:FeatureCollection")
		$Envelope:=DOM Find XML element:C864($FeatureCollection; "gml:boundedBy/gml:Envelope")
		
		DOM GET XML ATTRIBUTE BY NAME:C728($Envelope; "srsName"; $stringValue)
		This:C1470.srsName:=$stringValue
		DOM GET XML ATTRIBUTE BY NAME:C728($Envelope; "srsDimension"; $intValue)
		This:C1470.srsDimension:=$intValue
		
		$lowerCorner:=DOM Find XML element:C864($Envelope; "gml:lowerCorner")
		DOM GET XML ELEMENT VALUE:C731($lowerCorner; $stringValue)
		$coordinates:=This:C1470._posListToCoords($stringValue)
		This:C1470.lowerCorner:={lng: $coordinates[0][0]; lat: $coordinates[0][1]}
		
		$upperCorner:=DOM Find XML element:C864($Envelope; "gml:upperCorner")
		DOM GET XML ELEMENT VALUE:C731($upperCorner; $stringValue)
		$coordinates:=This:C1470._posListToCoords($stringValue)
		This:C1470.upperCorner:={lng: $coordinates[0][0]; lat: $coordinates[0][1]}
		
		ARRAY TEXT:C222($_featureMembers; 0)
		$featureMember:=DOM Find XML element:C864($FeatureCollection; "gml:featureMember"; $_featureMembers)
		$featureMembers:=[]
		ARRAY TO COLLECTION:C1563($featureMembers; $_featureMembers)
		
		This:C1470.featureMembers:=[]
		This:C1470.GeoJSON:=[]
		
		For each ($featureMember; $featureMembers)
			
			$GeoJSON:={}
			$GeoJSON.type:="Feature"
			$GeoJSON.geometry:={}
			$GeoJSON.geometry.type:="MultiPolygon"
			
			$member:={}
			
			$node:=DOM Get first child XML element:C723($featureMember)
			
			DOM GET XML ELEMENT NAME:C730($node; $stringValue)
			$member.name:=$stringValue
			
			DOM GET XML ATTRIBUTE BY NAME:C728($node; "gml:id"; $stringValue)
			$member.id:=$stringValue
			
			$Surface:=DOM Find XML element:C864($node; "gml:surfaceProperty/gml:Surface")
			DOM GET XML ATTRIBUTE BY NAME:C728($Surface; "srsName"; $stringValue)
			$member.srsName:=$stringValue
			DOM GET XML ATTRIBUTE BY NAME:C728($Surface; "srsDimension"; $intValue)
			$member.srsDimension:=$intValue
			
			$posList:=DOM Find XML element:C864($Surface; "gml:patches/gml:PolygonPatch/gml:exterior/gml:LinearRing/gml:posList")
			DOM GET XML ELEMENT VALUE:C731($posList; $stringValue)
			$coordinates:=This:C1470._posListToCoords($stringValue)
			
			$member.posList:=$coordinates
			
			For each ($fme; ["KEY_CODE"; "PREF"; "CITY"; "K_AREA"; \
				"S_AREA"; "PREF_NAME"; "CITY_NAME"; "S_NAME"; "KIGO_E"; \
				"HCODE"; "AREA"; "PERIMETER"; "KIHON1"; "DUMMY1"; "KIHON2"; \
				"KIHON3"; "C1"; "C2"; "DUMMY2"; "C3"; "DUMMY3"; "C4"; "KIGO_A"; \
				"KIGO_D"; "N_KEN"; "N_CITY"; "N_C1"; "KIGO_I"; "KEYCODE1"; "JINKO"; \
				"SETAI"; "KEN_OLD"; "CITY_OLD"; "X_CODE"; "Y_CODE"; "KCODE1"; "CCODE1"])
				This:C1470._getFme($node; $member; $fme)
			End for each 
			
			This:C1470.featureMembers.push($member)
			
			$GeoJSON.geometry.coordinates:=[[$coordinates]]
			
			$GeoJSON.properties:={}
			$GeoJSON.properties.parts:=[$member.PREF_NAME; $member.CITY_NAME; $member.S_NAME]
			$GeoJSON.properties.name:=$GeoJSON.properties.parts.join("")
			$GeoJSON.properties.code:=$member.KEYCODE1
			$GeoJSON.properties.point:={lat: Num:C11($member.Y_CODE); lng: Num:C11($member.X_CODE)}
			$GeoJSON.properties.population:=Num:C11($member.JINKO)
			$GeoJSON.properties.household:=Num:C11($member.SETAI)
			
			This:C1470.GeoJSON.push($GeoJSON)
			
		End for each 
		
		DOM CLOSE XML:C722($dom)
		
	End if 
	
Function _getFme($dom : Text; $member : Object; $fme : Text)
	
	var $stringValue : Text
	$node:=DOM Find XML element:C864($dom; "fme:"+$fme)
	DOM GET XML ELEMENT VALUE:C731($node; $stringValue)
	$member[$fme]:=$stringValue
	
Function _posListToCoords($stringValue : Text) : Collection
	
	$coordinates:=[]
	
	ARRAY LONGINT:C221($pos; 0)
	ARRAY LONGINT:C221($len; 0)
	
	$i:=1
	While (Match regex:C1019("(\\S+)\\s(\\S+)"; $stringValue; $i; $pos; $len))
		$lat:=Num:C11(Substring:C12($stringValue; $pos{1}; $len{1}); ".")
		$lng:=Num:C11(Substring:C12($stringValue; $pos{2}; $len{2}); ".")
		$coordinates.push([$lng; $lat])
		$i:=$pos{2}+$len{2}
	End while 
	
	return $coordinates