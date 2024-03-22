//%attributes = {"invisible":true}
If (False:C215)
	//GP Get_BDEPT
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	
	//Given the Town, this procedure returns the next
	//Bridge Department Number in sequence.
	
	// Modified by: costasmanousakis-(Designer)-(5/10/11 14:40:41)
	Mods_2011_05
	//  `Removed the PUSH and POP of records - use COPY NAMED SELECTIONS
	// Modified by: Costas Manousakis-(Designer)-(6/22/12 14:13:33)
	Mods_2012_06
	//  `Use SQL blocks to get the arrays - removed copy named selections .
End if 

C_TEXT:C284($1; $Town)  // Command Replaced was o_C_STRING length was 20
C_TEXT:C284($0; $bdept)  // Command Replaced was o_C_STRING length was 6
C_LONGINT:C283($i; $k; $SequenceNo; $asize1; $asize2)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($bPushed)

$Town:=$1

//COPY NAMED SELECTION([Bridge MHD NBIS];"GETBDEPTBRGMHDNBISSEL")
//COPY NAMED SELECTION([TownLineInfo];"GETBDEPTTWNLINESEL")
//PUSH RECORD([Bridge MHD NBIS])
//If (Records in selection([TownLineInfo])>0)
//PUSH RECORD([TownLineInfo])
//$bPushed:=True
//Else 
//$bPushed:=False
//End if 

$k:=Find in array:C230(<>aTownName; $Town)
ARRAY TEXT:C222(GETBDEPT_1_atxt; 0)  //Command Replaced was o_ARRAY string length was 6
ARRAY TEXT:C222(GETBDEPT_2_atxt; 0)  //Command Replaced was o_ARRAY string length was 6
C_TEXT:C284(GETBDEPT_match_txt)
GETBDEPT_match_txt:=<>aBDEPT{$k}+"%"
Begin SQL
	select [bridge mhd nbis].bdept
	from [bridge mhd nbis]
	where [Bridge MHD NBIS].BDEPT like <<GETBDEPT_match_txt>>
	order by [Bridge MHD NBIS].BDEPT
	into <<GETBDEPT_1_atxt>>
End SQL

Begin SQL
	select [TownLineInfo].BDEPT
	from [TownLineInfo]
	where [TownLineInfo].BDEPT like <<GETBDEPT_match_txt>>
	order by [TownLineInfo].BDEPT
	into <<GETBDEPT_2_atxt>>
End SQL
$asize1:=Size of array:C274(GETBDEPT_1_atxt)
$asize2:=Size of array:C274(GETBDEPT_2_atxt)
If ($asize2>0)
	For ($i; 1; $asize2)
		APPEND TO ARRAY:C911(GETBDEPT_1_atxt; GETBDEPT_2_atxt{$i})
	End for 
End if 
ARRAY INTEGER:C220($abridgeno; 0)
For ($i; 1; Size of array:C274(GETBDEPT_1_atxt))
	$SequenceNo:=Num:C11(Substring:C12(GETBDEPT_1_atxt{$i}; 4; 3))  //Num ignores alpha in string
	INSERT IN ARRAY:C227($abridgeno; $i)
	$abridgeno{$i}:=$SequenceNo
End for 
SORT ARRAY:C229($abridgeno)
$SequenceNo:=0
$i:=1
Repeat 
	If (Find in array:C230($abridgeno; $i)<0)
		$SequenceNo:=$i
	End if 
	$i:=$i+1
Until (($SequenceNo#0) | ($i>999))
If ($SequenceNo=0)
	$SequenceNo:=9999
End if 
$bdept:=<>aBDEPT{$k}+String:C10($SequenceNo; "000")

ARRAY TEXT:C222(GETBDEPT_1_atxt; 0)  //Command Replaced was o_ARRAY string length was 6
ARRAY TEXT:C222(GETBDEPT_2_atxt; 0)  //Command Replaced was o_ARRAY string length was 6
GETBDEPT_match_txt:=""

//If ($bPushed=True)
//POP RECORD([TownLineInfo])
//ONE RECORD SELECT([TownLineInfo])
//End if 
//POP RECORD([Bridge MHD NBIS])
//ONE RECORD SELECT([Bridge MHD NBIS])
//USE NAMED SELECTION("GETBDEPTTWNLINESEL")
//USE NAMED SELECTION("GETBDEPTBRGMHDNBISSEL")
//CLEAR NAMED SELECTION("GETBDEPTTWNLINESEL")
//CLEAR NAMED SELECTION("GETBDEPTBRGMHDNBISSEL")

$0:=$bdept