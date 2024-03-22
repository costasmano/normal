//%attributes = {"invisible":true}
// ----------------------------------------------------
// Mods_2008_CJM_v001
// User name (OS): cjmiller
// Date and time: 01/22/08, 14:55:10
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2008_CJM_v001  //r001 `01/22/08, 14:55:11     
End if 

//Add two new fields to project file
//[PRJ_ProjectFile]PF_Description_txt text
//[PRJ_ProjectFile]PF_TypeCode_s 2 char alpha
//Modify to retrieve from sql
//Modified parameter record
//sp_VW_PRJ_PROJECT
//added the following columns to the end
//, PROJECT_TYPE_CODE, DESCRIPTION 
//Modified 4d methods to retrieve
//SQL_FillBuiltStatements
//SQL_ClearArrays 
//ut_PRJRetrieveProjectFileData 


//End Mods_2008_CJM_v001