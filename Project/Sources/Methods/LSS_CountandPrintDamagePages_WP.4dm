//%attributes = {"invisible":true}
//Method: LSS_CountandPrintDamagePages_WP
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/09/21, 19:01:25
	// ----------------------------------------------------
	//Created : 
	Mods_2021_WP
	
	C_LONGINT:C283(LSS_CountandPrintDamagePages_WP; $1)
	
	// Modified by: manousakisc-(Designer)-(3/15/2024 15:03:57)
	Mods_2024_03_bug
	//  `use open / close printing job to control if user cancels out of selecting a file on 
	//  `the ms print to pdf save dialog,
End if 
//
C_POINTER:C301($Variable_ptr)

C_LONGINT:C283($1; $Page1ElementCount_L; $Loop_L)
$Page1ElementCount_L:=$1

C_TEXT:C284($Page1Form_txt; $Page2Form_txt)

Case of 
	: ([LSS_Inventory:165]LSS_Category_s:2="Sign") | ([LSS_Inventory:165]LSS_InventoryType_s:28="HS")
		TemplateMIN_Sin_txt:="HIN"
		$Page1Form_txt:="StructureDamage_HS_P1"
		$Page2Form_txt:="SignStructurePg2"
	: ([LSS_Inventory:165]LSS_Category_s:2="Light") | ([LSS_Inventory:165]LSS_InventoryType_s:28="LI")
		TemplateMIN_Sin_txt:="LIN"
		$Page2Form_txt:="LightStructurePg2"
		$Page1Form_txt:="StructureDamage_Light_P1"
	: ([LSS_Inventory:165]LSS_Category_s:2="Signal") | ([LSS_Inventory:165]LSS_InventoryType_s:28="SI")
		TemplateMIN_Sin_txt:="SIN"
		$Page1Form_txt:="StructureDamage_TS_P1"
		$Page2Form_txt:="TrafficSignalStructurePg2"
	: ([LSS_Inventory:165]LSS_Category_s:2="ITS") | ([LSS_Inventory:165]LSS_InventoryType_s:28="IT")
		TemplateMIN_Sin_txt:="IIN"
		$Page1Form_txt:="StructureDamage_ITS_P1"
		$Page2Form_txt:="ITSStructurePg2"
End case 
C_REAL:C285($NTEPages_r)
C_LONGINT:C283($ElementPages_L)

If (Size of array:C274(v_163_002_aL)<=$Page1ElementCount_L)
	$ElementPages_L:=0
Else 
	C_LONGINT:C283($pos_L; $Start_L; $RecordCountToUse_L)
	$RecordCountToUse_L:=Size of array:C274(v_163_002_aL)-$Page1ElementCount_L
	$NTEPages_r:=($RecordCountToUse_L/22)
	If ($RecordCountToUse_L%22=0)
		$ElementPages_L:=Trunc:C95($NTEPages_r; 0)
	Else 
		$ElementPages_L:=Trunc:C95($NTEPages_r; 0)+1
	End if 
End if 
vTotalPages:=$ElementPages_L+2  //Add in first page
C_LONGINT:C283($SketchCount_L; $ChartCount_L; $PhotoCount_L)
//Get number of image pages

SET QUERY DESTINATION:C396(Into set:K19:2; "LSS_SketchSet")
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1; *)
QUERY:C277([LSS_Photos:166];  & ; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch")
$SketchCount_L:=Records in set:C195("LSS_SketchSet")

SET QUERY DESTINATION:C396(Into set:K19:2; "LSS_ChartSet")
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1; *)
QUERY:C277([LSS_Photos:166];  & ; [LSS_Photos:166]LSS_PhotoType_s:3="Chart")
$ChartCount_L:=Records in set:C195("LSS_ChartSet")

SET QUERY DESTINATION:C396(Into set:K19:2; "LSS_InspectionPhotoSet")
QUERY:C277([LSS_Photos:166]; [LSS_Photos:166]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)

