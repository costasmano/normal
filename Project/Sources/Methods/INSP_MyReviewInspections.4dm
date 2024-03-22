//%attributes = {"invisible":true}
// Method: INSP_MyReviewInspections
// Description
//  ` Get the list of inspections that i (current user) supposed to review in my pending list.
//  `Return the list of Inspection responsibiliites
// 
// Parameters
// $0 : $InspTitles_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/07/11, 09:55:16
	// ----------------------------------------------------
	
	Mods_2011_10
	// Modified by: costasmanousakis-(Designer)-(10/18/11 11:55:31)
	Mods_2011_10
	//  `Use new global variable ◊CurrentUser_Name
	// Modified by: CJMiller-(Designer)-(5/14/13 16:33:50)
	Mods_2013_05
	//  `added exclusion of Rail and tunnel inspections
	// Modified by: Costas Manousakis-(Designer)-(5/30/13 14:27:25)
	Mods_2013_05  // ****** BUG FIX
	//  `moved the code for getting MYINSPECTIONS at the end of CLEANUP block
	// Modified by: Costas Manousakis-(Designer)-(2/13/15 11:51:18)
	Mods_2015_02
	//  `Added Damage and Other  TDA, TOT to the tunnel inspecions
	// Modified by: Costas Manousakis-(Designer)-(2021-10-28T00:00:00 17:38:24)
	Mods_2021_10_bug
	//  `include search for team members in the search for MYINSPECTIONS 
End if 
C_TEXT:C284($0; $InspTitles_txt)
CREATE EMPTY SET:C140([Inspections:27]; "MYDISTRICTSINSPECTS")
CREATE EMPTY SET:C140([Inspections:27]; "DIVEINSPECTIONS")
$InspTitles_txt:=""
QUERY:C277([Inspections:27]; [Inspections:27]InspApproved:167<BMS Approved)

C_LONGINT:C283($loop_L)
For ($loop_L; 1; Size of array:C274(<>InspReview_FinalStage_atxt))
	If (<>InspReview_FinalStage_atxt{$loop_L}="1")
		CREATE SET:C116([Inspections:27]; "STARTINSPECTIONSET")
		SET QUERY DESTINATION:C396(Into set:K19:2; "INSPECTIONSTOEXCLUDE")
		QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6=<>InspReview_Type_atxt{$loop_L}; *)
		If (<>INSP_DBIE_b)
			//show not approved ones only if i am responsible for this level
			QUERY SELECTION:C341([Inspections:27];  & ; [Inspections:27]InspReviewed:12=BMS Approved; *)
		End if 
		QUERY SELECTION:C341([Inspections:27];  & ; [Bridge MHD NBIS:1]Item8 Owner:208=<>InspReview_Owner_atxt{$loop_L})
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		DIFFERENCE:C122("STARTINSPECTIONSET"; "INSPECTIONSTOEXCLUDE"; "STARTINSPECTIONSET")
		USE SET:C118("STARTINSPECTIONSET")
		CLEAR SET:C117("STARTINSPECTIONSET")
		CLEAR SET:C117("INSPECTIONSTOEXCLUDE")
	End if 
