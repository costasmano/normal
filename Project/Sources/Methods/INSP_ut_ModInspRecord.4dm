//%attributes = {"invisible":true}
//Method: INSP_ut_ModInspRecord
//Description
//  ` Modify key fields in an Inspection record. Designed to run only from the Adminsitrative
//  `item under the Special menu.  Should only be run on the Central Boston server from a client

// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/10/13, 17:27:07
	// ----------------------------------------------------
	//Created : 
	Mods_2013_06
End if 
//
C_BOOLEAN:C305($DoRun_b)
$DoRun_b:=False:C215
If (Application type:C494=4D Remote mode:K5:5)
	
	If (Structure file:C489="MHD BMS.4DC")
		$DoRun_b:=True:C214
	End if 
End if 

If (Not:C34($DoRun_b))
	ALERT:C41("This utility should only be run connected with client app to the main Boston Server db!  That ensures that the changes will be transfered correctly to the other databases!")
	If (User in group:C338(Current user:C182; "Design Access Group"))
		CONFIRM:C162("Do you still want to execute this method :"+Current method name:C684+" ?"; "Execute")
		$DoRun_b:=(OK=1)
	End if 
End if 

If ($DoRun_b)
	C_LONGINT:C283($winref_L)
	$winref_L:=Open form window:C675([Inspections:27]; "CustomInput")
	READ ONLY:C145([Bridge MHD NBIS:1])
	READ WRITE:C146([Inspections:27])
	ALL RECORDS:C47([Inspections:27])
	FORM SET INPUT:C55([Inspections:27]; "CustomInput")
	MODIFY RECORD:C57([Inspections:27])  //the record gets unloaded in the form.
	CLOSE WINDOW:C154
End if 

//End INSP_ut_ModInspRecord