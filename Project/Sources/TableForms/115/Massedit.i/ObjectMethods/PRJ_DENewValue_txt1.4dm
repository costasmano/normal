// ----------------------------------------------------
// Object Method: PRJ_SelectionDD_atxt
// User name (OS): cjmiller
// Date and time: 04/12/07, 16:38:14
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
	Mods_PRJSELECTION
	// Modified by: costasmanousakis-(Designer)-(10/3/08 15:36:28)
	Mods_2008_CM_5404  // ("MASSEDITSTRPRJ")
	//  `edit Str Prj Mgr
End if 
Case of 
	: (<>FieldToChange_txt="Federal Aid")
		Case of 
			: (PRJ_SelectionDD_atxt=1)
			: (PRJ_SelectionDD_atxt=2)
				OBJECT SET VISIBLE:C603(PRJ_SelectionDD_atxt; False:C215)
				OBJECT SET VISIBLE:C603(PRJ_DENewValue_txt; True:C214)
				PRJ_DENewValue_txt:=""
				GOTO OBJECT:C206(PRJ_DENewValue_txt)
			Else 
				PRJ_DENewValue_txt:=PRJ_SelectionDD_atxt{PRJ_SelectionDD_atxt}
				OBJECT SET VISIBLE:C603(*; "MakeChangeButton"; True:C214)  //Mods_PRJSELECTION
		End case 
	: (<>FieldToChange_txt="Responsible Bridge Group")  //Mods_PRJSELECTION
		If (PRJ_SelectionDD_atxt=1)
		Else 
			PRJ_DENewValue_txt:=PRJ_SelectionDD_atxt{PRJ_SelectionDD_atxt}
			OBJECT SET VISIBLE:C603(*; "MakeChangeButton"; True:C214)  //Mods_PRJSELECTION
			
		End if 
	: (<>FieldToChange_txt="Program")
		Case of 
			: (PRJ_SelectionDD_atxt=1)
			: (PRJ_SelectionDD_atxt=2)
				OBJECT SET VISIBLE:C603(PRJ_SelectionDD_atxt; False:C215)
				OBJECT SET VISIBLE:C603(PRJ_DENewValue_txt; True:C214)
				PRJ_DENewValue_txt:=""
				GOTO OBJECT:C206(PRJ_DENewValue_txt)
			Else 
				PRJ_DENewValue_txt:=PRJ_SelectionDD_atxt{PRJ_SelectionDD_atxt}
				OBJECT SET VISIBLE:C603(*; "MakeChangeButton"; True:C214)  //Mods_PRJSELECTION
		End case 
	: (<>FieldToChange_txt="Struct. Prj. Mgr.")
		Case of 
			: (PRJ_SelectionDD_atxt=1)
			Else 
				PRJ_DENewValue_txt:=String:C10(PRJ_SelectionDD_aL{PRJ_SelectionDD_atxt})
				OBJECT SET VISIBLE:C603(*; "MakeChangeButton"; True:C214)  // Mods_2008_CM_5404 ("MASSEDITSTRPRJ")
		End case 
		
End case 
//End Object Method: PRJ_SelectionDD_atxt