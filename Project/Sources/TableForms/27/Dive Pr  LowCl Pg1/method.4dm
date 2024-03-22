If (False:C215)
	//Form Method: Dive Pr  LowCl Pg1 
	//LO: [Inspections];
	//Copyright © 1995-1997,  Albert S. Leung, All Rights Reserved.
	Mods_2005_CM01
	Mods_2005_CM05
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(11/20/07 16:29:04)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(12/6/07 14:37:06)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(1/6/10 12:07:43)
	Mods_2010_01
	//use var vsInspDepartment and method G_Insp_SetDeptFont
	// Modified by: costasmanousakis-(Designer)-(1/29/10 14:31:54)
	Mods_2010_01
	//  ` It is the addition of the shielding Element 114  under the Deck category.
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
	// Modified by: Costas Manousakis-(Designer)-(10/23/15 17:23:42)
	Mods_2015_10_bug
	//  `adjussted  vert size of variables and labels
End if 
//Load variables
C_LONGINT:C283($i; $j; $k; $k58limit; $k59limit; $recnum; $elm)  //Command Replaced was o_C_INTEGER
ARRAY INTEGER:C220($A; 0)
ARRAY TEXT:C222($B; 0)  //Command Replaced was o_ARRAY string length was 2
ARRAY TEXT:C222($C; 0)  //Deficiencies//Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($D; 0)  //Priority converted to deficieny + priority//Command Replaced was o_ARRAY string length was 5
//11/16/2001 ASL
ARRAY TEXT:C222($aElmSafetyTxt; 0)  //User defined element descriptions//Command Replaced was o_ARRAY string length was 40
C_TEXT:C284($vDeficiencyDef)  // Command Replaced was o_C_STRING length was 2
C_POINTER:C301($p; $q; $r; $t)
$vDeficiencyDef:="-"

//Added to simplify coding of Element info variables
C_LONGINT:C283($Num_items)  //Command Replaced was o_C_INTEGER//number of items on this form
$Num_items:=2  //items 60 61
ARRAY INTEGER:C220($aStart; $Num_items)  //start of item counter
ARRAY INTEGER:C220($aFin; $Num_items)  //end of item counter
//load values in the arrays
$aStart{1}:=<>k60s_
$aStart{2}:=<>k61s_
$aFin{1}:=<>k60f_
$aFin{2}:=<>k61f_

