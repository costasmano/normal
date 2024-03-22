//Method: Form Method: [PON_ELEM_INSP];"SearchNBE"
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/04/15, 23:59:50
	// ----------------------------------------------------
	//Created : 
	Mods_2015_07
	// Modified by: Costas Manousakis-(Designer)-(2/22/16 17:37:22)
	Mods_2016_02_bug
	//  `vrSearchElmttotQty filter to PosREals min val :0, max: none
	// Modified by: Costas Manousakis-(Designer)-(8/29/17 12:37:35)
	Mods_2017_08
	//  `Modifications in form / form method objects to allow filtering by element type, category, material
	// Modified by: Costas Manousakis-(Designer)-(4/22/19 15:58:31)
	Mods_2019_04_bug
	//  `made both listboxes to grow vertically; added a horizontal splitter between the two.
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		C_BOOLEAN:C305(vAddTo; vIncludeComments; vPrintNow)
		C_BOOLEAN:C305(vbAnyCompleted; vbAnyApprvDBIE; vInspApproved)
		C_TEXT:C284(vtSearchResultCnt)
		vtSearchResultCnt:=""
		
		If ((PON_TYPES_Desc_atxt>0) | (PON_CATEGORIES_Desc_atxt>0) | (PON_MATERIALS_Desc_atxt>0))
			NBE_Search_ApplyFilter
		End if 
		
End case 
//End Form Method: [PON_ELEM_INSP]SearchNBE