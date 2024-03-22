//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/09/09, 09:12:13
	// ----------------------------------------------------
	// Method: DCM_LoadConstrContrList
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_05
End if 
ARRAY TEXT:C222($ConstrContrNos_atxt; 0)
ARRAY TEXT:C222($ConstrContrLIst_atxt; 0)
C_LONGINT:C283(DCM_ConstrContrList_HL; $CatCount_L)
If (Is a list:C621(DCM_ConstrContrList_HL))
	CLEAR LIST:C377(DCM_ConstrContrList_HL; *)
End if 
DCM_ConstrContrList_HL:=New list:C375
READ ONLY:C145([PRJ_ConstructionProject:116])
READ ONLY:C145([PRJ_ProjectFile:117])
//ALL RECORDS([PRJ_ConstructionProject])
QUERY:C277([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_AELocation_s:23="District @")
//SET QUERY DESTINATION(Into set ;"RECENTAWARDContracts")
QUERY SELECTION:C341([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_Awarded_d:4>Add to date:C393(Current date:C33(*); (-8); 0; 0))
//SET QUERY DESTINATION(Into current selection )
QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_TypeCode_s:17="SM"; *)
QUERY:C277([PRJ_ProjectFile:117];  | ; [PRJ_ProjectFile:117]PF_TypeCode_s:17="SP")
ARRAY LONGINT:C221($SMSPPFFileIDS_aL; Records in selection:C76([PRJ_ProjectFile:117]))
SELECTION TO ARRAY:C260([PRJ_ProjectFile:117]PF_FileID_l:1; $SMSPPFFileIDS_aL)
If (Records in selection:C76([PRJ_ConstructionProject:116])>0)
	
	ORDER BY:C49([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_AELocation_s:23; >; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5)
	C_LONGINT:C283($loop_L; $SubList_HL; $startLoop_L; $NumConstrContr_L; $PosInSMSP_L; $LastValidContr_L)
	$NumConstrContr_L:=Records in selection:C76([PRJ_ConstructionProject:116])
	ARRAY TEXT:C222($ConstrContrNos_atxt; $NumConstrContr_L)
	ARRAY TEXT:C222($ConstrContrLIst_atxt; $NumConstrContr_L)
	ARRAY TEXT:C222($DCM_ContrLoc_atxt; $NumConstrContr_L)
	ARRAY LONGINT:C221($DCM_contrFID_aL; $NumConstrContr_L)
	SELECTION TO ARRAY:C260([PRJ_ConstructionProject:116]CP_AELocation_s:23; $DCM_ContrLoc_atxt; [PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5; $ConstrContrNos_atxt; [PRJ_ConstructionProject:116]CP_AEDescription_txt:22; $ConstrContrLIst_atxt; [PRJ_ConstructionProject:116]PF_FileID_l:11; $DCM_contrFID_aL)
	$CatCount_L:=1
	If (Is a list:C621($SubList_HL))
		CLEAR LIST:C377($SubList_HL; *)
	End if 
	$SubList_HL:=New list:C375
	C_BOOLEAN:C305($FoundFirst_b)
	$startLoop_L:=1
	Repeat 
		$PosInSMSP_L:=Find in array:C230($SMSPPFFileIDS_aL; $DCM_contrFID_aL{$startLoop_L})
		If (($ConstrContrLIst_atxt{$startLoop_L}="@BRIDGE@") | ($PosInSMSP_L>0))
			APPEND TO LIST:C376($SubList_HL; ($ConstrContrNos_atxt{$startLoop_L}+" - "+$ConstrContrLIst_atxt{$startLoop_L}); Num:C11($ConstrContrNos_atxt{$startLoop_L}))
			$FoundFirst_b:=True:C214
		Else 
			$startLoop_L:=$startLoop_L+1
		End if 
		
		
	Until ($FoundFirst_b)
	$LastValidContr_L:=$startLoop_L
	$startLoop_L:=$startLoop_L+1
	For ($loop_L; $startLoop_L; $NumConstrContr_L)
		$PosInSMSP_L:=Find in array:C230($SMSPPFFileIDS_aL; $DCM_contrFID_aL{$loop_L})
		If (($ConstrContrLIst_atxt{$startLoop_L}="@BRIDGE@") | ($PosInSMSP_L>0))
			If ($DCM_ContrLoc_atxt{$loop_L}#$DCM_ContrLoc_atxt{$LastValidContr_L})
				APPEND TO LIST:C376(DCM_ConstrContrList_HL; $DCM_ContrLoc_atxt{$LastValidContr_L}; (-$CatCount_L); $SubList_HL; True:C214)
				$CatCount_L:=$CatCount_L+1
				$SubList_HL:=New list:C375
			End if 
			APPEND TO LIST:C376($SubList_HL; ($ConstrContrNos_atxt{$loop_L}+" - "+$ConstrContrLIst_atxt{$loop_L}); Num:C11($ConstrContrNos_atxt{$loop_L}))
			$LastValidContr_L:=$loop_L
			
		End if 
		
	End for 
	APPEND TO LIST:C376(DCM_ConstrContrList_HL; $DCM_ContrLoc_atxt{$loop_L-1}; (-$CatCount_L); $SubList_HL; True:C214)
	
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($ConstrContrNos_atxt))
		$ConstrContrNos_atxt{$loop_L}:=""
	End for 
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($DCM_ContrLoc_atxt))
		$DCM_ContrLoc_atxt{$loop_L}:=""
	End for 
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($ConstrContrLIst_atxt))
		$ConstrContrLIst_atxt{$loop_L}:=""
	End for 
	
	ARRAY TEXT:C222($DCM_ContrLoc_atxt; 0)
	ARRAY LONGINT:C221($DCM_contrFID_aL; 0)
	ARRAY TEXT:C222($ConstrContrLIst_atxt; 0)
	ARRAY TEXT:C222($ConstrContrNos_atxt; 0)
	
End if 

ARRAY LONGINT:C221($SMSPPFFileIDS_aL; 0)

READ WRITE:C146([PRJ_ConstructionProject:116])
READ WRITE:C146([PRJ_ProjectFile:117])