SET QUERY DESTINATION:C396(Into set:K19:2; "DMeterPhotoSet")
USE SET:C118("LSS_InspectionPhotoSet")
QUERY SELECTION:C341([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch D Meter")
SET QUERY DESTINATION:C396(Into set:K19:2; "UMeterPhotoSet")
USE SET:C118("LSS_InspectionPhotoSet")
QUERY SELECTION:C341([LSS_Photos:166]; [LSS_Photos:166]LSS_PhotoType_s:3="Sketch UT")
DIFFERENCE:C122("LSS_InspectionPhotoSet"; "DMeterPhotoSet"; "LSS_InspectionPhotoSet")
DIFFERENCE:C122("LSS_InspectionPhotoSet"; "UMeterPhotoSet"; "LSS_InspectionPhotoSet")
DIFFERENCE:C122("LSS_InspectionPhotoSet"; "LSS_ChartSet"; "LSS_InspectionPhotoSet")
DIFFERENCE:C122("LSS_InspectionPhotoSet"; "LSS_SketchSet"; "LSS_InspectionPhotoSet")

$PhotoCount_L:=Records in set:C195("LSS_InspectionPhotoSet")

C_BOOLEAN:C305($SkipPhotoLog_B)
$SkipPhotoLog_B:=(Records in set:C195("LSS_InspectionPhotoSet")=0)

SET QUERY DESTINATION:C396(Into current selection:K19:1)
vTotalPages:=vTotalPages+Round:C94(($PhotoCount_L/2); 0)

vTotalPages:=vTotalPages+$SketchCount_L

vTotalPages:=vTotalPages+$ChartCount_L

C_LONGINT:C283($DMeterCount_L; $UTCount_L; $UTRodCount_L; $numExtraRods_L; $numExtraPgs_L)

SET QUERY DESTINATION:C396(Into variable:K19:4; $DMeterCount_L)
QUERY:C277([LSS_DMeter:161]; [LSS_DMeter:161]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)  //missing

If ($DMeterCount_L>0)  //Add dmeter count assume all fits on one page for now
	vTotalPages:=vTotalPages+1
End if 

READ ONLY:C145([LSS_UT:175])
QUERY:C277([LSS_UT:175]; [LSS_UT:175]LSS_InspectionId_s:2=[LSS_Inspection:164]LSS_InspectionId_s:1)
$UTCount_L:=0
If (Records in selection:C76([LSS_UT:175])>0)
	C_LONGINT:C283($UTRodCount_L; $numExtraPgs_L; $numExtraRods_L)
	FIRST RECORD:C50([LSS_UT:175])
	While (Not:C34(End selection:C36([LSS_UT:175])))
		SET QUERY DESTINATION:C396(Into variable:K19:4; $UTRodCount_L)
		QUERY:C277([LSS_UtResult:176]; [LSS_UtResult:176]LSS_UTId_s:2=[LSS_UT:175]LSS_UTId_s:1)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($UTRodCount_L>11)
			$numExtraRods_L:=$UTRodCount_L-11
			$numExtraPgs_L:=($numExtraRods_L\18)
			If (($numExtraPgs_L*18)<$numExtraRods_L)
				$numExtraPgs_L:=$numExtraPgs_L+1
			End if 
			$UTCount_L:=$UTCount_L+1+$numExtraPgs_L
		Else 
			$UTCount_L:=$UTCount_L+1
		End if 
		
		NEXT RECORD:C51([LSS_UT:175])
	End while 
	
End if 
LSS_CountingPage_B:=True:C214
vTotalPages:=vTotalPages+$UTCount_L

//start of changes Mods_2024_03_bug 
OPEN PRINTING JOB:C995

If (OK=1)  //user could abort printing on first page when printing to pdf
	
	//end of changes Mods_2024_03_bug 
	
	//CLEAR VARIABLE(LSS_ElementHeaderNo_atxt)
	Print form:C5([LSS_Inspection:164]; $Page1Form_txt)
	
	C_TEXT:C284($DHeader_txt; $RHeader_txt; $Header_txt)
	$DHeader_txt:=""
	$RHeader_txt:=""
	$DHeader_txt:=ST Get plain text:C1092(v_164_056_txt)
	$DSeeCommentsPos_L:=Position:C15("See REMARKS"; $DHeader_txt)
	$RHeader_txt:=ST Get plain text:C1092(v_164_059_txt)
	$RSeeCommentsPos_L:=Position:C15("See REMARKS"; $RHeader_txt)
	
	C_LONGINT:C283($DSeeCommentsPos_L; $RSeeCommentsPos_L)
	C_OBJECT:C1216($WPArea_; $ImageLogArea_)
	$WPArea_:=INSP_InitializeWPArea(New object:C1471("templateType"; "Normal"))
	$ImageLogArea_:=INSP_InitializeWPArea(New object:C1471("templateType"; "Normal"))
	
	If (([LSS_Inspection:164]LSS_GeneralComments_txt:32="")\
		 & ([LSS_Inspection:164]LSS_AdditionalComments_txt:38="")\
		 & (Size of array:C274(LSS_ElementRemarks_atxt)=0)\
		 & ($DSeeCommentsPos_L=0)\
		 & ($RSeeCommentsPos_L=0))
	Else 
		vInspFontName:="Arial"
		vInspFontSize:=11
		vbTopOfPage:=True:C214
		If ([LSS_Inspection:164]LSS_GeneralComments_txt:32#"")
			INSP_AddTextToArea_WP($WPArea_; "GENERAL REMARKS"; [LSS_Inspection:164]LSS_GeneralComments_txt:32)
		End if 
		C_LONGINT:C283($Start_L; $HeaderPos_L)
		$Start_L:=0
		
		If (Position:C15("See REMARKS"; $DHeader_txt)>0)  //cause of damage
			INSP_AddTextToArea_WP($WPArea_; "CAUSE OF DAMAGE :"; [LSS_Inspection:164]LSS_DamageCause_txt:56)
		End if 
		
		If (Position:C15("See REMARKS"; $RHeader_txt)>0)  //recommendions
			INSP_AddTextToArea_WP($WPArea_; "RECOMMENDATIONS :"; [LSS_Inspection:164]LSS_Recommendations_txt:26)
		End if 
		$Header_txt:=""
		Repeat 
			$Loop_L:=Find in array:C230(LSS_AddtoCommentsPAGE_AB; True:C214; $Start_L)
			If ($Loop_L>0)
				If ($Header_txt#v_163_007_atxt{LSS_HeaderPosition_aL{$loop_L}})
					$Header_txt:=v_163_007_atxt{LSS_HeaderPosition_aL{$loop_L}}
					LSS_AddHeader_WP($WPArea_; $Header_txt; LSS_ElementHeader_ab{$Loop_L}; $Loop_L; ->v_163_008_atxt)
				Else 
					LSS_AddHeader_WP($WPArea_; v_163_007_atxt{$loop_L}; LSS_ElementHeader_ab{$loop_L}; $Loop_L; ->v_163_008_atxt)
				End if 
				$Start_L:=$Loop_L+1
			End if 
			
		Until ($Loop_l<0)
		If ([LSS_Inspection:164]LSS_AdditionalComments_txt:38#"")
			INSP_AddTextToArea_WP($WPArea_; Uppercase:C13("Additional Comments"); [LSS_Inspection:164]LSS_AdditionalComments_txt:38)
		End if 
		
		vTotalPages:=vTotalPages+WP Get page count:C1412($WPArea_)
	End if 
	
	If (Not:C34($SkipPhotoLog_B))
		
		ARRAY TEXT:C222($PhotoDescription_atxt; 0)
		ARRAY TEXT:C222($PhotoType_atxt; 0)
		ARRAY LONGINT:C221($PhotoSeq_aL; 0)
		C_TEXT:C284($ID_txt; $PhotoType_txt)
		
		LSS_ReturnPhotoComments(->$PhotoSeq_aL; ->$PhotoDescription_atxt; ->$PhotoType_atxt; [LSS_Inspection:164]LSS_InspectionId_s:1)
		ARRAY LONGINT:C221($SortPosition_aL; 0)
		ARRAY LONGINT:C221($SortPosition_aL; Size of array:C274($PhotoDescription_atxt))
		ARRAY TEXT:C222($PhototTitle_atxt; 0)
		ARRAY TEXT:C222($PhototTitle_atxt; Size of array:C274($PhotoDescription_atxt))
		
		For ($Loop_L; Size of array:C274($PhotoType_atxt); 1; -1)
			Case of 
				: ($PhotoType_atxt{$Loop_L}="Sketch")
					$SortPosition_aL{$Loop_L}:=1
					
				: ($PhotoType_atxt{$Loop_L}="Chart")
					$SortPosition_aL{$Loop_L}:=2
					
				: ($PhotoType_atxt{$Loop_L}="Sketch D Meter")
					DELETE FROM ARRAY:C228($PhotoSeq_aL; $Loop_L; 1)
					DELETE FROM ARRAY:C228($PhotoDescription_atxt; $Loop_L; 1)
					DELETE FROM ARRAY:C228($PhotoType_atxt; $Loop_L; 1)
					DELETE FROM ARRAY:C228($SortPosition_aL; $Loop_L; 1)
					
				: ($PhotoType_atxt{$Loop_L}="Sketch UT")
					DELETE FROM ARRAY:C228($PhotoSeq_aL; $Loop_L; 1)
					DELETE FROM ARRAY:C228($PhotoDescription_atxt; $Loop_L; 1)
					DELETE FROM ARRAY:C228($PhotoType_atxt; $Loop_L; 1)
					DELETE FROM ARRAY:C228($SortPosition_aL; $Loop_L; 1)
				Else 
					$SortPosition_aL{$Loop_L}:=3
					
			End case 
			
			
		End for 
		MULTI SORT ARRAY:C718($SortPosition_aL; >; $PhotoSeq_aL; >; $PhotoDescription_atxt; $PhotoType_atxt)
		C_TEXT:C284($PhotoList_txt; $PhotoTitle_txt)
		$PhotoList_txt:=""
		For ($Loop_L; 1; Size of array:C274($PhotoDescription_atxt))
			
			If ($Loop_L<Size of array:C274($PhotoDescription_atxt))
				$PhotoList_txt:=$PhotoList_txt+$PhotoType_atxt{$Loop_L}+" "+String:C10($PhotoSeq_aL{$Loop_L})+" : "+<>sTAB+$PhotoDescription_atxt{$Loop_L}+<>sCR
			Else 
				$PhotoList_txt:=$PhotoList_txt+$PhotoType_atxt{$Loop_L}+" "+String:C10($PhotoSeq_aL{$Loop_L})+" : "+<>sTAB+$PhotoDescription_atxt{$Loop_L}
			End if 
		End for 
		
		INSP_AddTextToArea_WP($ImageLogArea_; ""; $PhotoList_txt; "-2.5cm")
		
		C_LONGINT:C283($PhotoPages_L)
		$PhotoPages_L:=WP Get page count:C1412($ImageLogArea_)
		vTotalPages:=vTotalPages+$PhotoPages_L
		
	End if 
	LSS_CountingPage_B:=False:C215
	
	Print form:C5([LSS_Inspection:164]; $Page1Form_txt)
	Print form:C5([LSS_Inspection:164]; $Page2Form_txt)
	
	ARRAY LONGINT:C221($v_163_002_aL; 0)
	For ($loop_l; $Page1ElementCount_L+1; Size of array:C274(v_163_002_aL))
		
		APPEND TO ARRAY:C911($v_163_002_aL; v_163_002_aL{$Loop_L})
	End for 
	
	If (Size of array:C274($v_163_002_aL)>0)  //Print special Member page or pages
		C_LONGINT:C283(vSpecMemStartLetter)
		vSpecMemStartLetter:=$Page1ElementCount_L
		C_LONGINT:C283($NumberOfRecords_L; $GroupCount_L)
		$NumberOfRecords_L:=Size of array:C274(LSS_AddtoCommentsPAGE_AB)-$Page1ElementCount_L
		Case of 
			: ($NumberOfRecords_L=0)
				$GroupCount_L:=0
			: ($NumberOfRecords_L<=22)
				$GroupCount_L:=1
			Else 
				$GroupCount_L:=-(Trunc:C95(-(($NumberOfRecords_L-22)/22); 0))
				$GroupCount_L:=$GroupCount_L+1
		End case 
		C_LONGINT:C283($j; $k)
		$k:=0
		C_LONGINT:C283($GroupLoop_L)
		
		If ($GroupCount_L>=1)
			
			C_LONGINT:C283(vSpecMemStartLetter; $viStart)
			$viStart:=Character code:C91("A")+vSpecMemStartLetter
			$i:=1
			
			For ($GroupLoop_L; 1; $GroupCount_L)
				LSS_ClearSpecialMemberVariables(22)
				If ($GroupLoop_L>2)
					vSpecMemStartLetter:=vSpecMemStartLetter+22
				End if 
				$k:=0
				ARRAY LONGINT:C221($ElementGroup_aL; 0)
				For ($j; 1; 22)
					$k:=$k+1
					Case of 
						: (Size of array:C274($v_163_002_aL)=0)
							$j:=23
						: ($k<=$NumberOfRecords_L)
							APPEND TO ARRAY:C911($ElementGroup_aL; $v_163_002_aL{1})
							DELETE FROM ARRAY:C228($v_163_002_aL; 1; 1)
						Else 
							$j:=23  //get out
							
					End case 
				End for 
				C_BOOLEAN:C305($Complete_B)
				$Complete_B:=False:C215
				ARRAY BOOLEAN:C223($PrintOnextras_aB; 0)
				CLEAR VARIABLE:C89($PrintOnextras_aB)
				ARRAY BOOLEAN:C223($PrintOnExtras_aB; Size of array:C274(v_163_002_aL))
				C_LONGINT:C283($Position_L)
				For ($j; 1; Size of array:C274($ElementGroup_aL))
					$Position_L:=Find in array:C230(v_163_002_aL; $ElementGroup_aL{$j})
					If ($Position_L>0)
						
						$PrintOnExtras_aB{$Position_L}:=True:C214
					End if 
					
				End for 
				
				vPageNo:=vPageNo+1
				C_LONGINT:C283($REMARKS_NUMBER; $i; $recnum)
				$REMARKS_NUMBER:=22
				
				$k:=0
				$j:=1
				C_POINTER:C301($pLetter)
				Repeat 
					$Position_L:=Find in array:C230($PrintOnExtras_aB; True:C214; $k)
					If ($Position_L>0)
						$k:=$Position_L+1
						$pLetter:=Get pointer:C304("vLetter"+String:C10($j))
						C_LONGINT:C283($vlLetterCode; $vlLetterCycle)
						$vlLetterCode:=$viStart+$i-1
						$vlLetterCycle:=($vlLetterCode-Character code:C91("A"))\26
						$vlLetterCode:=$vlLetterCode-(26*$vlLetterCycle)
						$pLetter->:=Char:C90($vlLetterCode)
						If ($vlLetterCycle>0)
							$pLetter->:=Char:C90($vlLetterCode)+String:C10($vlLetterCycle)
						End if 
						
						LSS_FillElementMemberLines($Position_L; $j)
						$i:=$i+1
						$j:=$j+1
					End if 
					
				Until ($Position_L<0)
				
				Print form:C5([LSS_Inspection:164]; "StructureDamageMoreMembers")
				PAGE BREAK:C6(>)
			End for 
		End if 
		
	End if 
	C_LONGINT:C283($CommentPages_L; $PhotoPages_L)
	//Print comments pages
	C_OBJECT:C1216($wpbody)
	$wpbody:=WP Text range:C1341($WPArea_; wk start text:K81:165; wk end text:K81:164)
	
	If ($wpbody.start=$wpbody.end)
	Else 
		C_OBJECT:C1216($pipParamObj)
		$pipParamObj:=wrpPrintInPartsNewParamObj
		$pipParamObj.isOpenPrintingJob:=False:C215  // True=OpenPrintingJobIsGiven , False=NoOpenPrintingJobIsGiven
		
		// typical pages
		$pipParamObj.firstPageFormName:="LSS_Comments_WP"
		$pipParamObj.firstPageFormTable:=Table:C252(->[LSS_Inspection:164])
		$pipParamObj.PagesFormName:="LSS_Comments_WP"
		$pipParamObj.PagesFormTable:=Table:C252(->[LSS_Inspection:164])
		wrpCustomPrintParts($WPArea_; $pipParamObj)
		
	End if 
	
	If ($DMeterCount_L>0)
		//Add print [LSS_DMeter]
		LSS_PrintDMeter(($UTCount_L=0) & $SkipPhotoLog_B)
	End if 
	
	If ($UTCount_L>0)
		//Add print [LSS_UT]
		LSS_PrintUT(Not:C34($SkipPhotoLog_B))
	End if 
	
	If (Not:C34($SkipPhotoLog_B))
		
		C_OBJECT:C1216($pipParamObj)
		$pipParamObj:=wrpPrintInPartsNewParamObj
		$pipParamObj.isOpenPrintingJob:=False:C215  // True=OpenPrintingJobIsGiven , False=NoOpenPrintingJobIsGiven
		
		// typical pages
		$pipParamObj.firstPageFormName:="LSS_PhotoLog_WP"
		$pipParamObj.firstPageFormTable:=Table:C252(->[LSS_Inspection:164])
		$pipParamObj.PagesFormName:="LSS_PhotoLog_WP"
		$pipParamObj.PagesFormTable:=Table:C252(->[LSS_Inspection:164])
		wrpCustomPrintParts($ImageLogArea_; $pipParamObj)
		
	End if 
	
	C_LONGINT:C283($PhotoCount_L; $ChartCount_L; $SketchCount_L)
	C_BOOLEAN:C305($HaveMorePages_B)
	
	$HaveMorePages_B:=($PhotoCount_L>0) | ($ChartCount_L>0) | ($SketchCount_L>0)
	If ($HaveMorePages_B)
		DIFFERENCE:C122("LSS_InspectionPhotoSet"; "LSS_ChartSet"; "LSS_InspectionPhotoSet")
		DIFFERENCE:C122("LSS_InspectionPhotoSet"; "LSS_SketchSet"; "LSS_InspectionPhotoSet")
		LSS_PrintPhoto(True:C214)
	Else 
		PAGE BREAK:C6
	End if 
	
	//start of changes Mods_2024_03_bug 
	
End if 

CLOSE PRINTING JOB:C996
//end of changes Mods_2024_03_bug 

CLEAR SET:C117("LSS_InspectionPhotoSet")
CLEAR SET:C117("LSS_ChartSet")
CLEAR SET:C117("LSS_SketchSet")

UNLOAD RECORD:C212([LSS_Inspection:164])

REDRAW WINDOW:C456

//End LSS_CountandPrintDamagePages_WP