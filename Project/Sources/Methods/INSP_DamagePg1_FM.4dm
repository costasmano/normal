//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/10/07, 11:33:04
	// ----------------------------------------------------
	// Method: INSP_DamagePg1_FM
	// Description
	// Form Method for the Damage Page 1
	// Copied from the form method
	// Parameters
	// ----------------------------------------------------
	//Copied from [Inspections];"Damage Pg1"
	Mods_2007_CM07
	// Modified by: costasmanousakis-(Designer)-(8/22/2007 15:49:09)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(10/25/2007 08:50:44)
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(3/28/08 15:05:41)
	Mods_2008_CM_5403  //adjust Kilo/Mile display values
	// Modified by: costasmanousakis-(Designer)-(8/5/08 11:05:10)
	Mods_2008_CM_5404
	//  `Use method INSP_ElmtSfty_ItemNo 
	
	//[Inspections];"DamagePg1_v2"
	
	// Date and time: 04/09/07
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
	Mods_2013_02  //r001 ` Allow for different headings on weights
	//Modified by: Charles Miller (2/14/13 15:05:49)
	// Modified by: Costas Manousakis-(Designer)-(12/2/19 16:19:06)
	Mods_2019_12
	//  `Hide Weight posting block for Rail Damage reports using FORM_HideEnclosedObjs
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
End if 

C_LONGINT:C283($i; $recnum; $count)  // **replaced _ o _C_INTEGER()
C_LONGINT:C283($REMARKS_NUMBER)  // **replaced _ o _C_INTEGER()
$REMARKS_NUMBER:=3
C_POINTER:C301($pMember; $pRemarks; $pPrevRat; $pRat; $pDef; $p)
C_LONGINT:C283($temparea)
ARRAY TEXT:C222($aPrevRating; 0)  // **Replaced old _ o _ARRAY STRING length 2
ARRAY TEXT:C222($aCurrentRating; 0)  // **Replaced old _ o _ARRAY STRING length 2
ARRAY TEXT:C222($aDeficiency; 0)  // **Replaced old _ o _ARRAY STRING length 5
ARRAY TEXT:C222($aPriority; 0)  // **Replaced old _ o _ARRAY STRING length 2
C_TEXT:C284(vDam_Boston_Date)  // **Replaced old C_STRING length 255
C_TEXT:C284(vAccident)  // **Replaced old C_STRING length 1
C_TEXT:C284(vDamageCmts)
C_TEXT:C284(vItem26)  // **Replaced old C_STRING length 23

