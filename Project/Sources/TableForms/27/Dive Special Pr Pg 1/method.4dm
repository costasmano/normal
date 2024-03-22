If (False:C215)
	//LO: [Inspections];"Dive Special Pr Pg 1"
	//Copyright © 1995-2002,  Albert S. Leung, All Rights Reserved.
	
	//Load variables
	Mods_2005_CM01
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(8/5/08 11:05:10)
	Mods_2008_CM_5404
	//  `Use method INSP_ElmtSfty_ItemNo 
	// Modified by: costasmanousakis-(Designer)-(1/6/10 12:07:43)
	Mods_2010_01
	//use var vsInspDepartment and method G_Insp_SetDeptFont
	// Modified by: Costas Manousakis-(Designer)-(10/23/15 17:26:39)
	Mods_2015_10_bug
	//  `adjussted  vert size of labels in the condition rating guide
	// Modified by: Costas Manousakis-(Designer)-(4/16/21 17:00:03)
	Mods_2021_WP
	//  `
End if 

C_LONGINT:C283($i; $recnum; $count)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($REMARKS_NUMBER)  //Command Replaced was o_C_INTEGER
$REMARKS_NUMBER:=6
C_POINTER:C301($pItem; $pMember; $pRemarks; $pPrevRat; $pRat; $pDef)
C_LONGINT:C283($temparea)
ARRAY TEXT:C222($aPrevRating; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222($aCurrentRating; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222($aDeficiency; 0)  //Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222($aPriority; 0)  //Command Replaced was o_ARRAY string length was 2

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		//3/17/2001 ASL
		//Fill out form was submitted by
		vAuthor:=Uppercase:C13(Current user:C182)
		//End 3/17/2001ASL
		//Sep-10-2001 
		//vAuthor set to blank
		vAuthor:=""
		//End Sep-10-2001
		G_Insp_SetDeptFont
		//9/2001
		//Adjust font for Bottom conditions
		Case of 
			: (Length:C16([Inspections:27]BotCondition:106)>29)
				OBJECT SET FONT SIZE:C165(*; "BotCondition"; 7)
			: (Length:C16([Inspections:27]BotCondition:106)>25)
				OBJECT SET FONT SIZE:C165(*; "BotCondition"; 8)
			: (Length:C16([Inspections:27]BotCondition:106)>21)
				OBJECT SET FONT SIZE:C165(*; "BotCondition"; 9)
		End case 
		//Adjust font for Bridge Access
		Case of 
			: (Length:C16([Inspections:27]UW BrgAccess:107)>26)
				OBJECT SET FONT SIZE:C165(*; "BrgAccess"; 7)
				OBJECT MOVE:C664(*; "BrgAccess"; 0; -3; 0; 4)
			: (Length:C16([Inspections:27]UW BrgAccess:107)>22)
				OBJECT SET FONT SIZE:C165(*; "BrgAccess"; 8)
			: (Length:C16([Inspections:27]UW BrgAccess:107)>18)
				OBJECT SET FONT SIZE:C165(*; "BrgAccess"; 9)
		End case 
		//Adjust font for Current 
		Case of 
			: (Length:C16([Inspections:27]Current:110)>26)
				OBJECT SET FONT SIZE:C165(*; "CurrentField"; 7)
				OBJECT MOVE:C664(*; "CurrentField"; 0; -3; 0; 4)
			: (Length:C16([Inspections:27]Current:110)>22)
				OBJECT SET FONT SIZE:C165(*; "CurrentField"; 8)
				OBJECT MOVE:C664(*; "CurrentField"; 0; -4; 0; 6)
			: (Length:C16([Inspections:27]Current:110)>18)
				OBJECT SET FONT SIZE:C165(*; "CurrentField"; 9)
		End case 
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
		
		//get only records that have a Rating not N
		QUERY SELECTION:C341([ElementsSafety:29]; [ElementsSafety:29]AltRating:21#"N")
		$recnum:=Records in selection:C76([ElementsSafety:29])
		//Sort by element no.
		//10/3/2002 ASL
		//ORDER BY([ElementsSafety];[ElementsSafety]ElementNo;>)
		ORDER BY:C49([ElementsSafety:29]; [ElementDict:30]Category:3; >; [ElementDict:30]FullLabel:13; >)
		
		$i:=1
		//5/23/2001 ASL add an array for the element category
		ARRAY TEXT:C222($aItem; $recnum)  //Command Replaced was o_ARRAY string length was 255
		ARRAY TEXT:C222($aElmMember; $recnum)  //Command Replaced was o_ARRAY string length was 255
		FIRST RECORD:C50([ElementsSafety:29])  //added nov-2001
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
						"charlimit"; <>vLimitCharDVS; "varpointer"; $pRemarks; \
						"notfit"; "See remarks in comments section."))
				Else 
					$pRemarks->:=""
				End if 
			End if 
			$i:=$i+1
			NEXT RECORD:C51([ElementsSafety:29])
		End while 
		If ($recnum>0)
			SELECTION TO ARRAY:C260([ElementsSafety:29]AltRating_i:24; $aPrevRating)
			SELECTION TO ARRAY:C260([ElementsSafety:29]AltRating:21; $aCurrentRating)  //for Dive get the Alt Rating
			SELECTION TO ARRAY:C260([ElementsSafety:29]Deficiency:3; $aDeficiency)
			SELECTION TO ARRAY:C260([ElementsSafety:29]Priority:20; $aPriority)
			//Sep-12-2001
			//Modify defaults of def and prio ratings
			For ($i; 1; Size of array:C274($aDeficiency))
				//Jan-2002 : Remove spaces from Deficiency
				$aDeficiency{$i}:=Replace string:C233($aDeficiency{$i}; " "; "")
				//Apr-2002 : Remove spaces from Priority
				$aPriority{$i}:=Replace string:C233($aPriority{$i}; " "; "")
				If ($aDeficiency{$i}="N")
					$aDeficiency{$i}:="-"  //default display of no deficiency
				End if 
				If ($aPriority{$i}#"")
					$aDeficiency{$i}:=$aDeficiency{$i}+"-"+$aPriority{$i}  //if there is a prio combine def+prio
				End if 
			End for 
		End if 
		
		//Print out just the first 6 elements we find.
		//That's all that can fit on the form.
		//up on the form
		For ($i; 1; $REMARKS_NUMBER)
			$pItem:=Get pointer:C304("vItem0"+String:C10($i))
			$pMember:=Get pointer:C304("vMember0"+String:C10($i))
			$pPrevRat:=Get pointer:C304("vprevR0"+String:C10($i))
			$pRat:=Get pointer:C304("vR0"+String:C10($i))
			$pDef:=Get pointer:C304("vDEF0"+String:C10($i))
			If ($i<=$recnum)
				$pItem->:=$aItem{$i}
				$pMember->:=$aElmMember{$i}
				$pPrevRat->:=$aPrevRating{$i}
				$pRat->:=$aCurrentRating{$i}
				$pDef->:=$aDeficiency{$i}
			Else 
				$pItem->:=""
				$pMember->:=""
				$pPrevRat->:=""
				$pRat->:=""
				$pDef->:=""
			End if 
		End for 
		If (([Inspections:27]Item59_i:143#"N") & ([Inspections:27]Item59_i:143#""))
			vItem59Prev:=[Inspections:27]Item59_i:143
		Else 
			vItem59Prev:="-"
		End if 
		If (([Inspections:27]Item60UW_i:152#"N") & ([Inspections:27]Item60UW_i:152#""))
			vItem60Prev:=[Inspections:27]Item60UW_i:152
		Else 
			vItem60Prev:="-"
		End if 
		If (([Inspections:27]Item61UW_i:153#"N") & ([Inspections:27]Item61UW_i:153#""))
			vItem61Prev:=[Inspections:27]Item61UW_i:153
		Else 
			vItem61Prev:="-"
		End if 
		If (([Inspections:27]Item62UW_i:154#"N") & ([Inspections:27]Item62UW_i:154#""))
			vItem62Prev:=[Inspections:27]Item62UW_i:154
		Else 
			vItem62Prev:="-"
		End if 
		If (([Inspections:27]Item 59:80#"N") & ([Inspections:27]Item 59:80#""))
			vItem59:=[Inspections:27]Item 59:80
		Else 
			vItem59:="-"
		End if 
		If (([Inspections:27]Item 60 UW:66#"N") & ([Inspections:27]Item 60 UW:66#""))
			vItem60:=[Inspections:27]Item 60 UW:66
		Else 
			vItem60:="-"
		End if 
		If (([Inspections:27]Item 61 UW:72#"N") & ([Inspections:27]Item 61 UW:72#""))
			vItem61:=[Inspections:27]Item 61 UW:72
		Else 
			vItem61:="-"
		End if 
		If (([Inspections:27]Item 62 UW:165#"N") & ([Inspections:27]Item 62 UW:165#""))
			vItem62:=[Inspections:27]Item 62 UW:165
		Else 
			vItem62:="-"
		End if 
End case 