// ----------------------------------------------------
// Object Method: Button1
// User name (OS): cjmiller
// Date and time: 10/09/07, 14:30:22
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJM_v5302  //r003 `10/09/07, 14:30:24
End if 

If (<>SelectionOption_txt="Consultant") | (<>SelectionOption_txt="OverideConsultant")
	FORM SET INPUT:C55([Conslt_Name:127]; "Conlst_Name.i")
	
	ADD RECORD:C56([Conslt_Name:127])
	FORM SET INPUT:C55([Conslt_Name:127]; "PRJ_Empty")
	POST OUTSIDE CALL:C329(<>ProjectProcess_l)
	//HIDE PROCESS(Current process)
	//PAUSE PROCESS(Current process)
Else 
	Case of 
		: (Size of array:C274(PRJ_SelectName_atxt)=1)
			<>PRJ_SelectedData_txt:=""
			PRJ_SelectName_atxt:=1
			CANCEL:C270
		: (PRJ_SelectName_atxt>0)
			<>PRJ_SelectedData_txt:=""
			CANCEL:C270
		Else 
			ALERT:C41("You must make a selection before you can create a new record")
			
	End case 
End if 

//End Object Method: Button1