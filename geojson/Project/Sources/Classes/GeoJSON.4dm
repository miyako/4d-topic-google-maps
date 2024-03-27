Class extends DataClass

Function searchByCodes($code : Collection)
	
	return This:C1470.query("data.geometry.properties.code in :1"; $code)
	