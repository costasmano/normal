//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/30/06, 09:25:24
	// ----------------------------------------------------
	// Method: Method: ut_GetPontisCUs_MDC
	// Description
	// get the CUs for MDC NBI inspections
	// 
	// Parameters
	// ----------------------------------------------------
	
End if 
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173="MDC"; *)
QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]FHWARecord:174=True:C214)
RELATE MANY SELECTION:C340([BMS Inspections:44]BIN:2)
QUERY SELECTION:C341([BMS Inspections:44]; [BMS Inspections:44]Insp Date:4>!1998-12-31!)
RELATE MANY SELECTION:C340([Cond Units:45]Inspection ID:2)
CREATE SET:C116([Cond Units:45]; "MDC_CUS")
UNION:C120("MDC_CUS"; "CondUnits"; "CondUnits")
CLEAR SET:C117("MDC_CUS")