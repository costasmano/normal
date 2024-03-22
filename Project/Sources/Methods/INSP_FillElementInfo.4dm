//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/19/07, 14:59:09
	// ----------------------------------------------------
	// Method: INSP_FillElementInfo
	// Description
	// Method to fill the element variables on a routine print form
	// variable INSP_NumItems_L and arrays INSP_Start_ai, INSP_Fin_ai must be defined from 
	// the calling form method. Use global arrays ◊ELMTDICT_@ for reference.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2007_CM12_5302
	// Modified by: costasmanousakis-(Designer)-(1/29/10 14:26:22)
	Mods_2010_01
	//  ` It is the addition of the shielding Element 114  under the Deck category.
	// Modified by: costasmanousakis-(Designer)-(1/18/11 14:27:22)
	Mods_2011_01
	//added call to INSP_VerifyElmtSftyFormVar
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
End if 

C_LONGINT:C283($i; $j)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($recnum)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($elm)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($p; $q; $r; $t)
ARRAY INTEGER:C220($A; 0)
ARRAY TEXT:C222($B; 0)  //Rating//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222($C; 0)  //Deficiencies//Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($D; 0)  //Priority converted to deficiency+priority//Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222($U; 0)  //UW Rating//Command Replaced was o_ARRAY string length was 1

ARRAY TEXT:C222($aElmSafetyTxt; 0)  //User defined element descriptions//Command Replaced was o_ARRAY string length was 40
C_TEXT:C284($vDeficiencyDef)  // Command Replaced was o_C_STRING length was 1
$vDeficiencyDef:="-"
INSP_VerifyElmtSftyFormVar
G_Insp_RelateInsp(->[ElementsSafety:29]InspID:4)
$recnum:=Records in selection:C76([ElementsSafety:29])

If ($recnum>0)
	SELECTION TO ARRAY:C260([ElementsSafety:29]ElementNo:1; $A; [ElementsSafety:29]Rating:2; $B; [ElementsSafety:29]Deficiency:3; $C; [ElementsSafety:29]Priority:20; $D; [ElementsSafety:29]AltRating:21; $U; [ElementsSafety:29]Description:22; $aElmSafetyTxt)
	For ($i; 1; Size of array:C274($A))
		$C{$i}:=Replace string:C233($C{$i}; " "; "")
		$D{$i}:=Replace string:C233($D{$i}; " "; "")
		If ($C{$i}="N")
			$C{$i}:="-"  //default display of no deficiency
		End if 
		If ($D{$i}#"")
			$D{$i}:=$C{$i}+"-"+$D{$i}  //if there is a prio combine def+prio
		Else 
			$D{$i}:=$C{$i}  // else set it to deficiency alone            
		End if 
		
	End for 
End if 

C_TEXT:C284($vsPointername)  // Command Replaced was o_C_STRING length was 40
C_LONGINT:C283($vPointerTnum; $vPointerFnum)
C_BOOLEAN:C305($btOK; $bpOK; $bqOK; $brOK)
For ($j; 1; INSP_NumItems_L)
	For ($i; INSP_Start_ai{$j}; INSP_Fin_ai{$j})
		$t:=Get pointer:C304("vT"+String:C10($i))  //User defined element description      
		//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
		//$btOK:=($vsPointername=("vT"+String($i)))
		$btOK:=(Type:C295($t->)#5)
		$p:=Get pointer:C304("vR"+String:C10($i))  //Rating
		//RESOLVE POINTER($p;$vsPointername;$vPointerTnum;$vPointerFnum)
		//$bpOK:=($vsPointername=("vR"+String($i)))
		$bpOK:=(Type:C295($p->)#5)
		$q:=Get pointer:C304("vD"+String:C10($i))  //Deficiency
		//RESOLVE POINTER($q;$vsPointername;$vPointerTnum;$vPointerFnum)
		//$bqOK:=($vsPointername=("vD"+String($i)))
		$bqOK:=(Type:C295($q->)#5)
		$r:=Get pointer:C304("vRd"+String:C10($i))
		//RESOLVE POINTER($r;$vsPointername;$vPointerTnum;$vPointerFnum)
		//$brOK:=($vsPointername=("vRd"+String($i)))
		$brOK:=(Type:C295($r->)#5)
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
			If ($brOK)
				$r->:=$U{$elm}
			End if 
		Else 
			If ($bpOK)
				$p->:="N"
			End if 
			If ($brOK)
				$r->:="N"
			End if 
			If ($bqOK)
				$q->:="-"  //9/10/2001 chgd from N to -
			End if 
			$elm:=Find in array:C230(<>ELMTDICT_ELNum_ai; $i)
			If ($btOK)
				If ($elm>0)
					If ($i=114)
						If (f_Insp_Revision6([Inspections:27]Insp Date:78))
							$t->:=<>ELMTDICT_Txt_as{$elm}
						Else 
							$t->:="Blank Element"
						End if 
					Else 
						$t->:=<>ELMTDICT_Txt_as{$elm}
					End if 
				Else 
					$t->:=""
				End if 
			End if 
		End if 
		//Check if the description still says blank....     
		If ($btOK)
			If (Substring:C12($t->; 1; 6)="Blank ")
				$t->:=""  //show it as blank
			End if 
		End if 
		Case of   //Special case for Item 61 blank elements - we do not show anything if blank
			: (($i=414) | ($i=415) | ($i=416))
				If ($t->#"")
					$t->:=String:C10($i-(414-9))+". "+$t->
				Else 
					$p->:=""
					$r->:=""
					$q->:=""
				End if 
		End case 
		
	End for 
End for 
//Clear the arrays
ARRAY INTEGER:C220($A; 0)
ARRAY TEXT:C222($B; 0)  //Rating//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222($C; 0)  //Deficiencies//Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($D; 0)  //Priority converted to deficiency+priority//Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222($U; 0)  //UW Rating//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222($aElmSafetyTxt; 0)  //User defined element descriptions//Command Replaced was o_ARRAY string length was 40