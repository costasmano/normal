//SC vOwnerTrans on layout [Bridge MHD NBIS];"RPC Report".

C_TEXT:C284(vOwnerTrans)  // Command Replaced was o_C_STRING length was 27

QUERY:C277([MaintOwnerCode:4]; [MaintOwnerCode:4]Code:1=[BridgeMHDNBISArchive:139]Item22:127)
Case of 
	: (Records in selection:C76([MaintOwnerCode:4])<=0)
		vOwnerTrans:=""
	: (Records in selection:C76([MaintOwnerCode:4])=1)
		vOwnerTrans:=[MaintOwnerCode:4]Description:2
	Else 
		vOwnerTrans:="Error-Not Unique"
End case 