//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/14/09, 12:24:55
	// ----------------------------------------------------
	// Method: SCPOA_ListPOAs
	// Description
	// List all the Scour Plans of action
	// 
	// Parameters
	// $1 : $Action : if blank launch a process with the same method
	// ----------------------------------------------------
	
	Mods_2009_05
	// Modified by: costasmanousakis-(Designer)-(5/9/11 17:04:39)
	Mods_2011_05  //Copied to Server on : 05/19/11, 16:01:53
	// Modified by: costasmanousakis-(Designer)-(5/20/11 09:17:35)
	Mods_2011_05
	//  `Added pFile ptr and MainTitle
	
	// Modified by: Costas Manousakis-(Designer)-(2/29/12 17:21:56)
	Mods_2012_02
	//  `New input form Input-A
	// Modified by: Costas Manousakis-(Designer)-(5/22/15 12:14:55)
	Mods_2015_05
	//  `use the new ScourPOAMenu menubar
	Mods_2020_06  //Added new list box output form. Only for designer now
	//Modified by: Chuck (6/25/20 16:03:37)
	Mods_2020_07  //change Continue to replace current user=Designer to select Listbox or not
	//Modified by: CJ (7/2/20 13:55:42)
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
	
End if 
Case of 
	: (Count parameters:C259=1)
		C_TEXT:C284($1; $Action)
		Compiler_LB
		InitProcessVar
		SCPOA_Variables("SETUP")
		READ ONLY:C145(*)
		ALL RECORDS:C47([ScourPOA:132])
		QUERY:C277([ScourPOA:132]; [ScourPOA:132]Consultant:26>" ")
		ORDER BY:C49([ScourPOA:132]; [Bridge MHD NBIS:1]BDEPT:1)
		FORM SET INPUT:C55([ScourPOA:132]; "Input-A")
		FORM SET OUTPUT:C54([ScourPOA:132]; "Output")
		READ WRITE:C146([ScourPOA:132])
		C_LONGINT:C283(SCPOA_INPUTMODE_L)
		C_TEXT:C284($username_txt)
		$username_txt:=<>CurrentUser_Name
		Case of 
			: (User in group:C338($username_txt; "SCOURPOAINIT"))
				SCPOA_INPUTMODE_L:=1  //edit
			: (User in group:C338($username_txt; "SCOURPOAEDIT"))
				SCPOA_INPUTMODE_L:=1  //edit
			: (User in group:C338($username_txt; "SCOURPOAVIEW"))
				SCPOA_INPUTMODE_L:=2  //view only
			: ($username_txt="Designer")
				SCPOA_INPUTMODE_L:=1  //edit
				//: ($username_txt="Mohammed Nabulsi")
				//SCPOA_INPUTMODE_L:=1  //edit
		End case 
		
		UpdatWindArray(""; Current process:C322)
		C_LONGINT:C283($fw; $fh)
		pFile:=->[ScourPOA:132]
		C_TEXT:C284($Form_txt)
		C_BOOLEAN:C305($useLB_B)
		$useLB_B:=ut_UseListBox(Current method name:C684)
		
		If ($useLB_B)
			$Form_txt:="Output_LB"
		Else 
			$Form_txt:="Output"
		End if 
		C_LONGINT:C283($win_L)
		FORM GET PROPERTIES:C674([ScourPOA:132]; $Form_txt; $fw; $fh)
		MainTitle:="Bridge Scour Plans of Action "
		$win_L:=ut_OpenNewWindow($fw; 600; 1; Plain form window:K39:10; MainTitle+"["+String:C10(Records in selection:C76([ScourPOA:132]))+"]"; "ut_CloseCancel")
		//NewWindow ($fw;600;1;0;MainTitle+"["+String(Records in selection([ScourPOA]))+"]")
		C_BOOLEAN:C305($OneRel_b; $ManyRel_b)
		GET AUTOMATIC RELATIONS:C899($OneRel_b; $ManyRel_b)
		ARRAY LONGINT:C221($ScourRecs; Records in selection:C76([ScourPOA:132]))
		ARRAY TEXT:C222($Bdepts; Records in selection:C76([ScourPOA:132]))
		SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
		SELECTION TO ARRAY:C260([ScourPOA:132]; $ScourRecs; [Bridge MHD NBIS:1]BDEPT:1; $Bdepts)
		
		SORT ARRAY:C229($Bdepts; $ScourRecs)
		CREATE SELECTION FROM ARRAY:C640([ScourPOA:132]; $ScourRecs)
		COPY NAMED SELECTION:C331([ScourPOA:132]; "AllForForm")
		ARRAY LONGINT:C221($ScourRecs; 0)
		ARRAY TEXT:C222($Bdepts; 0)
		SET AUTOMATIC RELATIONS:C310($OneRel_b; $ManyRel_b)
		READ ONLY:C145([Bridge MHD NBIS:1])
		SET MENU BAR:C67("ScourPOAMenu")
		If ($useLB_B)
			DIALOG:C40([ScourPOA:132]; "Output_LB")
		Else 
			MODIFY SELECTION:C204([ScourPOA:132]; *)
		End if 
		CLEAR NAMED SELECTION:C333("AllForForm")
		UpdatWindArray(""; Current process:C322)
		CLOSE WINDOW:C154
	: (Count parameters:C259=0)
		C_LONGINT:C283($ProcessID_l)
		$ProcessID_l:=LSpawnProcess("SCPOA_ListPOAs"; <>LStackSize; "Bridge ScourPOA"; True:C214; False:C215; "RUN")
		
End case 