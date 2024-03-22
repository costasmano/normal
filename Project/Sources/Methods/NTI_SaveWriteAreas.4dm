//%attributes = {"invisible":true}
//Method: NTI_SaveWriteAreas
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/21/17, 15:01:41
	// ----------------------------------------------------
	//Created : 
	Mods_2017_12
	C_POINTER:C301(NTI_SaveWriteAreas; $1)  //pointer to table
	C_LONGINT:C283(NTI_SaveWriteAreas; $2)  // 4d write area
	C_LONGINT:C283(NTI_SaveWriteAreas; $3)  //stack levl
	Mods_2018_01  // This method was replaced so all is commented out
End if 
//
//C_LONGINT($mod_L)
//C_TEXT($vsStrValue)
//WR GET AREA PROPERTY ($MyArea;wr modified;$mod_L;$vsStrValue)
//If ($mod_L=1)
//  //ALERT("now what???")
//INSP_4DWRITE_SaveToFld ($MyArea;$1;PON_ChangeStackLvl_L)

//End if 
//End NTI_SaveWriteAreas