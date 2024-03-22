//%attributes = {"invisible":true}
//GP: M_PrintRecords
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.
//Prints SIA's for current selection
If (False:C215)
	
	// Modified by: costasmanousakis-(Designer)-(1/18/11 16:27:12)
	Mods_2011_01
	//`RR
	// Modified by: costasmanousakis-(Designer)-(5/13/11 15:47:44)
	Mods_2011_05
	//  `Made dialog window movable dialog box. (avoid problems in v11)
	// Modified by: Costas Manousakis-(Designer)-(5/17/13 16:39:49)
	Mods_2013_05
	//  `added redraw window
	//  `check to see if there are only rail over or tunnel bridges in the list and avoid showing the form selection dialog
	//  `Added tunnel SIA
	// Modified by: manousakisc (10/21/2013)
	Mods_2013_10
	//  `Added call to G_PrintOptions
	// Modified by: Costas Manousakis-(Designer)-(10/14/15 12:26:19)
	Mods_2015_10_bug
	//  `use method SIA_PrintForms
End if 

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)
C_TEXT:C284($text)

$Recs:=Records in selection:C76([Bridge MHD NBIS:1])

If ($Recs>0)
	C_LONGINT:C283($RegBridgeRecs_L)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $RegBridgeRecs_L)
	QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"@RO"; *)
	QUERY SELECTION:C341([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"TNL"; *)
	QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 BridgeCat:207#"BTS")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If ($RegBridgeRecs_L>0)
		CENTER_WINDOW(250; 200; Movable dialog box:K34:7)
		DIALOG:C40([Dialogs:21]; "PrBridgeSel")
		CLOSE WINDOW:C154
	End if 
	
	If ((Ok=1) & ($Recs>10))
		$text:="Do you really want to print SI&A's for "+String:C10($Recs; "###,##0")+"  bridges?"
		CONFIRM:C162($text)
	End if 
	If (Ok=1)
		G_PrintOptions
		If (<>ShowPrint)
			PRINT SETTINGS:C106
		End if 
		If (OK=1)
			FIRST RECORD:C50([Bridge MHD NBIS:1])
			For ($i; 1; $Recs)
				
				Case of 
					: ([Bridge MHD NBIS:1]Item8 BridgeCat:207="@RO")
						READ ONLY:C145([RAILBridgeInfo:37])
						QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
						Print form:C5([Bridge MHD NBIS:1]; "RailTransitSIA")
					: (([Bridge MHD NBIS:1]Item8 BridgeCat:207="TNL") | ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BTS"))
						READ ONLY:C145([TunnelInfo:151])
						QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
						Print form:C5([Bridge MHD NBIS:1]; "TunnelSIA")
					Else 
						SIA_PrintForms(CBSIANormal; CBSIAInsp; CBSIAMA)
				End case 
				
				NEXT RECORD:C51([Bridge MHD NBIS:1])
			End for 
			PAGE BREAK:C6
			
		End if   //if OK from print settings      
	End if   //if OK from Dialog
	
Else 
	BEEP:C151
	ALERT:C41("No records have been selected!")
End if 
REDRAW WINDOW:C456