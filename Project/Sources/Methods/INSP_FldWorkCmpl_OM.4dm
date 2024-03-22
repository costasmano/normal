//%attributes = {"invisible":true}
//Method: INSP_FldWorkCmpl_OM
//Description
// object method for the [Inspections]InspFldWorkComplDate field for CallReference #663
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/09/19, 14:19:54
	// ----------------------------------------------------
	//Created : 
	Mods_2019_10_bug
End if 
//
If (Form event code:C388=On Data Change:K2:15)
	
	Case of 
		: ([Inspections:27]InspFldWorkComplDate:224=!00-00-00!)
			//no warnings here
		: ([Inspections:27]InspFldWorkComplDate:224<[Inspections:27]Insp Date:78)
			//cannot be before the inspection date - clear it
			[Inspections:27]InspFldWorkComplDate:224:=!00-00-00!
			ALERT:C41("Entered Field Work Complete Date is before the Inspection Date! Please re-enter!")
			GOTO OBJECT:C206([Inspections:27]InspFldWorkComplDate:224)
		: ([Inspections:27]InspFldWorkComplDate:224>Current date:C33(*))
			//cannot be in the future - clear it
			[Inspections:27]InspFldWorkComplDate:224:=!00-00-00!
			ALERT:C41("Entered Field Work Complete Date is in the future! Please re-enter!")
			GOTO OBJECT:C206([Inspections:27]InspFldWorkComplDate:224)
		Else 
			ALERT:C41("Please make sure the Field work Complete date is correct! Once you exit and save this report, you will not be able to modify this date again!")
	End case 
	
	PushChange(1; Self:C308)
End if 
//End INSP_FldWorkCmpl_OM