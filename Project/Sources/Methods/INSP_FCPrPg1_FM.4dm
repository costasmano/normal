//%attributes = {"invisible":true}
// Method: INSP_FCPrPg1_FM
// Description
// Form Method for the FC page 1 form
// Copied from Form method
// Parameters
//$1 : $REMARKS_NUMBER - optional default is 5
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/10/07, 11:30:40
	// ----------------------------------------------------
	// 
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/23/2007 09:30:39)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(12/20/07 12:34:54)
	Mods_2007_CM_5401
	//  `Use the ◊ELMTDICT_@ arrays instead of relate many
	// Modified by: costasmanousakis-(Designer)-(3/28/08 14:35:03)
	Mods_2008_CM_5403  // Adjust the Kilo/Mile values
End if 
If (False:C215)
	//LO:[Inspections];"FC Pr (Pg 1)"
	//Load variables
	Mods_2004_CM11
	Mods_2005_CM05  //twice
	Mods_2005_CM14
	Mods_2005_VN01
	Mods_2005_VN03
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 16:06:04)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(2/17/2006 16:51:09)
	Mods_2006_CM03
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
	Mods_2013_02  //r001 ` Allow for different headings on weights
	//Modified by: Charles Miller (2/14/13 14:49:47)
	Mods_2013_05  //r003 `   Modify length that can fit in remarks based upon inspection type
	//Modified by: Charles Miller (5/7/13 16:40:49)
	// Modified by: Costas Manousakis-(Designer)-(5/22/13 16:35:51)
	Mods_2013_05
	//  `Added use of  ut_FitPrintFormObject for tunnel special member inspections
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	// Modified by: Costas Manousakis-(Designer)-(4/14/14 11:25:26)
	Mods_2014_04
	//  `use method INSP_CountSpMbOnForm top count the number of elements on the form
	// Modified by: Costas Manousakis-(Designer)-(8/11/14 12:05:38)
	Mods_2014_08
	//  `For Tunnel inspections there is no need to move any of the Previous/Current Item ratings
	// Modified by: Costas Manousakis-(Designer)-(1/6/15 16:28:36)
	Mods_2015_01
	//  `special case for TDA : tunnel damage inspection
	// Modified by: Costas Manousakis-(Designer)-(12/2/19 16:19:06)
	Mods_2019_12
	//  `Hide Weight posting block for Rail reports using FORM_HideEnclosedObjs
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
	// Modified by: Costas Manousakis-(Designer)-(2021-10-26T00:00:00 17:18:51)
	Mods_2021_10
	//  `call INSP_QCFillESignatures
End if 

C_LONGINT:C283($i; $recnum; $count)  // **replaced _ o _C_INTEGER()
C_LONGINT:C283($REMARKS_NUMBER)  // **replaced _ o _C_INTEGER()
$REMARKS_NUMBER:=5
If (Count parameters:C259=1)
	C_LONGINT:C283($1)
	$REMARKS_NUMBER:=$1
End if 
C_POINTER:C301($pMember; $pRemarks; $pPrevRat; $pRat; $pDef; $p)
C_LONGINT:C283($temparea)
ARRAY TEXT:C222($aDeficiency; 0)  // **Replaced old _ o _ARRAY STRING length 5
ARRAY TEXT:C222($aPriority; 0)  // **Replaced old _ o _ARRAY STRING length 2
C_TEXT:C284(vInspDatePrLbl; vElmtsPrLbl)  // **Replaced old C_STRING length 80
C_TEXT:C284($vsItemi)  // **Replaced old C_STRING length 255

