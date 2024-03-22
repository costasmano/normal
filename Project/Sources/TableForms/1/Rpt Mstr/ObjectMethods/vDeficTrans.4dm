//SC vDeficTrans on layout [Bridge MHD NBIS];"RPC Report".

//Deficiency Description.

C_TEXT:C284(vDeficTrans)  // Command Replaced was o_C_STRING length was 5

Case of 
	: (([Bridge MHD NBIS:1]StructDef:103) & ([Bridge MHD NBIS:1]FunctObs:106))
		vDeficTrans:="SD,FO"
	: ([Bridge MHD NBIS:1]StructDef:103)
		vDeficTrans:="SD"
	: ([Bridge MHD NBIS:1]FunctObs:106)
		vDeficTrans:="FO"
	Else 
		//    vDeficTrans:="X"
		vDeficTrans:=""
End case 