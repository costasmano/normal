//%attributes = {"invisible":true}
If (False:C215)
	//GP: Initialize the Town field for all records
	
	// Modified by: costasmanousakis-(Designer)-(1/30/2006 16:24:47)
	Mods_2006_CM03
	
	ALL RECORDS:C47([Bridge MHD NBIS:1])
	APPLY TO SELECTION:C70([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Town Name:175:=Get_Town_Name([Bridge MHD NBIS:1]BDEPT:1))
	APPLY TO SELECTION:C70([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]RPC_Codes:183:=Get_RPCCode([Bridge MHD NBIS:1]BDEPT:1))
	
End if 
