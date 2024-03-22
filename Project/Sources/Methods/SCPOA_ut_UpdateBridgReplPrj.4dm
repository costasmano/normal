//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/09/09, 09:43:16
	// ----------------------------------------------------
	// Method: SCPOA_ut_UpdateBridgReplPrj
	// Description
	// Update Page 2 of the scour poa, from info in the projects table.
	// Get the projects scheduled for the BIN either awarded or scheduled.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_07
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
READ ONLY:C145(*)
ALL RECORDS:C47([ScourPOA:132])

FIRST RECORD:C50([ScourPOA:132])
C_DATE:C307($minDate_d; $MaxDate_d; $minAwardDate_D; $AdDate_d; $SchedAdDate_d; $AwardDate_D; $AwardadDate_D)
$minDate_d:=Date:C102("01/01/2006")
$MaxDate_d:=Date:C102("01/01/2015")
$minAwardDate_D:=Date:C102("01/01/2007")
C_LONGINT:C283($PFileNoAd_L; $PFileNoSchedAd_L; $PFileNoAwardAd_L; $PFileNo_L)
C_REAL:C285($ProjCost_r)
C_TEXT:C284($msg_txt; $Res_txt; $ProDesc_txt; $contrno_txt; $cost_txt)
C_BOOLEAN:C305($SaveData_b; $ClearCurrData_b)
$ClearCurrData_b:=False:C215
CONFIRM:C162("Save Changes to POAs?"; "Save"; "Don't Save")
$SaveData_b:=(OK=1)
If (Not:C34($SaveData_b))
	CONFIRM:C162("Clear Existing Data in the POAs?"; "Clear"; "Leave as is")
	$ClearCurrData_b:=(OK=1)
End if 

ut_StartMessage(3; "ScourBrhProjects.txt")
$msg_txt:="[ScourPOA]BIN"+<>sTAB+"($AdDate_d)"+<>sTAB+"($PFileNo_L)"+<>sTAB
$msg_txt:=$msg_txt+"($SchedAdDate_d)"+<>sTAB+"($PFileNoSchedAd_L)"+<>sTAB
$msg_txt:=$msg_txt+"($AwardDate_D)"+<>sTAB+"($PFileNoAwardAd_L)"+<>sTAB+"($AwardadDate_D)"+<>sTAB+"Res_txt"+<>sTAB+"NumBrgs"+<>sTAB+"BrgList"+<>sCR
ut_Message($msg_txt)
SCPOA_Variables("INIT")

