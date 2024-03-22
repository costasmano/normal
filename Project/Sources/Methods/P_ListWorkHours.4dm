//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/24/05, 17:56:14
	// ----------------------------------------------------
	// Method: P_ListWorkHours
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(11/28/2005 13:42:05)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(11/30/2005 10:42:46)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/1/2005 16:38:24)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 16:41:20)
	Mods_2005_CM19
	Mods_2020_06  //Added new list box output form. Only for designer now
	//Modified by: Chuck (6/25/20 16:03:37)
	Mods_2020_07  //change Continue to replace current user=Designer to select Listbox or not
	//Modified by: CJ (7/2/20 13:55:42)
	Mods_2020_08  //Changed method of opening window so we would have close box for all from
	//NewWindow to ut_OpenNewWindow 
	//Modified by: CJ (8/11/20 15:55:40)
	Mods_2020_12  // Modifed to add current method name to ut_UseListBox call
	//Modified by: CJ (12/22/20 14:45:46)
End if 
C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255
Compiler_LB
InitProcessVar
WKHR_InitConfigArrays

pFile:=->[Work_Estimate:103]
SHORT_MESSAGE("Retrieving data. Please wait…")
C_TEXT:C284($CurrUser_txt)
$CurrUser_txt:=Current user:C182
MainTitle:="Work Hour Estimates"
READ ONLY:C145([Contract_Assignment_Maintenance:101])
READ ONLY:C145([Contract_Maintenance:97])
READ ONLY:C145([WorkHour_Config:104])
READ ONLY:C145([Addendum_Maintenance:102])

Case of 
	: ($CurrUser_txt#"Designer")
		READ ONLY:C145([Personnel:42])
		Case of 
			: (User in group:C338($CurrUser_txt; "ExternalDesigners"))
				QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=<>CurrentUser_UID)
				If (Records in selection:C76([Personnel:42])=1)
					ARRAY TEXT:C222($ar_ListofCons_S; 0)  //Command Replaced was o_ARRAY string length was 132
					C_TEXT:C284($ConsName_S)  // Command Replaced was o_C_STRING length was 132
					C_LONGINT:C283($i; $k)
					$ConsName_S:=""
					LIST TO ARRAY:C288("Rating Cnslts"; $ar_ListofCons_S)
					$k:=Find in array:C230($ar_ListofCons_S; ([Personnel:42]Employer:9+"@"))
					If ($k>0)
						$ConsName_S:=$ar_ListofCons_S{$k}
						QUERY:C277([Work_Estimate:103]; [Work_Estimate:103]Consultant:6=$ConsName_S)
					End if 
					ARRAY TEXT:C222($ar_ListofCons_S; 0)  //Command Replaced was o_ARRAY string length was 132
				Else 
					REDUCE SELECTION:C351([Work_Estimate:103]; 0)
				End if 
			: (User in group:C338($CurrUser_txt; "BridgeMaintenance"))
				ALL RECORDS:C47([Work_Estimate:103])
		End case 
		
	Else 
		ALL RECORDS:C47([Work_Estimate:103])
End case 
CLOSE WINDOW:C154  //close message window
If (Records in selection:C76([Work_Estimate:103])>0)
	ORDER BY:C49([Work_Estimate:103]; [Work_Estimate:103]ContractNo:3; >)
	
	FORM SET INPUT:C55([Work_Estimate:103]; "Input")
	FORM SET OUTPUT:C54([Work_Estimate:103]; "List")
	C_TEXT:C284($RecSel)  // Command Replaced was o_C_STRING length was 10
	$RecSel:=String:C10(Records in selection:C76([Work_Estimate:103]))
	COPY NAMED SELECTION:C331([Work_Estimate:103]; "UserRegionA")  //save the selection
	
	SET MENU BAR:C67(8)
	DISABLE MENU ITEM:C150(1; 1)
	DISABLE MENU ITEM:C150(1; 2)
	C_LONGINT:C283($formW_O_L; $formW_I_L; $formH_L)
	C_TEXT:C284($Form_txt)
	C_BOOLEAN:C305($useLB_B)
	$useLB_B:=ut_UseListBox(Current method name:C684)
	
	If ($useLB_B)
		$Form_txt:="List_LB"
	Else 
		$Form_txt:="List"
	End if 
	FORM GET PROPERTIES:C674([Work_Estimate:103]; $Form_txt; $formW_O_L; $formH_L)
	
	FORM GET PROPERTIES:C674([Work_Estimate:103]; "Input"; $formW_I_L; $formH_L)
	$formW_O_L:=MaxNum($formW_O_L; $formW_I_L)
	
	
	C_LONGINT:C283(WKHR_InputStatus; $Win_L)  //Command Replaced was o_C_INTEGER
	$win_L:=ut_OpenNewWindow($formW_O_L; 700; 1; Plain form window:K39:10; MainTitle+"["+String:C10(Records in selection:C76([Work_Estimate:103]))+"]"; "ut_CloseCancel")
	//NewWindow ($formW_O_L;700;1;8)
	WKHR_InputStatus:=2  //coming from list - cannot accept work hour.
	UpdatWindArray(""; Current process:C322)
	SET WINDOW TITLE:C213(MainTitle+" ["+$RecSel+"]")
	If ($useLB_B)
		DIALOG:C40([Work_Estimate:103]; "List_LB")
	Else 
		MODIFY SELECTION:C204([Work_Estimate:103]; *; *)  //Display output form even for one record
	End if 
	CLEAR NAMED SELECTION:C333("UserRegionA")
	UpdatWindArray(""; Current process:C322)
	CLOSE WINDOW:C154
Else 
	ALERT:C41("There are no available Work Hour Proposals available")
End if 

WKHR_ClearConfigArrays