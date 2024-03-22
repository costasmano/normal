//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:56:04
	// ----------------------------------------------------
	// Method: SC_CalcScourCategories
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(06/10/08, 10:32:30)
	Mods_2008_CM_5403("SCOUR")
	//  `Modify some of the prompts, use progress bar for reporting the status
	// Modified by: costasmanousakis-(Designer)-(3/7/11 09:00:31)
	Mods_2011_03
	//  `Use  ut_OpenDocument instead of AP ShellExecute
	// Modified by: costasmanousakis-(Designer)-(5/31/11 08:26:25)
	Mods_2011_05
	//  `Just open the export file. Full path is defined in SC_StartExpHdr method
	Mods_2013_01  //r004 ` Make changes to make use of new [BridgeInfoLink] table as well as sending data using [Activity Log]
	//Modified by: Charles Miller (1/17/13 14:43:16)
	Mods_2013_01  //r001 ` Make sure [BridgeInfoLink] table is loaded and record changes are saved
	//Modified by: Charles Miller (2/12/13 15:16:29)
	Mods_2013_02  //r001 ` Remove [BridgeInfoLink] updates as we are going to update data on add only
	//Modified by: Charles Miller (2/26/13 16:27:38)
End if 

SC_LoadParameters

C_LONGINT:C283($i; $NumBINs)
C_LONGINT:C283(SC_P_LifeRemain)
C_REAL:C285(SC_P_AnnualFailProb_r; SC_P_LifeTimeProbFail_r; SC_P_AdjustedFailProb_r; SC_P_TotalFailCost_r; SC_P_LifeTimeRisk_r; SC_P_ContinuityF)
C_TEXT:C284(SC_P_Category_S)  // Command Replaced was o_C_STRING length was 1
READ ONLY:C145([Bridge MHD NBIS:1])
COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "SCBRIDGELISTORIG")
C_LONGINT:C283($UserChoise_i)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($DoCalcs_b)
C_TEXT:C284($ExportFile; $mypath)
$ExportFile:=""
$DoCalcs_b:=True:C214
$NumBINs:=Records in selection:C76([Bridge MHD NBIS:1])
$UserChoise_i:=ut_3Option_Confirm("Run report on current bridge list ("+String:C10($NumBINs)+"), Do a custom search, or cancel?"; "CurrentList"; "CustomSearch"; "Cancel")
Case of 
	: ($UserChoise_i=1)
	: ($UserChoise_i=2)
		QUERY:C277([Bridge MHD NBIS:1])
		If (OK=0)
			$DoCalcs_b:=False:C215
		End if 
		
	: ($UserChoise_i=3)
		$DoCalcs_b:=False:C215
