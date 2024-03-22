//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/28/08, 10:45:02
	// ----------------------------------------------------
	// Method: INSP_KiloPtValues
	// Description
	// Change text and format of Kilopoint vars on inspection forms for MTA bridges.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	Mods_2012_11  //r002 ` Make changes for Pedestrian bridge input
	//Modified by: Charles Miller (11/29/12 13:07:10)
	Mods_2012_12  //r001 ` Add code for new inspection types
	//Modified by: Charles Miller (12/13/12 14:05:01)
	
	Mods_2013_01  //r001 ` Add Railroad bridges
	//Modified by: Charles Miller (2/12/13 17:21:41)
End if 
C_TEXT:C284(INSP_KiloPtLblPrt_txt)
C_TEXT:C284(INSP_KiloPtLblInp_txt)
C_REAL:C285(INSP_KiloPtVal_r)

Case of 
	: ([Inspection Type:31]Code:1="RRC") | ([Inspection Type:31]Code:1="RRR") | ([Inspection Type:31]Code:1="RRA") | ([Inspections:27]Insp Type:6="RRF") | ([Inspections:27]Insp Type:6="RRS") | ([Inspections:27]Insp Type:6="RRO") | ([Inspections:27]Insp Type:6="RRD")
		INSP_KiloPtLblPrt_txt:="MILEPOST/T ID #"
		INSP_KiloPtLblInp_txt:="MILEPOST/T ID NO"
		INSP_KiloPtVal_r:=Round:C94([Bridge MHD NBIS:1]Item11:67*0.621371; 2)  //Is this correct?
	: ([Inspection Type:31]Code:1="PED")
		INSP_KiloPtLblPrt_txt:="11-MILE POINT"
		INSP_KiloPtLblInp_txt:="11-MILE POINT"
		INSP_KiloPtVal_r:=Round:C94([Bridge MHD NBIS:1]Item11:67*0.621371; 2)  //Is this correct?
		OBJECT SET FORMAT:C236(INSP_KiloPtVal_r; "#,##0.00")
	: (([Bridge MHD NBIS:1]InspResp:173="MTA") & Not:C34(([Inspections:27]Insp Type:6="DV@") & ([Inspections:27]Agency:156="MHD Underwater@")))
		INSP_KiloPtLblPrt_txt:="MILE MARKER"
		INSP_KiloPtLblInp_txt:="MILE MARKER"
		INSP_KiloPtVal_r:=Round:C94([Bridge MHD NBIS:1]Item11:67*0.621371; 2)
		OBJECT SET FORMAT:C236(INSP_KiloPtVal_r; "#,##0.00")
	Else 
		INSP_KiloPtLblPrt_txt:="11-Kilo. POINT"
		INSP_KiloPtLblInp_txt:="11-KILO POINT"
		INSP_KiloPtVal_r:=[Bridge MHD NBIS:1]Item11:67
		OBJECT SET FORMAT:C236(INSP_KiloPtVal_r; "#,000.000")
End case 