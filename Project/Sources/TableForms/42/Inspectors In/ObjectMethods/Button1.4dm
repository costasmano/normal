If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/12/06, 09:55:03
	// ----------------------------------------------------
	// Method: Object Method: Button1
	// Description
	// Set the Email address to the MHD std (Fnam.LastNam@MHD.state.ma.us)
	// 
	// Parameters
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(5/25/11 14:15:02)
	Mods_2011_05
	//Changed to DOT address
End if 
[Personnel:42]EmailAddress_s:14:=[Personnel:42]First Name:3+"."+[Personnel:42]Last Name:5+"@dot.state.ma.us"
PushChange(1; ->[Personnel:42]EmailAddress_s:14)