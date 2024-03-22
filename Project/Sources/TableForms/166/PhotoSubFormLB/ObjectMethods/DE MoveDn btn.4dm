//Method: [LSS_Inspection].Input_ITS.DE MoveDn btn
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): CJ
	//User (4D) : Designer
	//Date and time: 01/23/20, 16:41:43
	// ----------------------------------------------------
	//Created : 
	Mods_2020_01_bug  //Modfied way lss pictures are resequenced to follow model on tin images 
	//Modified by: CJ (1/23/20 16:35:21
	
End if 
//
Case of 
	: (Form event code:C388=On Mouse Enter:K2:33)
		C_TEXT:C284(vGenericHlpMsgVar1_S)
		vGenericHlpMsgVar1_S:="Move Selected Images Down in the List"
	: (Form event code:C388=On Mouse Leave:K2:34)
		vGenericHlpMsgVar1_S:=""
	: (Form event code:C388=On Clicked:K2:4)
		
		If (False:C215)
			LSS_MoveImageRows("Down")
			
		Else 
			INSP_MoveImages("Down")
			
		End if 
		
		
End case 
//End [LSS_Inspection].Input_ITS.DE MoveDn btn