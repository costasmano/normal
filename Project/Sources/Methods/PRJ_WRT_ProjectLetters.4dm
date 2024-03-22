//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/04/07, 13:28:28
	// ----------------------------------------------------
	// Method: PRJ_WRT_ProjectLetters
	// Description
	// 
	// 
	// Parameters
	// $1 : $sTemplateName
	// ----------------------------------------------------
	
	//Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(6/23/08 16:51:19)
	Mods_2008_CM_5404  //Added Proj Manager to the cc list
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(6/22/21 15:45:12)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2022-04-20 18:01:01)
	Mods_2022_04
	//  `make [Templates] Read only
End if 
C_TEXT:C284($Submissiondate_txt)
C_TEXT:C284($1; $sTemplateName)  // Command Replaced was o_C_STRING length was 80

$sTemplateName:=$1

C_BOOLEAN:C305(PRJ_WRT_InList_b)
C_TEXT:C284(vPlural)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284(vBridgelist_txt)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284(vAssignmentList; vAssignmentList1; Submissiondate_txt; study_txt)
C_TEXT:C284(town_txt; BridgeNum_txt; Vcclist)
C_DATE:C307(vToday)
C_LONGINT:C283(vAssignNo)  //Command Replaced was o_C_INTEGER
C_TEXT:C284(vWriterInitial)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284(vCompanyName; vcontactname)  // Command Replaced was o_C_STRING length was 100
C_LONGINT:C283($i; $Recs; $J)
C_BOOLEAN:C305($bCreateLetter)
C_TEXT:C284($district)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($userInitial)  // Command Replaced was o_C_STRING length was 5
C_TEXT:C284($BDept)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($town)  // Command Replaced was o_C_STRING length was 50
C_TEXT:C284($Item6; $Item7)  // Command Replaced was o_C_STRING length was 100
C_DATE:C307($Subdate_D)
//multiple bridges
If (PRJ_WRT_InList_b)
	$Recs:=Records in set:C195("UserSet")
Else 
	$Recs:=1
End if 
$bCreateLetter:=True:C214
READ ONLY:C145([Templates:86])
$sTemplateName:=WP_4WRTemplNameToWP($sTemplateName)
READ ONLY:C145([Templates:86])
QUERY:C277([Templates:86]; [Templates:86]TemplateName:2=$sTemplateName)
Case of 
	: ($Recs=0)
		ALERT:C41("No Projects selected!")
		$bCreateLetter:=False:C215
	: (Records in selection:C76([Templates:86])=0)
		ALERT:C41("Required Document Template <"+$sTemplateName+"> does not exist!")
		$bCreateLetter:=False:C215
	: ($Recs>20)
		CONFIRM:C162("Are you sure you want to include all the selected bridges in the letter?"; "Yes"; "No")
		If (Ok=1)
			$bCreateLetter:=True:C214
		Else 
			$bCreateLetter:=False:C215
		End if 
End case 

