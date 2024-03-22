// ----------------------------------------------------
// Form Method: Input
// User name (OS): cjmiller
// Date and time: 11/30/06, 15:18:30
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //03/15/07, 12:34:00`Modify to use group description
	Mods_2007_CJM_v5303  //r006 `changes for use as a consultant selector
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		If (Record number:C243([Conslt_Name:127])=New record:K29:1)
			Inc_Sequence("ConsultantNameID_l"; ->[Conslt_Name:127]ConsultantNameID_l:1)
		Else 
			PRJ_CurrentPrjMgr_txt:=""
			PRJ_SetUpStructuralPrjMgr(->[Conslt_Name:127]; [Conslt_Name:127]CurrentStructureProjectMgr_l:4)
			
			If ([Conslt_Name:127]SQL_VendorID_l:3#0)
				OBJECT SET ENTERABLE:C238([Conslt_Name:127]ConsultantName_s:2; False:C215)
			Else 
				OBJECT SET ENTERABLE:C238([Conslt_Name:127]ConsultantName_s:2; True:C214)
			End if 
		End if 
	: (Form event code:C388=On Validate:K2:3)
		If (<>SelectionOption_txt="Consultant") | (<>SelectionOption_txt="OverideConsultant")
			<>PRJ_SelectedData_txt:=String:C10([Conslt_Name:127]ConsultantNameID_l:1)
			
		End if 
		If (Old:C35([Conslt_Name:127]ConsultantName_s:2)#([Conslt_Name:127]ConsultantName_s:2))
			QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=[Conslt_Name:127]ConsultantNameID_l:1)
			Repeat 
				APPLY TO SELECTION:C70([Conslt Address:77]; [Conslt_Name:127]ConsultantName_s:2:=PRJ_ConsultantName_atxt{1})
				If (Records in set:C195("LockedSet")#0)
					USE SET:C118("LockedSet")
				End if 
			Until (Records in set:C195("LockedSet")=0)
		End if 
		If (Old:C35([Conslt_Name:127]CurrentStructureProjectMgr_l:4)#0)
			If (Old:C35([Conslt_Name:127]CurrentStructureProjectMgr_l:4)#([Conslt_Name:127]CurrentStructureProjectMgr_l:4))
				If (Old:C35([Conslt_Name:127]CurrentStructureProjectMgr_l:4)>0)
					QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39=Old:C35([Conslt_Name:127]CurrentStructureProjectMgr_l:4))
					QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=Old:C35([Conslt_Name:127]CurrentStructureProjectMgr_l:4))
					C_TEXT:C284($Name_txt)
					C_DATE:C307($Current_d)
					$Name_txt:=[Personnel:42]Last Name:5+", "+[Personnel:42]First Name:3
					$Current_d:=Current date:C33(*)
					C_LONGINT:C283($Loop_l)
					C_BOOLEAN:C305($Complete_b)
					$Complete_b:=False:C215
					CREATE SET:C116([PRJ_ProjectDetails:115]; "WorkingOnSet")
					$Loop_l:=0
					Repeat 
						APPLY TO SELECTION:C70([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39:=[Conslt_Name:127]CurrentStructureProjectMgr_l:4)
						If (Records in set:C195("LockedSet")>0)
							USE SET:C118("LockedSet")
							$Loop_l:=$Loop_l+1
							If ($Loop_l>20)
								LOAD RECORD:C52([PRJ_ProjectDetails:115])
								C_LONGINT:C283($process_l)
								C_TEXT:C284($User_txt; $Machine_txt; $ProcessName_txt)
								LOCKED BY:C353([PRJ_ProjectDetails:115]; $process_l; $User_txt; $Machine_txt; $ProcessName_txt)
								CONFIRM:C162("There are "+String:C10(Records in selection:C76([PRJ_ProjectDetails:115]))+" locked. The first is locked by "+$User_txt+" on machine "+$Machine_txt; "Continue Trying"; "Skip Remainder")
								If (OK=1)
								Else 
									$Complete_b:=True:C214
								End if 
							End if 
						Else 
							$Complete_b:=True:C214
						End if 
					Until ($Complete_b)
					DIFFERENCE:C122("WorkingOnSet"; "LockedSet"; "WorkingOnSet")
					USE SET:C118("WorkingOnSet")
					ARRAY LONGINT:C221($ProjectIDs_al; 0)
					SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]PRJ_ProjectID_l:1; $ProjectIDs_al)
					For ($Loop_l; 1; Size of array:C274($ProjectIDs_al))
						CREATE RECORD:C68([PRJ_StrPrjManagerHistory:128])
						[PRJ_StrPrjManagerHistory:128]PRJ_ProjectID_l:1:=$ProjectIDs_al{$Loop_l}
						[PRJ_StrPrjManagerHistory:128]SPMH_Replaced_d:3:=$Current_d
						[PRJ_StrPrjManagerHistory:128]SPMH_StructuralProjManager_txt:2:=$Name_txt
						SAVE RECORD:C53([PRJ_StrPrjManagerHistory:128])
						UNLOAD RECORD:C212([PRJ_StrPrjManagerHistory:128])
						
					End for 
					CLEAR SET:C117("WorkingOnSet")
				End if 
			End if 
		End if 
End case 
//End Form Method: Input