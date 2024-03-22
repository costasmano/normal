
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 04/02/15, 16:17:52
//----------------------------------------------------
//Method: Object Method: [LSS_Photos].Input.bDelete
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2014_Lighting  // 
	//Modified by: administrator (4/2/15 16:17:53)
	Mods_2015_08_bug  //Fix [LSS_Photos]LSS_PhotoSequence_L bug
	//Modified by: administrator (8/18/15 16:00:19)
	Mods_2018_04  //Change delete from aut action to no action (Delete photo recprd here in code and and accept
End if 
LSS_ResequencePictures("Delete")

LogDeletion(->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; ->[LSS_Photos:166]LSS_PhotoId_s:1; 0)
DELETE RECORD:C58([LSS_Photos:166])
ACCEPT:C269
LSS_PhotoUpdateSeq_b:=True:C214
//End Object Method: [LSS_Photos].Input.bDelete

