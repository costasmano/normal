//%attributes = {"invisible":true}
//Method: LSS_CreateElementArraysForQuery
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/11/18, 17:14:27
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12  //add [LSS_ElementInspection] query and report
	//Modified by: Chuck Miller (1/24/19 11:42:45)
End if 
//
C_TEXT:C284($1)
C_BOOLEAN:C305($2; $IncludeNumberlabels_B)
$IncludeNumberlabels_B:=$2
C_LONGINT:C283($Offset_L; $MaxOffset_L; $Position_L; $ID_L)
$MaxOffset_L:=Length:C16($1)

$Offset_L:=0
ARRAY TEXT:C222($ElementNumbers_atxt; 0)
ARRAY TEXT:C222($ElementNumberLabels_atxt; 0)
ARRAY LONGINT:C221($ElementNumbers_aL; 0)
C_TEXT:C284($ElementType_txt; $ElementNumbers_txt; $ElementLbls_txt)
Repeat 
	$Position_L:=Position:C15("\r"; $1; $Offset_L)
	If ($Position_L>0)
		$ElementType_txt:=Substring:C12($1; $Offset_L; $Position_L-$Offset_L)  //N58, n60 etc
		$Offset_L:=$Position_L+1
		$Position_L:=Position:C15("\r"; $1; $Offset_L)  //element numbers 100, 101, etc
		If ($Position_L>0)
			$ElementNumbers_txt:=Substring:C12($1; $Offset_L; $Position_L-$Offset_L)  //element numbers 100, 101, etc 
			$Offset_L:=$Position_L+1
			$Position_L:=Position:C15("\r"; $1; $Offset_L)  //element labels 1.,2.,a. etc
			
			If ($Position_L>0)
				$ElementLbls_txt:=Substring:C12($1; $Offset_L; $Position_L-$Offset_L)  // `element labels 1.,2.,a. etc
				$Offset_L:=$Position_L+1
			Else 
				$ElementLbls_txt:=Substring:C12($1; $Offset_L)
				$Offset_L:=$MaxOffset_L
			End if 
		Else 
			$Offset_L:=$MaxOffset_L
		End if 
		APPEND TO ARRAY:C911($ElementNumbers_atxt; $ElementType_txt)
		APPEND TO ARRAY:C911($ElementNumberLabels_atxt; "")
		
		ut_NewTextToArray($ElementNumbers_txt; ->$ElementNumbers_atxt; ",")
		ut_NewTextToArray($ElementLbls_txt; ->$ElementNumberLabels_atxt; ",")
		
	Else 
		$Offset_L:=$MaxOffset_L
	End if 
	
Until ($Offset_L>=$MaxOffset_L)
ARRAY TEXT:C222(LSS_Headers_atxt; 0)

ARRAY TEXT:C222(v_162_002_atxt; 0)
ARRAY LONGINT:C221(v_162_001_aL; 0)
ARRAY TEXT:C222(CBOINSPTYPE; 0)  //Command Replaced was o_ARRAY string length was 20
$MaxOffset_L:=Size of array:C274($ElementNumbers_atxt)
ARRAY TEXT:C222(v_162_002_atxt; $MaxOffset_L)
ARRAY LONGINT:C221(v_162_001_aL; $MaxOffset_L)
APPEND TO ARRAY:C911(CBOINSPTYPE; "ALL")
ARRAY TEXT:C222(LSS_Headers_atxt; $MaxOffset_L)
C_TEXT:C284($LastHeader_txt; $Description_txt)
$LastHeader_txt:=""
C_LONGINT:C283($HeaderCount_L)
$HeaderCount_L:=0
C_BOOLEAN:C305($Header_B)
For ($Offset_L; 1; $MaxOffset_L)
	
	v_162_001_aL{$Offset_L}:=Num:C11($ElementNumbers_atxt{$Offset_L})
	$ID_L:=v_162_001_aL{$Offset_L}
	Begin SQL
		SELECT 
		[LSS_Element].[LSS_ElementDescription_s] ,
		[LSS_Element].[LSS_ElementHeader_b]
		FROM
		[LSS_Element]
		WHERE
		[LSS_Element].[LSS_ElementId_L] = :$ID_L
		INTO
		:$Description_txt, 
		:$Header_B;
	End SQL
	If ($IncludeNumberlabels_B)
		v_162_002_atxt{$Offset_L}:=$ElementNumberLabels_atxt{$Offset_L}+" "+$Description_txt
	Else 
		v_162_002_atxt{$Offset_L}:=$Description_txt
	End if 
	If ($Header_B)
		$HeaderCount_L:=$HeaderCount_L+1
		If ($LastHeader_txt#$Description_txt)
			APPEND TO ARRAY:C911(CBOINSPTYPE; $Description_txt)
			$LastHeader_txt:=$Description_txt
		End if 
		
		
	End if 
	If ($IncludeNumberlabels_B)
		If ($Header_B)
			v_162_002_atxt{$Offset_L}:=String:C10($HeaderCount_L; "0.0")+" "+$LastHeader_txt
		End if 
		LSS_Headers_atxt{$Offset_L}:=$LastHeader_txt  // String($HeaderCount_L;"0.0")+" "+
	Else 
		LSS_Headers_atxt{$Offset_L}:=$LastHeader_txt
	End if 
End for 
//End LSS_CreateElementArraysForQuery