Case of 
		//3-3-03 ASL change events to form events    
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		INSP_SetWPHeadings
		G_Insp_SetDirLbl([Inspections:27]OrientationNS:133)
		INSP_KiloPtValues
		//Item21 and 22 - added 4/1/04 (redefine on print form)    
		INSP_Item21Desc
		INSP_Item22Desc
		INSP_Item107Desc
		INSP_Item43Desc
		
		//Hide WeightPosting block for Rail reports
		If ([Inspections:27]Insp Type:6="RR@")
			FORM_HideEnclosedObjs("WTPostingArea"; Form all pages:K67:7)
		End if 
		//change font if more than one Bdept number is to be printed.
		//Adjust Fonts and fields.
		vItem26:=Get_Description(-><>aFC; -><>aFC_Cod; ->[Inspections:27]Item26:200)
		If (Length:C16(vItem26)>14)
			OBJECT SET FONT SIZE:C165(vItem26; 9)
		End if 
		INSP_Item43Desc("Resize")
		G_Insp_FmtSTOWN
		
		If (f_Insp_Revision1([Inspections:27]Insp Date:78))
			//for inspections after 'Date_1' just use the field.      
			vDamageCmts:=[Inspections:27]DamageCmtsPg1:132
		Else 
			//for inspections before 'Date_1'
			If (BLOB size:C605([Inspections:27]InspComments:171)>0)
				INSP_ElemCommentsList_WP(New object:C1471("elemblob"; ->[Inspections:27]InspComments:171; \
					"charlimit"; 350; "varpointer"; ->vDamageCmts; "notfit"; "See General Comments."))
				
				If (vPageNo>1)
					//don't repeat comments
					vDamageCmts:=""
				End if 
			Else 
				vDamageCmts:=""
			End if 
		End if 
		
		//get only records that have a Rating not N
		//ASL 4/28/03 This was querying the AltRating instead
		//of the Rating
		//QUERY SELECTION([ElementsSafety];[ElementsSafety]Rating#"N")
		$recnum:=Records in selection:C76([ElementsSafety:29])
		//Sort by element no.
		//ORDER BY([ElementsSafety];[ElementsSafety]ElementNo;>)
		If ($recnum>0)
			SELECTION TO ARRAY:C260([ElementsSafety:29]Rating_i:15; $aPrevRating; [ElementsSafety:29]Rating:2; $aCurrentRating; [ElementsSafety:29]Deficiency:3; $aDeficiency; [ElementsSafety:29]Priority:20; $aPriority)
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
			$pMember:=Get pointer:C304("vMember0"+String:C10($i))
			$pPrevRat:=Get pointer:C304("vprevR0"+String:C10($i))
			$pRat:=Get pointer:C304("vR0"+String:C10($i))
			$pDef:=Get pointer:C304("vDEF0"+String:C10($i))
			$pRemarks:=Get pointer:C304("vRemarks0"+String:C10($i))
			$pMember->:=""
			$pPrevRat->:=""
			$pRat->:=""
			$pDef->:=""
			$pRemarks->:=""
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
			OBJECT SET VISIBLE:C603(*; "NotRated@"; False:C215)
		End for 
		
		$i:=1
		ARRAY TEXT:C222($aItem; $recnum)  // **Replaced old _ o _ARRAY STRING length 255
		ARRAY TEXT:C222($aElmMember; $recnum)  // **Replaced old _ o _ARRAY STRING length 255
		FIRST RECORD:C50([ElementsSafety:29])
		While (Not:C34(End selection:C36([ElementsSafety:29])))
			RELATE ONE:C42([ElementsSafety:29]ElementNo:1)
			$aItem{$i}:=INSP_ElmtSfty_ItemNo([ElementsSafety:29]ElementNo:1; False:C215)
			If ([ElementDict:30]Parent:4#0)
				//has parent
				$aItem{$i}:=$aItem{$i}+"."+GetParentPrefix+" "+GetParentDescription
				//Display description
				$aElmMember{$i}:=[ElementDict:30]Prefix:11+[ElementsSafety:29]Description:22
			Else 
				//no parent
				$aItem{$i}:=$aItem{$i}+"."+[ElementDict:30]Prefix:11
				//Display description
				$aElmMember{$i}:=[ElementsSafety:29]Description:22
			End if 
			//Get the comments
			If ($i<=$REMARKS_NUMBER)
				$pRemarks:=Get pointer:C304("vRemarks0"+String:C10($i))
				If (BLOB size:C605([ElementsSafety:29]ElmComments:23)>0)
					INSP_ElemCommentsList_WP(New object:C1471("elemblob"; ->[ElementsSafety:29]ElmComments:23; \
						"charlimit"; <>vLimitCharDAM; "varpointer"; $pRemarks; \
						"notfit"; "See remarks in comments section."))
					
				Else 
					$pRemarks->:=""
				End if 
				$pMember:=Get pointer:C304("vMember0"+String:C10($i))
				$pPrevRat:=Get pointer:C304("vprevR0"+String:C10($i))
				$pRat:=Get pointer:C304("vR0"+String:C10($i))
				$pDef:=Get pointer:C304("vDEF0"+String:C10($i))
				$pMember->:=$aItem{$i}+" "+$aElmMember{$i}
				Case of   //added this to fit text.
					: (Length:C16($pMember->)>29)
						OBJECT SET FONT SIZE:C165($pMember->; 8)
					: (Length:C16($pMember->)>27)
						OBJECT SET FONT SIZE:C165($pMember->; 9)
					: (Length:C16($pMember->)>24)
						OBJECT SET FONT SIZE:C165($pMember->; 10)
				End case 
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
				
			End if 
			
			$i:=$i+1
			NEXT RECORD:C51([ElementsSafety:29])
		End while 
		
		//ASL 4-25-03 Added Item 58
		vItem58Prev:=G_FormatItmRtg([Inspections:27]Item58_i:151)
		vItem59Prev:=G_FormatItmRtg([Inspections:27]Item59_i:143)
		vItem60Prev:=G_FormatItmRtg([Inspections:27]Item60_i:144)
		vItem62Prev:=G_FormatItmRtg([Inspections:27]Item62_i:174)  //Added 2004-01-08
		vItem58:=G_FormatItmRtg([Inspections:27]Item 58:79)
		vItem59:=G_FormatItmRtg([Inspections:27]Item 59:80)
		vItem60:=G_FormatItmRtg([Inspections:27]Item 60:81)
		vItem62:=G_FormatItmRtg([Inspections:27]Item 62:113)  //Added 2004-01-08
		
		//Get the year rehab'd      
		vYrRehab:=[Inspections:27]YrRehab:158
		
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
		vPlans:=f_Boolean2String([Inspections:27]Plans:69; "YN")
		vVCR:=f_Boolean2String([Inspections:27]VCR:70; "YN")
		vAccident:=f_Boolean2String([Inspections:27]AccidentRep:149; "YN")
		
		vDam_Boston_Date:=Uppercase:C13(String:C10([Inspections:27]Dam_Boston_Office_Date:184; Internal date short:K1:7))
		If ([Inspections:27]Dam_Boston_Office_Date:184=!00-00-00!)
			vDam_Boston_Date:=""
		End if 
		G_Insp_SetDeptFont
		G_Insp_ApplyRev2_PR
		
		INSP_PR_RatgBlock
End case 