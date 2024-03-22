If (False:C215)
	//Object Method: [ScourPOA].Input-A.SCPOA_Descr2_txt 
	// Modified by: costasmanousakis-(Designer)-(5/6/11 15:19:18)
	Mods_2011_05  //Copied to Server on : 05/24/11, 12:12:23
	// Modified by: Costas Manousakis-(Designer)-(12/23/15 10:05:43)
	Mods_2015_12_bug
	//  `Fix on Right click popup menu; and  if statement in on mouse enter
End if 

Case of 
	: ((Form event code:C388=On Clicked:K2:4) & Right click:C712)
		C_TEXT:C284($option_txt)
		$option_txt:=" ;View in a separate window"
		C_LONGINT:C283($Choise_L)
		$Choise_L:=Pop up menu:C542($option_txt)
		Case of 
			: ($Choise_L=1)
				
			: ($Choise_L=2)
				ut_BigAlert(SCPOA_Descr2_txt)
		End case 
	: (Form event code:C388=On Mouse Enter:K2:33)
		C_TEXT:C284(vGenericHlpMsgVar1_S; SCPOA_OldGenMsg_txt)
		SCPOA_OldGenMsg_txt:=vGenericHlpMsgVar1_S
		If (SCPOA_Descr2_txt="")
			vGenericHlpMsgVar1_S:=""
		Else 
			vGenericHlpMsgVar1_S:="Right Click for Options.."
		End if 
	: (Form event code:C388=On Mouse Leave:K2:34)
		C_TEXT:C284(vGenericHlpMsgVar1_S; SCPOA_OldGenMsg_txt)
		If (SCPOA_OldGenMsg_txt#"")
			vGenericHlpMsgVar1_S:=SCPOA_OldGenMsg_txt
		End if 
		
		
End case 