If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(8/26/09 16:46:38)
	Mods_2009_08
	// Modified by: costasmanousakis-(Designer)-(6/14/10 15:16:38)
	Mods_2010_06
	//  `Fixes in the calls to refresh Bridge info
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284($BrgSrch_txt)
		vBridgeNo:=Replace string:C233(vBridgeNo; "_"; "")
		$BrgSrch_txt:=vBridgeNo
		If (Length:C16($BrgSrch_txt)<6)
			$BrgSrch_txt:=$BrgSrch_txt+"@"
		End if 
		C_BOOLEAN:C305($isTblRO_b)
		//Read only state(
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
					ALERT:C41("Bridge Number <"+vBridgeNo+"> entered not found!")
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
			LOAD RECORD:C52([Bridge MHD NBIS:1])
			[DCM_Project:138]BIN:5:=[Bridge MHD NBIS:1]BIN:3
			DCM_SetBINInfo("SET")
			DCM_LOADBrgInfo("LOAD")
			
		Else 
			vBridgeNo:=""
			[DCM_Project:138]BIN:5:=""
			DCM_LOADBrgInfo("INIT")
			DCM_ControlCUs("INITCUS")
			
			GOTO OBJECT:C206(vBridgeNo)
		End if 
		
		<>ProjectProcess_l:=$ExistProjProcess_L
		
		READ WRITE:C146([Bridge MHD NBIS:1])
		
End case 