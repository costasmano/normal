If (False:C215)
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($BrgSrch_txt)
		SCPOA_DetBridgeNo_txt:=Replace string:C233(SCPOA_DetBridgeNo_txt; "_"; "")
		$BrgSrch_txt:=SCPOA_DetBridgeNo_txt
		If (Length:C16($BrgSrch_txt)<6)
			$BrgSrch_txt:=$BrgSrch_txt+"@"
		End if 
		
		READ ONLY:C145([Bridge MHD NBIS:1])
		SET QUERY DESTINATION:C396(Into set:K19:2; "CMNT_BRIDGES")
		C_LONGINT:C283(<>ProjectProcess_l; $ExistProjProcess_L)
		If (<>ProjectProcess_l#0)
			$ExistProjProcess_L:=<>ProjectProcess_l
			<>ProjectProcess_l:=0
		End if 
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$BrgSrch_txt)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		Case of 
			: (Records in set:C195("CMNT_BRIDGES")=1)
				USE SET:C118("CMNT_BRIDGES")
				CLEAR SET:C117("CMNT_BRIDGES")
			Else 
				If (Records in set:C195("CMNT_BRIDGES")>0)
					USE SET:C118("CMNT_BRIDGES")
					CLEAR SET:C117("CMNT_BRIDGES")
				Else 
					ALERT:C41("Bridge Number <"+SCPOA_DetBridgeNo_txt+"> entered not found!")
					ALL RECORDS:C47([Bridge MHD NBIS:1])
				End if 
				C_LONGINT:C283($Width; $ht)
				FORM GET PROPERTIES:C674([Bridge MHD NBIS:1]; "PRJ_Selection.o"; $Width; $ht)
				ORDER BY:C49([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1; >; [Bridge MHD NBIS:1]BIN:3; >)
				NewWindow($Width; 600; 0; Plain window:K34:13)
				FORM SET OUTPUT:C54([Bridge MHD NBIS:1]; "PRJ_Selection.o")
				DISPLAY SELECTION:C59([Bridge MHD NBIS:1]; *)
				CLOSE WINDOW:C154
				If (OK#1)  //User canceled
					REDUCE SELECTION:C351([Bridge MHD NBIS:1]; 0)
				End if 
				
		End case 
		
		If (Records in selection:C76([Bridge MHD NBIS:1])=1)
			[ScourPOA_DetourBridge:133]DetourBIN:3:=[Bridge MHD NBIS:1]BIN:3
			SCPOA_DetBridgeNo_txt:=[Bridge MHD NBIS:1]BDEPT:1
			SCPOA_DetTown_txt:=[Bridge MHD NBIS:1]Town Name:175
			SCPOA_DetLocation_txt:=[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63
		Else 
			SCPOA_DetBridgeNo_txt:=""
			GOTO OBJECT:C206(SCPOA_DetBridgeNo_txt)
		End if 
		
		<>ProjectProcess_l:=$ExistProjProcess_L
		
End case 