If ($bCreateLetter=True:C214)
	If (PRJ_WRT_InList_b)
		COPY NAMED SELECTION:C331([PRJ_ProjectDetails:115]; "PrePrintBrgList")
		C_LONGINT:C283($vlicount; $vlSelRecs; $vlUsrRecs)
		$vlSelRecs:=Records in selection:C76([PRJ_ProjectDetails:115])
		$vlUsrRecs:=Records in set:C195("UserSet")
		ARRAY LONGINT:C221($alRecIDS; $vlSelRecs)
		ARRAY LONGINT:C221($alURecIDs; $vlUsrRecs)
		ARRAY LONGINT:C221($alURecIDsSorted; $vlUsrRecs)
		LONGINT ARRAY FROM SELECTION:C647([PRJ_ProjectDetails:115]; $alRecIDs)
		USE SET:C118("UserSet")
		LONGINT ARRAY FROM SELECTION:C647([PRJ_ProjectDetails:115]; $alURecIDs)
		$vlicount:=1
		For ($i; 1; $vlSelRecs)
			If (Find in array:C230($alURecIDs; $alRecIDS{$i})>0)
				$alURecIDsSorted{$vlicount}:=$alRecIDS{$i}
				$vlicount:=$vlicount+1
			End if 
		End for 
		CREATE SELECTION FROM ARRAY:C640([PRJ_ProjectDetails:115]; $alURecIDsSorted)
		ARRAY LONGINT:C221($alRecIDS; 0)
		ARRAY LONGINT:C221($alURecIDs; 0)
		ARRAY LONGINT:C221($alURecIDsSorted; 0)
		CREATE SET:C116([PRJ_ProjectDetails:115]; "TempHilightSet")
	End if 
	
	//USE SET("UserSet")
	vToday:=Current date:C33(*)
	vAssignmentList:=""
	vAssignmentList1:=""
	Submissiondate_txt:=""
	town_txt:=""
	BridgeNum_txt:=""
	Vcclist:=""
	study_txt:=""
	C_BOOLEAN:C305($SameFileNum)
	C_LONGINT:C283($FirstFileNum)
	$SameFileNum:=True:C214
	$FirstFileNum:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
	If (PRJ_WRT_InList_b)
		FIRST RECORD:C50([PRJ_ProjectDetails:115])
		$FirstFileNum:=[PRJ_ProjectFile:117]PF_FileNumber_l:3
		QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
		
		NEXT RECORD:C51([PRJ_ProjectDetails:115])
		For ($i; 2; $Recs)
			QUERY:C277([PRJ_ProjectFile:117]; [PRJ_ProjectFile:117]PF_FileID_l:1=[PRJ_ProjectDetails:115]PF_FileID_l:3)
			If ([PRJ_ProjectFile:117]PF_FileNumber_l:3#$FirstFileNum)
				$SameFileNum:=False:C215
			End if 
			NEXT RECORD:C51([PRJ_ProjectDetails:115])
		End for 
		
	End if 
	
	If ($sTemplateName="WRTemplate_SketchPlanApproval_LTR")
		If (PRJ_WRT_InList_b)
			Submissiondate_txt:=String:C10(PRJ_LTR_SktchSubmDate)
		Else 
			If ([PRJ_SketchPlans:120]SKT_Recieved_d:5=!00-00-00!)
				C_BOOLEAN:C305($Done_b)
				$Done_b:=False:C215
				$Submissiondate_txt:=""
				Repeat 
					$Submissiondate_txt:=Request:C163("Enter date Sketch plans were received"; $Submissiondate_txt)
					Case of 
						: (Date:C102($Submissiondate_txt)=!00-00-00!)
							ALERT:C41("You entered an Invalid date! <"+$Submissiondate_txt+">")
						Else 
							$Submissiondate_txt:=String:C10(Date:C102($Submissiondate_txt))  // to make sure it is formated correctly
							CONFIRM:C162("Sketch plans received on "+$Submissiondate_txt; "OK"; "Try Again")
							If (OK=1)
								$Subdate_D:=Date:C102($Submissiondate_txt)
								If (ut_LoadRecordInteractive(->[PRJ_SketchPlans:120]))
									[PRJ_SketchPlans:120]SKT_Recieved_d:5:=$Subdate_D  // to save it also
									SAVE RECORD:C53([PRJ_SketchPlans:120])
								End if 
								$Done_b:=True:C214
							End if 
					End case 
					
				Until ($Done_b)
				
			Else 
			End if 
			Submissiondate_txt:=String:C10([PRJ_SketchPlans:120]SKT_Recieved_d:5)
		End if 
		
	End if 
	
	If ($SameFileNum=False:C215)
		ALERT:C41("Not all Project File numbers selected are the same!  Please select project with t"+"he same Project FIle number!")
	Else 
		If (PRJ_WRT_InList_b)
			FIRST RECORD:C50([PRJ_ProjectDetails:115])
		End if 
		For ($i; 1; $Recs)
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=[PRJ_ProjectDetails:115]PRJ_PrimaryBin_s:34)
			$town:=[Bridge MHD NBIS:1]Town Name:175
			
			$BDept:=Insert string:C231([Bridge MHD NBIS:1]BDEPT:1; "-"; 2)
			$BDept:=Insert string:C231($BDept; "-"; 5)
			If ([Bridge MHD NBIS:1]OnTwnLine:177=True:C214)
				C_TEXT:C284($otherBDept)  // Command Replaced was o_C_STRING length was 20
				RELATE MANY:C262([Bridge MHD NBIS:1]BIN:3)
				For ($j; 1; Records in selection:C76([TownLineInfo:73]))
					$otherBDept:=Insert string:C231([TownLineInfo:73]BDEPT:2; "-"; 2)
					$otherBDept:=Insert string:C231($otherBDept; "-"; 5)
					$BDept:=$BDept+" = "+$otherBDept
					$otherBDept:=""
				End for 
			End if 
			
			$Item6:=F_RemoveFeatIntCode([Bridge MHD NBIS:1]Item6A:63)
			$Item7:=F_RemoveFeatIntCode([Bridge MHD NBIS:1]Item7:65)
			
			Case of 
				: ($sTemplateName="WRtemplate_BridgeSketchPlan_LTR")  //Bridge sketch plan
					PRJ_LTR_BrgSketch_fill($i; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				: ($sTemplateName="WRtemplate_FHA_LTR")  //FHA Letter
					PRJ_LTR_FHA_fill($i; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				: ($sTemplateName="WRTemplate_PSEApp_LTR")  //
					PRJ_LTR_PSEAPP_fill($i; $town; $BDept; $Item7; $Item6; $FirstFileNum)
				: ($sTemplateName="WRtemplate_ReviewComment_LTR")  //Bridge skecth plan
					PRJ_LTR_RevwCmmt_fill($i; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				: ($sTemplateName="WRTemplate_SketchPlanApproval_LTR")  //Bridge skecth plan
					PRJ_LTR_BrgSketch_fill($i; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				: ($sTemplateName="WRTemplate_SketchplanComment_LTR")  //Bridge skecth plan
					PRJ_LTR_BrgSketch_fill($i; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				: ($sTemplateName="WRTemplate_TransToFHWAOfPSE_LTR")  //Bridge skecth plan
					PRJ_LTR_FHA_fill($i; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				: ($sTemplateName="WRTemplate_TypeStudyReport_LTR")  //Bridge skecth plan
					PRJ_LTR_RevwCmmt_fill($i; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
					
			End case 
			If (PRJ_WRT_InList_b)
				NEXT RECORD:C51([PRJ_ProjectDetails:115])
			End if 
		End for 
		
		Case of 
			: ($sTemplateName="WRtemplate_BridgeSketchPlan_LTR")  //Bridge sketch plan
				PRJ_LTR_BrgSketch_fill(0; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				PRJ_LTR_ConsAddr
				PRJ_LTR_MyInfo
				vToday:=PRJ_LTR_SKLTRToDE_d
			: ($sTemplateName="WRtemplate_FHA_LTR")  //Bridge skecth plan
				PRJ_LTR_FHA_fill(0; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
			: ($sTemplateName="WRTemplate_PSEApp_LTR")  //Bridge 
				PRJ_LTR_PSEAPP_fill(0; $town; $BDept; $Item7; $Item6; $FirstFileNum)
				PRJ_LTR_ConsAddr
				PRJ_LTR_MyInfo
			: ($sTemplateName="WRtemplate_ReviewComment_LTR")  //Bridge skecth plan
				PRJ_LTR_RevwCmmt_fill(0; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				PRJ_LTR_ConsAddr
				C_TEXT:C284(vReviewCount_txt)
				vReviewCount_txt:=F_AnglicizeOrder([PRJ_StructuralReview:119]SR_StructureReviewOrder_l:3)
				vToday:=PRJ_LTR_SKLTRToDE_d
			: ($sTemplateName="WRTemplate_SketchPlanApproval_LTR")  //Bridge skecth plan
				PRJ_LTR_BrgSketch_fill(0; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				PRJ_LTR_ConsAddr
				PRJ_LTR_MyInfo
				vToday:=PRJ_LTR_SKLTRToDE_d
			: ($sTemplateName="WRTemplate_SketchplanComment_LTR")  //Bridge skecth plan
				PRJ_LTR_BrgSketch_fill(0; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				PRJ_LTR_ConsAddr
				PRJ_LTR_MyInfo
				vToday:=PRJ_LTR_SKLTRToDE_d
			: ($sTemplateName="WRTemplate_TransToFHWAOfPSE_LTR")  //Bridge skecth plan
				PRJ_LTR_FHA_fill(0; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				PRJ_LTR_MyInfo
			: ($sTemplateName="WRTemplate_TypeStudyReport_LTR")  //Bridge skecth plan
				PRJ_LTR_RevwCmmt_fill(0; $town; $BDept; $Item7; $Item6; $FirstFileNum; $sTemplateName)
				PRJ_LTR_ConsAddr
				PRJ_LTR_MyInfo
				vToday:=PRJ_LTR_SKLTRToDE_d
		End case 
		
		If ($Recs>1)
			vPlural:="s"
		Else 
			vPlural:=""
		End if 
		
		town_txt:=$town
		If (BridgeNum_txt="")
			BridgeNum_txt:=$BDept
		End if 
		
		GetBridgeEngineer
		//GetPresvervationEngineer 
		GetStructReviewerInfo([PRJ_ProjectDetails:115]PRJ_CurrentStructutalPrjMgrID_l:39)
		$userInitial:=F_GetUserInitial(<>CurrentUser_Name)
		If ($userInitial="")
			vWriterInitial:="ENTER_WRITER_INITIAL"
		Else 
			vWriterInitial:=Uppercase:C13($userInitial)+"/"+Lowercase:C14($userInitial)
		End if 
		
		If ([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6#"")
			Vcclist:=f_TrimStr(Substring:C12([PRJ_ProjectFile:117]PF_ProjectExpediter_s:6; 1; (Position:C15(":"; [PRJ_ProjectFile:117]PF_ProjectExpediter_s:6)-1)); True:C214; True:C214)
		Else 
			Vcclist:="_"
		End if 
		
		Vcclist:="cc: "+Request:C163("Enter CC List"; Vcclist+", File")
		
		//````4D WR commands
		G_WP_MakeDocument
	End if 
	
	If (PRJ_WRT_InList_b)
		USE NAMED SELECTION:C332("PrePrintBrgList")
		CLEAR NAMED SELECTION:C333("PrePrintBrgList")
		HIGHLIGHT RECORDS:C656("TempHilightSet")
		CLEAR SET:C117("TempHilightSet")
		REDRAW WINDOW:C456
		
	End if 
End if   //matches If ($bCreateLetter=True)

vAssignmentList:=""
vAssignmentList1:=""
Submissiondate_txt:=""
town_txt:=""
BridgeNum_txt:=""
Vcclist:=""
study_txt:=""

READ WRITE:C146([Templates:86])