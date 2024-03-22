//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/17/07, 08:32:26
	// ----------------------------------------------------
	// Method: ut_SelectFieldNum
	// Description
	// Select a field from a table
	// 
	// Parameters
	// $0 : Field number (L)
	// $1 : Table number (L)
	// ----------------------------------------------------
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(4/12/10 09:11:54)
	Mods_2010_04
	//  `Changed PickFIELDName_as to a text array.
	//  `Added Field type and length in the description
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(7/29/20 19:04:30)
	Mods_2020_07_bug
	//  `use Field Titles set by SET FIELD TITLES for the field name, if found.
End if 
C_LONGINT:C283($0; $FieldNum_L; $1; $TableNum_L)
$TableNum_L:=$1
$FieldNum_L:=0

C_LONGINT:C283($numFlds_L; $SelectedFld_L; $FldType_L; $fldLen_L; $i; $fieldTtitleIndx_L)
C_BOOLEAN:C305($FldIndexed_b; $FldUnique_b)
C_TEXT:C284($FldType_s)
$numFlds_L:=Get last field number:C255($TableNum_L)
ARRAY LONGINT:C221($FLDNum_aL; $numFlds_L)
ARRAY TEXT:C222(PickFIELDName_as; $numFlds_L)
ARRAY TEXT:C222($FieldTitles_atxt; 0)
ARRAY LONGINT:C221($FieldTitleNum_aL; 0)
GET FIELD TITLES:C804(Table:C252($1)->; $FieldTitles_atxt; $FieldTitleNum_aL)
For ($i; 1; $numFlds_L)
	$FLDNum_aL{$i}:=$i
	$fieldTtitleIndx_L:=Find in array:C230($FieldTitleNum_aL; $i)
	If ($fieldTtitleIndx_L>0)
		PickFIELDName_as{$i}:=$FieldTitles_atxt{$fieldTtitleIndx_L}
	Else 
		PickFIELDName_as{$i}:=Field name:C257($TableNum_L; $i)
	End if 
	
	GET FIELD PROPERTIES:C258($TableNum_L; $i; $FldType_L; $fldLen_L; $FldIndexed_b; $FldUnique_b)
	Case of 
		: ($FldType_L=Is alpha field:K8:1)
			$FldType_s:="Char*"+String:C10($fldLen_L)  //String
		: ($FldType_L=Is real:K8:4)
			$FldType_s:="Real"  //Real
		: ($FldType_L=Is text:K8:3)
			$FldType_s:="Text"  //Text
		: ($FldType_L=Is date:K8:7)
			$FldType_s:="Date"  //Date
		: ($FldType_L=Is boolean:K8:9)
			$FldType_s:="Boolean"  //Boolean
		: ($FldType_L=Is integer:K8:5)
			$FldType_s:="Integer"  //Integer
		: ($FldType_L=Is longint:K8:6)
			$FldType_s:="Long Int"  //Long Integer
		: ($FldType_L=Is time:K8:8)
			$FldType_s:="Time"  //Time
		: ($FldType_L=Is picture:K8:10)
			$FldType_s:="Picture"  //Time
		: ($FldType_L=Is BLOB:K8:12)
			$FldType_s:="BLOB"  //Time
		Else 
			$FldType_s:="?"
	End case 
	PickFIELDName_as{$i}:=PickFIELDName_as{$i}+" ("+$FldType_s+")"
	If ($FldUnique_b)
		PickFIELDName_as{$i}:=PickFIELDName_as{$i}+" -k"
	End if 
End for 
SORT ARRAY:C229(PickFIELDName_as; $FLDNum_aL)
$SelectedFld_L:=G_PickFromList(->PickFIELDName_as)
If ($SelectedFld_L>0)
	$FieldNum_L:=$FLDNum_aL{$SelectedFld_L}
End if 

ARRAY TEXT:C222(PickFIELDName_as; 0)

$0:=$FieldNum_L