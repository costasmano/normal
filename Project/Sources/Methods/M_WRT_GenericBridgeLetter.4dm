//%attributes = {"invisible":true}
If (False:C215)
	//``````````````````````````````````````````````````````````````````````````
	//````````` SJH  1/22/2004
	//````````` Used to create memo or letter for a single bridge
	//````````` Letter subject: Bridge Ratings and Postings
	//````````` Assigns Bridge releated data to process variables
	//````````` $1:  name of the 4D Write template
	//````````` $2:  whether the ratings (H, S, 3S2) values need to be retrieved 
	//````````` $3:  if ($bTownLetter), letter is sent to town--> retrieve town addres
	//``````````````````````````````````````````````````````````````````````````
	
	// Modified by: costasmanousakis-(Designer)-(4/20/2006 12:37:03)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(1/17/2007 15:13:30)
	Mods_2007_CM04
	Mods_2011_06  //r002 CJ Miller`06/03/11, 16:11:27      `Make vDistrict alpha 2
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
End if 
C_TEXT:C284($1; $sTemplateName)  // Command Replaced was o_C_STRING length was 80
C_BOOLEAN:C305($2; $bRatings)
C_BOOLEAN:C305($3; $bTownLetter)

$sTemplateName:=$1
$bRatings:=$2
$bTownLetter:=$3

C_TEXT:C284(vWriterInitial)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vDistrict)  // Command Replaced was o_C_STRING length was 2
C_DATE:C307(vToday)
C_TEXT:C284($mypath)
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20

$Recs:=Records in set:C195("UserSet")
If (Not:C34($Recs=1))
	
	ALERT:C41("Please select one bridge for this letter!")
	
Else 
	
	COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "PrePrintBrgList")
	USE SET:C118("UserSet")
	READ ONLY:C145([Templates:86])
	READ ONLY:C145([Bridge MHD NBIS:1])
	READ ONLY:C145([RatingReports:65])
	$sTemplateName:=WP_4WRTemplNameToWP($sTemplateName)
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$sTemplateName)
	If (Records in selection:C76([Templates:86])=0)
		//  If ($mypath="")      
		ALERT:C41("Document template does not exist!")
		
	Else 
		
		vToday:=Current date:C33(*)
		
		C_TEXT:C284($UserInitial)  // Command Replaced was o_C_STRING length was 5
		$UserInitial:=F_GetUserInitial(Current user:C182)
		If ($UserInitial="")
			vWriterInitial:="ENTER_WRITER_INITIAL"
		Else 
			vWriterInitial:=Uppercase:C13($UserInitial)+"/"+Lowercase:C14($UserInitial)
		End if 
		
		C_TEXT:C284($district)  // Command Replaced was o_C_STRING length was 1
		C_TEXT:C284(vCityTown; vLocation; $Item6; $Item7)  // Command Replaced was o_C_STRING length was 100
		C_TEXT:C284($BridgeKey; vBridgeKeyNo; vBridgeNo)  // Command Replaced was o_C_STRING length was 50
		C_TEXT:C284(vBIN)  // Command Replaced was o_C_STRING length was 3
		
		FIRST RECORD:C50([Bridge MHD NBIS:1])
		
		If ($bRatings)
			C_DATE:C307(vReportDate)
			C_TEXT:C284(vConsltName)  // Command Replaced was o_C_STRING length was 100
			C_LONGINT:C283(vHType; v3Type; v3S2Type)  //Command Replaced was o_C_INTEGER
			vReportDate:=[RatingReports:65]ReportDate:4
			If ([RatingReports:65]Consultant:5="")
				vConsltName:="ENTER_CONSULTANT_NAME"
			Else 
				vConsltName:=[RatingReports:65]Consultant:5
			End if 
			vHType:=[RatingReports:65]RecPostingH:14
			v3Type:=[RatingReports:65]RecPost3:15
			v3S2Type:=[RatingReports:65]RecPost3S2:16
		End if 
		
		$district:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
		$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
		$BDept:=Insert string:C231($BDept; "-"; 5)
		vCityTown:=[Bridge MHD NBIS:1]Town Name:175
		$Item6:=F_RemoveFeatIntCode([Bridge MHD NBIS:1]Item6A:63)
		$Item7:=F_RemoveFeatIntCode([Bridge MHD NBIS:1]Item7:65)
		vLocation:=$Item7+" / "+$Item6
		vBridgeNo:=$BDept
		vBIN:=[Bridge MHD NBIS:1]BIN:3
		$BridgeKey:=Insert string:C231([Bridge MHD NBIS:1]Item8:206; "-"; 7)
		$BridgeKey:=Insert string:C231($BridgeKey; "-"; 11)
		$BridgeKey:=Insert string:C231($BridgeKey; "-"; 15)
		vBridgeKeyNo:=$BridgeKey
		
		vDistrict:=$district
		GetDHDinfo($district)
		GetBridgeEngineer
		GetChiefEngineer
		
		If (($bRatings) | ($bTownLetter))
			GetDBIEinfo($district)
			vWriterInitial:=vDBIEinitial+"/"+Lowercase:C14(vDBIEinitial)
		End if 
		
		If ($bTownLetter)
			GetTownAddress(vCityTown)
		End if 
		
		//````4D WR commands
		G_WP_MakeDocument
		
	End if 
	READ WRITE:C146([Templates:86])
	READ WRITE:C146([Bridge MHD NBIS:1])
	READ WRITE:C146([RatingReports:65])
	USE NAMED SELECTION:C332("PrePrintBrgList")
	CLEAR NAMED SELECTION:C333("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656("UserSet")
	REDRAW WINDOW:C456
End if   //matches If (Not($Recs=1))