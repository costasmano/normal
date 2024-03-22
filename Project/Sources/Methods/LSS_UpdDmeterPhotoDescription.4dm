//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/21/15, 12:55:22
//----------------------------------------------------
//Method: LSS_UpdDmeterPhotoDescription
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (5/21/15 12:55:25)
	Mods_2015_12_bug  //Fix bug where accessibility records, ut records, dmeter recdords not updated all the time
	//Modified by: administrator (12/29/15 16:10:34)
	Mods_2017_06_bug  ////Fix error where errors occur and tranaction not cancelled
	//Modified by: Chuck Miller (6/21/17 13:44:29)
End if 
If (Records in selection:C76([LSS_Photos:166])=1)
	If (LSS_CompareText(->LSS_PhotoDescription_txt; ->[LSS_Photos:166]LSS_Photo_txt:4))
		LSS_UpdateMany_B:=True:C214
		C_TEXT:C284($ErrorMethodCalled_txt)
		$ErrorMethodCalled_txt:=Method called on error:C704
		ON ERR CALL:C155("LSS_ErrorMethod")
		[LSS_Photos:166]LSS_Photo_txt:4:=LSS_PhotoDescription_txt
		PushChange(5; ->[LSS_Photos:166]LSS_Photo_txt:4)
		FlushGrpChgs(5; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0)
		SAVE RECORD:C53([LSS_Photos:166])
		ON ERR CALL:C155($ErrorMethodCalled_txt)
	End if 
End if 
//End LSS_UpdDmeterPhotoDescription