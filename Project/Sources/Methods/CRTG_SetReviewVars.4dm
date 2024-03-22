//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/23/10, 16:02:40
	// ----------------------------------------------------
	// Method: Method: CRTG_SetReviewVars
	// Description
	//  ` Set process variables used in cons ratings
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_09
End if 
C_TEXT:C284(CRTG_Here_s; CRTG_BridgeNoBIN_s; CRTG_Color_1_S; CRTG_Consult_s; CRTG_BridgeType_s)
C_LONGINT:C283(CRTG_Here_L)
C_DATE:C307(CRTG_MostRecent_d; CRTG_Recv1_d; CRTG_Ret1_d; CRTG_Recv2_d; CRTG_Ret2_d; CRTG_Recv3_d; CRTG_Ret3_d; CRTG_Recv4_d; CRTG_Ret4_d)
C_DATE:C307(CRTG_Processed_d; CRTG_ReportDate_d)
C_TEXT:C284(CRTG_MostRecent_s; CRTG_Recv1_s; CRTG_Ret1_s; CRTG_Recv2_s; CRTG_Ret2_s; CRTG_Recv3_s; CRTG_Ret3_s; CRTG_Recv4_s; CRTG_Ret4_s)
C_TEXT:C284(CRTG_Processed_s; CRTG_ReportDate_s)
CRTG_Consult_s:=[Conslt Rating:63]AssignRatCons:5
CRTG_BridgeType_s:=[Conslt Rating:63]BridgeType:63
CRTG_Recv1_d:=[Conslt Rating:63]SentInHouseRev1:36
CRTG_Ret1_d:=[Conslt Rating:63]SentBackToConslt1:33
CRTG_Recv2_d:=[Conslt Rating:63]SentInHouseRev2:37
CRTG_Ret2_d:=[Conslt Rating:63]SentBackToConslt2:34
CRTG_Recv3_d:=[Conslt Rating:63]SentInHouseRev3:38
CRTG_Ret3_d:=[Conslt Rating:63]SentBackToConslt3:35
CRTG_Recv4_d:=[Conslt Rating:63]SentInHouseRev4:53
CRTG_Ret4_d:=[Conslt Rating:63]SentBackToConslt4:62
CRTG_Processed_d:=[Conslt Rating:63]NBISLetter:26
CRTG_ReportDate_d:=[Conslt Rating:63]ReportDate:64
CRTG_Color_1_S:=Substring:C12([Conslt Rating:63]CRtgColor:46; 1; 1)
CRTG_BridgeNoBIN_s:=[Bridge MHD NBIS:1]BDEPT:1+[Bridge MHD NBIS:1]BIN:3
CRTG_MostRecent_d:=!00-00-00!
CRTG_Here_s:="???"
Case of 
	: ([Conslt Rating:63]NBISLetter:26>!00-00-00!)
		CRTG_MostRecent_d:=[Conslt Rating:63]NBISLetter:26
		CRTG_Here_s:="A"
	: ([Conslt Rating:63]SentBackToConslt4:62>!00-00-00!)
		CRTG_MostRecent_d:=[Conslt Rating:63]SentBackToConslt4:62
		CRTG_Here_s:="N"
	: ([Conslt Rating:63]SentInHouseRev4:53>!00-00-00!)
		CRTG_MostRecent_d:=[Conslt Rating:63]SentInHouseRev4:53
		CRTG_Here_s:="Y"
	: ([Conslt Rating:63]SentBackToConslt3:35>!00-00-00!)
		CRTG_MostRecent_d:=[Conslt Rating:63]SentBackToConslt3:35
		CRTG_Here_s:="N"
	: ([Conslt Rating:63]SentInHouseRev3:38>!00-00-00!)
		CRTG_MostRecent_d:=[Conslt Rating:63]SentInHouseRev3:38
		CRTG_Here_s:="Y"
	: ([Conslt Rating:63]SentBackToConslt2:34>!00-00-00!)
		CRTG_MostRecent_d:=[Conslt Rating:63]SentBackToConslt2:34
		CRTG_Here_s:="N"
	: ([Conslt Rating:63]SentInHouseRev2:37>!00-00-00!)
		CRTG_MostRecent_d:=[Conslt Rating:63]SentInHouseRev2:37
		CRTG_Here_s:="Y"
	: ([Conslt Rating:63]SentBackToConslt1:33>!00-00-00!)
		CRTG_MostRecent_d:=[Conslt Rating:63]SentBackToConslt1:33
		CRTG_Here_s:="N"
	: ([Conslt Rating:63]SentInHouseRev1:36>!00-00-00!)
		CRTG_MostRecent_d:=[Conslt Rating:63]SentInHouseRev1:36
		CRTG_Here_s:="Y"
		
End case 

CRTG_MostRecent_s:=f_Date2String(CRTG_MostRecent_d; Internal date short:K1:7; "")
CRTG_Recv1_s:=f_Date2String(CRTG_Recv1_d; Internal date short:K1:7; "")
CRTG_Ret1_s:=f_Date2String(CRTG_Ret1_d; Internal date short:K1:7; "")
CRTG_Recv2_s:=f_Date2String(CRTG_Recv2_d; Internal date short:K1:7; "")
CRTG_Ret2_s:=f_Date2String(CRTG_Ret2_d; Internal date short:K1:7; "")
CRTG_Recv3_s:=f_Date2String(CRTG_Recv3_d; Internal date short:K1:7; "")
CRTG_Ret3_s:=f_Date2String(CRTG_Ret3_d; Internal date short:K1:7; "")
CRTG_Recv4_s:=f_Date2String(CRTG_Recv4_d; Internal date short:K1:7; "")
CRTG_Ret4_s:=f_Date2String(CRTG_Ret4_d; Internal date short:K1:7; "")
CRTG_Processed_s:=f_Date2String(CRTG_Processed_d; Internal date short:K1:7; "")
CRTG_ReportDate_s:=f_Date2String(CRTG_ReportDate_d; Internal date short:K1:7; "")