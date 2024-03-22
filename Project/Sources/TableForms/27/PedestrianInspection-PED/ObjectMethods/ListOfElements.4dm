//Method: [Inspections];"PedestrianInspection-PED".ListOfElements
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/26/19, 14:11:01
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=-20)
		//custom event to signal on close detail
		G_Insp_ElmtArray_setup
		vInspTitle:=G_Insp_SetTitle
		G_Insp_FormatInpTitle
		If (Position:C15("Special"; vInspTitle)>0)
			OBJECT SET VISIBLE:C603(*; "@Initial"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "@Initial"; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

//End [Inspections];"PedestrianInspection-PED".ListOfElements