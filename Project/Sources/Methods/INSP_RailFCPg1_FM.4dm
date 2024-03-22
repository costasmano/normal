//%attributes = {"invisible":true}
// Method: INSP_RailFCPg1_FM
// Description
// method for printing the MBTA hwy / rail / transit fract crit / CMI forms
// 
// Parameters
// $1 : $FormEvent_L
// ----------------------------------------------------
If (False:C215)
	// User name (OS): Costas Manousakis
	// User name (4D): Designer
	// Date and time: 04/24/14, 12:13:47
	// ----------------------------------------------------
	// First Release
	Mods_2014_04
	// Modified by: Costas Manousakis-(Designer)-(5/14/14 15:26:00)
	Mods_2014_05
	//  `use method INSP_SetTransitRtgLabels - mainly for Transiit CMI, FCR inspections
	// Modified by: Costas Manousakis-(Designer)-(1/22/19 17:03:36)
	Mods_2019_01_bug
	//  `Use method INSP_IsElementLoadRated to check printing of rating loads or not. CallReference #598
	//  // moved creating $temparea outside of element loop - use select all / clear
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
End if 
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 
C_LONGINT:C283($i; $recnum; $count)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283($REMARKS_NUMBER)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_POINTER:C301($pMember; $pRemarks; $pPrevRat; $pRat; $pDef; $p)
C_LONGINT:C283($temparea)
ARRAY TEXT:C222($aDeficiency; 0)  // old _ O _ARRAY STRING length 5
ARRAY TEXT:C222($aPriority; 0)  // old _ O _ARRAY STRING length 2
C_TEXT:C284(vInspDatePrLbl; vElmtsPrLbl)  // old C_STRING length 80
C_TEXT:C284($vsItemi)  // old C_STRING length 255

