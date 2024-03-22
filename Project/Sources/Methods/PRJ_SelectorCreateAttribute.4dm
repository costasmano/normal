//%attributes = {"invisible":true}
// ----------------------------------------------------
// PRJ_SelectorCreateAttribute
// User name (OS): charlesmiller
// Date and time: 09/16/11, 14:23:18
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_09  // CJ Miller`09/16/11, 14:23:20      `
	// Modified by: costasmanousakis-(Designer)-(9/23/11 09:39:22)
	Mods_2011_09
	//  `Add SET QUERY DESTINATION(Into current selection ) right after the QUery commands
	Mods_2022_05  //Convert from using modify selection to list boxes 
	//Modified by: Chuck Miller (5/24/22 10:59:53)
	
End if 

C_TEXT:C284($NewAttribute_txt)
C_LONGINT:C283($Count_l)
C_BOOLEAN:C305($complete_b)
C_LONGINT:C283($Version4D_L)
$Version4D_L:=Num:C11(Substring:C12(Application version:C493; 1; 2))
Case of 
		
	: (<>SelectionOption_txt="FederalAid")
		$complete_b:=False:C215
		Repeat 
			$NewAttribute_txt:=Request:C163("Enter a new Federal Aid item")
			SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
			QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1=<>SelectionOption_txt; *)
			QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$NewAttribute_txt)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			Case of 
				: ($NewAttribute_txt="")
					$complete_b:=True:C214
				: ($NewAttribute_txt="Enter a new Federal Aid item")
				: ($Count_l=1)
					ALERT:C41("This "+<>SelectionOption_txt+" already exists")
				Else 
					CONFIRM:C162("New "+<>SelectionOption_txt+" - "+$NewAttribute_txt; "Create"; "Try Again")
					If (OK=1)
						
						CREATE RECORD:C68([TableOfLists:125])
						Inc_Sequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
						[TableOfLists:125]ListName_s:1:=<>SelectionOption_txt
						[TableOfLists:125]ListValue_s:2:=$NewAttribute_txt
						SAVE RECORD:C53([TableOfLists:125])
						If ($Version4D_L>8)
							InitChangeStack(1)
							LogNewRecord(->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0; "TableOfLists")
							PushChange(1; ->[TableOfLists:125]ListName_s:1)
							PushChange(1; ->[TableOfLists:125]ListSequence_l:3)
							PushChange(1; ->[TableOfLists:125]ListValue_s:2)
							FlushGrpChgs(1; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0)
						End if 
						UNLOAD RECORD:C212([TableOfLists:125])
					End if 
					<>PRJ_SelectedData_txt:=$NewAttribute_txt
					$complete_b:=True:C214
					
			End case 
		Until ($complete_b)
		
	: (<>SelectionOption_txt="Program")
		$complete_b:=False:C215
		Repeat 
			$NewAttribute_txt:=Request:C163("Enter a new Program item")
			SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
			QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListName_s:1=<>SelectionOption_txt; *)
			QUERY:C277([TableOfLists:125]; [TableOfLists:125]ListValue_s:2=$NewAttribute_txt)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			Case of 
				: ($NewAttribute_txt="")
					$complete_b:=True:C214
				: ($NewAttribute_txt="Enter a new Program item")
				: ($Count_l=1)
					ALERT:C41("This "+<>SelectionOption_txt+" already exists")
				Else 
					CONFIRM:C162("New "+<>SelectionOption_txt+" - "+$NewAttribute_txt; "Create"; "Try Again")
					If (OK=1)
						CREATE RECORD:C68([TableOfLists:125])
						Inc_Sequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
						[TableOfLists:125]ListName_s:1:=<>SelectionOption_txt
						[TableOfLists:125]ListValue_s:2:=$NewAttribute_txt
						SAVE RECORD:C53([TableOfLists:125])
						If ($Version4D_L>8)
							InitChangeStack(1)
							LogNewRecord(->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0; "TableOfLists")
							PushChange(1; ->[TableOfLists:125]ListName_s:1)
							PushChange(1; ->[TableOfLists:125]ListSequence_l:3)
							PushChange(1; ->[TableOfLists:125]ListValue_s:2)
							FlushGrpChgs(1; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; ->[TableOfLists:125]ListKeyID_L:4; 0)
						End if 
						UNLOAD RECORD:C212([TableOfLists:125])
					End if 
					<>PRJ_SelectedData_txt:=$NewAttribute_txt
					$complete_b:=True:C214
					
			End case 
		Until ($complete_b)
		
	: (<>SelectionOption_txt="ProjectFile")
		FORM SET INPUT:C55([PRJ_ProjectFile:117]; "ProjectFile.i")
		ADD RECORD:C56([PRJ_ProjectFile:117])
		
End case 
If (OK=1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	POST OUTSIDE CALL:C329(<>ProjectProcess_l)
	//HIDE PROCESS(Current process)
	//PAUSE PROCESS(Current process)
	ACCEPT:C269
End if 
//End PRJ_SelectorCreateAttribute