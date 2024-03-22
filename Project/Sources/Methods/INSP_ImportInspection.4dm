//%attributes = {"invisible":true}
// Method: Method: INSP_ImportInspection
// Description
// Import an Inspection from a file.
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/18/05, 09:19:26
	// ----------------------------------------------------
	
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(12/13/2005 11:59:49)
	Mods_2005_CM20
	// Modified by: Costas Manousakis-(Designer)-(10/30/13 17:12:28)
	Mods_2013_10
	//  `Added importing of [TunnelInspection] record and additional warning at the end of the import
	//  `regarding the personnel. It will have to be verified if the data file is not the same as the export
	// Modified by: Costas Manousakis-(Designer)-(4/16/14 17:25:35)
	Mods_2014_04
	//  `added import of  [ElmtRatingLoads]
	// Modified by: Costas Manousakis-(Designer)-(4/15/15 17:17:30)
	Mods_2015_04
	//  `added import of NBEs
	// Modified by: Costas Manousakis-(Designer)-(4/1/16 16:38:24)
	Mods_2016_04_bug
	//  `added code to unload records from all tables loaded
	// Modified by: Costas Manousakis-(Designer)-(6/22/16 09:12:24)
	Mods_2016_NTE
	//  `added import of NTEs
	// Modified by: Costas Manousakis-(Designer)-(11/3/17 15:46:37)
	Mods_2017_11_bug
	//  `update UUIDs of imported records - skip logging UUID fields
	// Modified by: Costas Manousakis-(Designer)-(5/1/18 17:30:10)
	Mods_2018_05_bug
	//  `Modifications to allow importing an inspection to a different BIN.
	// Modified by: Costas Manousakis-(Designer)-(6/25/18 09:42:42)
	Mods_2018_06_bug
	//  `fix bug in logging of std photos where Stdphotoid was the only GRP change
	Mods_NewDownloadCode  //Make changes to address new upload and download code
	//These methods moved from single user to DEV Server 
	//Add call to Synch_ReturnForward to reset new style vsForward
	//Modified by: Chuck Miller (1/11/22 10:57:26)
End if 

