If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(2/29/12 12:52:10)
	Mods_2012_02
	//  ` Added code to load the bridge record
End if 


READ ONLY:C145([Bridge MHD NBIS:1])
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[ScourPOA:132]BIN:2)
LOAD RECORD:C52([Bridge MHD NBIS:1])
ut_GoogleBIN
UNLOAD RECORD:C212([Bridge MHD NBIS:1])