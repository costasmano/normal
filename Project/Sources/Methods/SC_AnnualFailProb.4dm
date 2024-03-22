//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 03/10/06, 15:55:38
	// ----------------------------------------------------
	// Method: SC_AnnualFailProb
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(5/20/08 15:45:10)
	Mods_2008_CM_5403  //include 113=6,D with 113=3
	// Modified by: costasmanousakis-(Designer)-(6/10/08 10:29:45)
	Mods_2008_CM_5403("SCOUR")  //Use new method SC_FailProb_6061_7126 for 113 # 0,1,2,3
End if 
C_REAL:C285($0; $FailProb)
$FailProb:=0
Case of 
	: ([Bridge MHD NBIS:1]Item113:151="0")
		$FailProb:=1
	: (([Bridge MHD NBIS:1]Item113:151="1") | ([Bridge MHD NBIS:1]Item113:151="2"))
		Case of 
			: (Not:C34(bIsNumeric([Bridge MHD NBIS:1]Item71:145)))
				$FailProb:=0
			: (Num:C11([Bridge MHD NBIS:1]Item71:145)>=8)
				$FailProb:=0.2
			Else 
				$FailProb:=0.5
		End case 
		
	: ([Bridge MHD NBIS:1]Item113:151="3")
		Case of 
			: (Not:C34(bIsNumeric([Bridge MHD NBIS:1]Item71:145)))
				$FailProb:=0
			: (Num:C11([Bridge MHD NBIS:1]Item71:145)>=8)
				$FailProb:=0.04
			Else 
				$FailProb:=0.1
		End case 
	Else 
		$FailProb:=SC_FailProb_6061_7126
End case 
$0:=$FailProb