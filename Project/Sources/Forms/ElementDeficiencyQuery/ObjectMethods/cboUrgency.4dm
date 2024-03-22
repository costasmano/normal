//Method: ElementDeficiencyQuery.cboUrgency1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 16:52:23
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//
//I=Immediate
//A=ASAP
//P=Prioritize

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Case of 
			: (Self:C308->=1)
				vUrg:=""
				
			: (Self:C308->=2)
				vUrg:="I"
				
				
			: (Self:C308->=3)
				vUrg:="A"
				
			: (Self:C308->=4)
				vUrg:="P"
				
		End case 
End case 

OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)

//End ElementDeficiencyQuery.cboUrgency1