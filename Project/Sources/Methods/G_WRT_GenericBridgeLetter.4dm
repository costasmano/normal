//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: G_WRT_GenericBridgeLetter

//````````` Used to create memo or letter for a single bridge
//````````` Letter subject: Bridge Ratings and Postings
//````````` Assigns Bridge releated data to process variables
//````````` $1:  name of the 4D Write template
//````````` $2:  whether the ratings (H, S, 3S2) values need to be retrieved 
//````````` $3:  if ($bTownLetter), letter is sent to town--> retrieve town addres
If (False:C215)
	//``````````````````````````````````````````````````````````````````````````
	//````````` SJH  1/22/2004
	// ----------------------------------------------------
	//``````````````````````````````````````````````````````````````````````````
	Mods_2005_CM12
	Mods_2005_CM12
	Mods_2005_CM15
	// Modified by: costasmanousakis-(Designer)-(11/19/05 09:53:24)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(4/20/2006 12:39:46)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(6/29/06 12:43:50)
	Mods_2006_CM05
	// Modified by: costasmanousakis-(Designer)-(8/22/2006 10:11:03)
	Mods_2006_CM06
	// Modified by: costasmanousakis-(Designer)-(11/8/2006 09:36:51)
	Mods_2006_CM07
	// Modified by: costasmanousakis-(Designer)-(2/23/2007 14:52:29)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(3/27/2007 15:50:27)
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/29/2007 11:11:56)
	Mods_2007_CM12_5301
	Mods_2011_05  //r002 CJ Miller`06/03/11, 16:11:27      `Make vDistrict alpha 2
	Mods_2011_06  // CJ Miller`06/14/11, 10:29:51      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(1/11/17 11:37:58)
	Mods_2017_01
	//  `add ability to use custom templates by inspection responsibility of the first bridge record
	//  `use save and retore RO state of tables using ut_db_SaveROState  and ut_db_RestoreROState
	// Modified by: Costas Manousakis-(Designer)-(10/22/19 16:23:20)
	Mods_2019_10_bug
	//  `Sort rating reports by report date, NBIS letter date and Report ID  CallReference #662
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
End if 

C_TEXT:C284($1; $sTemplateName)  // **Replaced old C_STRING length 80
C_BOOLEAN:C305($2; $bRatings)
C_BOOLEAN:C305($3; $bTownLetter)

$sTemplateName:=$1
$bRatings:=$2
$bTownLetter:=$3

C_TEXT:C284(vWriterInitial)  // **Replaced old C_STRING length 30
C_TEXT:C284(vDistrict)  // **Replaced old C_STRING length 2
C_DATE:C307(vToday)
C_TEXT:C284($mypath)
C_LONGINT:C283($i)  // **replaced _ o _C_INTEGER()
C_LONGINT:C283($Recs)
C_TEXT:C284($BDept)  // **Replaced old C_STRING length 20
C_TEXT:C284(vFacility; vFeature)  // **Replaced old C_STRING length 80

$Recs:=Records in set:C195("UserSet")
If (Not:C34($Recs=1))
	If ($Recs=0)
		ALERT:C41("Please select one bridge for this letter!")
	Else 
		ALERT:C41("Please select only one bridge for this letter!")
	End if 
	