While (Not:C34(End selection:C36([ScourPOA:132])))
	QUERY:C277([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetailsIncludedBINS:122]PDB_BIN_s:2=[ScourPOA:132]BIN:2)
	If (Records in selection:C76([PRJ_ProjectDetailsIncludedBINS:122])>0)
		RELATE ONE SELECTION:C349([PRJ_ProjectDetailsIncludedBINS:122]; [PRJ_ProjectDetails:115])
		RELATE ONE SELECTION:C349([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117])
		RELATE ONE SELECTION:C349([PRJ_ProjectDetails:115]; [PRJ_ConstructionProject:116])
		SET QUERY DESTINATION:C396(Into set:K19:2; "BRADVERTISED2014")
		QUERY SELECTION:C341([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_Advertised_d:14>$minDate_d; *)
		QUERY SELECTION:C341([PRJ_ProjectFile:117];  & ; [PRJ_ProjectFile:117]PF_Advertised_d:14<$MaxDate_d; *)
		QUERY SELECTION:C341([PRJ_ProjectFile:117];  & ; [PRJ_ProjectFile:117]PF_TypeCode_s:17="BR")
		SET QUERY DESTINATION:C396(Into set:K19:2; "BRSCHEDADVERTISED2014")
		QUERY SELECTION:C341([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5>$minDate_d; *)
		QUERY SELECTION:C341([PRJ_ProjectFile:117];  & ; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5<$MaxDate_d; *)
		QUERY SELECTION:C341([PRJ_ProjectFile:117];  & ; [PRJ_ProjectFile:117]PF_TypeCode_s:17="BR")
		SET QUERY DESTINATION:C396(Into set:K19:2; "BRAWARDED2014")
		QUERY SELECTION:C341([PRJ_ConstructionProject:116]; [PRJ_ConstructionProject:116]CP_Awarded_d:4>$minAwardDate_D; *)
		QUERY SELECTION:C341([PRJ_ConstructionProject:116];  & ; [PRJ_ConstructionProject:116]CP_Awarded_d:4<$MaxDate_d)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$AdDate_d:=!00-00-00!
		$SchedAdDate_d:=!00-00-00!
		$AwardDate_D:=!00-00-00!
		$AwardadDate_D:=!00-00-00!
		$ProjCost_r:=0
		$PFileNo_L:=0
		$PFileNoSchedAd_L:=0
		$PFileNoAwardAd_L:=0
		$Res_txt:=""
		$ProDesc_txt:=""
		$contrno_txt:=""
		$cost_txt:=""
		If (Records in set:C195("BRADVERTISED2014")>0)
			USE SET:C118("BRADVERTISED2014")
			ORDER BY:C49([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_Advertised_d:14; <)
			FIRST RECORD:C50([PRJ_ProjectFile:117])
			$AdDate_d:=[PRJ_ProjectFile:117]PF_Advertised_d:14
			$PFileNo_L:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
			$ProDesc_txt:=[PRJ_ProjectFile:117]PF_Description_txt:16
			$ProjCost_r:=[PRJ_ProjectFile:117]PF_EstTotalCost_r:10
		End if 
		If (Records in set:C195("BRSCHEDADVERTISED2014")>0)
			USE SET:C118("BRSCHEDADVERTISED2014")
			ORDER BY:C49([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5; <)
			FIRST RECORD:C50([PRJ_ProjectFile:117])
			$SchedAdDate_d:=[PRJ_ProjectFile:117]PF_ScheduledAdvertising_d:5
			$PFileNoSchedAd_L:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
			$ProDesc_txt:=[PRJ_ProjectFile:117]PF_Description_txt:16
			$ProjCost_r:=[PRJ_ProjectFile:117]PF_EstTotalCost_r:10
		End if 
		If (Records in set:C195("BRAWARDED2014")>0)
			USE SET:C118("BRAWARDED2014")
			FIRST RECORD:C50([PRJ_ConstructionProject:116])
			QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ConstructionProject:116]PF_FileID_l:11)
			If ([PRJ_ProjectFile:117]PF_TypeCode_s:17="BR")
				$contrno_txt:=[PRJ_ConstructionProject:116]CP_ConstructionContractNo_s:5
				$PFileNoAwardAd_L:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
				$AwardDate_D:=[PRJ_ConstructionProject:116]CP_Awarded_d:4
				$AwardadDate_D:=[PRJ_ProjectFile:117]PF_Advertised_d:14
				$ProDesc_txt:=[PRJ_ProjectFile:117]PF_Description_txt:16
				$ProjCost_r:=[PRJ_ConstructionProject:116]CP_LowBid_r:7
			End if 
			
		End if 
		$ProDesc_txt:=Replace string:C233($ProDesc_txt; <>sTAB; " ")
		$ProDesc_txt:=Replace string:C233($ProDesc_txt; <>sCR; "  ")
		$ProDesc_txt:=Replace string:C233($ProDesc_txt; <>sLF; "  ")
		
		If ($AwardDate_D#!00-00-00!)
			$Res_txt:="Construction Contract # "+$contrno_txt+", for Bridge Replacement Project # "+String:C10($PFileNoAwardAd_L)+" ["+$ProDesc_txt+"],  was awarded on "+String:C10($AwardDate_D)+"."
			$cost_txt:="The Low Bid was $"+String:C10($ProjCost_r; "###,###,###,##0.")
			$PFileNo_L:=$PFileNoAwardAd_L
		Else 
			If ($AdDate_d#!00-00-00!)
				$Res_txt:="Bridge Replacement Project # "+String:C10($PFileNo_L)+" ["+$ProDesc_txt+"]  was advertised on "+String:C10($AdDate_d)+"."
				$cost_txt:=" Total project cost is $"+String:C10($ProjCost_r; "###,###,###,##0.")
			Else 
				If ($SchedAdDate_d#!00-00-00!)
					$Res_txt:="Bridge Replacement Project # "+String:C10($PFileNoSchedAd_L)+" ["+$ProDesc_txt+"]  is to be advertised on "+String:C10($SchedAdDate_d)+"."
					$cost_txt:=" Total project cost is $"+String:C10($ProjCost_r; "###,###,###,##0.")
					$PFileNo_L:=$PFileNoSchedAd_L
				End if 
				
			End if 
			
		End if 
		C_LONGINT:C283($NumProjBridges_L; $loop_L; $indx_L)
		C_TEXT:C284($BridgeList_txt)
		$NumProjBridges_L:=0
		$BridgeList_txt:=""
		If ($PFileNo_L>0)
			QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileNumber_l:3=$PFileNo_L)
			QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3=[PRJ_ProjectFile:117]PF_FileID_l:1)
			ARRAY TEXT:C222($BridgeNos_atxt; Records in selection:C76([PRJ_ProjectDetails:115]))
			SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $BridgeNos_atxt)
			$NumProjBridges_L:=Size of array:C274($BridgeNos_atxt)
			If ($NumProjBridges_L>0)
				For ($loop_L; 1; $NumProjBridges_L)
					If (Length:C16($BridgeNos_atxt{$loop_L})=6)
						QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$BridgeNos_atxt{$loop_L})
						QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BIN:1=[Bridge MHD NBIS:1]BIN:3)
						QUERY SELECTION:C341([TownLineInfo:73]; [TownLineInfo:73]BDEPT:2#"")
						If (Records in selection:C76([TownLineInfo:73])>0)
							$BridgeNos_atxt{$loop_L}:=$BridgeNos_atxt{$loop_L}+"="+[TownLineInfo:73]BDEPT:2
						End if 
						
					End if 
					
				End for 
				
				SORT ARRAY:C229($BridgeNos_atxt)
				For ($loop_L; $NumProjBridges_L; 2; -1)
					$indx_L:=Find in array:C230($BridgeNos_atxt; (Substring:C12($BridgeNos_atxt{$loop_L}; 1; 6)+"@"))
					If ($indx_L<$loop_L)
						DELETE FROM ARRAY:C228($BridgeNos_atxt; $loop_L)
					End if 
					
				End for 
				$NumProjBridges_L:=Size of array:C274($BridgeNos_atxt)
				$BridgeList_txt:=$BridgeNos_atxt{1}
				For ($loop_L; 2; $NumProjBridges_L)
					$BridgeList_txt:=$BridgeList_txt+", "+$BridgeNos_atxt{$loop_L}
				End for 
			End if 
			
		End if 
		If ($Res_txt#"")
			If ($NumProjBridges_L>1)
				$Res_txt:=$Res_txt+" The project includes a total of "+String:C10($NumProjBridges_L)+" bridges."
			End if 
			$Res_txt:=$Res_txt+" "+$cost_txt
		End if 
		
		$msg_txt:=[ScourPOA:132]BIN:2+<>sTAB+String:C10($AdDate_d)+<>sTAB+String:C10($PFileNo_L)+<>sTAB
		$msg_txt:=$msg_txt+String:C10($SchedAdDate_d)+<>sTAB+String:C10($PFileNoSchedAd_L)+<>sTAB
		$msg_txt:=$msg_txt+String:C10($AwardDate_D)+<>sTAB+String:C10($PFileNoAwardAd_L)+<>sTAB+String:C10($AwardadDate_D)+<>sTAB+$Res_txt+<>sTAB
		$msg_txt:=$msg_txt+String:C10($NumProjBridges_L)+<>sTAB+$BridgeList_txt+<>sCR
		ut_Message($msg_txt)
		If (($AwardDate_D#!00-00-00!) | ($AdDate_d#!00-00-00!) | ($SchedAdDate_d#!00-00-00!))
			If (ut_LoadRecordInteractive(->[ScourPOA:132]))
				If ($SaveData_b)
					SCPOA_Variables("CLEAR")
					SCPOA_Variables("LOAD")
					SCPOA_PropCNT_txt:=$Res_txt
					SCPOA_Inst_BrgRepl_L:=1
					SCPOA_Inst_BrgRepl_r:=$ProjCost_r
					SCPOA_Variables("SAVE")
					SAVE RECORD:C53([ScourPOA:132])
				Else 
					If ($ClearCurrData_b)
						SCPOA_Variables("CLEAR")
						SCPOA_Variables("LOAD")
						SCPOA_PropCNT_txt:=""
						SCPOA_Inst_BrgRepl_L:=0
						SCPOA_Inst_BrgRepl_r:=0
						SCPOA_Variables("SAVE")
						SAVE RECORD:C53([ScourPOA:132])
					End if 
					
				End if 
			Else 
				ALERT:C41("Cannot load POA record for BIN "+[ScourPOA:132]BIN:2)
			End if 
			
		End if 
		
	End if 
	
	NEXT RECORD:C51([ScourPOA:132])
End while 

$Res_txt:=""
$ProDesc_txt:=""
$contrno_txt:=""
$msg_txt:=""
$cost_txt:=""
ut_CloseMessage
CLEAR SET:C117("BRADVERTISED2014")
CLEAR SET:C117("BRSCHEDADVERTISED2014")
CLEAR SET:C117("BRAWARDED2014")
ALERT:C41("Done!")
READ WRITE:C146(*)
