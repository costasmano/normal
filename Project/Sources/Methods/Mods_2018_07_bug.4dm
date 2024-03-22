//%attributes = {"invisible":true}
//Method: Mods_2018_07_bug
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/05/18, 12:30:02
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07_bug
End if 
//

//**********`Modified by: Costas Manousakis-(Designer)-(7/5/18)
// Modified Method(s) : 
// NTI_SaveandUpdateComments
//  `change stack level to 1 when doing GENERAL REMARKS and relation type in FlushGrpChags is 2 (was 1)


//```
//```    **** End of Release 7.1.1.b 05-July-2018
//```

//**********`Modified by: Costas Manousakis-(Designer)-(7/11/18)
// [NTI_ELEM_TIN_INSP];"Input".DE Spell Check
//  `fix pointer to wrong table
//**********`Modified by -(7/12/18)
// FM_SavePhotoInput
//  `add check for new record

//```
//```    **** End of Release 7.1.1.c 12-July-2018
//```

//Move change form development
//Fix page number error cause by fact that there were no image records loaded before while getting page count
//Modified by: Chuck Miller (7/26/18 14:41:48)
//NTI_PrintInspection


//End Mods_2018_07_bug