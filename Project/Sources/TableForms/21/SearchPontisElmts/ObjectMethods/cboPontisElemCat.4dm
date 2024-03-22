Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($CatID)
		$CatID:=cboPontisElemCatCod{cboPontisElemCat}
		Case of 
			: ($CatID>0)
				QUERY:C277([BMS Elements:47]; [BMS Elements:47]Category ID:8=cboPontisElemCatCod{cboPontisElemCat})
			: ($CatID=0)
				//All records
				ALL RECORDS:C47([BMS Elements:47])
			Else 
				//smart Flags
				QUERY:C277([BMS Elements:47]; [BMS Categories:49]Smart Flag:5=True:C214)
		End case 
		SRCP_LoadElmArrays
		cboPontisElem:=0
		REDRAW:C174(cboPontisElem)
		
		OBJECT SET ENABLED:C1123(cbElmtEnv; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(cbElmtState; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		OBJECT SET ENABLED:C1123(cbElmtQty; True:C214)  // Command Replaced was o_ENABLE BUTTON 
		
End case 