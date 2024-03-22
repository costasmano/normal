// ----------------------------------------------------
// Form Method: ProjectFile.i
// User name (OS): cjmiller
// Date and time: 03/03/06, 10:37:02
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2006_CJMv2
	Mods_2006_CJMv2  //11/30/06, 15:32:22`change to use new consultant name table
	Mods_2009_05  //r001  `05/08/09, 13:29:44  `Continue changes PRJ Design Contract Changes 
	//Change from [PRJ_ProjectFile]PF_ConsultantOverideID_l to [PRJ_ProjectDetails]PRJ_ConsultantOverideID_l
	Mods_2009_06  //r002 `06/11/09, 14:05:44   `Merge PRJ Design Contract Changes
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		utl_SetSpellandContextMenu
		ut_ResizeWindow(Frontmost window:C447; 763; 639)
		ut_SetStringOrTextFilter(->[PRJ_ProjectFile:117]PF_EWO_s:4)
		ut_SetStringOrTextFilter(->[PRJ_ProjectFile:117]PF_TIP_s:7)
		
		If ([PRJ_ProjectFile:117]PF_FromSQL_b:11)
			PRJ_SetEntry(False:C215)
		Else 
			PRJ_SetEntry(True:C214)
		End if 
		QUERY:C277([PRJ_DesignContracts:123]; [PRJ_DesignContracts:123]DC_DesignContractID_l:1=[PRJ_ProjectDetails:115]DC_DesignContractID_l:54)
		If (Records in selection:C76([PRJ_DesignContracts:123])=0)
			OBJECT SET VISIBLE:C603(*; "DC_@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "DC_@"; True:C214)
		End if 
		C_LONGINT:C283(PRJ_ConsultantHList_l; $hSubList_l; $Loop_l; $InnerLoop_l; $UniqueID_l)
		ALL RECORDS:C47([Conslt_Name:127])
		ARRAY TEXT:C222($Consultantnames_atxt; 0)
		SELECTION TO ARRAY:C260([Conslt_Name:127]ConsultantName_s:2; $Consultantnames_atxt; [Conslt_Name:127]ConsultantNameID_l:1; $NameID_al)
		If (Not:C34(Is a list:C621(PRJ_ConsultantHList_l)))
			PRJ_ConsultantHList_l:=New list:C375
			For ($Loop_l; 1; Size of array:C274($Consultantnames_atxt))
				QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsultantNameID_l:22=$NameID_al{$Loop_l})
				$UniqueID_l:=[Conslt Address:77]ConsltAddressID:1
				$hSubList_l:=New list:C375
				For ($InnerLoop_l; 1; Records in selection:C76([Conslt Address:77]))
					GOTO SELECTED RECORD:C245([Conslt Address:77]; $InnerLoop_l)
					APPEND TO LIST:C376($hSubList_l; [Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4; [Conslt Address:77]ConsltAddressID:1)
				End for 
				APPEND TO LIST:C376(PRJ_ConsultantHList_l; $Consultantnames_atxt{$Loop_l}; $NameID_al{$Loop_l}; $hSubList_l; True:C214)
			End for 
			SORT LIST:C391(PRJ_ConsultantHList_l; >)
			SET LIST PROPERTIES:C387(PRJ_ConsultantHList_l; _o_Ala Macintosh:K28:1)  // to maintain with form
		End if 
		POPUP_HL_MENUC(PRJ_ConsultantHList_l; ->[PRJ_DesignContracts:123]ConsultantNameID_l:2)
		QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltAddressID:1=[PRJ_DesignContracts:123]ConsultantNameID_l:2)
		DC_ConsultantName_txt:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
	: (Form event code:C388=On Validate:K2:3)
		If (Records in selection:C76([PRJ_DesignContracts:123])=1)
			SAVE RECORD:C53([PRJ_DesignContracts:123])
			UNLOAD RECORD:C212([PRJ_DesignContracts:123])
		End if 
	: (Form event code:C388=On Unload:K2:2)
		ut_ResizeWindow(Frontmost window:C447; 1000; 700)
End case 

//End Form Method: ProjectFile.i