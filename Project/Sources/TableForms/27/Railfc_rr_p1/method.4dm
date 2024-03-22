
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 10/04/12, 11:38:22
//----------------------------------------------------
//Method: Form Method: [Inspections]Railfc_rr_p1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_10  //r001 ` 
	//Modified by: Charles Miller (10/4/12 11:38:23)
	Mods_2013_02  //r001 ` Allow for different headings on weights
	//Modified by: Charles Miller (2/14/13 15:59:35)
	// Modified by: Costas Manousakis-(Designer)-(7/29/13 11:33:18)
	Mods_2013_07
	//  `Modified print forms for MBTA to display the title MBTA Area engineer only.
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
End if 
C_LONGINT:C283($i; $recnum; $count; $REMARKS_NUMBER)  //Command Replaced was o_C_INTEGER
$REMARKS_NUMBER:=5
C_POINTER:C301($pMember; $pRemarks; $pPrevRat; $pRat; $pDef; $pLetter; $p)
C_LONGINT:C283($temparea)
ARRAY TEXT:C222($aPrevRating; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222($aCurrentRating; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222($aDeficiency; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222($aPriority; 0)  //Command Replaced was o_ARRAY string length was 2
Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		INSP_SetWPHeadings
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)  //get the element safety records
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]AltRating:21#"N")
		$recnum:=Records in selection:C76([ElementsSafety:29])
		//Sort by element no.
		//10/3/2002 ASL
		//ORDER BY([ElementsSafety];[ElementsSafety]ElementNo;>)
		ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabel:13; >)
		
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
		ARRAY TEXT:C222($aItem; $recnum)  //Command Replaced was o_ARRAY string length was 255
		ARRAY TEXT:C222($aElmMember; $recnum)  //Command Replaced was o_ARRAY string length was 255
		C_LONGINT:C283(vSpecMemStartLetter; $viStart)
		$viStart:=Character code:C91("A")+vSpecMemStartLetter
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
				If ([ElementsSafety:29]Inv H20:11>=0)  //Is this correct for rr bridges
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
		
End case 

//End Form Method: [Inspections]Railfc_rr_p1