End for 
CREATE SET:C116([Inspections:27]; "UNAPPROVEDINSPECTIONS")
//debugginghere:=True  // costas 14-may
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="FRZ")
USE SET:C118("UNAPPROVEDINSPECTIONS")
If (Size of array:C274(<>INSP_MyDistricts_atxt)>0)
	SET QUERY DESTINATION:C396(Into set:K19:2; "MYDISTRICTSINSPECTS")
	QUERY SELECTION:C341([Inspections:27]; [Bridge MHD NBIS:1]InspResp:173=<>INSP_MyDistricts_atxt{1}; *)
	$InspTitles_txt:=<>INSP_MyDistricts_atxt{1}
	For ($loop_L; 2; Size of array:C274(<>INSP_MyDistricts_atxt))
		QUERY SELECTION:C341([Inspections:27];  | ; [Bridge MHD NBIS:1]InspResp:173=<>INSP_MyDistricts_atxt{$loop_L}; *)
		$InspTitles_txt:=$InspTitles_txt+", "+<>INSP_MyDistricts_atxt{$loop_L}
	End for 
	QUERY SELECTION:C341([Inspections:27])
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End if 
SET QUERY DESTINATION:C396(Into set:K19:2; "DIVEINSPECTIONS")
QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Insp Type:6="DV@")
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If (<>INSP_UOEng_b | <>INSP_BridgeInspEng_b)
	If (Not:C34(<>INSP_BridgeInspEng_b))
		If ($InspTitles_txt#"")
			$InspTitles_txt:=$InspTitles_txt+", DIVE"
		Else 
			$InspTitles_txt:="DIVE"
		End if 
	End if 
	
	UNION:C120("MYDISTRICTSINSPECTS"; "DIVEINSPECTIONS"; "MYDISTRICTSINSPECTS")
Else 
	//not UWOE - exclude dive inspections
	DIFFERENCE:C122("MYDISTRICTSINSPECTS"; "DIVEINSPECTIONS"; "MYDISTRICTSINSPECTS")
	
End if 
USE SET:C118("MYDISTRICTSINSPECTS")
CLEAR SET:C117("DIVEINSPECTIONS")

If (User in group:C338(<>CurrentUser_Name; "Design Access Group"))
	USE SET:C118("UNAPPROVEDINSPECTIONS")
Else 
	//``  CLEAN UP  of inspections
	ARRAY TEXT:C222($InspTypes_atxt; 0)
	ARRAY TEXT:C222($InspTypes_atxt; 7)
	$InspTypes_atxt{1}:="RRR"
	$InspTypes_atxt{2}:="RRA"
	$InspTypes_atxt{3}:="RRC"
	$InspTypes_atxt{4}:="RRS"
	$InspTypes_atxt{5}:="RRF"
	$InspTypes_atxt{6}:="RRO"
	$InspTypes_atxt{7}:="RRD"
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "RailSet")
	QUERY WITH ARRAY:C644([Inspections:27]Insp Type:6; $InspTypes_atxt)
	
	ARRAY TEXT:C222($InspTypes_atxt; 0)
	ARRAY TEXT:C222($InspTypes_atxt; 5)
	$InspTypes_atxt{1}:="TAL"
	$InspTypes_atxt{2}:="TOV"
	$InspTypes_atxt{3}:="TSP"
	$InspTypes_atxt{4}:="TDA"
	$InspTypes_atxt{5}:="TOT"
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "TunnelSet")
	QUERY WITH ARRAY:C644([Inspections:27]Insp Type:6; $InspTypes_atxt)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	DIFFERENCE:C122("MYDISTRICTSINSPECTS"; "RailSet"; "HwyBridgeSet")
	DIFFERENCE:C122("HwyBridgeSet"; "TunnelSet"; "HwyBridgeSet")
	
	If (<>INSP_HWYBrgReview_b)
	Else 
		DIFFERENCE:C122("MYDISTRICTSINSPECTS"; "HwyBridgeSet"; "MYDISTRICTSINSPECTS")
	End if 
	
	If (<>INSP_RailBrgReview_b)
	Else 
		DIFFERENCE:C122("MYDISTRICTSINSPECTS"; "RailSet"; "MYDISTRICTSINSPECTS")
	End if 
	
	If (<>INSP_TunnelReview_b)
	Else 
		DIFFERENCE:C122("MYDISTRICTSINSPECTS"; "TunnelSet"; "MYDISTRICTSINSPECTS")
	End if 
	
	USE SET:C118("UNAPPROVEDINSPECTIONS")
	
	C_TEXT:C284($vstestUser; $vsUserName)
	$vsUserName:=<>CurrentUser_Name
	$vstestUser:=Replace string:C233($vsUserName; " "; "@")
	C_BOOLEAN:C305($autoOne_b; $autoMany_b)
	GET AUTOMATIC RELATIONS:C899($autoOne_b; $autoMany_b)
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	SET QUERY DESTINATION:C396(Into set:K19:2; "INSPSBYME")
	QUERY SELECTION:C341([Inspections:27]; [Inspections:27]Modified By:134=$vstestUser; *)  //done by me
	If (<>CurrentUser_PID>0)
		QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]TeamLeader:4=<>CurrentUser_PID; *)  //or i'm team leader
		QUERY SELECTION:C341([Inspections:27];  | ; [Field Trip:43]Person ID:2=<>CurrentUser_PID; *)  //or i'm team member
		If (User in group:C338($vsUserName; "ExternalInspectors"))
			If (<>PERS_MyJobCode_i<=2)  //only if I'm a team leader
				QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]Agency:156=<>PERS_MyCompany_txt; *)  //or from my agency
			End if 
		End if 
	End if 
	QUERY SELECTION:C341([Inspections:27];  | ; [Inspections:27]DBrInspEngr:3=<>CurrentUser_PID; *)  //or I am the DBIE
	QUERY SELECTION:C341([Inspections:27])
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	UNION:C120("MYDISTRICTSINSPECTS"; "INSPSBYME"; "MYDISTRICTSINSPECTS")
	
	SET AUTOMATIC RELATIONS:C310($autoOne_b; $autoMany_b)
	
	CLEAR SET:C117("INSPSBYME")
	
	USE SET:C118("MYDISTRICTSINSPECTS")
	
End if 
CLEAR SET:C117("RailSet")
CLEAR SET:C117("TunnelSet")
CLEAR SET:C117("MYDISTRICTSINSPECTS")
CLEAR SET:C117("UNAPPROVEDINSPECTIONS")

If (Position:C15("@"; $InspTitles_txt)=1)
	$InspTitles_txt:=""
End if 

$0:=$InspTitles_txt