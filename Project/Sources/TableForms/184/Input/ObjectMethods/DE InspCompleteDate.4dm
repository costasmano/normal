//Method: [TIN_Inspections];"Input".DE InspCompleteDate
//Description
// object method for the [Inspections]InspFldWorkComplDate field for CallReference #663
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 10/09/19, 17:13:33
	// ----------------------------------------------------
	//Created : 
	Mods_2019_10_bug
End if 
//

Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Data Change:K2:15)
		
		Case of 
			: ([TIN_Inspections:184]InspCompleteDate:15=!00-00-00!)
				//no warnings here
				
			: ([TIN_Inspections:184]InspCompleteDate:15<[TIN_Inspections:184]InspDate:3)
				//cannot be before the inspection date
				[TIN_Inspections:184]InspCompleteDate:15:=!00-00-00!
				ALERT:C41("Inspection Complete Date cannot be before the Inspection Date! Please re-Enter!")
				
			: ([TIN_Inspections:184]InspCompleteDate:15>Current date:C33(*))
				//cannot be in the future
				[TIN_Inspections:184]InspCompleteDate:15:=!00-00-00!
				ALERT:C41("Inspection Complete Date cannot be in the future! Please re-Enter!")
				
		End case 
		
	: (Form event code:C388=On Clicked:K2:4)
		
End case 

//End [TIN_Inspections].Input.DE InspDate1