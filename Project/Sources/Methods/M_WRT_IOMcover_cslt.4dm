//%attributes = {"invisible":true}
If (False:C215)
	//M_WRT_IOMcover_cslt 
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(3/23/10 10:48:18)
	Mods_2010_03
	//  `changed vBridgeInfo1;vBridgeInfo2 to text
	// Modified by: costasmanousakis-(Designer)-(6/14/10 09:56:46)
	Mods_2010_06
	//  `Added var vFourthCheck for the 4th submittal;
	//  ` and vWhiteCheck for a white rating report - gusset plate rating
	// Modified by: Costas Manousakis-(Designer)-(3/6/19 17:10:15)
	Mods_2019_03
	//  `use field CRtgSource to pick the consultant representative
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
End if 

//This method, M_WRT_IOMcover_cslt, is exactly identical to 
//M_WRT_IOMcover_inhouse except for the $inhouse=0 value

C_TEXT:C284(vContractNo)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284(vBridgeNo; $CommentDate)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284(vContactPerson; vCompanyName)  // Command Replaced was o_C_STRING length was 100
C_TEXT:C284(vBridgeInfo1; vBridgeInfo2)
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($sCh111)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($mypath)
C_DATE:C307(vToday)
C_LONGINT:C283($i; vAssignNo; $inhouse)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Recs)

$inhouse:=0
$sCh111:=Char:C90(111)

//single bridge
//$Recs:=Records in set("UserSet")
$Recs:=Records in selection:C76([Conslt Rating:63])

If (Not:C34($Recs=1))
	ALERT:C41("Please select one bridge for this letter!")
Else 
	COPY NAMED SELECTION:C331([Conslt Rating:63]; "PrePrintBrgList")
	READ ONLY:C145([Templates:86])
	QUERY:C277([Templates:86]; [Templates:86]TemplateName:2="WPtemplate_IOMcover")
	If (Records in selection:C76([Templates:86])=0)
		ALERT:C41("Document template [WPtemplate_IOMcover] does not exist!")
	Else 
		
		vToday:=Current date:C33(*)
		vBridgeNo:="Bridge Dept No."
		vContactName:="Contact_Person"
		vCompanyName:="Company_Name"
		vAddress1:="Address Line 1"
		vAddress2:="Address Line 2"
		vEWO:=""
		vBridgeInfo1:=""
		vBridgeInfo2:=""
		
		FIRST RECORD:C50([Conslt Rating:63])
		vContractNo:=[Conslt Rating:63]ContractNoRat:14
		vAssignNo:=[Conslt Rating:63]AssignNoRat:12
		vCompanyName:=[Conslt Rating:63]AssignRatCons:5
		
		RELATE ONE:C42([Conslt Rating:63]BIN:1)
		$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
		$BDept:=Insert string:C231($BDept; "-"; 5)
		vBridgeNo:=$BDept+" ("+[Conslt Rating:63]BIN:1+")"
		vBridgeInfo1:=vBridgeNo+", "+[Bridge MHD NBIS:1]Town Name:175
		vBridgeInfo2:=vBridgeInfo2+[Bridge MHD NBIS:1]Item7:65+" / "+[Bridge MHD NBIS:1]Item6A:63
		
		GetEWONo(vContractNo)
		
		vRedCheck:=$sCh111
		vYellowCheck:=$sCh111
		vGreenCheck:=$sCh111
		vWhiteCheck:=$sCh111
		Case of 
			: (Uppercase:C13([Conslt Rating:63]CRtgColor:46)="RED")
				vRedCheck:="x"
			: (Uppercase:C13([Conslt Rating:63]CRtgColor:46)="YELLOW")
				vYellowCheck:="x"
			: (Uppercase:C13([Conslt Rating:63]CRtgColor:46)="GREEN")
				vGreenCheck:="x"
			: (Uppercase:C13([Conslt Rating:63]CRtgColor:46)="WHITE")
				vWhiteCheck:="x"
		End case 
		
		vFirstCheck:=$sCh111
		vSecondCheck:=$sCh111
		vThirdCheck:=$sCh111
		vFourthCheck:=$sCh111
		$CommentDate:=""
		Case of 
			: ([Conslt Rating:63]RepSubmit4:52#!00-00-00!)
				vFourthCheck:="x"
				$CommentDate:=""
			: ([Conslt Rating:63]RepSubmit3:41#!00-00-00!)
				vThirdCheck:="x"
				$CommentDate:=String:C10([Conslt Rating:63]CmntsRecvd3:57)
			: ([Conslt Rating:63]RepSubmit2:31#!00-00-00!)
				vSecondCheck:="x"
				$CommentDate:=String:C10([Conslt Rating:63]CmntsRecvd2:19)
			: ([Conslt Rating:63]RepSubmit1:23#!00-00-00!)
				vFirstCheck:="x"
				$CommentDate:=String:C10([Conslt Rating:63]CmntsRecvd1:18)
		End case 
		
		C_TEXT:C284(vAttachedDesc1; vAttachedDesc2; vOther; vToCompanyName)  // Command Replaced was o_C_STRING length was 100
		C_TEXT:C284(vQuantity1; vQuantity2)  // Command Replaced was o_C_STRING length was 10
		
		If ($inhouse=1)
			
			GetConsltAddress("In-House Design"; "")
			
			vReviewCheck:="x"
			vOtherCheck:=$sCh111
			vToCompanyName:="Assistant Bridge Engineer"
			vAddress1:="In-House Design"
			vAddress2:=<>sTab+<>sTab
			vAttachedDesc1:="Copies of Rating Report "+vBridgeNo+" prepared by "+vCompanyName
			vAttachedDesc2:=""
			vQuantity1:="     2"
			vQuantity2:=""
			vOther:="____________________"
			
		Else 
			
			Case of 
				: ([Conslt Rating:63]CRtgSource:47="design@")
					GetConsltAddress(vCompanyName; "DESIGN")
				: ([Conslt Rating:63]CRtgSource:47="Inspection@")
					GetConsltAddress(vCompanyName; "Rating")
				Else 
					GetConsltAddress(vCompanyName; "RATING")
			End case 
			
			
			vReviewCheck:=$sCh111
			vOtherCheck:="x"
			vToCompanyName:=vCompanyName
			vAttachedDesc1:="Copies of Rating "+vBridgeNo
			vAttachedDesc2:="Copy of Rating and Overloads Unit's comments dated "+$CommentDate
			vQuantity1:="     2"
			vQuantity2:="     1"
			vOther:="  For resolution"
		End if 
		
		GetBIEinfo
		
		//````4D WR commands
		G_WP_MakeDocument
		UNLOAD RECORD:C212([Templates:86])
	End if 
	
End if   //matches If ($bCreateLetter=True)