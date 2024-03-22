//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/02/07, 12:06:05
	// ----------------------------------------------------
	// Method: ut_verifySequence
	// Description
	// 
	// 
	// Parameters
	// $1 : $SeqName_s : A40
	// $2 : $KeyField_ptr : pointer 
	// ----------------------------------------------------
	
End if 
C_TEXT:C284($1; $SeqName_s)  // Command Replaced was o_C_STRING length was 40
C_POINTER:C301($2; $KeyField_ptr)

$SeqName_s:=$1
$KeyField_ptr:=$2
C_LONGINT:C283($CurrSeqValue_L; $MaxSeqValue_L; $TableNum_L; $FieldNum_L)
C_POINTER:C301($Table_ptr)
QUERY:C277([Sequences:28]; [Sequences:28]Name:1=$SeqName_s)
If (Records in selection:C76([Sequences:28])=1)
	$CurrSeqValue_L:=[Sequences:28]Value:2
Else 
	$CurrSeqValue_L:=-1
End if 
$TableNum_L:=Table:C252($KeyField_ptr)
$Table_ptr:=Table:C252($TableNum_L)
$FieldNum_L:=Field:C253($KeyField_ptr)
READ ONLY:C145($Table_ptr->)
ALL RECORDS:C47($Table_ptr->)
If (Records in selection:C76($Table_ptr->)>0)
	ORDER BY:C49($Table_ptr->; $KeyField_ptr->; <)
	FIRST RECORD:C50($Table_ptr->)
	$MaxSeqValue_L:=$KeyField_ptr->
Else 
	$MaxSeqValue_L:=-1
End if 
If ($MaxSeqValue_L<=$CurrSeqValue_L)
	ALERT:C41("Sequence "+$SeqName_s+" OK : seqvalue="+String:C10($CurrSeqValue_L)+" max Field value:"+String:C10($MaxSeqValue_L))
Else 
	ALERT:C41("Sequence "+$SeqName_s+" NG : seqvalue="+String:C10($CurrSeqValue_L)+" max Field value:"+String:C10($MaxSeqValue_L))
End if 
