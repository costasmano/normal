//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/04/07, 14:41:36
	// ----------------------------------------------------
	// Method: PRJ_LTR_SktchSubmDate
	// Description
	// Retrieve the submission date of sketch plans
	// 
	// Parameters
	// $0 : $Subdate_D
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 
C_DATE:C307($0; $Subdate_D)
$Subdate_D:=!00-00-00!
C_TEXT:C284($Submissiondate_txt)
QUERY:C277([PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]PRJ_ProjectID_l:1=[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
ORDER BY:C49([PRJ_SketchPlans:120]; [PRJ_SketchPlans:120]SKT_SubmissionNumber_l:3; <)
If ([PRJ_SketchPlans:120]SKT_Recieved_d:5=!00-00-00!)
	C_BOOLEAN:C305($Done_b)
	$Done_b:=False:C215
	$Submissiondate_txt:=""
	Repeat 
		$Submissiondate_txt:=Request:C163("Enter date Sketch plans were received"; $Submissiondate_txt)
		Case of 
			: (Date:C102($Submissiondate_txt)=!00-00-00!)
				ALERT:C41("You entered an Invalid date! <"+$Submissiondate_txt+">")
			Else 
				$Submissiondate_txt:=String:C10(Date:C102($Submissiondate_txt))  // to make sure it is formated correctly
				CONFIRM:C162("Sketch plans received on "+$Submissiondate_txt; "OK"; "Try Again")
				If (OK=1)
					$Subdate_D:=Date:C102($Submissiondate_txt)
					If (ut_LoadRecordInteractive(->[PRJ_SketchPlans:120]))
						[PRJ_SketchPlans:120]SKT_Recieved_d:5:=$Subdate_D  // to save it also
						SAVE RECORD:C53([PRJ_SketchPlans:120])
					End if 
					$Done_b:=True:C214
				End if 
		End case 
		
	Until ($Done_b)
Else 
	$Subdate_D:=[PRJ_SketchPlans:120]SKT_Recieved_d:5
End if 

$0:=$Subdate_D