//%attributes = {"invisible":true}
//Method: Find1stMissingBIN
//Description
//  ` search and find missing Bins. 
//  ` bring up dialog to show  list
//  ` return the selected one, or the first one
// Parameters
// $0 : $BIN_s
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/06/15, 16:30:29
	// ----------------------------------------------------
	//Created : 
	Mods_2015_02
End if 
//
C_TEXT:C284($0)  // Command Replaced was o_C_STRING length was 3
READ ONLY:C145([Sequences:28])
ARRAY TEXT:C222(aBINs; 0)
Begin SQL
	select [Bridge MHD NBIS].BIN from [Bridge MHD NBIS] order by [Bridge MHD NBIS].BIN into :aBINs ;
End SQL
ARRAY TEXT:C222(LBGeneric_atxt; 0)
QUERY:C277([Sequences:28]; [Sequences:28]Name:1="BIN")
C_LONGINT:C283($lastSeq_L; $loop_L; $lastBIN_L; $PickBIN_L)
$lastSeq_L:=[Sequences:28]Value:2
C_TEXT:C284($TestBIN_s)  // Command Replaced was o_C_STRING length was 3
$lastBIN_L:=ConvertBINtoNumber(aBINs{Size of array:C274(aBINs)})
If ($lastBIN_L>$lastSeq_L)
	ALERT:C41("Sequence num "+String:C10($lastSeq_L)+" is smaller than last bin ("+aBINs{Size of array:C274(aBINs)}+") = "+String:C10($lastBIN_L))
	$lastSeq_L:=$lastBIN_L
End if 
SHORT_MESSAGE("Searching for "+String:C10($lastSeq_L)+" BINs...")
For ($loop_L; 1; $lastSeq_L)
	$TestBIN_s:=ConvertBIN($loop_L)
	
	If (Find in array:C230(aBINs; $TestBIN_s)>0)
	Else 
		APPEND TO ARRAY:C911(LBGeneric_atxt; $TestBIN_s)
	End if 
	
End for 
CLOSE WINDOW:C154
C_LONGINT:C283($Width_l; $Height_l)
FORM GET PROPERTIES:C674("OneArrayLB"; $Width_l; $Height_l)
ut_OpenNewWindow($Width_l; $Height_l; 0; Plain window:K34:13; "Missing BINs = "+String:C10(Size of array:C274(LBGeneric_atxt)); "ut_CloseCancel")
C_TEXT:C284(1_txt)
1_txt:="Missing BINs"
LBGeneric_atxt:=0
DIALOG:C40("OneArrayLB")
CLOSE WINDOW:C154
$PickBIN_L:=LBGeneric_atxt
If ($PickBIN_L=0)
	$PickBIN_L:=1  // pick the first
End if 
$TestBIN_s:=LBGeneric_atxt{$PickBIN_L}

$0:=$TestBIN_s
//End Find1stMissingBIN