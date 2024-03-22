// ----------------------------------------------------
// Object Method: Button1
// User name (OS): cjmiller
// Date and time: 04/12/07, 12:32:43
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2007_CJMv2
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 

C_BOOLEAN:C305($Complete_b)
$Complete_b:=False:C215
C_LONGINT:C283($Loc_l)
C_LONGINT:C283($Version4D_L)
$Version4D_L:=Num:C11(Substring:C12(Application version:C493; 1; 2))
If (PRJ_DENewValue_txt#"")
	Case of 
		: (<>FieldToChange_txt="Project File No")
			QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=PRJ_DENewValue_txt)
			If (Records in selection:C76([PRJ_ProjectFile:117])=1)
				<>PRJ_DENewValue_txt:=String:C10([PRJ_ProjectFile:117]PF_FileID_l:1)
				$Complete_b:=True:C214
			End if 
		: (<>FieldToChange_txt="Federal Aid")
			<>PRJ_DENewValue_txt:=PRJ_DENewValue_txt
			$Loc_l:=Find in array:C230(PRJ_SelectionDD_atxt; <>PRJ_DENewValue_txt)
			If ($Loc_l<0)
				CREATE RECORD:C68([TableOfLists:125])
				Inc_Sequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
				[TableOfLists:125]ListName_s:1:="FederalAid"
				[TableOfLists:125]ListValue_s:2:=<>PRJ_DENewValue_txt
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
			$Complete_b:=True:C214
		: (<>FieldToChange_txt="Program")
			<>PRJ_DENewValue_txt:=PRJ_DENewValue_txt
			$Loc_l:=Find in array:C230(PRJ_SelectionDD_atxt; <>PRJ_DENewValue_txt)
			If ($Loc_l<0)
				CREATE RECORD:C68([TableOfLists:125])
				Inc_Sequence("TableOfLists"; ->[TableOfLists:125]ListKeyID_L:4)
				[TableOfLists:125]ListName_s:1:="Program"
				[TableOfLists:125]ListValue_s:2:=<>PRJ_DENewValue_txt
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
			$Complete_b:=True:C214
		Else 
			<>PRJ_DENewValue_txt:=PRJ_DENewValue_txt
			$Complete_b:=True:C214
	End case 
	If ($Complete_b)
		UNLOAD RECORD:C212([PRJ_ProjectDetails:115])
		
		COPY SET:C600("UserSet"; "◊MassEditSet")
		
		<>MassEdit_l:=LSpawnProcess("ut_PRJApplyMassEdits"; <>LStackSize; "Project Mass Edit"; True:C214; False:C215)
		
		//DELAY PROCESS(Current process;60)  `delay 3 saeconds to make sure we started
		C_LONGINT:C283($Count_l)
		$Count_l:=0
		Repeat 
			$Count_l:=$Count_l+1
			IDLE:C311
			DELAY PROCESS:C323(Current process:C322; 60)
		Until (<>MassEdit_l=0)
		CANCEL:C270
	End if 
End if 
//End Object Method: Button1