//%attributes = {"invisible":true}
//Method: NTI_InspCompleteCheck
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/25/16, 16:16:20
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	// Modified by: Costas Manousakis-(Designer)-(9/15/17 12:05:23)
	Mods_2017_09
	//  `do not clear inspcompldate when incomplete; and mark the date only first time that insp is complete
	// Modified by: Costas Manousakis-(Designer)-(3/27/18 15:32:51)
	Mods_2018_03
	//  `additions for protective systems
End if 
//
C_TEXT:C284($Message_txt)
$Message_txt:="Current Inspection status = [] "+Char:C90(Carriage return:K15:38)+"Is this Inspection ready to be reviewed?"
If ([TIN_Inspections:184]Complete:4)
	$Message_txt:=Replace string:C233($Message_txt; "[]"; "complete")
Else 
	$Message_txt:=Replace string:C233($Message_txt; "[]"; "Incomplete")
End if 
CONFIRM:C162($Message_txt; "Not Yet"; "Ready")
If (OK=1)
	If ([TIN_Inspections:184]Complete:4)
		[TIN_Inspections:184]Complete:4:=False:C215
		PushChange(1; ->[TIN_Inspections:184]Complete:4)
	End if 
Else 
	//check the inspection first!
	C_OBJECT:C1216($ErrorReport_obj)
	C_BOOLEAN:C305($ReadyOK_b)
	$ErrorReport_obj:=NTI_CheckInspComplete
	//display the various messages - do not set as ready if there are warnings or errors
	ARRAY TEXT:C222($ReportParts_atxt; 0)
	OB GET PROPERTY NAMES:C1232($ErrorReport_obj; $ReportParts_atxt)
	
	If (Size of array:C274($ReportParts_atxt)>0)
		
		$ReadyOK_b:=(Find in array:C230($ReportParts_atxt; "Error")<=0) & (Find in array:C230($ReportParts_atxt; "Warning")<=0)  //if there are no Errors or warnings
		//Now show the messages - Errors first, Warnings , and info
		C_TEXT:C284($Message_txt)
		
		If (Not:C34($ReadyOK_b))
			$Message_txt:="Report cannot be marked as Complete! There were Errors and/or Warnings found in the Report! Please see below."
		Else 
			$Message_txt:="No Problems Found! Please note the following Information messages."
		End if 
		NTI_DisplayInspChkMsgs($ErrorReport_obj; $Message_txt)
		
	Else 
		$ReadyOK_b:=True:C214
	End if 
	
	If ($ReadyOK_b)
		//Report is Ready - mark it complete if needed
		If (Not:C34([TIN_Inspections:184]Complete:4))
			[TIN_Inspections:184]Complete:4:=True:C214
			PushChange(1; ->[TIN_Inspections:184]Complete:4)
			If ([TIN_Inspections:184]InspReportComplete_d:51=!00-00-00!)
				//mark the date only the first time
				[TIN_Inspections:184]InspReportComplete_d:51:=Current date:C33(*)
				
				If (ut_LoadRecordInteractive(->[NTI_TunnelInfo:181]))
					Case of 
						: ([TIN_Inspections:184]InspType:21="ZRN")  //routine
							[NTI_TunnelInfo:181]NTI_D2_d:54:=[TIN_Inspections:184]InspDate:3
							
						: ([TIN_Inspections:184]InspType:21="ZDA")  //damage
							[NTI_TunnelInfo:181]NTI_Damage_Actual_d:83:=[TIN_Inspections:184]InspDate:3
						: ([TIN_Inspections:184]InspType:21="ZOI")
							[NTI_TunnelInfo:181]NTI_Overhead_Actual_d:76:=[TIN_Inspections:184]InspDate:3
						: ([TIN_Inspections:184]InspType:21="ZSM")
							[NTI_TunnelInfo:181]NTI_SpecMemb_Actual_d:79:=[TIN_Inspections:184]InspDate:3
							
							
						Else 
					End case 
				Else 
					$Message_txt:="Could not load [NTI_TunnelInfo] record you will have to change the "
					Case of 
						: ([TIN_Inspections:184]InspType:21="ZRN")  //routine
							$Message_txt:=$Message_txt+"[NTI_TunnelInfo]NTI_D2_d manually."
							
						: ([TIN_Inspections:184]InspType:21="ZDA")  //damage
							
							$Message_txt:=$Message_txt+"[NTI_TunnelInfo]NTI_Damage_Actual_d manually."
							
						: ([TIN_Inspections:184]InspType:21="ZOI")
							$Message_txt:=$Message_txt+"[NTI_TunnelInfo]NTI_Overhead_Actual_d manually."
							
							
						: ([TIN_Inspections:184]InspType:21="ZSM")
							
							$Message_txt:=$Message_txt+"[NTI_TunnelInfo]NTI_SpecMemb_Actual_d manually."
							
						Else 
					End case 
					ALERT:C41($Message_txt)
					
				End if 
				PushChange(1; ->[TIN_Inspections:184]InspReportComplete_d:51)
			End if 
		End if 
	Else 
		//report is not ready - mkke sure complete is unchecked
		If ([TIN_Inspections:184]Complete:4)
			[TIN_Inspections:184]Complete:4:=False:C215
			PushChange(1; ->[TIN_Inspections:184]Complete:4)
		End if 
	End if 
	
End if 
//End NTI_InspCompleteCheck