Case of 
	: (Form event code:C388=On Printing Detail:K2:18)
		
		FORM_FixHairLine
		
		OBJECT SET VISIBLE:C603(*; "txtPCAbutments"; <>WindowsPL_b)
		OBJECT SET VISIBLE:C603(*; "txtMacAbutments"; <>MacPL_b)
		OBJECT SET VISIBLE:C603(*; "txtPCPiersBents"; <>WindowsPL_b)
		OBJECT SET VISIBLE:C603(*; "txtMacPiersBents"; <>MacPL_b)
		OBJECT SET VISIBLE:C603(*; "txtPCPileBents"; <>WindowsPL_b)
		OBJECT SET VISIBLE:C603(*; "txtMacPileBents"; <>MacPL_b)
		
		G_Insp_SetDeptFont
		//3/17/2001 ASL
		//Fill out form was submitted by
		vAuthor:=Uppercase:C13(Current user:C182)
		//End 3/17/2001ASL
		//Sep-10-2001 
		//vAuthor set to blank
		vAuthor:=""
		//End Sep-10-2001
		
		//9/2001
		//Adjust font for Bottom conditions
		Case of 
			: (Length:C16([Inspections:27]BotCondition:106)>32)
				OBJECT SET FONT SIZE:C165(*; "BotCondition"; 6)
				OBJECT MOVE:C664(*; "BotCondition"; 0; -3; 0; 4)
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
			: (Length:C16([Inspections:27]Current:110)>19)
				OBJECT SET FONT SIZE:C165(*; "CurrentField"; 7)
				OBJECT MOVE:C664(*; "CurrentField"; 0; -3; 0; 4)
			: (Length:C16([Inspections:27]Current:110)>15)
				OBJECT SET FONT SIZE:C165(*; "CurrentField"; 8)
				OBJECT MOVE:C664(*; "CurrentField"; 0; -4; 0; 6)
			: (Length:C16([Inspections:27]Current:110)>10)
				OBJECT SET FONT SIZE:C165(*; "CurrentField"; 9)
		End case 
		
		//Added variables for Item 61-62 ratings
		vItem60UW:=G_ElmtRatingTxt([Inspections:27]Item 60 UW:66)
		vItem61UW:=G_ElmtRatingTxt([Inspections:27]Item 61 UW:72)
		vItem58:=G_ElmtRatingTxt([Inspections:27]Item 58:79)
		vItem59:=G_ElmtRatingTxt([Inspections:27]Item 59:80)
		
		G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
		
		$recnum:=Records in selection:C76([ElementsSafety:29])
		$i:=1
		//3/25/2001 ASL get the element descriptions for each [ElementSafety] record
		ARRAY TEXT:C222($E; $recnum)  //Command Replaced was o_ARRAY string length was 40
		//5/23/2001 ASL add an array for the element category
		ARRAY TEXT:C222($F; $recnum)  //Command Replaced was o_ARRAY string length was 3
		//5/23/2001 add an array for the element parent
		ARRAY INTEGER:C220($G; $recnum)
		//Oct-2002 : add array for element prefix - used in 58,59
		ARRAY TEXT:C222($H; $recnum)  //Command Replaced was o_ARRAY string length was 10
		FIRST RECORD:C50([ElementsSafety:29])  //added nov-2001
		While (Not:C34(End selection:C36([ElementsSafety:29])))
			RELATE ONE:C42([ElementsSafety:29]ElementNo:1)
			$E{$i}:=[ElementDict:30]Description:2
			$F{$i}:=[ElementDict:30]Category:3
			$G{$i}:=[ElementDict:30]Parent:4
			$H{$i}:=[ElementDict:30]Prefix:11
			$i:=$i+1
			NEXT RECORD:C51([ElementsSafety:29])
		End while 
		If ($recnum>0)
			SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $A)
			SELECTION TO ARRAY:C260([ElementsSafety:29]AltRating:21; $B)  //for Dive get the Alt Rating
			SELECTION TO ARRAY:C260([ElementsSafety:29]Deficiency:3; $C)
			SELECTION TO ARRAY:C260([ElementsSafety:29]Priority:20; $D)
			//11/16/2001 ASL
			SELECTION TO ARRAY:C260([ElementsSafety:29]Description:22; $aElmSafetyTxt)
			//Sep-12-2001
			//Modify defaults of def and prio ratings
			For ($i; 1; Size of array:C274($A))
				//Jan-2002 : Remove spaces from Deficiency
				$C{$i}:=Replace string:C233($C{$i}; " "; "")
				//Apr-2002 : Remove spaces from Priority
				$D{$i}:=Replace string:C233($D{$i}; " "; "")
				If ($C{$i}="N")
					$C{$i}:=$vDeficiencyDef  //default display of no deficiency
				End if 
				If ($D{$i}#"")
					$D{$i}:=$C{$i}+"-"+$D{$i}  //if there is a prio combine def+prio
				Else 
					$D{$i}:=$C{$i}  // else set it to deficiency alone            
				End if 
				
			End for 
			
		End if 
		
		//3/25/2001 ASL add section for Item 58.
		//Select first 3 elements of Item 58 we find.
		//Item 58
		//Initialize the first three elements
		vr_58_1:="N"
		vD_58_1:=$vDeficiencyDef
		vDescr_58_1:=""
		vr_58_2:="N"
		vD_58_2:=$vDeficiencyDef
		vDescr_58_2:=""
		vr_58_3:="N"
		vD_58_3:=$vDeficiencyDef
		vDescr_58_3:=""
		
		//6/07/2002 DBD add section for Item 59.
		//Select first 10 elements of Item 59 we find.
		//Item 59
		//Initialize the first ten elements
		vr_59_1:="N"
		vD_59_1:=$vDeficiencyDef
		vDescr_59_1:=""
		vr_59_2:="N"
		vD_59_2:=$vDeficiencyDef
		vDescr_59_2:=""
		vr_59_3:="N"
		vD_59_3:=$vDeficiencyDef
		vDescr_59_3:=""
		vr_59_4:="N"
		vD_59_4:=$vDeficiencyDef
		vDescr_59_4:=""
		vr_59_5:="N"
		vD_59_5:=$vDeficiencyDef
		vDescr_59_5:=""
		vr_59_6:="N"
		vD_59_6:=$vDeficiencyDef
		vDescr_59_6:=""
		vr_59_7:="N"
		vD_59_7:=$vDeficiencyDef
		vDescr_59_7:=""
		vr_59_8:="N"
		vD_59_8:=$vDeficiencyDef
		vDescr_59_8:=""
		vr_59_9:="N"
		vD_59_9:=$vDeficiencyDef
		vDescr_59_9:=""
		vr_59_10:="N"
		vD_59_10:=$vDeficiencyDef
		vDescr_59_10:=""
		
		//Start with the first 3
		$k:=1
		$k58limit:=3  //The number of lines for Item 58 that show
		$p:=Get pointer:C304("vR_58_"+String:C10($k))
		$q:=Get pointer:C304("vD_58_"+String:C10($k))
		$r:=Get pointer:C304("vDescr_58_"+String:C10($k))
		//up on the form
		For ($i; <>k58s_; <>k58f_)
			$elm:=Find in array:C230($A; $i)
			If ($elm>0)
				If (($B{$elm}#"N") & ($B{$elm}#""))
					$p->:=$B{$elm}
					$q->:=$D{$elm}
					//3/25/2001 ASL fill in the description
					$r->:=$H{$elm}+" "+$aElmSafetyTxt{$elm}
					//Go to the next one
					If ($k<$k58limit)
						$k:=$k+1
						$p:=Get pointer:C304("vR_58_"+String:C10($k))
						$q:=Get pointer:C304("vD_58_"+String:C10($k))
						$r:=Get pointer:C304("vDescr_58_"+String:C10($k))
					Else 
						$i:=<>k58f_+1  //Get out of the loop
					End if 
				End if 
			End if 
		End for 
		//End 3/25/2001 ASL  
		//9/10/2001 Changed default of deficiency from N to -
		
		//6/10/2002 DBD Added routine for item59 
		//Start with the first 10
		$k:=1
		$k59limit:=10  //The number of lines for Item 59 that show
		$p:=Get pointer:C304("vR_59_"+String:C10($k))
		$q:=Get pointer:C304("vD_59_"+String:C10($k))
		$r:=Get pointer:C304("vDescr_59_"+String:C10($k))
		//up on the form
		For ($i; <>k59s_; <>k59f_)
			$elm:=Find in array:C230($A; $i)
			If ($elm>0)
				If (($B{$elm}#"N") & ($B{$elm}#""))
					$p->:=$B{$elm}
					$q->:=$D{$elm}
					//3/25/2001 ASL fill in the description
					$r->:=$H{$elm}+" "+$aElmSafetyTxt{$elm}
					//Go to the next one
					If ($k<$k59limit)
						$k:=$k+1
						$p:=Get pointer:C304("vR_59_"+String:C10($k))
						$q:=Get pointer:C304("vD_59_"+String:C10($k))
						$r:=Get pointer:C304("vDescr_59_"+String:C10($k))
					Else 
						$i:=<>k59f_+1  //Get out of the loop
					End if 
				End if 
			End if 
		End for 
		//End 3/25/2001 ASL  
		//9/10/2001 Changed default of deficiency from N to -    
		
		//all items are grouped in this loop.    
		C_TEXT:C284($vsPointername)  // Command Replaced was o_C_STRING length was 40
		C_LONGINT:C283($vPointerTnum; $vPointerFnum)
		C_BOOLEAN:C305($btOK; $bpOK; $bqOK)
		For ($j; 1; $Num_items)
			For ($i; $aStart{$j}; $aFin{$j})
				//11/16/2001 ASL      
				$t:=Get pointer:C304("vT"+String:C10($i))  //User defined element description      
				//May-2002 : added checks to see if pointers are to valid variables
				//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
				//$btOK:=($vsPointername=("vT"+String($i)))
				$btOK:=(Type:C295($t->)#5)
				//End 11/16/2001 ASL
				$p:=Get pointer:C304("vR"+String:C10($i))  //Rating
				//RESOLVE POINTER($p;$vsPointername;$vPointerTnum;$vPointerFnum)
				//$bpOK:=($vsPointername=("vR"+String($i)))
				$bpOK:=(Type:C295($p->)#5)
				$q:=Get pointer:C304("vD"+String:C10($i))  //Deficiency
				//RESOLVE POINTER($q;$vsPointername;$vPointerTnum;$vPointerFnum)
				//$bqOK:=($vsPointername=("vD"+String($i)))
				$bqOK:=(Type:C295($q->)#5)
				$elm:=Find in array:C230($A; $i)
				If ($elm>0)
					If ($btOK)
						$t->:=$aElmSafetyTxt{$elm}
					End if 
					If ($bpOK)
						$p->:=$B{$elm}
					End if 
					If ($bqOK)
						$q->:=$D{$elm}
					End if 
				Else 
					If ($bpOK)
						$p->:="N"
					End if 
					If ($bqOK)
						$q->:=$vDeficiencyDef  //9/10/2001 chgd from N to -
					End if 
					//11/16/2001 ASL
					//Use the one in the element dictionary
					$elm:=Find in array:C230(<>ELMTDICT_ELNum_ai; $i)
					If ($btOK)
						If ($i=114)
							If (f_Insp_Revision6([Inspections:27]Insp Date:78))
								$t->:=<>ELMTDICT_Txt_as{$elm}
							Else 
								$t->:="Blank Element"
							End if 
						Else 
							$t->:=<>ELMTDICT_Txt_as{$elm}
						End if 
					End if 
				End if 
				//Check if the description still says blank....     
				If ($btOK)
					If (Substring:C12($t->; 1; 6)="Blank ")
						$t->:=""  //show it as blank
					End if 
				End if 
			End for 
		End for 
		
		//Check boxes
		xR1:="N"
		If ([Inspections:27]UnderMining:19=True:C214)
			xR1:="Y"  //17-jan-02 changed from X to Y
		End if 
		
End case 