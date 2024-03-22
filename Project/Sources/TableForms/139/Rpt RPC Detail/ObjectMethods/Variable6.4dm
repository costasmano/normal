//SC vDeficTrans on layout [Bridge MHD NBIS];"RPC Report".

//Deficiency Description.

C_TEXT:C284(vDeficTrans)  // Command Replaced was o_C_STRING length was 5

Case of 
	: (([BridgeMHDNBISArchive:139]StructDef:102) & ([BridgeMHDNBISArchive:139]FunctObs:105))
		vDeficTrans:="SD,FO"
	: ([BridgeMHDNBISArchive:139]StructDef:102)
		vDeficTrans:="SD"
	: ([BridgeMHDNBISArchive:139]FunctObs:105)
		vDeficTrans:="FO"
	Else 
		vDeficTrans:=""
End case 