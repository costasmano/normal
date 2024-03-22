//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/15/10, 10:32:19
	// ----------------------------------------------------
	// Method: Method: CRTG_PrintForm_FM
	// Description
	//  ` Method for the Print Forms used in Consultant Ratings
	// 
	// Parameters
	// $1 : $FormEvent_L
	// ----------------------------------------------------
	
	Mods_2010_10
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

Case of 
	: ($FormEvent_L=On Printing Detail:K2:18)
		
		C_LONGINT:C283(vActive; vRescinded; vCompleted; vRejectWP; vRejectWOP; vContrLaps)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283(vInHouse; vDesignCon; vRatingCon; vROUnit)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283(vRegular; vComplex; vBRI)  //Command Replaced was o_C_INTEGER
		
		vActive:=0
		vRescinded:=0
		vCompleted:=0
		vRejectWP:=0
		vRejectWOP:=0
		vContrLaps:=0
		vInHouse:=0
		vDesignCon:=0
		vRatingCon:=0
		vROUnit:=0
		vRegular:=0
		vComplex:=0
		vBRI:=0
		
		Case of 
			: ([Conslt Rating:63]AssignStatus:43="Active")
				vActive:=1
			: ([Conslt Rating:63]AssignStatus:43="Rescinded")
				vRescinded:=1
			: ([Conslt Rating:63]AssignStatus:43="Completed")
				vCompleted:=1
			: ([Conslt Rating:63]AssignStatus:43="Rejected with Penalty")
				vRejectWP:=1
			: ([Conslt Rating:63]AssignStatus:43="Rejected W/O Penalty")
				vRejectWOP:=1
			: ([Conslt Rating:63]AssignStatus:43="Contract Lapsed")
				vContrLaps:=1
			Else 
		End case 
		
		Case of 
			: ([Conslt Rating:63]CRtgSource:47="In-House Design")
				vInHouse:=1
			: ([Conslt Rating:63]CRtgSource:47="Design Consultant")
				vDesignCon:=1
			: ([Conslt Rating:63]CRtgSource:47="Rating Consultant")
				vRatingCon:=1
			: ([Conslt Rating:63]CRtgSource:47="R/O Unit")
				vROUnit:=1
			Else 
		End case 
		
		Case of 
			: ([Conslt Rating:63]ContractType:48="Regular")
				vRegular:=1
			: ([Conslt Rating:63]ContractType:48="Complex")
				vComplex:=1
			: ([Conslt Rating:63]ContractType:48="BRI")
				vBRI:=1
			Else 
		End case 
		
		G_SIA_BuildTownLine
		
		C_TEXT:C284(vsDate)  // Command Replaced was o_C_STRING length was 80
		vsDate:="Report Date: "+String:C10(Current date:C33(*))
		
		//added to get the Recommended Posting values from the [RatingReports] table
		G_SIA_GetRecPostings
		
		If (Not:C34(User in group:C338(<>CurrentUser_Name; "Conslt Rating - ReadWrite")) & (Not:C34(User in group:C338(<>CurrentUser_Name; "Conslt Rating - ReadOnly"))))
			OBJECT SET VISIBLE:C603(*; "costs@"; False:C215)
		End if 
		
End case 