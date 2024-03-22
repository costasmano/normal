//Method: Object Method: [Inspections].CustomInput.Insp Type
//Description
//  `Added button and modified object methods to allow editing of inspection type
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/29/13, 09:52:09
	// ----------------------------------------------------
	//Created : 
	Mods_2013_07
End if 
//
Case of 
	: (Form event code:C388=On Data Change:K2:15)
		READ ONLY:C145([Inspection Type:31])
		QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=[Inspections:27]Insp Type:6)
		
		If (Records in selection:C76([Inspection Type:31])<=0)
			ALERT:C41("Entered Code "+[Inspections:27]Insp Type:6+" NOT found in table [Inspection Type]!! Try Again!!")
			[Inspections:27]Insp Type:6:=Old:C35([Inspections:27]Insp Type:6)
		Else 
			[Inspections:27]Insp Type:6:=[Inspection Type:31]Code:1
		End if 
		
End case 

//End Object Method: [Inspections].CustomInput.Insp Type