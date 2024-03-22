// ----------------------------------------------------
// Form Method: LastAction.dlg
// User name (OS): cjmiller
// Date and time: 06/12/08, 15:54:22
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v56  //r001 `06/12/08, 15:54:26     
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		C_TEXT:C284(PRJ_EditAction_txt)
		
		PRJ_EditAction_txt:=PRJ_CurrentAction_txt+Char:C90(Carriage return:K15:38)+[PRJ_ProjectDetails:115]PRJ_LastActionDescription_txt:9
		HIGHLIGHT TEXT:C210([PRJ_ProjectDetails:115]PRJ_LastActionDescription_txt:9; 0; Length:C16(PRJ_CurrentAction_txt))
		
End case 

//End Form Method: LastAction.dlg