
// ----------------------------------------------------
// User name (OS): administrator
// Date and time: 08/21/14, 15:25:09
// ----------------------------------------------------
// Method: Object Method: [LSS_Inspection].Input_Light.ElementRating_LB
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=On Load:K2:1)
		If ([LSS_refInspectionType:167]LSS_Description_txt:2="Damage")
			//OBJECT SET VISIBLE(*;"Column7";False)
		End if 
	: (Form event code:C388=On Double Clicked:K2:5)
		
		LSS_ModifyElement
		
End case 

