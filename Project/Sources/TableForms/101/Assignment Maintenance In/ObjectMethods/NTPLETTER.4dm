If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(9/11/2007 12:21:11)
	Mods_2007_CM12_5301
End if 

C_BOOLEAN:C305($PrintLetter_B)
C_TEXT:C284($Msg_txt)
$PrintLetter_B:=True:C214
$Msg_txt:=""
If (Not:C34(([Contract_Assignment_Maintenance:101]ProjectType:36="@Bridge@") | ([Contract_Assignment_Maintenance:101]ProjectType:36="Weight Restr@")))
Else 
	If ([Contract_Assignment_Maintenance:101]ProjectIS:4="")
		$Msg_txt:="You must enter the correct Project Info number!"
		$PrintLetter_B:=False:C215
	End if 
	If (Records in selection:C76([Contract_Project_Maintenance:100])=0)
		If ($Msg_txt#"")
			$Msg_txt:=$Msg_txt+<>sCR
		End if 
		$Msg_txt:=$Msg_txt+"You must create the bridge project records on the second page of this form!"
		$PrintLetter_B:=False:C215
	End if 
	If ($Msg_txt#"")
		$Msg_txt:="Before you can create a Notice to Proceed you must complete the following:"+<>sCR+$Msg_txt
		ALERT:C41($Msg_txt)
	End if 
	
End if 
If ($PrintLetter_B)
	If (Records in selection:C76([Work_Estimate:103])=0)
		$Msg_txt:="There is no Fee Proposal for this Assignment!"+<>sCR
		$Msg_txt:=$Msg_txt+"Do you still wish to generate a Notice To Proceed letter?"
		CONFIRM:C162($Msg_txt; "Generate"; "Cancel")
		$PrintLetter_B:=(OK=1)
	Else 
		UNLOAD RECORD:C212([Work_Estimate:103])
		READ ONLY:C145([Work_Estimate:103])
		FIRST RECORD:C50([Work_Estimate:103])
		If ([Work_Estimate:103]WkHrEstApproved:18=BMS Approved)
			$PrintLetter_B:=True:C214
		Else 
			$Msg_txt:="There a Fee Proposal for this Assignment but it has not been Approved yet!"+<>sCR
			$Msg_txt:=$Msg_txt+"Do you still wish to generate a Notice To Proceed letter?"
			CONFIRM:C162($Msg_txt; "Generate"; "Cancel")
			$PrintLetter_B:=(OK=1)
		End if 
		READ WRITE:C146([Work_Estimate:103])
	End if 
	If ($PrintLetter_B)
		//change NTPdate_written to the day when user clicks "NTP LETTER" button
		// and Save the change
		[Contract_Assignment_Maintenance:101]NTPdate_written:17:=Current date:C33(*)
		SAVE RECORD:C53([Contract_Assignment_Maintenance:101])
		CM_Print_NTP_Letter
	End if 
End if 