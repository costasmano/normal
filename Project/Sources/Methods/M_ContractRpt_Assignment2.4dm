//%attributes = {"invisible":true}
If (False:C215)
	//M_ContractRpt_Assignment2 
	//copy from M_RPC_Report
	//Use the current selection and print a report
	//This version uses Print Layout to completely control printing.
	
	// Modified by: costasmanousakis-(Designer)-(6/3/08 14:28:26)
	Mods_2008_CM_5403
	//Added calculation for rating cons score
	// Modified by: costasmanousakis-(Designer)-(10/28/08 16:47:14)
	Mods_2008_CM_5404  // ("ContrAssgn")
	//  `Remember the current selection of Contract assignments.
	Mods_2011_06  // CJ Miller`06/14/11, 10:30:01      ` Type all local variables for v11
End if 


C_LONGINT:C283($i; $j; $countAssignNo; vCurrPage; vRptPages)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($PixPage; $PixH0; $PixH1; $PixD; $PixF; $PixCount)  //Command Replaced was o_C_INTEGER
C_TEXT:C284(vRptHeader; vRptDescr; vRateInfo; $sContractNo; $sContractType)
C_DATE:C307(vRptDate)
C_TIME:C306(vRptTime)
C_TEXT:C284($type)  // Command Replaced was o_C_STRING length was 20
C_LONGINT:C283($iD1Total; $iD2Total; $iD3Total; $iD4Total; $iD5Total; $iActiveTotal; $iCompletedTotal; $iRescindedTotal; $iInspNotifTotal)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vD1Total; vD2Total; vD3Total; vD4Total; vD5Total; vActiveTotal; vCompletedTotal; vRescindedTotal; vInspNotifTotal)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(vD1Count; vD2Count; vD3Count; vD4Count; vD5Count; vActiveCount; vCompletedCount; vRescindedCount; vInspNotifCount)  //Command Replaced was o_C_INTEGER
C_REAL:C285(vAvgScore)
C_TEXT:C284(vSpecialAssign)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($sBIN)  // Command Replaced was o_C_STRING length was 3
vD1Total:=0
vD2Total:=0
vD3Total:=0
vD4Total:=0
vD5Total:=0
vActiveTotal:=0
vCompletedTotal:=0
vRescindedTotal:=0
vInspNotifTotal:=0

$iD1Total:=0
$iD2Total:=0
$iD3Total:=0
$iD4Total:=0
$iD5Total:=0
$iActiveTotal:=0
$iCompletedTotal:=0
$iRescindedTotal:=0
$iInspNotifTotal:=0

$PixPage:=551
$PixH0:=61
$PixH1:=10
$PixD:=8
$PixF:=3

//```````````` ````````````` ````````````` ````````````` `````````````
//````Retrieve assignment numbers for the selected contract
//```````````` ````````````` ````````````` ````````````` `````````````
$sContractNo:=[Contracts:79]ContractNo:1
$sContractType:=[Contracts:79]ContractType:2
COPY NAMED SELECTION:C331([Contract Assignments:83]; "CONSCONTASSGNS")
QUERY:C277([Contract Assignments:83]; [Contract Assignments:83]ContractNo:1=$sContractNo)
$countAssignNo:=Records in selection:C76([Contract Assignments:83])
ARRAY INTEGER:C220($aiAssignNo; $countAssignNo)
DISTINCT VALUES:C339([Contract Assignments:83]AssignNo:2; $aiAssignNo)
SORT ARRAY:C229($aiAssignNo)
READ ONLY:C145([Bridge MHD NBIS:1])