Case of 
		//3-3-03 ASL change events to form events    
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		INSP_QCFillESignatures
		
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
			: ([Inspections:27]Insp Type:6="T@")
				//no changes needed for any Tunnel inspections
				
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
				//Leave out Item 61 for special memb or a typical routine & special member.
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
		
		//Hide WeightPosting block for Rail reports
		If ([Inspections:27]Insp Type:6="RR@")
			//OBJECT SET VISIBLE(*;"WP_@";False)
			FORM_HideEnclosedObjs("WTPostingArea"; Form all pages:K67:7)
		End if 
		
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
			$p:=Get pointer:C304("vH20_"+String:C10($i))
			$p->:=""
			$p:=Get pointer:C304("vTyp3_"+String:C10($i))
			$p->:=""
			$p:=Get pointer:C304("v3S2_"+String:C10($i))
			$p->:=""
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
		$ReturnLengthLimit_L:=INSP_ReturnCMLength
		
		$i:=1
		FIRST RECORD:C50([ElementsSafety:29])
		While (Not:C34(End selection:C36([ElementsSafety:29])))
			//RELATE ONE([ElementsSafety]ElementNo)
			//Added this to supercede the previous descriptions.      
			$vsItemi:=G_GetElmtLabel
			//Get the comments
			C_OBJECT:C1216($p_o)
			If ($i<=$REMARKS_NUMBER)
				$pRemarks:=Get pointer:C304("vRemarks0"+String:C10($i))
				If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
					$p_o:=New object:C1471("elemblob"; ->[ElementsSafety:29]ElmComments:23; \
						"charlimit"; $ReturnLengthLimit_L; "varpointer"; $pRemarks; \
						"notfit"; "See remarks in comments section.")
					INSP_ElemCommentsList_WP($p_o)
					
				End if 
				//
				$pMember:=Get pointer:C304("vMember0"+String:C10($i))
				$pPrevRat:=Get pointer:C304("vprevR0"+String:C10($i))
				$pRat:=Get pointer:C304("vR0"+String:C10($i))
				$pDef:=Get pointer:C304("vDEF0"+String:C10($i))
				$pMember->:=$vsItemi  //modified from above.
				If ([Inspections:27]Insp Type:6="T@")
					C_BOOLEAN:C305($fit_b)
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
				If ([ElementsSafety:29]Inv H20:11>=0)
					$p:=Get pointer:C304("vH20_"+String:C10($i))
					$p->:=String:C10([ElementsSafety:29]Inv H20:11; "##0;N;0")
					$p:=Get pointer:C304("vTyp3_"+String:C10($i))
					$p->:=String:C10([ElementsSafety:29]Inv Type 3:12; "##0;N;0")
					$p:=Get pointer:C304("v3S2_"+String:C10($i))
					$p->:=String:C10([ElementsSafety:29]Inv 3S2:13; "##0;N;0")
				Else 
					$p:=Get pointer:C304("vNotRated_"+String:C10($i))
					$p->:="Not Rated"
					OBJECT SET VISIBLE:C603(*; ("NotRated "+String:C10($i)); True:C214)
				End if 
				//  
			End if 
			$i:=$i+1
			NEXT RECORD:C51([ElementsSafety:29])
		End while 
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
		
		If ([Inspections:27]Insp Type:6="TDA")
			//Check boxes
			If ([Inspections:27]ClrPosting:49=True:C214)
				vClrPost:=""
				vBrClrSgnNE:=[Inspections:27]BrClrSignsNE:54
				vBrClrSgnSW:=[Inspections:27]BrClrSignsSW:55
				vAdClrSgnNE:=[Inspections:27]AdClrSignNE:56
				vAdClrSgnSW:=[Inspections:27]AdClrSignSW:57
			Else 
				vClrPost:="X"
				vBrClrSgnNE:=""
				vBrClrSgnSW:=""
				vAdClrSgnNE:=""
				vAdClrSgnSW:=""
			End if 
			vAccident:=f_Boolean2String([Inspections:27]AccidentRep:149; "YN")
			If (f_Insp_Revision1([Inspections:27]Insp Date:78))
				//for inspections after 'Date_1' just use the field.      
				vDamageCmts:=[Inspections:27]DamageCmtsPg1:132
			Else 
				//for inspections before 'Date_1'
				If (BLOB size:C605([Inspections:27]InspComments:171)>0)
					INSP_ElemCommentsList_WP(New object:C1471("elemblob"; ->[Inspections:27]InspComments:171; \
						"charlimit"; 350; "varpointer"; ->vDamageCmts; \
						"notfit"; "See General Comments."))
					
					If (vPageNo>1)
						//don't repeat comments
						vDamageCmts:=""
					End if 
				Else 
					vDamageCmts:=""
				End if 
			End if 
			
			vDam_Boston_Date:=Uppercase:C13(String:C10([Inspections:27]Dam_Boston_Office_Date:184; Internal date short:K1:7))
			If ([Inspections:27]Dam_Boston_Office_Date:184=!00-00-00!)
				vDam_Boston_Date:=""
			End if 
			
		End if 
		
		INSP_PR_RatgBlock
		
		G_Insp_SetDeptFont
		G_Insp_ApplyRev2_PR
End case 