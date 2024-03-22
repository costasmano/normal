//%attributes = {"invisible":true}
If (False:C215)
	//PM: PopulatePrintFormField
	//Purpose: populate fields on a printed inspection form that begin with
	//vR, vD and vRd with values in the following arrays
	//param 1 ptrElementNo pointer to array of element nos
	//param 2 ptrRating pointer to array of ratings
	//param 3 ptrDeficiency to array of deficiencies
	//param 4 ptrPriority to array of priorities
	//param 5 ptrAltRating to array dive ratings
	//param 6 element no to find
	//param 7 ptr ElmDesc to array descriptions
	//param 8 ptr DictDesc to array Dictionary descriptions
	//param 9 ptr DictNo to array of Dictionary numbers
	//Assumptions: this routine assumes that vR, vD and vRd form fields are
	//named with their corresponding element nos.
	//Copyright © 1995-2002,  Albert S. Leung, All Rights Reserved.
	Mods_2012_02  //r002   `Fix bug where resolve pointer not retuning corect data
	//Modified by: Charles Miller (2/9/12 14:43:44)
End if 

C_LONGINT:C283($6; $elmno)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($p; $q; $r; $t)
C_LONGINT:C283($elm)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($ptrElementNo; $ptrDictNo)
C_POINTER:C301($ptrRating)
C_POINTER:C301($ptrDeficiency)
C_POINTER:C301($ptrPriority)
C_POINTER:C301($ptrAltRating)
C_POINTER:C301($ptrElmDesc; $ptrDictDesc)
C_TEXT:C284($vsPointername)  // Command Replaced was o_C_STRING length was 40
C_LONGINT:C283($vPointerTnum; $vPointerFnum)
C_BOOLEAN:C305($btOK; $bpOK; $bqOK; $brOK)
C_POINTER:C301($1; $2; $3; $4; $5; $7; $8; $9)

$ptrElementNo:=$1
$ptrRating:=$2
$ptrDeficiency:=$3
$ptrPriority:=$4
$ptrAltRating:=$5
$ptrElmDesc:=$7
$ptrDictDesc:=$8
$ptrDictNo:=$9

$elmno:=$6
$t:=Get pointer:C304("vT"+String:C10($elmno))  //User defined element description      
//RESOLVE POINTER($t;$vsPointername;$vPointerTnum;$vPointerFnum)
//$btOK:=($vsPointername=("vT"+String($elmno)))
$btOK:=(Type:C295($t->)#5)
$p:=Get pointer:C304("vR"+String:C10($elmno))  //Rating
//RESOLVE POINTER($p;$vsPointername;$vPointerTnum;$vPointerFnum)
//$bpOK:=($vsPointername=("vR"+String($elmno)))
$bpOK:=(Type:C295($p->)#5)
$q:=Get pointer:C304("vD"+String:C10($elmno))  //Deficiency
//RESOLVE POINTER($q;$vsPointername;$vPointerTnum;$vPointerFnum)
//$bqOK:=($vsPointername=("vD"+String($elmno)))
$bqOK:=(Type:C295($q->)#5)
$r:=Get pointer:C304("vRd"+String:C10($elmno))
//RESOLVE POINTER($r;$vsPointername;$vPointerTnum;$vPointerFnum)
//$brOK:=($vsPointername=("vRd"+String($elmno)))
$brOK:=(Type:C295($r->)#5)
$elm:=Find in array:C230($ptrElementNo->; $elmno)
If ($elm>0)
	If ($btOK)
		$t->:=$ptrElmDesc->{$elm}
	End if 
	If ($bpOK)
		$p->:=$ptrRating->{$elm}
	End if 
	If ($bqOK)
		If ($ptrPriority->{$elm}#"")
			$q->:=$ptrDeficiency->{$elm}+"-"+$ptrPriority->{$elm}
		Else 
			$q->:=$ptrDeficiency->{$elm}
		End if 
	End if 
	If ($brOK)
		$r->:=$ptrAltRating->{$elm}
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
	$elm:=Find in array:C230($ptrDictNo->; $elmno)
	If ($btOK)
		$t->:=$ptrDictDesc->{$elm}
	End if 
End if 
//Check if the description still says blank....     
If ($btOK)
	If (Substring:C12($t->; 1; 6)="Blank ")
		$t->:=""  //show it as blank
	End if 
End if 
//default deficiency is "-" ....     
If ($bqOK)
	If ($q->="N")
		$q->:="-"
	End if 
End if 