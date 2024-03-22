If (False:C215)
	Mods_2005_CM05
	// Modified by: ManousakisC (4/24/2006)
	Mods_2006_CM04
End if 

If (Form event code:C388=On Printing Detail:K2:18)
	C_TEXT:C284(sItem92A; sItem92B; sItem92C; sCritInsp; sClosedInsp; sUWSpInsp)  // Command Replaced was o_C_STRING length was 1
	sItem92A:=f_Boolean2String([Bridge MHD NBIS:1]Item92AA:163; "YN")
	sItem92B:=f_Boolean2String([Bridge MHD NBIS:1]Item92BA:165; "YN")
	sItem92C:=f_Boolean2String([Bridge MHD NBIS:1]Item92CA:167; "YN")
	sCritInsp:=f_Boolean2String([Bridge MHD NBIS:1]OtherInsp:42; "YN")
	sClosedInsp:=f_Boolean2String([Bridge MHD NBIS:1]ClosedInsp:45; "YN")
	sUWSpInsp:=f_Boolean2String([Bridge MHD NBIS:1]UWSpInsp:212; "YN")
	C_TEXT:C284(vInspProgress_s)  // Command Replaced was o_C_STRING length was 20
	
	C_LONGINT:C283(vActive; vRescinded; vCompleted; vInspReceived)  //Command Replaced was o_C_INTEGER
	vActive:=0
	vRescinded:=0
	vCompleted:=0
	vInspReceived:=0
	
	Case of 
		: ([Cons Inspection:64]AssignStatus:24="Active")
			vActive:=1
		: ([Cons Inspection:64]AssignStatus:24="Rescinded")
			vRescinded:=1
		: ([Cons Inspection:64]AssignStatus:24="Completed")
			vCompleted:=1
		: ([Cons Inspection:64]AssignStatus:24="Insp. Notification Received")
			vInspReceived:=1
		Else 
	End case 
	
	C_LONGINT:C283(vRegular; vComplex; vBRI)  //Command Replaced was o_C_INTEGER
	vRegular:=0
	vComplex:=0
	vBRI:=0
	
	Case of 
		: ([Conslt Rating:63]ContractType:48="Regular")
			vRegular:=1
		: ([Conslt Rating:63]ContractType:48="Complex")
			vComplex:=1
		: ([Conslt Rating:63]ContractType:48="BRI")
			vBRI:=1
		Else 
	End case 
	
	C_TEXT:C284(vInspMonth)  // Command Replaced was o_C_STRING length was 15
	vInspMonth:=String:C10(Month of:C24([Cons Inspection:64]InspMonth:34))+"/"+String:C10(Year of:C25([Cons Inspection:64]InspMonth:34))
	
	G_SIA_BuildTownLine
	
	C_TEXT:C284(vsDate)  // Command Replaced was o_C_STRING length was 80
	vsDate:="Report Date: "+String:C10(Current date:C33(*))
	
	//added to get the Recommended Posting values from the [RatingReports] table
	G_SIA_GetRecPostings
	
	C_TEXT:C284(vInspRecvd1)  // Command Replaced was o_C_STRING length was 50
	C_TEXT:C284(vInspRecvd2)  // Command Replaced was o_C_STRING length was 50
	vInspRecvd1:="Inspection received ()"
	vInspRecvd2:="Inspection received ()"
	C_TEXT:C284($InspRcvdString1)  // Command Replaced was o_C_STRING length was 10
	C_TEXT:C284($InspRcvdString2)  // Command Replaced was o_C_STRING length was 10
	
	C_TEXT:C284($sInspType)  // Command Replaced was o_C_STRING length was 100
	$sInspType:=[Cons Inspection:64]InspType:33
	If (Position:C15("Routine"; $sInspType)#0)
		chkRoutine:=1
		$InspRcvdString1:="R"
	End if 
	
	If (Position:C15("Special Member"; $sInspType)#0)
		chkSM:=1
		If (Length:C16($InspRcvdString1)>0)
			$InspRcvdString1:=$InspRcvdString1+", SM"
		Else 
			$InspRcvdString1:="SM"
		End if 
	End if 
	
	If (Position:C15("Fracture Critical"; $sInspType)#0)
		chkFC:=1
		If (Length:C16($InspRcvdString1)>0)
			$InspRcvdString1:=$InspRcvdString1+", FC"
		Else 
			$InspRcvdString1:="FC"
		End if 
	End if 
	
	If (Position:C15("Mechanical"; $sInspType)#0)
		chkMec:=1
		OBJECT SET ENTERABLE:C238([Cons Inspection:64]InspRecvd_ME:37; True:C214)
		If (Length:C16($InspRcvdString2)>0)
			$InspRcvdString2:=$InspRcvdString2+", M"
		Else 
			$InspRcvdString2:="M"
		End if 
	End if 
	
	If (Position:C15("Electrical"; $sInspType)#0)
		chkElec:=1
		OBJECT SET ENTERABLE:C238([Cons Inspection:64]InspRecvd_ME:37; True:C214)
		If (Length:C16($InspRcvdString2)>0)
			$InspRcvdString2:=$InspRcvdString2+", E"
		Else 
			$InspRcvdString2:="E"
		End if 
	End if 
	
	vInspRecvd1:="Inspection received ("+$InspRcvdString1+")"
	vInspRecvd2:="Inspection received ("+$InspRcvdString2+")"
	
	vInspProgress_s:=""
	
	If ((Month of:C24([Cons Inspection:64]InspMonth:34)=0) | (Year of:C25([Cons Inspection:64]InspMonth:34)=0))
		vInspMonth:=""
	Else 
		C_TEXT:C284($InspMo_S; $InspYear_S)  // Command Replaced was o_C_STRING length was 4
		$InspMo_S:=String:C10(Month of:C24([Cons Inspection:64]InspMonth:34))
		$InspYear_S:=String:C10(Year of:C25([Cons Inspection:64]InspMonth:34))
		vInspMonth:=$InspMo_S+"/"+$InspYear_S
		vInspProgress_s:=QR_ConsInspElecSubm
	End if 
	
	If (Not:C34(User in group:C338(Current user:C182; "Conslt Rating - ReadWrite")) & (Not:C34(User in group:C338(Current user:C182; "Conslt Rating - ReadOnly"))))
		OBJECT SET VISIBLE:C603(*; "costs@"; False:C215)
	End if 
	
End if 