End case 
$NumBINs:=Records in selection:C76([Bridge MHD NBIS:1])
Case of 
	: ($DoCalcs_b & ($NumBINs=0))
		ALERT:C41("No Bridge records have been selected!")
	: ($DoCalcs_b)
		C_BOOLEAN:C305($SaveResults_b)
		CONFIRM:C162("Store Results in the database or just create a report?"; "Store"; "Report only")
		$SaveResults_b:=(OK=1)
		SC_ITEM113Filter_txt:=Request:C163("Specify filter for I_113 (Enclose values in ,)"; SC_ITEM113Filter_txt)
		If (SC_ITEM113Filter_txt#"")
			
			//SHORT_MESSAGE ("Scour Categories for "+String($NumBINs)+" BINs")
			ARRAY LONGINT:C221($MHDBINRecNums; 0)
			LONGINT ARRAY FROM SELECTION:C647([Bridge MHD NBIS:1]; $MHDBINRecNums)
			C_LONGINT:C283(SC_SAVEASHTML_i)  //Command Replaced was o_C_INTEGER
			If ($SaveResults_b)
				SC_SAVEASHTML_i:=ut_3Option_Confirm("Export HTML or XML format?"; "HTML"; "XML"; "No Output")
			Else 
				SC_SAVEASHTML_i:=ut_3Option_Confirm("Export HTML or XML format?"; "HTML"; "XML"; "")
			End if 
			<>ProgressPID:=StartProgress("ScourCat"; "Button"; "Scour Categories")
			UpdateProgress(0; $NumBINs)  //start it
			C_BOOLEAN:C305($SaveRecord_b)
			
			$ExportFile:=SC_StartExpHdr
			For ($i; 1; $NumBINs)
				ARRAY POINTER:C280(ptr_Changes; 0; 0)
				InitChangeStack(1)
				GOTO RECORD:C242([Bridge MHD NBIS:1]; $MHDBINRecNums{$i})
				If (Position:C15(","+[Bridge MHD NBIS:1]Item113:151+","; SC_ITEM113Filter_txt)>0)
					
					SC_WriteScourStartInfo
					//do calcs
					SC_CalcSingleBridgeData
					
					If ($SaveResults_b)
						
						$SaveRecord_b:=False:C215
						
						QUERY:C277([ScourPriorityRank:108]; [ScourPriorityRank:108]BIN:1=[Bridge MHD NBIS:1]BIN:3)
						If (Records in selection:C76([ScourPriorityRank:108])=1)
							LOAD RECORD:C52([ScourPriorityRank:108])
						Else 
							CREATE RECORD:C68([ScourPriorityRank:108])
							$SaveRecord_b:=True:C214
							LogNewRecord(->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; 0; "")
							[ScourPriorityRank:108]BIN:1:=[Bridge MHD NBIS:1]BIN:3
						End if 
						If ([ScourPriorityRank:108]Category:5#SC_P_Category_S)
							[ScourPriorityRank:108]Category:5:=SC_P_Category_S
							PushChange(1; ->[ScourPriorityRank:108]Category:5)
							$SaveRecord_b:=True:C214
						End if 
						If ([ScourPriorityRank:108]FailureCost:3#SC_P_TotalFailCost_r)
							[ScourPriorityRank:108]FailureCost:3:=SC_P_TotalFailCost_r
							PushChange(1; ->[ScourPriorityRank:108]FailureCost:3)
							$SaveRecord_b:=True:C214
						End if 
						If ([ScourPriorityRank:108]FailureProb:2#SC_P_AdjustedFailProb_r)
							[ScourPriorityRank:108]FailureProb:2:=SC_P_AdjustedFailProb_r
							PushChange(1; ->[ScourPriorityRank:108]FailureProb:2)
							$SaveRecord_b:=True:C214
						End if 
						If ([ScourPriorityRank:108]LifeTimeRisk:4#SC_P_LifeTimeRisk_r)
							[ScourPriorityRank:108]LifeTimeRisk:4:=SC_P_LifeTimeRisk_r
							PushChange(1; ->[ScourPriorityRank:108]LifeTimeRisk:4)
							$SaveRecord_b:=True:C214
						End if 
						If ($SaveRecord_b)
							SAVE RECORD:C53([ScourPriorityRank:108])
							FlushGrpChgs(1; ->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; 0)
						End if 
					End if 
					
				Else 
					If ($SaveResults_b)
						//Clear from Scour Table
						QUERY:C277([ScourPriorityRank:108]; [ScourPriorityRank:108]BIN:1=[Bridge MHD NBIS:1]BIN:3)
						If (Records in selection:C76([ScourPriorityRank:108])=1)
							LOAD RECORD:C52([ScourPriorityRank:108])
							[ScourPriorityRank:108]BIN:1:=""
							
							LogDeletion(->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; ->[ScourPriorityRank:108]BIN:1; 0)
							DELETE RECORD:C58([ScourPriorityRank:108])
						End if 
						
					End if 
					
				End if 
				If (($i%50)=0)
					UpdateProgress($i; $NumBINs)
					//FLUSH CACHE
				End if 
				If (<>Abort)
					$i:=$NumBINs+1
				End if 
				
			End for 
			SC_EndExpFile
			If ($SaveResults_b)
				MESSAGE:C88(<>sCR+"Adjusting Rank ..")
				SC_SetRanking
			End if 
			CLOSE DOCUMENT:C267(vScourCalcDocRef)
			//CLOSE WINDOW
			POST OUTSIDE CALL:C329(<>ProgressPID)
			
			If ($ExportFile#"")
				C_LONGINT:C283($shellexecRes)
				ut_OpenDocument($ExportFile)
			End if 
			
		Else 
			ALERT:C41("You must specify a Filter for Item 113! Only bridges matching the filter will be "+"processed!")
		End if 
End case 

READ WRITE:C146([Bridge MHD NBIS:1])
USE NAMED SELECTION:C332("SCBRIDGELISTORIG")
CLEAR NAMED SELECTION:C333("SCBRIDGELISTORIG")