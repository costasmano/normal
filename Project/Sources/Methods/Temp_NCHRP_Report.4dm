//%attributes = {"invisible":true}
If (False:C215)
	If (False:C215)
		// ----------------------------------------------------
		// User name (OS): costasmanousakis
		// User name (4D): Designer
		// Date and time: 11/10/09, 16:05:01
		// ----------------------------------------------------
		// Method: Method: Temp_NCHRP_Report
		// Description
		// Temp method to get a report on projects and costs for an NCHRP report request
		// 
		// Parameters
		// ----------------------------------------------------
		
		Mods_2009_11
	End if 
	
	QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5#"")
	QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_TypeCode_s:17="BH"; *)
	QUERY SELECTION:C341([PRJ_ProjectDetails:115];  | ; [PRJ_ProjectFile:117]PF_TypeCode_s:17="BR"; *)
	QUERY SELECTION:C341([PRJ_ProjectDetails:115];  | ; [PRJ_ProjectFile:117]PF_TypeCode_s:17="SM")
	QUERY SELECTION:C341([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117]PF_Advertised_d:14>!2003-12-31!; *)
	QUERY SELECTION:C341([PRJ_ProjectDetails:115];  & ; [PRJ_ProjectFile:117]PF_Advertised_d:14<!2009-01-01!)
	
	ARRAY TEXT:C222($PrjBridges_atxt; Records in selection:C76([PRJ_ProjectDetails:115]))
	SELECTION TO ARRAY:C260([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $PrjBridges_atxt)
	CREATE SET:C116([PRJ_ProjectDetails:115]; "BRGSEARCHSTARTSET")
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($PrjBridges_atxt))
		$PrjBridges_atxt{$loop_L}:=Substring:C12($PrjBridges_atxt{$loop_L}; 1; 6)
	End for 
	QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BDEPT:1; $PrjBridges_atxt)
	QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]LegacyOwner:226="MHD")
	QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
	If (Records in selection:C76([Bridge MHD NBIS:1])>0)
		ARRAY TEXT:C222($BridgeBDEPTS_atxt; Records in selection:C76([Bridge MHD NBIS:1]))
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BDEPT:1; $BridgeBDEPTS_atxt)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($BridgeBDEPTS_atxt))
			$BridgeBDEPTS_atxt{$loop_L}:=$BridgeBDEPTS_atxt{$loop_L}+"@"
		End for 
		SET QUERY DESTINATION:C396(Into set:K19:2; "BRGSEARCHBRIDGESET")
		QUERY WITH ARRAY:C644([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; $BridgeBDEPTS_atxt)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		INTERSECTION:C121("BRGSEARCHSTARTSET"; "BRGSEARCHBRIDGESET"; "BRGSEARCHSTARTSET")
		If (Records in set:C195("BRGSEARCHSTARTSET")>0)
			USE SET:C118("BRGSEARCHSTARTSET")
		End if 
		CLEAR SET:C117("BRGSEARCHSTARTSET")
		CLEAR SET:C117("BRGSEARCHBRIDGESET")
		RELATE ONE SELECTION:C349([PRJ_ProjectDetails:115]; [PRJ_ProjectFile:117])
		ARRAY LONGINT:C221(PFFileIDS_aL; Records in selection:C76([PRJ_ProjectFile:117]))
		ARRAY TEXT:C222(PFBridgeNos_atxt; Records in selection:C76([PRJ_ProjectFile:117]))
		ARRAY REAL:C219(PFAreas_ar; Records in selection:C76([PRJ_ProjectFile:117]))
		ARRAY LONGINT:C221(PFBridges_aL; Records in selection:C76([PRJ_ProjectFile:117]))
		SELECTION TO ARRAY:C260([PRJ_ProjectFile:117]PF_FileID_l:1; PFFileIDS_aL)
		SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
		
		C_LONGINT:C283($loop_L; $K; $BridgeCount)
		C_TEXT:C284($BridgeNo_txt; $ProjBridges_txt)
		C_REAL:C285($ProjArea_r)
		For ($loop_L; 1; Size of array:C274(PFFileIDS_aL))
			$ProjBridges_txt:=""
			$ProjArea_r:=0
			$BridgeCount:=0
			QUERY:C277([PRJ_ProjectDetails:115]; [PRJ_ProjectDetails:115]PF_FileID_l:3=PFFileIDS_aL{$loop_L})
			FIRST RECORD:C50([PRJ_ProjectDetails:115])
			While (Not:C34(End selection:C36([PRJ_ProjectDetails:115])))
				$BridgeNo_txt:=Substring:C12([PRJ_ProjectDetails:115]PRJ_BridgeNo_s:5; 1; 6)
				If (Position:C15($BridgeNo_txt; $ProjBridges_txt)>0)
				Else 
					$ProjBridges_txt:=$ProjBridges_txt+" - "+$BridgeNo_txt+" -"
					QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$BridgeNo_txt)
					QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]LegacyOwner:226="MHD")
					QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
					FIRST RECORD:C50([Bridge MHD NBIS:1])
					While (Not:C34(End selection:C36([Bridge MHD NBIS:1])))
						$ProjArea_r:=[Bridge MHD NBIS:1]Item49:93*[Bridge MHD NBIS:1]Item52:97+$ProjArea_r
						$BridgeCount:=$BridgeCount+1
						$ProjBridges_txt:=$ProjBridges_txt+"["+[Bridge MHD NBIS:1]BIN:3+"]"
						NEXT RECORD:C51([Bridge MHD NBIS:1])
					End while 
					
				End if 
				PFAreas_ar{$loop_L}:=$ProjArea_r
				PFBridges_aL{$loop_L}:=$BridgeCount
				PFBridgeNos_atxt{$loop_L}:=$ProjBridges_txt
				NEXT RECORD:C51([PRJ_ProjectDetails:115])
			End while 
			
		End for 
		
		QR REPORT:C197([PRJ_ProjectFile:117]; Char:C90(1); False:C215; True:C214)
		
	End if 
End if 