//```` Report Header
//```````````` ````````````` ````````````` ````````````` `````````````
//``````` Detail Section
//```````````` ````````````` ````````````` ````````````` `````````````
For ($i; 1; $countAssignNo)
	vAvgScore:=0
	vAssignDesc:=""
	vAssignDesc:=vAssignDesc+String:C10($aiAssignNo{$i})
	vD1Count:=0
	vD2Count:=0
	vD3Count:=0
	vD4Count:=0
	vD5Count:=0
	vActiveCount:=0
	vCompletedCount:=0
	vRescindedCount:=0
	vInspNotifCount:=0
	
	QUERY:C277([Contract Assignments:83]; [Contract Assignments:83]ContractNo:1=$sContractNo; *)
	QUERY:C277([Contract Assignments:83];  & ; [Contract Assignments:83]AssignNo:2=$aiAssignNo{$i})
	FIRST RECORD:C50([Contract Assignments:83])
	If ([Contract Assignments:83]SpecialAssignment:21=True:C214)
		vSpecialAssign:="Y"
	Else 
		vSpecialAssign:="N"
	End if 
	
	If ($type="Inspection")
		QUERY:C277([Cons Inspection:64]; [Cons Inspection:64]ConContractNo:7=$sContractNo; *)
		QUERY:C277([Cons Inspection:64];  & ; [Cons Inspection:64]AssignConNumber:6=$aiAssignNo{$i})
		For ($j; 1; Records in selection:C76([Cons Inspection:64]))
			Case of 
				: ([Cons Inspection:64]AssignStatus:24="Active")
					vActiveCount:=vActiveCount+1
				: ([Cons Inspection:64]AssignStatus:24="Rescinded")
					vRescindedCount:=vRescindedCount+1
				: ([Cons Inspection:64]AssignStatus:24="Completed")
					vCompletedCount:=vCompletedCount+1
					If ([Cons Inspection:64]ConsltScore:30<0)
					Else 
						vAvgScore:=vAvgScore+[Cons Inspection:64]ConsltScore:30
					End if 
					
				: ([Cons Inspection:64]AssignStatus:24="Insp. Notification Received")
					vInspNotifCount:=vInspNotifCount+1
			End case 
			
			$sBIN:=[Cons Inspection:64]BIN:1
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$sBIN)
			FIRST RECORD:C50([Bridge MHD NBIS:1])
			Case of 
				: ([Bridge MHD NBIS:1]Item2:60="01")
					vD1count:=vD1count+1
				: ([Bridge MHD NBIS:1]Item2:60="02")
					vD2count:=vD2count+1
				: ([Bridge MHD NBIS:1]Item2:60="03")
					vD3count:=vD3count+1
				: ([Bridge MHD NBIS:1]Item2:60="04")
					vD4count:=vD4count+1
				: ([Bridge MHD NBIS:1]Item2:60="05")
					vD5count:=vD5count+1
			End case 
			NEXT RECORD:C51([Cons Inspection:64])
		End for 
		
	Else   //``Rating  ```Rating  ```Rating  ```Rating  ```Rating     
		QUERY:C277([Conslt Rating:63]; [Conslt Rating:63]ContractNoRat:14=$sContractNo; *)
		QUERY:C277([Conslt Rating:63];  & ; [Conslt Rating:63]AssignNoRat:12=$aiAssignNo{$i})
		For ($j; 1; Records in selection:C76([Conslt Rating:63]))
			//      CREATE SET([Conslt Rating];"ConsltRating Set")
			Case of 
				: ([Conslt Rating:63]AssignStatus:43="Active")
					vActiveCount:=vActiveCount+1
				: ([Conslt Rating:63]AssignStatus:43="Rescinded")
					vRescindedCount:=vRescindedCount+1
				: ([Conslt Rating:63]AssignStatus:43="Completed")
					If ([Conslt Rating:63]ConsltScore:15<0)
					Else 
						vAvgScore:=vAvgScore+[Conslt Rating:63]ConsltScore:15
					End if 
					vCompletedCount:=vCompletedCount+1
			End case 
			
			$sBIN:=[Conslt Rating:63]BIN:1
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$sBIN)
			FIRST RECORD:C50([Bridge MHD NBIS:1])
			Case of 
				: ([Bridge MHD NBIS:1]Item2:60="01")
					vD1count:=vD1count+1
				: ([Bridge MHD NBIS:1]Item2:60="02")
					vD2count:=vD2count+1
				: ([Bridge MHD NBIS:1]Item2:60="03")
					vD3count:=vD3count+1
				: ([Bridge MHD NBIS:1]Item2:60="04")
					vD4count:=vD4count+1
				: ([Bridge MHD NBIS:1]Item2:60="05")
					vD5count:=vD5count+1
			End case 
			NEXT RECORD:C51([Conslt Rating:63])
		End for 
	End if   //Inspection Type  
	If (vCompletedCount>0)
		vAvgScore:=Round:C94(vAvgScore/vCompletedCount; 1)
	End if 
	
	Print form:C5([Contracts:79]; "Rpt Assign Detail2")
	
	//keep a running sum
	$iD1Total:=$iD1Total+vD1count
	$iD2Total:=$iD2Total+vD2count
	$iD3Total:=$iD3Total+vD3count
	$iD4Total:=$iD4Total+vD4count
	$iD5Total:=$iD5Total+vD5count
	$iActiveTotal:=$iActiveTotal+vActiveCount
	$iCompletedTotal:=$iCompletedTotal+vCompletedCount
	$iRescindedTotal:=$iRescindedTotal+vRescindedCount
	$iInspNotifTotal:=$iInspNotifTotal+vInspNotifCount
	
End for   //end of assingment # loop


//```````````` ````````````` ````````````` ````````````` `````````````
//``````` Totals
//```````````` ````````````` ````````````` ````````````` `````````````
vAssignDesc:="Totals"
vD1Total:=$iD1Total
vD2Total:=$iD2Total
vD3Total:=$iD3Total
vD4Total:=$iD4Total
vD5Total:=$iD5Total
vActiveTotal:=$iActiveTotal
vCompletedTotal:=$iCompletedTotal
vRescindedTotal:=$iRescindedTotal
vInspNotifTotal:=$iInspNotifTotal

Print form:C5([Contracts:79]; "Rpt Assign Footer2")

READ WRITE:C146([Bridge MHD NBIS:1])
USE NAMED SELECTION:C332("CONSCONTASSGNS")
CLEAR NAMED SELECTION:C333("CONSCONTASSGNS")