Else 
	
	COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "PrePrintBrgList")
	COPY SET:C600("UserSet"; "PrePrintBrgUset")
	USE SET:C118("UserSet")
	
	C_BLOB:C604($ROState_x)
	$ROState_x:=ut_db_SaveROState
	
	READ ONLY:C145([Templates:86])  // Modified by: ManousakisC (5/6/2005)
	READ ONLY:C145([Personnel:42])
	READ ONLY:C145([Conslt Address:77])
	READ ONLY:C145([Bridge MHD NBIS:1])
	READ ONLY:C145([RatingReports:65])
	READ ONLY:C145([TownLineInfo:73])
	
	FIRST RECORD:C50([Bridge MHD NBIS:1])
	
	//convert template name from 4D Write coding to Write Pro
	
	$sTemplateName:=WP_4WRTemplNameToWP($sTemplateName)
	
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$sTemplateName+"_"+[Bridge MHD NBIS:1]InspResp:173)
	If (Records in selection:C76([Templates:86])=0)
		QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$sTemplateName)
	End if 
	If (Records in selection:C76([Templates:86])=0)
		//  If ($mypath="")      
		ALERT:C41("Required Document template <"+$sTemplateName+">does not exist!")
	Else 
		
		vToday:=Current date:C33(*)
		If (Position:C15("_LTR"; $sTemplateName)>0)
			LTR_GetLetterDate
		End if 
		
		C_TEXT:C284($UserInitial)  // **Replaced old C_STRING length 5
		$UserInitial:=F_GetUserInitial(Current user:C182)
		If ($UserInitial="")
			vWriterInitial:="ENTER_WRITER_INITIAL"
		Else 
			vWriterInitial:=Uppercase:C13($UserInitial)+"/"+Lowercase:C14($UserInitial)
		End if 
		
		C_TEXT:C284($district)  // **Replaced old C_STRING length 1
		C_TEXT:C284(vCityTown; vLocation; $Item6; $Item7)  // **Replaced old C_STRING length 100
		C_TEXT:C284($BridgeKey; vBridgeKeyNo; vBridgeNo)  // **Replaced old C_STRING length 50
		C_TEXT:C284(vBIN)  // **Replaced old C_STRING length 3
		
		FIRST RECORD:C50([Bridge MHD NBIS:1])
		
		If ($bRatings)
			C_DATE:C307(vReportDate)
			C_TEXT:C284(vConsltName)  // **Replaced old C_STRING length 100
			C_LONGINT:C283(vHType; v3Type; v3S2Type)  // **replaced _ o _C_INTEGER()
			QUERY:C277([RatingReports:65]; [RatingReports:65]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			ORDER BY:C49([RatingReports:65]; [RatingReports:65]ReportDate:4; <; [RatingReports:65]NBIS_Letter_d:36; <; [RatingReports:65]RatingID:21; <)
			
			//get the latest ratings report data      
			If (Records in selection:C76([RatingReports:65])>0)
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
		End if 
		
		$district:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
		$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
		$BDept:=Insert string:C231($BDept; "-"; 5)
		
		If ([Bridge MHD NBIS:1]OnTwnLine:177=True:C214)
			C_TEXT:C284($otherBDept)  // **Replaced old C_STRING length 20
			QUERY:C277([TownLineInfo:73]; [TownLineInfo:73]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			ARRAY TEXT:C222($TwnLineBDept_as; 0)  // **Replaced old _ o _ARRAY STRING length 6
			If (Records in selection:C76([TownLineInfo:73])>0)
				SELECTION TO ARRAY:C260([TownLineInfo:73]BDEPT:2; $TwnLineBDept_as)
				C_LONGINT:C283($j)
				For ($j; 1; Records in selection:C76([TownLineInfo:73]))
					$otherBDept:=Insert string:C231($TwnLineBDept_as{$j}; "-"; 2)
					$otherBDept:=Insert string:C231($otherBDept; "-"; 5)
					$BDept:=$BDept+" = "+$otherBDept
					$otherBDept:=""
				End for 
				
			Else 
				ALERT:C41("WARNING : Bridge Record BIN : "+[Bridge MHD NBIS:1]BIN:3+" is flagged as a TownLine Bridge but there are no TownLine records in the MISC se"+"ction!")
			End if 
			
		End if 
		
		vCityTown:=[Bridge MHD NBIS:1]Town Name:175
		$Item6:=F_RemoveFeatIntCode([Bridge MHD NBIS:1]Item6A:63)
		$Item7:=F_RemoveFeatIntCode([Bridge MHD NBIS:1]Item7:65)
		vFacility:=$Item7
		vFeature:=$Item6
		vLocation:=$Item7+" / "+$Item6
		vBridgeNo:=$BDept
		vBIN:=[Bridge MHD NBIS:1]BIN:3
		$BridgeKey:=Insert string:C231([Bridge MHD NBIS:1]Item8:206; "-"; 7)
		$BridgeKey:=Insert string:C231($BridgeKey; "-"; 11)
		$BridgeKey:=Insert string:C231($BridgeKey; "-"; 15)
		vBridgeKeyNo:=$BridgeKey
		
		C_TEXT:C284(vItem43Code; vItem44Code)  // **Replaced old C_STRING length 3
		vItem43Code:=[Bridge MHD NBIS:1]Item43:75
		vItem44Code:=[Bridge MHD NBIS:1]Item44:76
		
		C_TEXT:C284(item43a)  // **Replaced old C_STRING length 1
		C_TEXT:C284($Item43aDesc)  // **Replaced old C_STRING length 30
		item43a:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 1; 1)
		$Item43aDesc:=Get_Description(-><>aMaterial; -><>aMatCode; ->item43a)
		
		C_TEXT:C284(item43b)  // **Replaced old C_STRING length 2
		C_TEXT:C284($Item43bDesc)  // **Replaced old C_STRING length 40
		item43b:=Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)
		$Item43bDesc:=Get_Description(-><>aDesign; -><>aDesignCod; ->item43b)
		
		If ($Item43aDesc="")
			vItem43:=$Item43bDesc
		Else 
			vItem43:=$Item43aDesc+" "+$Item43bDesc
		End if 
		
		C_TEXT:C284(item44a)  // **Replaced old C_STRING length 1
		C_TEXT:C284($Item44aDesc)  // **Replaced old C_STRING length 40
		item44a:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 1; 1)
		$Item44aDesc:=Get_Description(-><>aDesign; -><>aDesignCod; ->item44a)
		
		C_TEXT:C284(item44b)  // **Replaced old C_STRING length 2
		C_TEXT:C284($Item44bDesc)  // **Replaced old C_STRING length 40
		item44b:=Substring:C12([Bridge MHD NBIS:1]Item44:76; 2; 2)
		$Item44bDesc:=Get_Description(-><>aDesign; -><>aDesignCod; ->item44b)
		
		If ($Item44aDesc="")
			vItem44:=$Item44bDesc
		Else 
			vItem44:=$Item44aDesc+" "+$Item44bDesc
		End if 
		
		//used in Request for Consultant Bridge Rating
		If ([Bridge MHD NBIS:1]Item104:119=True:C214)
			vOnSystem:="x"
			vOffSystem:="o"
		Else 
			vOnSystem:="o"
			vOffSystem:="x"
		End if 
		
		vDistrict:=$district
		GetDHDinfo($district)
		GetBridgeEngineer
		GetChiefEngineer
		
		If (($bRatings) | ($bTownLetter))
			GetBIEinfo
			GetAreaBIEinfo($district)
			GetDBIEinfo($district)
			// Modified by: costasmanousakis-(Designer)-(6/29/06 12:44:46)
			//vWriterInitial:=vDBIEinitial+"/"+Lowercase(vDBIEinitial)
		End if 
		
		If ($bTownLetter)
			GetTownAddress(vCityTown)
		End if 
		C_PICTURE:C286(LTR_PictureInsert_pict)
		LTR_PictureInsert_pict:=LTR_PictureInsert_pict*0
		C_BOOLEAN:C305($ImageOK_b)
		$ImageOK_b:=True:C214
		Case of 
			: ($sTemplateName="@MISSING@")  //missing positn signs letter
				PUSH RECORD:C176([Templates:86])
				LTR_PictureInsert_pict:=LTR_GenerateTruckPic
				If (Picture size:C356(LTR_PictureInsert_pict)>0)
				Else 
					CONFIRM:C162("Errors generating Truck Posting image. Continue?"; "Continue"; "Cancel")
					If (OK=1)
					Else 
						$ImageOK_b:=False:C215
					End if 
					
				End if 
				POP RECORD:C177([Templates:86])
				LTR_GetLastInspDate
			: ($sTemplateName="@_CLEAR_@")  //clearance letter
				PUSH RECORD:C176([Templates:86])
				LTR_PictureInsert_pict:=LTR_GenerateVertCLPic
				If (Picture size:C356(LTR_PictureInsert_pict)>0)
				Else 
					CONFIRM:C162("Errors generating Vertical Clearance image. Continue?"; "Continue"; "Cancel")
					If (OK=1)
					Else 
						$ImageOK_b:=False:C215
					End if 
					
				End if 
				POP RECORD:C177([Templates:86])
				LTR_GetLastInspDate
		End case 
		If ($ImageOK_b)
			
			G_WP_MakeDocument
			
			If ($bTownLetter & [Bridge MHD NBIS:1]OnTwnLine:177)
				C_LONGINT:C283($twnCount)
				For ($twnCount; 1; Size of array:C274($TwnLineBDept_as))
					
					QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BDEPT:1=$TwnLineBDept_as{$twnCount})
					If (Records in selection:C76([Bridge MHD NBIS:1])>0)
						GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; 1)
						$district:=Substring:C12([Bridge MHD NBIS:1]Item2:60; 2; 1)
						vCityTown:=[Bridge MHD NBIS:1]Town Name:175
						ALERT:C41("Town Line Bridge : Creating Letter for Town "+vCityTown)
						vDistrict:=$district
						GetDHDinfo($district)
						GetAreaBIEinfo($district)
						GetTownAddress(vCityTown)
						G_WP_MakeDocument
					Else 
						C_TEXT:C284($msg)
						$msg:="ERROR : There is no DUM record in the BRIDGE NBI database for Townline BDEPT # <"+$TwnLineBDept_as{$twnCount}+"> !"
						$msg:=$msg+Char:C90(13)+"Please verify proper coding of TownLine records!"
						ALERT:C41($msg)
						$msg:=""
					End if 
				End for 
			End if 
			
		End if 
		
		LTR_PictureInsert_pict:=LTR_PictureInsert_pict*0  //don't need it anymore
		
	End if 
	
	USE NAMED SELECTION:C332("PrePrintBrgList")
	CLEAR NAMED SELECTION:C333("PrePrintBrgList")
	HIGHLIGHT RECORDS:C656("PrePrintBrgUset")
	CLEAR SET:C117("PrePrintBrgUset")
	REDRAW WINDOW:C456
	
	ut_db_RestoreROState($ROState_x)
End if   //matches If (Not($Recs=1))