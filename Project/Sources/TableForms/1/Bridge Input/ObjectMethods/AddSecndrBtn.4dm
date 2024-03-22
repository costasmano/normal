//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/21/12, 14:25:38
//----------------------------------------------------
//Object Method: [Bridge MHD NBIS].Bridge Input.bAdd 
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_02  //r001
	//Modified by: Charles Miller (2/21/12 14:25:39)
	// Modified by: Costas Manousakis-(Designer)-(5/23/14 14:38:43)
	Mods_2014_05
	//  `added sorting by Item5
End if 
FORM SET INPUT:C55([NBIS Secondary:3]; "2nd In")
ADD RECORD:C56([NBIS Secondary:3])
QUERY:C277([NBIS Secondary:3]; [NBIS Secondary:3]BIN:1=[Bridge MHD NBIS:1]BIN:3)
ORDER BY:C49([NBIS Secondary:3]; [NBIS Secondary:3]Item5:4)
//End Object Method: [Bridge MHD NBIS].2nd Records.bAdd