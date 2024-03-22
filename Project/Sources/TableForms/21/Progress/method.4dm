If (False:C215)
	// Layout procedure : [Dialogs];"Progress"
	// Modified by: Costas Manousakis-(Designer)-(3/14/16 15:05:07)
	Mods_2016_03_bug
	//  `fixed format of ◊Remaining  variable
	// Modified by: Costas Manousakis-(Designer)-(3/16/16 17:10:33)
	Mods_2016_03_bug
	//  `moved the setting of ◊Ready  from ShowProgress to the end of the onload event here
End if 
Case of 
		//: (Before)
	: (Form event code:C388=On Load:K2:1)
		FORM GOTO PAGE:C247(<>Page)
		If (<>Page=3)
			ON EVENT CALL:C190("ProgressEvents")
		End if 
		If (<>Page=4)
			// even there is no message - trap events here too..      
			ON EVENT CALL:C190("ProgressEvents")
		End if 
		<>TimeRemaining:=""
		<>Ready:=True:C214  //tell StartProgress we are ready
		
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
End case 