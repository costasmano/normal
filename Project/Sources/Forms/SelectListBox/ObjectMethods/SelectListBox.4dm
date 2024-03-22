If (False:C215)
	// Method: SelectListBox.SelectListBox
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2017_04
	//  //added LB_ProcessNBEQuery
End if 

C_LONGINT:C283($0)
$0:=0


If (Form event code:C388=On Load:K2:1)
	USE NAMED SELECTION:C332(NamedSelection_txt)
	C_POINTER:C301($Table_ptr)
	$Table_ptr:=Table:C252([LB_QueryTable:147]TableNumber_l:3)
	COPY NAMED SELECTION:C331($Table_ptr->; "MyLocalNamedSelection")
	CLEAR NAMED SELECTION:C333(NamedSelection_txt)
	//CREATE SET($Table_ptr->;"MyLocalSet")
	ARRAY TEXT:C222(arrColNames; 0)
	ARRAY TEXT:C222(arrHeaderNames; 0)
	ARRAY POINTER:C280(arrColVars; 0)
	ARRAY POINTER:C280(arrHeaderVars; 0)
	ARRAY BOOLEAN:C223(arrColsVisible; 0)
	ARRAY POINTER:C280(arrStyles; 0)
	
End if 
If (Form event code:C388=On Load:K2:1) | (Form event code:C388=On Display Detail:K2:22) | (Form event code:C388=On Header Click:K2:40) | (Form event code:C388=On Clicked:K2:4)
	
	Case of 
		: ([LB_QueryTable:147]QueryName_s:1="INSPQuery1")
			$0:=LB_ProcessINSPQuery1
		: ([LB_QueryTable:147]QueryName_s:1="INSPQuery2")
			$0:=LB_ProcessINSPQuery2
			
		: ([LB_QueryTable:147]QueryName_s:1="ELEMSafetyQuery1")
			$0:=LB_ProcessElemSftyQuery1
		: ([LB_QueryTable:147]QueryName_s:1="ELEMSafetyQuery2")
			$0:=LB_ProcessElemSftyQuery1
			
		: ([LB_QueryTable:147]QueryName_s:1="StandardPhotosQuery1")
			$0:=LB_ProcessStandardPhotosQuery
		: ([LB_QueryTable:147]QueryName_s:1="CondUnitsQuery1")
			$0:=LB_ProcessCondUnitsQuery
		: ([LB_QueryTable:147]QueryName_s:1="NBEQuery")
			$0:=LB_ProcessNBEQuery
		: ([LB_QueryTable:147]QueryName_s:1="LSS_ElementQuery")
			$0:=LB_ProcessLSSElementQuery
	End case 
End if 
If (Form event code:C388=On Load:K2:1)
	LISTBOX GET ARRAYS:C832(*; "SelectListBox"; arrColNames; arrHeaderNames; arrColVars; arrHeaderVars; arrColsVisible; arrStyles)
	If ([LB_QueryTable:147]WindowTitle_s:5#"")
		LB_SetWindowTitle
	End if 
	
	C_LONGINT:C283($Left_l; $Top_l; $WindowRight_l; $Bottom_l; $OBJRight_l)
	If ([LB_QueryTable:147]ColumnWidths_txt:2="")
		GET WINDOW RECT:C443($Left_l; $Top_l; $WindowRight_l; $Bottom_l)
		ut_ResizeWindow(Frontmost window:C447; 950; $Bottom_l-$Top_l)
		OBJECT GET COORDINATES:C663(*; "SelectListBox"; $Left_l; $Top_l; $OBJRight_l; $Bottom_l)
		OBJECT MOVE:C664(*; "SelectListBox"; 0; 0; 50; 0)
	Else 
		ColumnWidths_txt:=[LB_QueryTable:147]ColumnWidths_txt:2
		LB_SetColumnWidths
		
	End if 
	
End if 
