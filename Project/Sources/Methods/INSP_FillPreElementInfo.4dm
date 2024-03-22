//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	//Created by: Kenny Yang-(Designer) `10/25/10, 17:18:41   `// ----------------------------------------------------\
		
	// ----------------------------------------------------
	// Method: INSP_FillPreElementInfo
	// Description
	// Method to fill the element variables for the previous inspection on a Inspection Evalutaion form
	// variable INSP_NumItems_L and arrays INSP_Start_ai, INSP_Fin_ai must be defined from 
	// the calling form method. Use global arrays ◊ELMTDICT_@ for reference.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_12
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
	
	// Modified by: Costas Manousakis-(Designer)-(10/28/14 16:53:03)
	Mods_2014_10
	//  `Add the deficiency and Urgency to the rating value text
	//  `Added combining of the "Current Inspection" Def and Urgency to the current Rating text
	
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
		
		$p:=Get pointer:C304("vPR"+String:C10($i))  //Rating
		$bpOK:=(Type:C295($p->)#5)
		$elm:=Find in array:C230($A; $i)
		If ($elm>0)
			If ($bpOK)
				
				If ($D{$elm}#"-")
					$p->:=$B{$elm}+" "+$D{$elm}
				Else 
					$p->:=$B{$elm}
				End if 
				
			End if 
		Else 
			If ($bpOK)
				$p->:="N"
			End if 
		End if 
		$q:=Get pointer:C304("vR"+String:C10($i))  //curr rating
		$r:=Get pointer:C304("vD"+String:C10($i))  // curr deficiency combined with urgency
		$t:=Get pointer:C304("vCR"+String:C10($i))  // curr rtg+def variable
		$bqOK:=(Type:C295($q->)#5)
		$brOK:=(Type:C295($r->)#5)
		$btOK:=(Type:C295($t->)#5)
		
		If ($btOK)
			
			If ($bqOK & $brOK)
				
				If ($r->#"-")
					$t->:=$q->+" "+$r->
				Else 
					$t->:=$q->
				End if 
				
			End if 
			
		End if 
		
	End for 
End for 
//Clear the arrays
ARRAY INTEGER:C220($A; 0)
ARRAY TEXT:C222($B; 0)  //Rating//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222($C; 0)  //Deficiencies//Command Replaced was o_ARRAY string length was 3
ARRAY TEXT:C222($D; 0)  //Priority converted to deficiency+priority//Command Replaced was o_ARRAY string length was 5
ARRAY TEXT:C222($U; 0)  //UW Rating//Command Replaced was o_ARRAY string length was 1
ARRAY TEXT:C222($aElmSafetyTxt; 0)  //User defined element descriptions//Command Replaced was o_ARRAY string length was 40