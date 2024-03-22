If (False:C215)
	//Object Method: SCPOA_ApproveChkBx 
	// Modified by: costasmanousakis-(Designer)-(5/6/11 16:09:02)
	Mods_2011_05
	// Modified by: costasmanousakis-(Designer)-(6/8/11 12:07:14)
	Mods_2011_06
	//  `bug Fixes and additional input when box is checked
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
	: (Form event code:C388=On Clicked:K2:4)
		[ScourPOA:132]Approved:23:=Self:C308->
		PushChange(1; ->[ScourPOA:132]Approved:23)
		If ([ScourPOA:132]Approved:23=0)
			C_BOOLEAN:C305($ClearOthers_b)
			$ClearOthers_b:=True:C214
			If ([ScourPOA:132]ApprovedBy:10#"") | ([ScourPOA:132]DateApproved:5#!00-00-00!)
				C_TEXT:C284($msg_txt)
				$msg_txt:="Clear the Approved By ["+[ScourPOA:132]ApprovedBy:10+"] , and the Approved Date?"
				CONFIRM:C162($msg_txt)
				$ClearOthers_b:=(OK=1)
			End if 
			
			If ($ClearOthers_b)
				[ScourPOA:132]ApprovedBy:10:=""
				[ScourPOA:132]DateApproved:5:=!00-00-00!
				PushChange(1; ->[ScourPOA:132]ApprovedBy:10)
				PushChange(1; ->[ScourPOA:132]DateApproved:5)
			End if 
			
		Else 
			[ScourPOA:132]DateApproved:5:=Current date:C33(*)
			PushChange(1; ->[ScourPOA:132]DateApproved:5)
			[ScourPOA:132]ApprovedBy:10:=<>PERS_MyFullName_txt
			PushChange(1; ->[ScourPOA:132]ApprovedBy:10)
			
		End if 
		POST KEY:C465(Tab key:K12:28)
End case 