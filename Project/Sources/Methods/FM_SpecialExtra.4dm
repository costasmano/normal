//%attributes = {"invisible":true}
//Method: FM_SpecialExtra
//Description
//
// Parameters
If (False:C215)
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 05/21/13, 16:36:38
	//----------------------------------------------------
	
	Mods_2005_CM07
	Mods_2005_CM12
	Mods_2005_CM14
	Mods_2005_VN01
	// Modified by: costasmanousakis-(Designer)-(12/7/07 11:21:11)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(8/5/08 11:05:10)
	Mods_2008_CM_5404
	//  `Use method INSP_ElmtSfty_ItemNo 
	Mods_2011_06  // CJ Miller`06/20/11, 11:06:56      ` Type all local variables for v11
	Mods_2013_02  //r001 ` Allow for different headings on weights
	//Modified by: Charles Miller (2/14/13 15:09:02)
	Mods_2013_05  //r003 ` Add new tunnelextra special form
	//Modified by: Charles Miller (5/21/13 16:38:36)
	//used on form
	//Method: Form Method: [Inspections]SpecialExtra
	//Method: Form Method: [Inspections]TunnelSpecialExtra
	// Modified by: Costas Manousakis-(Designer)-(4/14/14 11:26:24)
	Mods_2014_04
	//  `use method INSP_CountSpMbOnForm top count the number of elements on the form
	// Modified by: Costas Manousakis-(Designer)-(5/2/14 14:44:46)
	Mods_2014_05
	//  `use method INSP_LoadElmRtgDefs to load the pointers for the load ratings;
	//  `use these pointer arrays to load the element data -
	//  `use INSP_ReturnCMLength to get the remarks length
	// Modified by: Costas Manousakis-(Designer)-(5/14/14 15:18:10)
	Mods_2014_05
	//  `use method INSP_SetTransitRtgLabels - mainly for Transiit CMI, FCR inspections
	// Modified by: Costas Manousakis-(Designer)-(1/8/15 14:23:21)
	Mods_2015_01
	//  `added TDA : tunnel damage for the Label
	// Modified by: Costas Manousakis-(Designer)-(11/25/19 17:18:49)
	Mods_2019_11_bug
	//  `Fix labeling of elements to be consistant with page 1 of the reports. 
	//  `All page 1 forms use G_GetElmtLabel - CallReference #673
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
End if 


C_LONGINT:C283($i; $recnum; $count; $REMARKS_NUMBER)  // **replaced _ o _C_INTEGER()
$REMARKS_NUMBER:=22
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$REMARKS_NUMBER:=$1
End if 
C_POINTER:C301($pMember; $pRemarks; $pPrevRat; $pRat; $pDef; $pLetter; $p)
C_LONGINT:C283($temparea)
ARRAY TEXT:C222($aPrevRating; 0)  // **Replaced old _ o _ARRAY STRING length 2
ARRAY TEXT:C222($aCurrentRating; 0)  // **Replaced old _ o _ARRAY STRING length 2
ARRAY TEXT:C222($aDeficiency; 0)  // **Replaced old _ o _ARRAY STRING length 5
ARRAY TEXT:C222($aPriority; 0)  // **Replaced old _ o _ARRAY STRING length 2

