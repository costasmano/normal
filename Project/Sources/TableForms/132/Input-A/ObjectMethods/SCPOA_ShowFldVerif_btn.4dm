// ----------------------------------------------------
// Method: Object Method: [ScourPOA].Input-A.SCPOA_ShowFldVerif_btn
// Description
// 
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 03/21/12, 17:50:19
	// First Release
	Mods_2012_03
	//  `FV Photo changes : can add more than 4 photos
	
End if 

If (SCPOA_IMAGETYPELIST_L=1)
	SCPOA_IMAGETYPELIST_L:=2
	OBJECT SET TITLE:C194(Self:C308->; "Switch to Inventory List")
	SCPOA_PHOTOLISTMODE_TXT:="Field Verification List"
	MULTI SORT ARRAY:C718(SCPOA_FVPhotoSeq_aL; >; SCPOA_PhotoSeq_aL; >; SCPOA_PhotoRecs_aL; SCPOA_PhotoIDs_aL; SCPOA_PhotoDesc_atxt)
Else 
	SCPOA_IMAGETYPELIST_L:=1
	OBJECT SET TITLE:C194(Self:C308->; "Switch to Field Verif. List")
	SCPOA_PHOTOLISTMODE_TXT:="Inventory List"
	SORT ARRAY:C229(SCPOA_PhotoSeq_aL; SCPOA_PhotoRecs_aL; SCPOA_PhotoIDs_aL; SCPOA_PhotoDesc_atxt; SCPOA_FVPhotoSeq_aL)
End if 
CREATE SELECTION FROM ARRAY:C640([ScourPOA_Images:134]; SCPOA_PhotoRecs_aL)
LISTBOX SELECT ROW:C912(SCPOAImagesListBox; 0; lk remove from selection:K53:3)