SET CHANNEL:C77(10; "")
C_TEXT:C284($CurrBIN)  // old C_STRING length 3
$CurrBIN:=[Bridge MHD NBIS:1]BIN:3
If (Ok=1)
	C_TEXT:C284($ExportHeader)
	RECEIVE VARIABLE:C81($ExportHeader)
	If ($ExportHeader#"InspectionExport")
		ALERT:C41("File <"+Document+"> NOT A VALID MHD BMS Inspection Export data file!!")
	Else 
		C_BOOLEAN:C305($DoImport_b)
		
		RECEIVE RECORD:C79([Inspections:27])
		$DoImport_b:=False:C215
		If ([Inspections:27]BIN:1=$CurrBIN)
			$DoImport_b:=True:C214
		Else 
			CONFIRM:C162("Inspection BIN "+[Inspections:27]BIN:1+" not for Current BIN "+$CurrBIN; "Load for BIN "+$CurrBIN; "Cancel")
			If (OK=1)
				//will switch inspection to the current BIN
				$DoImport_b:=True:C214
			Else 
				
			End if 
		End if 
		
		If ($DoImport_b)
			//Get the Table Number of [Inspections] table
			C_LONGINT:C283($InspTable; $ElmtTable; $ImgTable; $Num_I_Fields; $Num_El_Fields; $Num_Img_Fields; $BMSTable; $Num_BMS_Fields; $vlFldLen)
			C_LONGINT:C283($CUSTable; $Num_CUS_Fields; $CombTable; $Num_Comb_Fields)
			ARRAY LONGINT:C221($TablesToUnload_aL; 0)
			$InspTable:=Table:C252(->[Inspections:27])
			APPEND TO ARRAY:C911($TablesToUnload_aL; $InspTable)
			
			$Num_I_Fields:=Get last field number:C255($InspTable)
			ARRAY POINTER:C280($a_Ptr_InspFields; $Num_I_Fields)
			For ($i; 1; $Num_I_Fields)
				$a_Ptr_InspFields{$i}:=Field:C253($InspTable; $i)
			End for 
			$ImgTable:=Table:C252(->[Standard Photos:36])
			APPEND TO ARRAY:C911($TablesToUnload_aL; $ImgTable)
			$Num_Img_Fields:=Get last field number:C255(->[Standard Photos:36])
			ARRAY POINTER:C280($a_Ptr_ImgFields; $Num_Img_Fields)
			For ($i; 1; $Num_Img_Fields)
				$a_Ptr_ImgFields{$i}:=Field:C253($ImgTable; $i)
			End for 
			$BMSTable:=Table:C252(->[BMS Inspections:44])
			APPEND TO ARRAY:C911($TablesToUnload_aL; $BMSTable)
			$Num_BMS_Fields:=Get last field number:C255(->[BMS Inspections:44])
			ARRAY POINTER:C280($a_Ptr_BMSFields; $Num_BMS_Fields)
			For ($i; 1; $Num_BMS_Fields)
				$a_Ptr_BMSFields{$i}:=Field:C253($BMSTable; $i)
			End for 
			$CUSTable:=Table:C252(->[Cond Units:45])
			APPEND TO ARRAY:C911($TablesToUnload_aL; $CUSTable)
			$Num_CUS_Fields:=Get last field number:C255(->[Cond Units:45])
			ARRAY POINTER:C280($a_Ptr_CUFields; $Num_CUS_Fields)
			For ($i; 1; $Num_CUS_Fields)
				$a_Ptr_CUFields{$i}:=Field:C253($CUSTable; $i)
			End for 
			$CombTable:=Table:C252(->[Combined Inspections:90])
			APPEND TO ARRAY:C911($TablesToUnload_aL; $CombTable)
			$Num_Comb_Fields:=Get last field number:C255(->[Combined Inspections:90])
			ARRAY POINTER:C280($a_Ptr_CombFields; $Num_Comb_Fields)
			For ($i; 1; $Num_Comb_Fields)
				$a_Ptr_CombFields{$i}:=Field:C253($CombTable; $i)
			End for 
			$ElmtTable:=Table:C252(->[ElementsSafety:29])
			APPEND TO ARRAY:C911($TablesToUnload_aL; $ElmtTable)
			$Num_El_Fields:=Get last field number:C255(->[ElementsSafety:29])
			ARRAY POINTER:C280($a_Ptr_ElFields; $Num_El_Fields)
			For ($i; 1; $Num_El_Fields)
				$a_Ptr_ElFields{$i}:=Field:C253($ElmtTable; $i)
			End for 
			C_LONGINT:C283($TunnelInspTbl; $Num_Tnl_Fields)
			$TunnelInspTbl:=Table:C252(->[TunnelInspection:152])
			APPEND TO ARRAY:C911($TablesToUnload_aL; $TunnelInspTbl)
			$Num_Tnl_Fields:=Get last field number:C255(->[TunnelInspection:152])
			ARRAY POINTER:C280($a_Ptr_TNLFields; $Num_Tnl_Fields)
			For ($i; 1; $Num_Tnl_Fields)
				$a_Ptr_TNLFields{$i}:=Field:C253($TunnelInspTbl; $i)
			End for 
			//add the field trip tables and [PON_ELEM_INSP]
			APPEND TO ARRAY:C911($TablesToUnload_aL; Table:C252(->[Field Trip:43]))
			APPEND TO ARRAY:C911($TablesToUnload_aL; Table:C252(->[BMS Field Trip:56]))
			APPEND TO ARRAY:C911($TablesToUnload_aL; Table:C252(->[PON_ELEM_INSP:179]))
			APPEND TO ARRAY:C911($TablesToUnload_aL; Table:C252(->[NTI_ELEM_BIN_INSP:183]))
			
			SHORT_MESSAGE("Importing Inspection...")
			C_LONGINT:C283($NumTeam_L; $NumElmts_L; $NumPhotos_L; $NumPontisElmt_L; $NumPontisTm_L; $i; $j; $viFldType)
			C_TEXT:C284($vtSkipFields; $FieldName)
			
			Inc_Sequence("Inspections"; ->[Inspections:27]InspID:2)
			[Inspections:27]Inspections_UUIDKey_s:226:=Generate UUID:C1066
			[Inspections:27]BIN:1:=[Bridge MHD NBIS:1]BIN:3  //make sure BIN is the current one
			vsForward:=Synch_ReturnForward([Bridge MHD NBIS:1]Item2:60; [Bridge MHD NBIS:1]InspResp:173; [Inspections:27]Insp Type:6; [Inspections:27]TeamLeader:4)
			
			SAVE RECORD:C53([Inspections:27])
			LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1; "Inspections")
			C_DATE:C307($InspDate_d)
			C_TEXT:C284($InspType_txt)
			$InspDate_d:=[Inspections:27]Insp Date:78
			$InspType_txt:=[Inspections:27]Insp Type:6
			InitChangeStack(1)
			C_LONGINT:C283($viFldType)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
			For ($i; 1; $Num_I_Fields)
				$FieldName:=Field name:C257($a_Ptr_InspFields{$i})
				If (($FieldName#"InspID") & ($FieldName#"BIN"))  //Skip BIN and INSPID
					GET FIELD PROPERTIES:C258($a_Ptr_InspFields{$i}; $viFldType; $vlFldLen)
					If (($viFldType=Is subtable:K8:11) | (($viFldType=Is alpha field:K8:1) & ($vlFldLen=0)))  //skip subtables and UUIDs
					Else 
						PushChange(1; $a_Ptr_InspFields{$i})
					End if 
				End if 
			End for 
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Inspections:27]BIN:1; ->[Inspections:27]InspID:2; 1)
			
			RECEIVE VARIABLE:C81($NumTeam_L)
			If ($NumTeam_L>0)
				MESSAGE:C88(<>sCR+"Loading Team..")
				For ($i; 1; $NumTeam_L)
					MESSAGE:C88(String:C10($i)+" of "+String:C10($NumTeam_L)+".. ")
					RECEIVE RECORD:C79([Field Trip:43])
					[Field Trip:43]InspID:1:=[Inspections:27]InspID:2
					[Field Trip:43]Field_Trip_UUIDKey_s:3:=Generate UUID:C1066
					SAVE RECORD:C53([Field Trip:43])
					LogNewRecord(->[Inspections:27]InspID:2; ->[Field Trip:43]InspID:1; ->[Field Trip:43]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
				End for 
			End if 
			RECEIVE VARIABLE:C81($NumElmts_L)
			ARRAY LONGINT:C221($ImportElmIDs_aL; 0)
			ARRAY LONGINT:C221($NewElmIDs_aL; 0)
			If ($NumElmts_L>0)
				ARRAY LONGINT:C221($ImportElmIDs_aL; $NumElmts_L)
				ARRAY LONGINT:C221($NewElmIDs_aL; $NumElmts_L)
				MESSAGE:C88(<>sCR+"Loading Elements..")
				For ($i; 1; $NumElmts_L)
					MESSAGE:C88(String:C10($i)+" of "+String:C10($NumElmts_L)+".. ")
					RECEIVE RECORD:C79([ElementsSafety:29])
					$ImportElmIDs_aL{$i}:=[ElementsSafety:29]ElmSafetyID:7
					Inc_Sequence("ElementsSafety"; ->[ElementsSafety:29]ElmSafetyID:7)
					[ElementsSafety:29]ElementsSafety_UUIDKey_s:27:=Generate UUID:C1066
					$NewElmIDs_aL{$i}:=[ElementsSafety:29]ElmSafetyID:7
					[ElementsSafety:29]InspID:4:=[Inspections:27]InspID:2
					SAVE RECORD:C53([ElementsSafety:29])
					LogNewRecord(->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2; "ElementsSafety")
					InitChangeStack(1)
					For ($j; 1; $Num_El_Fields)
						$FieldName:=Field name:C257($a_Ptr_ElFields{$j})
						GET FIELD PROPERTIES:C258($a_Ptr_ElFields{$j}; $viFldType; $vlFldLen)
						
						If (($FieldName="InspID") | ($FieldName="ElmSafetyID") | (($viFldType=Is alpha field:K8:1) & ($vlFldLen=0)))  //Skip Ids and UUIDs
						Else 
							PushChange(1; $a_Ptr_ElFields{$j})
						End if 
					End for 
					FlushGrpChgs(1; ->[Inspections:27]InspID:2; ->[ElementsSafety:29]InspID:4; ->[ElementsSafety:29]ElmSafetyID:7; 2)
					
				End for 
			End if 
			RECEIVE VARIABLE:C81($NumPhotos_L)
			If ($NumPhotos_L>0)
				MESSAGE:C88(<>sCR+"Loading Images..")
				For ($i; 1; $NumPhotos_L)
					MESSAGE:C88(String:C10($i)+" of "+String:C10($NumPhotos_L)+".. ")
					RECEIVE RECORD:C79([Standard Photos:36])
					Inc_Sequence("StandardPhotos"; ->[Standard Photos:36]StdPhotoID:7)
					[Standard Photos:36]InspID:1:=[Inspections:27]InspID:2
					[Standard Photos:36]Standard_Photos_UUIDKey_s:10:=Generate UUID:C1066
					SAVE RECORD:C53([Standard Photos:36])
					// log the change/duplication here
					LogNewRecord(->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2; "StandardPhotos")
					InitChangeStack(1)
					For ($j; 1; $Num_Img_Fields)
						$FieldName:=Field name:C257($a_Ptr_ImgFields{$j})
						GET FIELD PROPERTIES:C258($a_Ptr_ImgFields{$j}; $viFldType; $vlFldLen)
						
						If (($FieldName="InspID") | ($FieldName="StdPhotoID") | (($viFldType=Is alpha field:K8:1) & ($vlFldLen=0)))  //Skip Ids and UUIDs
						Else 
							PushChange(1; $a_Ptr_ImgFields{$j})
						End if 
					End for 
					FlushGrpChgs(1; ->[Inspections:27]InspID:2; ->[Standard Photos:36]InspID:1; ->[Standard Photos:36]StdPhotoID:7; 2)
					
				End for 
			End if 
			C_LONGINT:C283($BMSInspID_L)
			RECEIVE VARIABLE:C81($BMSInspID_L)
			If ($BMSInspID_L>0)
				MESSAGE:C88(<>sCR+"Loading Pontis Insp..")
				RECEIVE RECORD:C79([BMS Inspections:44])
				Inc_Sequence("Pontis Insp ID"; ->[BMS Inspections:44]Inspection ID:1)
				[BMS Inspections:44]BMS_Inspections_UUIDKey_s:18:=Generate UUID:C1066
				[BMS Inspections:44]BIN:2:=[Bridge MHD NBIS:1]BIN:3  //make sure BIN is the current one
				SAVE RECORD:C53([BMS Inspections:44])
				$BMSInspID_L:=[BMS Inspections:44]Inspection ID:1
				LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1; "Pontis Insp ID")
				$vtSkipFields:=";Inspection ID;BIN;"
				InitChangeStack(1)
				For ($i; 1; $Num_BMS_Fields)
					$FieldName:=Field name:C257($a_Ptr_BMSFields{$i})
					If (Position:C15((";"+$FieldName+";"); $vtSkipFields)=0)
						GET FIELD PROPERTIES:C258($a_Ptr_BMSFields{$i}; $viFldType; $vlFldLen)
						If (($viFldType=Is subtable:K8:11) | (($viFldType=Is alpha field:K8:1) & ($vlFldLen=0)))  //AND subtables
						Else 
							PushChange(1; $a_Ptr_BMSFields{$i})
						End if 
					End if 
				End for 
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[BMS Inspections:44]BIN:2; ->[BMS Inspections:44]Inspection ID:1; 1)
				
				RECEIVE VARIABLE:C81($NumElmts_L)
				If ($NumElmts_L>0)
					MESSAGE:C88(<>sCR+"Loading Pontis Elmts..")
					For ($i; 1; $NumElmts_L)
						MESSAGE:C88(String:C10($i)+" of "+String:C10($NumElmts_L)+".. ")
						RECEIVE RECORD:C79([Cond Units:45])
						Inc_Sequence("Cond Unit ID"; ->[Cond Units:45]Cond Unit ID:1)
						[Cond Units:45]Inspection ID:2:=[BMS Inspections:44]Inspection ID:1
						[Cond Units:45]Cond_Units_UUIDKey_s:17:=Generate UUID:C1066
						SAVE RECORD:C53([Cond Units:45])
						LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2; "Cond Unit ID")
						InitChangeStack(1)
						For ($j; 1; $Num_CUS_Fields)
							$FieldName:=Field name:C257($a_Ptr_CUFields{$j})
							GET FIELD PROPERTIES:C258($a_Ptr_CUFields{$j}; $viFldType; $vlFldLen)
							If (($FieldName="Inspection ID") | ($FieldName="Cond Unit ID") | (($viFldType=Is alpha field:K8:1) & ($vlFldLen=0)))  //Skip Ids
							Else 
								PushChange(1; $a_Ptr_CUFields{$j})
							End if 
						End for 
						FlushGrpChgs(1; ->[BMS Inspections:44]Inspection ID:1; ->[Cond Units:45]Inspection ID:2; ->[Cond Units:45]Cond Unit ID:1; 2)
						
					End for 
					
				End if 
				
				RECEIVE VARIABLE:C81($NumTeam_L)
				If ($NumTeam_L>0)
					MESSAGE:C88(<>sCR+"Loading Pontis Tm..")
					For ($i; 1; $NumTeam_L)
						MESSAGE:C88(String:C10($i)+" of "+String:C10($NumTeam_L)+".. ")
						RECEIVE RECORD:C79([BMS Field Trip:56])
						[BMS Field Trip:56]Inspection ID:1:=[BMS Inspections:44]Inspection ID:1
						[BMS Field Trip:56]BMS_Field_Trip_UUIDKey_s:3:=Generate UUID:C1066
						SAVE RECORD:C53([BMS Field Trip:56])
						LogNewRecord(->[BMS Inspections:44]Inspection ID:1; ->[BMS Field Trip:56]Inspection ID:1; ->[BMS Field Trip:56]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
					End for 
				End if 
				
			End if 
			
			MESSAGE:C88(<>sCR+"Loading Combine Record..")
			RECEIVE RECORD:C79([Combined Inspections:90])
			Inc_Sequence("CombinedInspections"; ->[Combined Inspections:90]ID:6)
			[Combined Inspections:90]NBISInspID:2:=[Inspections:27]InspID:2
			[Combined Inspections:90]BMSInspID:3:=$BMSInspID_L
			[Combined Inspections:90]Combined_Inspections_UUIDKey_s:7:=Generate UUID:C1066
			[Combined Inspections:90]BIN:1:=[Bridge MHD NBIS:1]BIN:3  //make sure BIN is the current one
			SAVE RECORD:C53([Combined Inspections:90])
			LogNewRecord(->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1; "CombinedInspections")
			$vtSkipFields:=";ID;BIN;NBISInspID;BMSInspID;"
			For ($i; 1; $Num_Comb_Fields)
				$FieldName:=Field name:C257($a_Ptr_CombFields{$i})
				If (Position:C15((";"+$FieldName+";"); $vtSkipFields)=0)  //Skip BIN and INSPID
					GET FIELD PROPERTIES:C258($a_Ptr_CombFields{$i}; $viFldType; $vlFldLen)
					If ($viFldType#Is subtable:K8:11)  //AND subtables
						PushChange(1; $a_Ptr_CombFields{$i})
					End if 
				End if 
			End for 
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
			LogLink(->[Combined Inspections:90]NBISInspID:2; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
			LogLink(->[Combined Inspections:90]BMSInspID:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Combined Inspections:90]BIN:1; ->[Combined Inspections:90]ID:6; 1)
			
			C_LONGINT:C283($tunnelInspID_L)
			RECEIVE VARIABLE:C81($tunnelInspID_L)
			
			If ($tunnelInspID_L>0)
				MESSAGE:C88(<>sCR+"Loading Tunnel Inspection Record..")
				RECEIVE RECORD:C79([TunnelInspection:152])
				Inc_Sequence("TunnelInspection"; ->[TunnelInspection:152]TunnelInspID_L:15)
				[TunnelInspection:152]InspID:1:=[Inspections:27]InspID:2
				LogNewRecord(->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2; "TunnelInspection")
				$vtSkipFields:=";InspID;TunnelInspID_L;QA_QC_L;"
				For ($i; 1; $Num_Tnl_Fields)
					$FieldName:=Field name:C257($a_Ptr_TNLFields{$i})
					If (Position:C15((";"+$FieldName+";"); $vtSkipFields)=0)  //Skip BIN and INSPID
						GET FIELD PROPERTIES:C258($a_Ptr_TNLFields{$i}; $viFldType; $vlFldLen)
						If (($viFldType=Is subtable:K8:11) | (($viFldType=Is alpha field:K8:1) & ($vlFldLen=0)))  //Skip Ids //AND subtables
						Else 
							PushChange(1; $a_Ptr_TNLFields{$i})
						End if 
					End if 
				End for 
				
				FlushGrpChgs(1; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2)
				If ([TunnelInspection:152]QA_QC_L:2>0)
					LogLink(->[TunnelInspection:152]QA_QC_L:2; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2; ->[Personnel:42]Person ID:1)
				Else 
					LogChanges(->[TunnelInspection:152]QA_QC_L:2; ->[Inspections:27]InspID:2; ->[TunnelInspection:152]InspID:1; ->[TunnelInspection:152]TunnelInspID_L:15; 2)
				End if 
				SAVE RECORD:C53([TunnelInspection:152])
			End if 
			C_LONGINT:C283($ElmRtgLoads_L)
			RECEIVE VARIABLE:C81($ElmRtgLoads_L)
			
			If ($ElmRtgLoads_L>0)
				MESSAGE:C88(<>sCR+"Loading Element Rating loads..")
				
				For ($i; 1; $ElmRtgLoads_L)
					MESSAGE:C88(String:C10($i)+" of "+String:C10($ElmRtgLoads_L)+".. ")
					RECEIVE RECORD:C79([ElmtRatingLoads:158])
					C_LONGINT:C283($oldIDindx_L)
					$oldIDindx_L:=Find in array:C230($ImportElmIDs_aL; [ElmtRatingLoads:158]ElmSafetyID:2)
					If ($oldIDindx_L>0)
						[ElmtRatingLoads:158]ElmSafetyID:2:=$NewElmIDs_aL{$oldIDindx_L}  //link it to the new id
						Inc_Sequence("ElmtRatingLoads"; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1)
						[ElmtRatingLoads:158]ElmtRatingLoads_UUIDKey_s:15:=Generate UUID:C1066
						SAVE RECORD:C53([ElmtRatingLoads:158])
						LogNewRecord(->[ElementsSafety:29]ElmSafetyID:7; ->[ElmtRatingLoads:158]ElmSafetyID:2; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1; 2; "ElmtRatingLoads")
						InitChangeStack(1)
						PushAllChanges(1; ->[ElmtRatingLoads:158]; ->[ElmtRatingLoads:158]ElmSafetyID:2; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1)
						FlushGrpChgs(1; ->[ElementsSafety:29]ElmSafetyID:7; ->[ElmtRatingLoads:158]ElmSafetyID:2; ->[ElmtRatingLoads:158]ElmtRtgLoadID_L:1; 2)
					Else 
						ALERT:C41("Loads for Element Import ID "+String:C10([ElmtRatingLoads:158]ElmSafetyID:2)+" Skipped!  ID Not found in IDs loaded previously!!!!")
					End if 
				End for 
				
			End if 
			
			C_LONGINT:C283($NBEs_L)
			C_LONGINT:C283($oldIDindx_L)
			RECEIVE VARIABLE:C81($NBEs_L)
			If ($NBEs_L>0)
				MESSAGE:C88(<>sCR+"Loading NBEs..")
				ARRAY LONGINT:C221($OldNBEIDs_aL; $NBEs_L)
				ARRAY LONGINT:C221($NewNBEIDs_aL; $NBEs_L)
				For ($i; 1; $NBEs_L)
					MESSAGE:C88(String:C10($i)+" of "+String:C10($NBEs_L)+".. ")
					RECEIVE RECORD:C79([PON_ELEM_INSP:179])
					$OldNBEIDs_aL{$i}:=[PON_ELEM_INSP:179]ELEMID:22
					Inc_Sequence("PON_ELEM_INSP"; ->[PON_ELEM_INSP:179]ELEMID:22)
					$NewNBEIDs_aL{$i}:=[PON_ELEM_INSP:179]ELEMID:22
					[PON_ELEM_INSP:179]INSPID:21:=[Inspections:27]InspID:2
					[PON_ELEM_INSP:179]PON_ELEM_INSP_UUIDKey_s:30:=Generate UUID:C1066
					InitChangeStack(1)
					LogNewRecordChanges(->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; "PON_ELEM_INSP"; 1; ->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)
					
					If ([PON_ELEM_INSP:179]ELEM_PARENTID:27>0)
						$oldIDindx_L:=Find in array:C230($OldNBEIDs_aL; [PON_ELEM_INSP:179]ELEM_PARENTID:27)
						C_TEXT:C284($msg)
						
						If ($oldIDindx_L>0)
							If ($NewNBEIDs_aL{$oldIDindx_L}>0)
								[PON_ELEM_INSP:179]ELEM_PARENTID:27:=$NewNBEIDs_aL{$oldIDindx_L}
								LogLink(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179])
							Else 
								$msg:="Element Key "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+" / Env "+String:C10([PON_ELEM_INSP:179]ENVKEY:5)
								$msg:=$msg+"Found ZERO new entry for Parent ID "+String:C10([PON_ELEM_INSP:179]ELEM_PARENTID:27)+" for parent elem key "+String:C10([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)+<>sCR
								$msg:=$msg+"NEW Parent set to ZERO!"
								[PON_ELEM_INSP:179]ELEM_PARENTID:27:=0
								LogChanges(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
								ALERT:C41($msg)
								
							End if 
							
						Else 
							$msg:="Element Key "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+" / Env "+String:C10([PON_ELEM_INSP:179]ENVKEY:5)
							$msg:=$msg+"Could not find Parent ID "+String:C10([PON_ELEM_INSP:179]ELEM_PARENTID:27)+" for parent elem key "+String:C10([PON_ELEM_INSP:179]ELEM_PARENT_KEY:4)+<>sCR
							$msg:=$msg+"NEW Parent set to ZERO!"
							[PON_ELEM_INSP:179]ELEM_PARENTID:27:=0
							LogChanges(->[PON_ELEM_INSP:179]ELEM_PARENTID:27; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
							ALERT:C41($msg)
						End if 
						
					End if 
					
					If ([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28>0)
						$oldIDindx_L:=Find in array:C230($OldNBEIDs_aL; [PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)
						C_TEXT:C284($msg)
						
						If ($oldIDindx_L>0)
							If ($NewNBEIDs_aL{$oldIDindx_L}>0)
								[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=$NewNBEIDs_aL{$oldIDindx_L}
								LogLink(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2; ->[PON_ELEM_INSP:179])
							Else 
								$msg:="Element Key "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+" / Env "+String:C10([PON_ELEM_INSP:179]ENVKEY:5)+<>sCR
								$msg:=$msg+"Found ZERO new entry for Grand Parent ID "+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)+" for Grand parent elem key "+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)+<>sCR
								$msg:=$msg+"NEW Grand Parent set to ZERO!"
								[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=0
								LogChanges(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
								ALERT:C41($msg)
								
							End if 
							
						Else 
							$msg:="Element Key "+String:C10([PON_ELEM_INSP:179]ELEM_KEY:3)+" / Env "+String:C10([PON_ELEM_INSP:179]ENVKEY:5)+<>sCR
							$msg:=$msg+"Could not find Grand Parent ID "+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28)+" for Grand parent elem key "+String:C10([PON_ELEM_INSP:179]ELEM_GRANDPARENT_KEY:19)+<>sCR
							$msg:=$msg+"NEW Grand Parent set to ZERO!"
							[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28:=0
							LogChanges(->[PON_ELEM_INSP:179]ELEM_GRANDPARENTID:28; ->[Inspections:27]InspID:2; ->[PON_ELEM_INSP:179]INSPID:21; ->[PON_ELEM_INSP:179]ELEMID:22; 2)
							ALERT:C41($msg)
						End if 
						
					End if 
					SAVE RECORD:C53([PON_ELEM_INSP:179])
					
				End for 
				
			End if 
			
			RECEIVE VARIABLE:C81($NBEs_L)
			If ($NBEs_L>0)
				MESSAGE:C88(<>sCR+"Loading NTEs..")
				ARRAY LONGINT:C221($OldNBEIDs_aL; $NBEs_L)
				ARRAY LONGINT:C221($NewNBEIDs_aL; $NBEs_L)
				For ($i; 1; $NBEs_L)
					MESSAGE:C88(String:C10($i)+" of "+String:C10($NBEs_L)+".. ")
					RECEIVE RECORD:C79([NTI_ELEM_BIN_INSP:183])
					$OldNBEIDs_aL{$i}:=[NTI_ELEM_BIN_INSP:183]ELEMID:2
					Inc_Sequence("NTI_ELEM_BIN_INSP"; ->[NTI_ELEM_BIN_INSP:183]ELEMID:2)
					$NewNBEIDs_aL{$i}:=[NTI_ELEM_BIN_INSP:183]ELEMID:2
					[NTI_ELEM_BIN_INSP:183]INSPID:1:=[Inspections:27]InspID:2
					[NTI_ELEM_BIN_INSP:183]NTI_ELEM_BIN_INSP_UUIDKey_s:23:=Generate UUID:C1066
					InitChangeStack(1)
					LogNewRecordChanges(->[Inspections:27]InspID:2; ->[NTI_ELEM_BIN_INSP:183]INSPID:1; ->[NTI_ELEM_BIN_INSP:183]ELEMID:2; 2; "NTI_ELEM_BIN_INSP"; 1; ->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8)
					
					If ([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8>0)
						$oldIDindx_L:=Find in array:C230($OldNBEIDs_aL; [NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8)
						C_TEXT:C284($msg)
						
						If ($oldIDindx_L>0)
							If ($NewNBEIDs_aL{$oldIDindx_L}>0)
								[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8:=$NewNBEIDs_aL{$oldIDindx_L}
								LogLink(->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8; ->[Inspections:27]InspID:2; ->[NTI_ELEM_BIN_INSP:183]INSPID:1; ->[NTI_ELEM_BIN_INSP:183]ELEMID:2; 2; ->[NTI_ELEM_BIN_INSP:183])
							Else 
								$msg:="Element Key "+String:C10([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
								$msg:=$msg+"Found ZERO new entry for Parent ID "+String:C10([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8)+" for parent elem key "+String:C10([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7)+<>sCR
								$msg:=$msg+"NEW Parent set to ZERO!"
								[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8:=0
								LogChanges(->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8; ->[Inspections:27]InspID:2; ->[NTI_ELEM_BIN_INSP:183]INSPID:1; ->[NTI_ELEM_BIN_INSP:183]ELEMID:2; 2)
								ALERT:C41($msg)
								
							End if 
							
						Else 
							$msg:="Element Key "+String:C10([NTI_ELEM_BIN_INSP:183]ELEM_KEY:3)
							$msg:=$msg+"Could not find Parent ID "+String:C10([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8)+" for parent elem key "+String:C10([NTI_ELEM_BIN_INSP:183]ELEM_PARENT_KEY:7)+<>sCR
							$msg:=$msg+"NEW Parent set to ZERO!"
							[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8:=0
							LogChanges(->[NTI_ELEM_BIN_INSP:183]ELEM_PARENT_ID:8; ->[Inspections:27]InspID:2; ->[NTI_ELEM_BIN_INSP:183]INSPID:1; ->[NTI_ELEM_BIN_INSP:183]ELEMID:2; 2)
							ALERT:C41($msg)
						End if 
						
					End if 
					SAVE RECORD:C53([NTI_ELEM_BIN_INSP:183])
					
				End for 
				
			End if 
			
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274($TablesToUnload_aL))
				UNLOAD RECORD:C212(Table:C252($TablesToUnload_aL{$loop_L})->)
			End for 
			
			CLOSE WINDOW:C154
			C_TEXT:C284($msg_txt)
			$msg_txt:="Loaded inspection "+$InspType_txt+" for BIN "+[Bridge MHD NBIS:1]BIN:3+" dated "+String:C10($InspDate_d)+" from file <"+Document+">"
			$msg_txt:=$msg_txt+Char:C90(13)+"If the export is not from the current data file, personnel might not be identified correctly "
			$msg_txt:=$msg_txt+"and would need to be corrected before doing any data transfers!"
			ALERT:C41($msg_txt)
		Else 
			ALERT:C41("Import of Inspection BIN "+[Inspections:27]BIN:1+" aborted for Current BIN "+$CurrBIN)
		End if 
	End if 
	
	SET CHANNEL:C77(11)
End if 