Case of 
		//3-3-03 ASL change events to form events    
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		$REMARKS_NUMBER:=INSP_CountSpMbOnForm
		ARRAY TEXT:C222($ratingVarPref_atxt; 0)
		ARRAY POINTER:C280($ratingField_aptr; 0)
		C_LONGINT:C283($numRatings_L; $ratingLoop_L)
		$numRatings_L:=INSP_LoadElmRtgDefs(->$ratingVarPref_atxt; ->$ratingField_aptr)
		
		INSP_SetWPHeadings
		$recnum:=Records in selection:C76([ElementsSafety:29])
		
		Case of 
			: ([Inspections:27]Insp Type:6="FCR")
				vElmtsPrLbl:="FRACTURE CRITICAL MEMBER(S):"
			: ([Inspections:27]Insp Type:6="DAM")
				vElmtsPrLbl:="DAMAGED MEMBER(S):"
			: ([Inspections:27]Insp Type:6="OTH")
				vElmtsPrLbl:="MEMBER(S):"
			: ([Inspections:27]Insp Type:6="RRF")
				vElmtsPrLbl:="FRACTURE CRITICAL MEMBER(S):"
			: ([Inspections:27]Insp Type:6="RRD")
				vElmtsPrLbl:="DAMAGED MEMBER(S):"
			: ([Inspections:27]Insp Type:6="TDA")
				vElmtsPrLbl:="DAMAGED MEMBER(S):"
				
			Else 
				vElmtsPrLbl:="SPECIAL MEMBER(S):"
		End case 
		
		If ($recnum>0)
			SELECTION TO ARRAY:C260([ElementsSafety:29]Rating_i:15; $aPrevRating)
			SELECTION TO ARRAY:C260([ElementsSafety:29]Rating:2; $aCurrentRating)
			SELECTION TO ARRAY:C260([ElementsSafety:29]Deficiency:3; $aDeficiency)
			SELECTION TO ARRAY:C260([ElementsSafety:29]Priority:20; $aPriority)
			//Modify defaults of def and prio ratings
			For ($i; 1; Size of array:C274($aDeficiency))
				//Remove spaces from Deficiency
				$aDeficiency{$i}:=Replace string:C233($aDeficiency{$i}; " "; "")
				//Remove spaces from Priority
				$aPriority{$i}:=Replace string:C233($aPriority{$i}; " "; "")
				If ($aDeficiency{$i}="N")
					$aDeficiency{$i}:="-"  //default display of no deficiency
				End if 
				If ($aPriority{$i}#"")
					$aDeficiency{$i}:=$aDeficiency{$i}+"-"+$aPriority{$i}  //if there is a prio combine def+prio
				End if 
			End for 
		End if 
		//Initialize  form element variables
		For ($i; 1; $REMARKS_NUMBER)
			$pMember:=Get pointer:C304("vMember"+String:C10($i))
			$pPrevRat:=Get pointer:C304("vprevR"+String:C10($i))
			$pRat:=Get pointer:C304("vR"+String:C10($i))
			$pDef:=Get pointer:C304("vDEF"+String:C10($i))
			$pRemarks:=Get pointer:C304("vRemarks"+String:C10($i))
			$pLetter:=Get pointer:C304("vLetter"+String:C10($i))
			$pMember->:=""
			$pPrevRat->:=""
			$pRat->:=""
			$pDef->:=""
			$pRemarks->:=""
			$pLetter->:=""
			$p:=Get pointer:C304("vCrack"+String:C10($i))
			$p->:=""
			$p:=Get pointer:C304("vWeld"+String:C10($i))
			$p->:=""
			For ($ratingLoop_L; 1; $numRatings_L)
				$p:=Get pointer:C304($ratingVarPref_atxt{$ratingLoop_L}+String:C10($i))
				$p->:=""
			End for 
			$p:=Get pointer:C304("vNotRated_"+String:C10($i))
			$p->:=""
			OBJECT SET VISIBLE:C603(*; "NotRated@"; False:C215)
		End for 
		
		$i:=1
		C_LONGINT:C283($ReturnLengthLimit_L)
		C_BOOLEAN:C305($fit_b)
		C_TEXT:C284($ElmRevCar_txt; $ElmWorkCar_txt)
		$ElmRevCar_txt:=""
		$ElmWorkCar_txt:=""
		
		$ReturnLengthLimit_L:=INSP_ReturnCMLength
		
		ARRAY TEXT:C222($aItem; $recnum)  // **Replaced old _ o _ARRAY STRING length 255
		ARRAY TEXT:C222($aElmMember; $recnum)  // **Replaced old _ o _ARRAY STRING length 255
		C_LONGINT:C283(vSpecMemStartLetter; $viStart)
		$viStart:=Character code:C91("A")+vSpecMemStartLetter
		FIRST RECORD:C50([ElementsSafety:29])
		While (Not:C34(End selection:C36([ElementsSafety:29])))
			RELATE ONE:C42([ElementsSafety:29]ElementNo:1)
			
			$aItem{$i}:=G_GetElmtLabel
			
			//Get the comments
			If ($i<=$REMARKS_NUMBER)
				$pLetter:=Get pointer:C304("vLetter"+String:C10($i))
				C_LONGINT:C283($vlLetterCode; $vlLetterCycle)
				$vlLetterCode:=$viStart+$i-1
				$vlLetterCycle:=($vlLetterCode-Character code:C91("A"))\26
				$vlLetterCode:=$vlLetterCode-(26*$vlLetterCycle)
				$pLetter->:=Char:C90($vlLetterCode)
				If ($vlLetterCycle>0)
					$pLetter->:=Char:C90($vlLetterCode)+String:C10($vlLetterCycle)
				End if 
				$pRemarks:=Get pointer:C304("vRemarks"+String:C10($i))
				If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
					INSP_ElemCommentsList_WP(New object:C1471("elemblob"; ->[ElementsSafety:29]ElmComments:23; \
						"charlimit"; <>vLimitCharDAM; "varpointer"; $pRemarks; \
						"notfit"; "See remarks in comments section."))
					
				Else 
					$pRemarks->:=""
				End if 
				$pMember:=Get pointer:C304("vMember"+String:C10($i))
				$pPrevRat:=Get pointer:C304("vprevR"+String:C10($i))
				$pRat:=Get pointer:C304("vR"+String:C10($i))
				$pDef:=Get pointer:C304("vDEF"+String:C10($i))
				//$pMember->:=$aItem{$i}+" "+$aElmMember{$i}
				$pMember->:=$aItem{$i}
				
				If ([Inspections:27]Insp Type:6="T@")
					$fit_b:=ut_FitPrintFormObject($pMember; 11; 8)
				Else 
					Case of   //added this to fit text.
						: (Length:C16($pMember->)>29)
							OBJECT SET FONT SIZE:C165($pMember->; 8)
						: (Length:C16($pMember->)>27)
							OBJECT SET FONT SIZE:C165($pMember->; 9)
						: (Length:C16($pMember->)>24)
							OBJECT SET FONT SIZE:C165($pMember->; 10)
					End case 
					
				End if 
				$pPrevRat->:=$aPrevRating{$i}
				$pRat->:=$aCurrentRating{$i}
				$pDef->:=$aDeficiency{$i}
				$p:=Get pointer:C304("vCrack"+String:C10($i))
				If ([ElementsSafety:29]Crack:9=True:C214)
					$p->:="Y"
				Else 
					$p->:="N"
				End if 
				$p:=Get pointer:C304("vWeld"+String:C10($i))
				$p->:=[ElementsSafety:29]Weld Condition:10
				QUERY:C277([ElmtRatingLoads:158]; [ElmtRatingLoads:158]ElmSafetyID:2=[ElementsSafety:29]ElmSafetyID:7)
				Case of 
					: ([ElementsSafety:29]Inv H20:11>=0)
						For ($ratingLoop_L; 1; $numRatings_L)
							$p:=Get pointer:C304($ratingVarPref_atxt{$ratingLoop_L}+String:C10($i))
							$p->:=String:C10($ratingField_aptr{$ratingLoop_L}->; "#,##0;N;0")
						End for 
					Else 
						$p:=Get pointer:C304("vNotRated_"+String:C10($i))
						$p->:="Not Rated"
						OBJECT SET VISIBLE:C603(*; ("NotRated "+String:C10($i)); True:C214)
				End case 
				
			End if 
			
			$i:=$i+1
			NEXT RECORD:C51([ElementsSafety:29])
		End while 
		
		INSP_SetTransitRtgLabels([Inspections:27]Rating_RevCar_desc_s:220; [Inspections:27]Rating_WorkCar_desc_s:219)
		
End case 
//End FM_SpecialExtra