Case of 
	: ($FormEvent_L=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		ARRAY TEXT:C222($ratingVarPref_atxt; 0)
		ARRAY POINTER:C280($ratingField_aptr; 0)
		C_LONGINT:C283($numRatings_L; $ratingLoop_L)
		$numRatings_L:=INSP_LoadElmRtgDefs(->$ratingVarPref_atxt; ->$ratingField_aptr)
		
		$REMARKS_NUMBER:=INSP_CountSpMbOnForm
		vInspTitlePr:=Uppercase:C13(G_Insp_SetTitle)
		G_Insp_FormatTitle
		INSP_KiloPtValues
		INSP_Item21Desc
		INSP_Item22Desc
		INSP_Item107Desc
		INSP_Item43Desc
		//change font if more than one Bdept number is to be printed.
		If (Length:C16(vItem26)>14)
			OBJECT SET FONT SIZE:C165(vItem26; 9)
		End if 
		INSP_Item43Desc("RESIZE")
		G_Insp_SetDirLbl([Inspections:27]OrientationNS:133)
		
		//ASL 4-24-03
		//Leave out Item 58 and 62 if this is a fracture critical inspection.
		Case of 
			: ([Inspections:27]Insp Type:6="FCR") | ([Inspections:27]Insp Type:6="RRF")
				OBJECT SET VISIBLE:C603(*; "Item58@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "Item61@"; False:C215)
				OBJECT SET VISIBLE:C603(*; "Item62@"; False:C215)
				OBJECT MOVE:C664(*; "Item59@"; 40; 0)
				OBJECT MOVE:C664(*; "Item60@"; 40; 0)
				OBJECT MOVE:C664(*; "lbl_PrevCondition"; 60; 0)
				OBJECT MOVE:C664(*; "lbl_CurCondition"; 60; 0)
				OBJECT MOVE:C664(*; "box_FieldTests"; 0; 0; 60; 0)
				OBJECT MOVE:C664([Inspections:27]FieldTests:104; 0; 0; 60; 0)
				vInspDatePrLbl:="93a - F.C. INSP. DATE"
				vElmtsPrLbl:="FRACTURE CRITICAL MEMBER(S):"
				
			: (([Inspections:27]Insp Type:6="CMI") | ([Inspections:27]Insp Type:6="RRS") | INSP_IsInspRoutine_b)
				OBJECT SET VISIBLE:C603(*; "Item61@"; False:C215)
				OBJECT MOVE:C664(*; "Item58@"; 28; 0)
				OBJECT MOVE:C664(*; "Item59@"; 28; 0)
				OBJECT MOVE:C664(*; "Item60@"; 28; 0)
				OBJECT MOVE:C664(*; "lbl_PrevCondition"; 28; 0)
				OBJECT MOVE:C664(*; "lbl_CurCondition"; 28; 0)
				OBJECT MOVE:C664(*; "box_FieldTests"; 0; 0; 28; 0)
				OBJECT MOVE:C664([Inspections:27]FieldTests:104; 0; 0; 28; 0)
				vInspDatePrLbl:="93*-SPEC. MEMB. INSP. DATE"
				vElmtsPrLbl:="SPECIAL MEMBER(S):"
				
			: ([Inspections:27]Insp Type:6="OTH") | ([Inspections:27]Insp Type:6="RRO")
				vInspDatePrLbl:="INSPECTION DATE"
				vElmtsPrLbl:="MEMBER(S):"
				
		End case 
		
		//Initialize Element variables....
		For ($i; 1; $REMARKS_NUMBER)
			$pRemarks:=Get pointer:C304("vRemarks0"+String:C10($i))
			$pMember:=Get pointer:C304("vMember0"+String:C10($i))
			$pPrevRat:=Get pointer:C304("vprevR0"+String:C10($i))
			$pRat:=Get pointer:C304("vR0"+String:C10($i))
			$pDef:=Get pointer:C304("vDEF0"+String:C10($i))
			$pRemarks->:=""
			$pMember->:=""
			$pPrevRat->:=""
			$pRat->:=""
			$pDef->:=""
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
			OBJECT SET VISIBLE:C603(*; ("NotRated "+String:C10($i)); False:C215)
		End for 
		
		//RELATE MANY([Inspections])
		//get only records that have a Rating not N
		//ASL 4/28/03 This was querying the AltRating instead
		//of the Rating
		//QUERY SELECTION([ElementsSafety];[ElementsSafety]Rating#"N")
		$recnum:=Records in selection:C76([ElementsSafety:29])
		//Sort by element no.
		//ORDER BY([ElementsSafety];[ElementsSafety]ElementNo;>)
		If ($recnum>0)
			SELECTION TO ARRAY:C260([ElementsSafety:29]Deficiency:3; $aDeficiency; [ElementsSafety:29]Priority:20; $aPriority)
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
		
		C_LONGINT:C283($ReturnLengthLimit_L)
		C_BOOLEAN:C305($fit_b)
		
		$ReturnLengthLimit_L:=INSP_ReturnCMLength
		$i:=1
		
		FIRST RECORD:C50([ElementsSafety:29])
		While (Not:C34(End selection:C36([ElementsSafety:29])))
			//RELATE ONE([ElementsSafety]ElementNo)
			//Added this to supercede the previous descriptions.      
			$vsItemi:=G_GetElmtLabel
			//Get the comments
			If ($i<=$REMARKS_NUMBER)
				$pRemarks:=Get pointer:C304("vRemarks0"+String:C10($i))
				If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
					INSP_ElemCommentsList_WP(New object:C1471("elemblob"; ->[ElementsSafety:29]ElmComments:23; \
						"charlimit"; $ReturnLengthLimit_L; "varpointer"; $pRemarks; \
						"notfit"; "See remarks in comments section."))
					
				End if 
				//
				$pMember:=Get pointer:C304("vMember0"+String:C10($i))
				$pPrevRat:=Get pointer:C304("vprevR0"+String:C10($i))
				$pRat:=Get pointer:C304("vR0"+String:C10($i))
				$pDef:=Get pointer:C304("vDEF0"+String:C10($i))
				$pMember->:=$vsItemi  //modified from above.
				If ([Inspections:27]Insp Type:6="T@")
					$fit_b:=ut_FitPrintFormObject($pMember; 11; 8)
				Else 
					Case of   //added this to fit text.
						: (Length:C16($pMember->)>34)
							OBJECT SET FONT SIZE:C165($pMember->; 8)
						: (Length:C16($pMember->)>29)
							OBJECT SET FONT SIZE:C165($pMember->; 9)
						: (Length:C16($pMember->)>27)
							OBJECT SET FONT SIZE:C165($pMember->; 10)
					End case 
					
				End if 
				$pPrevRat->:=[ElementsSafety:29]Rating_i:15
				$pRat->:=[ElementsSafety:29]Rating:2
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
					: (INSP_IsElementLoadRated(->$ratingField_aptr))
						For ($ratingLoop_L; 1; $numRatings_L)
							$p:=Get pointer:C304($ratingVarPref_atxt{$ratingLoop_L}+String:C10($i))
							$p->:=String:C10($ratingField_aptr{$ratingLoop_L}->; "#,##0;N;0")
						End for 
						
					Else 
						$p:=Get pointer:C304("vNotRated_"+String:C10($i))
						$p->:="Not Rated"
						OBJECT SET VISIBLE:C603(*; ("NotRated "+String:C10($i)); True:C214)
				End case 
				//  
			End if 
			$i:=$i+1
			NEXT RECORD:C51([ElementsSafety:29])
		End while 
		
		INSP_SetTransitRtgLabels([Inspections:27]Rating_RevCar_desc_s:220; [Inspections:27]Rating_WorkCar_desc_s:219)
		
		//ASL 4-25-03 Added Item 58
		vItem58Prev:=G_FormatItmRtg([Inspections:27]Item58_i:151)
		vItem59Prev:=G_FormatItmRtg([Inspections:27]Item59_i:143)
		vItem60Prev:=G_FormatItmRtg([Inspections:27]Item60_i:144)
		vItem61Prev:=G_FormatItmRtg([Inspections:27]Item61_i:173)  //added 2005-10-27
		vItem62Prev:=G_FormatItmRtg([Inspections:27]Item62_i:174)  //added 2004-01-08
		vItem58:=G_FormatItmRtg([Inspections:27]Item 58:79)
		vItem59:=G_FormatItmRtg([Inspections:27]Item 59:80)
		vItem60:=G_FormatItmRtg([Inspections:27]Item 60:81)
		vItem61:=G_FormatItmRtg([Inspections:27]Item 61:82)  //added 2005-10-27
		vItem62:=G_FormatItmRtg([Inspections:27]Item 62:113)  //added 2004-01-08
		
		vItem62a:=G_FormatItmRtg([TunnelInspection:152]Structural_Rtg_s:3)
		vItem62aPrev:=G_FormatItmRtg([TunnelInspection:152]Structural_Prev_Rtg_s:16)
		vItem62b:=G_FormatItmRtg([TunnelInspection:152]Roadway_Rtg_s:4)
		vItem62bPrev:=G_FormatItmRtg([TunnelInspection:152]Roadway_Prev_Rtg_s:17)
		vItem62c:=G_FormatItmRtg([TunnelInspection:152]Ceiling_Rtg_s:5)
		vItem62cPrev:=G_FormatItmRtg([TunnelInspection:152]Ceiling_Prev_Rtg_s:18)
		vItem62d:=G_FormatItmRtg([TunnelInspection:152]SupplyAirDuct_Rtg_s:6)
		vItem62dPrev:=G_FormatItmRtg([TunnelInspection:152]SupplyAirDuct_Prev_Rtg_s:19)
		vItem62e:=G_FormatItmRtg([TunnelInspection:152]CrossPassage_Rtg_s:7)
		vItem62ePrev:=G_FormatItmRtg([TunnelInspection:152]CrossPassage_Prev_Rtg_s:20)
		vItem62f:=G_FormatItmRtg([TunnelInspection:152]Egress_Rtg_s:8)
		vItem62fPrev:=G_FormatItmRtg([TunnelInspection:152]Egress_Prev_Rtg_s:21)
		vItem62g:=G_FormatItmRtg([TunnelInspection:152]UtilityRoom_Rtg_s:9)
		vItem62gPrev:=G_FormatItmRtg([TunnelInspection:152]UtilityRoom_Prev_Rtg_s:22)
		
		//Get the year rehab'd      
		vYrRehab:=[Inspections:27]YrRehab:158
		
		vPlans:=f_Boolean2String([Inspections:27]Plans:69; "YN")
		vVCR:=f_Boolean2String([Inspections:27]VCR:70; "YN")
		
		INSP_PR_RatgBlock
		
		G_Insp_SetDeptFont
		G_Insp_ApplyRev2_PR
		
End case 

//End INSP_RailFCPg1_FM