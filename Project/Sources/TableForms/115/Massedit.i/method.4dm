// ----------------------------------------------------
// Form Method: Massedit.i
// User name (OS): cjmiller
// Date and time: 04/12/07, 11:53:12
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
	Mods_PRJSELECTION
	// Modified by: costasmanousakis-(Designer)-(10/3/08 15:39:06)
	Mods_2008_CM_5404  // ("MASSEDITSTRPRJ")
	//  `edit Str Prj Mgr
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		PRJ_DENewValue_txt:=""
		<>PRJ_DENewValue_txt:=PRJ_DENewValue_txt
		ARRAY TEXT:C222(PRJ_SelectField_atxt; 8)
		PRJ_SelectField_atxt{1}:="Select Field to edit"
		PRJ_SelectField_atxt{2}:="Project File No"  //Mods_PRJSELECTION
		PRJ_SelectField_atxt{3}:="Program"
		PRJ_SelectField_atxt{4}:="Federal Aid"
		PRJ_SelectField_atxt{5}:="Responsible Bridge Group"  //Mods_PRJSELECTION
		PRJ_SelectField_atxt{6}:="Entered Design EWO"
		PRJ_SelectField_atxt{7}:="Entered Construction EWO"
		PRJ_SelectField_atxt{8}:="Struct. Prj. Mgr."
		PRJ_SelectField_atxt:=1
		OBJECT SET VISIBLE:C603(*; "PRJ_DENewValue_txt@"; False:C215)
		SET WINDOW TITLE:C213("Apply Changes to "+String:C10(Records in set:C195("UserSet"))+" project detail records")
		OBJECT SET VISIBLE:C603(*; "MakeChangeButton"; False:C215)
	: (Form event code:C388=On Unload:K2:2)
		ARRAY TEXT:C222(PRJ_SelectField_atxt; 0)
		
End case 
//End Form Method: Massedit.i