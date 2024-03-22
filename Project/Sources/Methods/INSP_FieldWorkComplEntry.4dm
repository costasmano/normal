//%attributes = {"invisible":true}
//Method: INSP_FieldWorkComplEntry
//Description
//  ` Set the visibility of field FieldWorkCompleteDate
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/15/15, 16:59:10
	// ----------------------------------------------------
	//Created : 
	Mods_2015_01
End if 
//
OBJECT SET VISIBLE:C603(*; "DE FieldWorkComplete@"; False:C215)

Case of 
	: ([Bridge MHD NBIS:1]InspResp:173="DIST@")  // only for DOT inspection responsibility
		If (<>INSPFORMREVDATE_8#!00-00-00!)  //date changes are effective
			If ([Inspections:27]Insp Date:78>=<>INSPFORMREVDATE_8)
				OBJECT SET VISIBLE:C603(*; "DE FieldWorkComplete@"; True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*; "DE FieldWorkComplete@"; False:C215)
			End if 
			
		End if 
		
End case 

//End INSP_FieldWorkComplEntry