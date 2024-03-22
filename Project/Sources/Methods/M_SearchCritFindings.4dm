//%attributes = {"invisible":true}
//Method: M_SearchCritFindings
//Description
// Search for critical findings (FHWA) over a given time period for the current list of bridges
// reduce the list of bridges to the ones with critical Findings.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Created : 
	//Date and time: Feb 27, 2023, 17:56:07
	Mods_2023_02
	// ----------------------------------------------------
	
	// Modified by: Costas Manousakis-(Designer)-(2023-05-02 18:42:44)
	Mods_2023_05
	//  `modified to use a dialog to ask for search parameters
End if 

RELATE MANY SELECTION:C340([Inspections:27]BIN:1)
C_OBJECT:C1216($datafromdlg_o)
$datafromdlg_o:=New object:C1471
C_LONGINT:C283($dlg_L)
$dlg_L:=Open form window:C675("BridgeCriticalFindSearch"; Plain form window:K39:10)
DIALOG:C40("BridgeCriticalFindSearch"; New object:C1471("returnobject"; $datafromdlg_o))
CLOSE WINDOW:C154($dlg_L)

If (OK=1)
	
	C_DATE:C307($start_d; $end_d)
	$start_d:=Date:C102($datafromdlg_o.startDate)
	$end_d:=Date:C102($datafromdlg_o.endDate)
	
	C_TEXT:C284($Deficiency_txt; $priority_txt)
	$Deficiency_txt:=$datafromdlg_o.deficiency
	$priority_txt:=$datafromdlg_o.priority
	
	//start the bar
	C_OBJECT:C1216($progress_o)
	$progress_o:=ProgressNew("Searching for Critical Findings"; 1; False:C215; ""; 0)
	
	Progress SET PROGRESS($progress_o.progress; -1)
	Progress SET MESSAGE($progress_o.progress; "Searching for related Inspections...")
	
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6#"FRZ"; *)  //no feeeze thaw
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Type:6#"FCR"; *)  //no fract critical - should be same as the routine
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Date:78>=$start_d; *)
	QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]Insp Date:78<=$end_d)
	If (Records in selection:C76([Inspections:27])=0)
		ALERT:C41("No inspections were found between "+\
			String:C10($start_d)+"-"+String:C10($end_d)+"!")
		//quit progress
		Progress QUIT($progress_o.progress)
	Else 
		Progress SET MESSAGE($progress_o.progress; "Searching for Critical findings in inspections...")
		
		RELATE MANY SELECTION:C340([ElementsSafety:29]InspID:4)
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3=$Deficiency_txt; *)
		QUERY SELECTION:C341([ElementsSafety:29];  & ; [ElementsSafety:29]Priority:20=$priority_txt)
		
		ORDER BY:C49([ElementsSafety:29]; [Bridge MHD NBIS:1]BDEPT:1; >; [ElementsSafety:29]ElementNo:1; >; [Inspections:27]Insp Date:78; >)
		
		Progress QUIT($progress_o.progress)
		
		If (Records in selection:C76([ElementsSafety:29])=0)
			ALERT:C41("No Inspection elements were found with Deficiency-Priority = "\
				+$Deficiency_txt+"-"+$priority_txt+" between "+\
				String:C10($start_d)+"-"+String:C10($end_d)+"!")
		Else 
			
			RELATE ONE SELECTION:C349([ElementsSafety:29]; [Bridge MHD NBIS:1])
			RegionTitle
			
			C_TEXT:C284($NamedSelectionName_txt; $ProcessName_txt; $Seq_txt; $WinTitle_txt; $QueryName_txt)
			$ProcessName_txt:="Elements LB"
			$NamedSelectionName_txt:="◊ElementsSelect"
			$WinTitle_txt:="ELEMENTS"
			$QueryName_txt:="ELEMSafetyQuery2"
			C_POINTER:C301($Tbl_ptr)
			$Tbl_ptr:=->[ElementsSafety:29]
			
			C_LONGINT:C283($pid)
			$Seq_txt:=String:C10(LNextView($ProcessName_txt)+1)
			$ProcessName_txt:=$ProcessName_txt+" "+$Seq_txt
			$NamedSelectionName_txt:=$NamedSelectionName_txt+"_"+$Seq_txt
			$WinTitle_txt:=$WinTitle_txt+" ["+$Seq_txt+"]"
			COPY NAMED SELECTION:C331($Tbl_ptr->; $NamedSelectionName_txt)
			
			ALERT:C41("Opening window with found elements!")
			
			$pid:=New process:C317("LB_ControlListBoxDisplay"; 0; $ProcessName_txt; $QueryName_txt; Table:C252($Tbl_ptr); $WinTitle_txt; $NamedSelectionName_txt)
			
		End if 
		
	End if 
	
End if 


//
//End M_SearchCritFindings   