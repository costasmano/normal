// ----------------------------------------------------
// Object Method: PRJ_SelectField_atxt
// User name (OS): cjmiller
// Date and time: 04/12/07, 10:47:13
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
	Mods_2007_CJMv2  //04/30/07, 11:52:26`Fix xompiler errors
	// Modified by: costasmanousakis-(Designer)-(10/3/08 15:35:47)
	Mods_2008_CM_5404  // ("MASSEDITSTRPRJ")
	//  `edit Str Prj Mgr
	// Modified by: costasmanousakis-(Designer)-(1/22/09 12:11:05)
	Mods_2009_CM_5404
	//For Responsible group, copy the  PRJ_BridgeSection_atxt array used in the input forms.
End if 
If (Form event code:C388=On Clicked:K2:4)
	OBJECT SET VISIBLE:C603(*; "PRJ_DENewValue_txt@"; False:C215)
	C_TEXT:C284($EntryFilter_txt)
	$EntryFilter_txt:="&"+Char:C90(Double quote:K15:41)+"a-z;A-Z;0-9; ;,;.;-;%"+Char:C90(Double quote:K15:41)
	
	Case of 
		: (PRJ_SelectField_atxt=1)  //	PRJ_SelectField_atxt{1}:="Select Field to edit"
			OBJECT SET VISIBLE:C603(*; "MakeChangeButton"; False:C215)
		: (PRJ_SelectField_atxt=2)  //PRJ_SelectField_atxt{2}:="File No"
			OBJECT SET VISIBLE:C603(PRJ_DENewValue_txt; True:C214)
			$EntryFilter_txt:="&9"
			
		: (PRJ_SelectField_atxt=3)  //PRJ_SelectField_atxt{3}:="Program"
			ARRAY TEXT:C222(PRJ_SelectionDD_atxt; 0)
			QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="Program")
			ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListValue_s:2; >)
			SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; PRJ_SelectionDD_atxt)
			INSERT IN ARRAY:C227(PRJ_SelectionDD_atxt; 0; 2)
			PRJ_SelectionDD_atxt{1}:="Select Program"
			PRJ_SelectionDD_atxt{2}:="New"
			OBJECT SET VISIBLE:C603(PRJ_SelectionDD_atxt; True:C214)
			PRJ_SelectionDD_atxt:=1
		: (PRJ_SelectField_atxt=4)  //PRJ_SelectField_atxt{4}:="Federal Aid"
			ARRAY TEXT:C222(PRJ_SelectionDD_atxt; 0)
			QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1="FederalAid")
			ORDER BY:C49([TableOfLists:125]; [TableOfLists:125]ListValue_s:2; >)
			SELECTION TO ARRAY:C260([TableOfLists:125]ListValue_s:2; PRJ_SelectionDD_atxt)
			INSERT IN ARRAY:C227(PRJ_SelectionDD_atxt; 0; 2)
			PRJ_SelectionDD_atxt{1}:="Select Federal Aid"
			PRJ_SelectionDD_atxt{2}:="New"
			OBJECT SET VISIBLE:C603(PRJ_SelectionDD_atxt; True:C214)
			PRJ_SelectionDD_atxt:=1
		: (PRJ_SelectField_atxt=5)  //PRJ_SelectField_atxt{5}:="Responsible Group"
			ARRAY TEXT:C222(PRJ_SelectionDD_atxt; 0)
			COPY ARRAY:C226(PRJ_BridgeSection_atxt; PRJ_SelectionDD_atxt)
			INSERT IN ARRAY:C227(PRJ_SelectionDD_atxt; 1; 1)
			PRJ_SelectionDD_atxt{1}:="Select Responsible Group"
			PRJ_SelectionDD_atxt:=1
			OBJECT SET VISIBLE:C603(PRJ_SelectionDD_atxt; True:C214)
			
		: (PRJ_SelectField_atxt=6)  //PRJ_SelectField_atxt{6}:="Entered Design EWO"
			OBJECT SET VISIBLE:C603(PRJ_DENewValue_txt; True:C214)
			
		: (PRJ_SelectField_atxt=7)  //PRJ_SelectField_atxt{7}:="Entered Construction EWO"
			OBJECT SET VISIBLE:C603(PRJ_DENewValue_txt; True:C214)
			
		: (PRJ_SelectField_atxt=8)  //PRJ_SelectField_atxt{8}:="Struct. Prj. Mgr."
			ARRAY TEXT:C222(PRJ_SelectionDD_atxt; 0)
			ARRAY LONGINT:C221(PRJ_SelectionDD_aL; 0)
			COPY ARRAY:C226(PRJ_StructPrjMgr_atxt; PRJ_SelectionDD_atxt)
			COPY ARRAY:C226(PRJ_StructPrjMgrID_al; PRJ_SelectionDD_aL)
			INSERT IN ARRAY:C227(PRJ_SelectionDD_atxt; 0; 2)
			INSERT IN ARRAY:C227(PRJ_SelectionDD_aL; 0; 2)
			PRJ_SelectionDD_atxt{1}:="Select Struct. Prj. Mgr."
			PRJ_SelectionDD_aL{1}:=-1
			PRJ_SelectionDD_atxt{2}:="Clear"
			PRJ_SelectionDD_aL{2}:=0
			OBJECT SET VISIBLE:C603(PRJ_SelectionDD_atxt; True:C214)
			PRJ_SelectionDD_atxt:=1
			
	End case 
	OBJECT SET FILTER:C235(PRJ_DENewValue_txt; $EntryFilter_txt)
	PRJ_DENewValue_txt:=""
	GOTO OBJECT:C206(PRJ_DENewValue_txt)
	<>FieldToChange_txt:=PRJ_SelectField_atxt{PRJ_SelectField_atxt}
End if 
//End Object Method: PRJ_SelectField_atxt