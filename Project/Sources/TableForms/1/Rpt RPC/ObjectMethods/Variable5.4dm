//SC vFCTrans on layout [Bridge MHD NBIS];"RPC Report".

//Functional Classification Description.

C_TEXT:C284(vFCTrans)  // Command Replaced was o_C_STRING length was 23

QUERY:C277([FunctionalClass:5]; [FunctionalClass:5]Code:1=[Bridge MHD NBIS:1]Item26:120)
Case of 
	: (Records in selection:C76([FunctionalClass:5])<=0)
		vFCTrans:=""
	: (Records in selection:C76([FunctionalClass:5])=1)
		vFCTrans:=[FunctionalClass:5]Description:2
	Else 
		vFCTrans:="Error-Not Unique"
End case 