//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/07/11, 10:28:11
	// ----------------------------------------------------
	// Method: QR_SearchArchive
	// Description
	//  ` Search the bridge archive table for a record base on the Reason, date, and BIN and return the value of a field in text
	// 
	// Parameters
	// $0 : $ARCH_Result_txt
	// $1 : $ARCH_Reason_txt
	// $2 : $ARCH_Date_d
	// $3 : $ARCH_BIN_txt
	// $4 : $ARCH_Field_ptr
	// $5 : $ARCH_Fmt_txt (optional)
	// ----------------------------------------------------
	
	Mods_2011_09
End if 
C_TEXT:C284($1; $ARCH_Reason_txt; $3; $ARCH_BIN_txt; $0; $ARCH_Result_txt; $ARCH_Fmt_txt)
C_DATE:C307($2; $ARCH_Date_d)
C_POINTER:C301($4; $ARCH_Field_ptr)

$ARCH_Reason_txt:=$1
$ARCH_BIN_txt:=$3
$ARCH_Date_d:=$2
$ARCH_Field_ptr:=$4
$ARCH_Fmt_txt:=""
If (Count parameters:C259>4)
	C_TEXT:C284($5)
	$ARCH_Fmt_txt:=$5
End if 

$ARCH_Result_txt:=""

QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223=$ARCH_Reason_txt; *)
If ($ARCH_Date_d#!00-00-00!)
	QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=$ARCH_Date_d; *)
End if 

QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]BIN:3=$ARCH_BIN_txt; *)
QUERY:C277([BridgeMHDNBISArchive:139])
Case of 
	: (Records in selection:C76([BridgeMHDNBISArchive:139])=1)
		Case of 
			: (Type:C295($ARCH_Field_ptr->)=Is alpha field:K8:1)
				$ARCH_Result_txt:=$ARCH_Field_ptr->
			: (Type:C295($ARCH_Field_ptr->)=Is text:K8:3)
				$ARCH_Result_txt:=$ARCH_Field_ptr->
			: (Type:C295($ARCH_Field_ptr->)=Is real:K8:4)
				
				$ARCH_Result_txt:=String:C10($ARCH_Field_ptr->; $ARCH_Fmt_txt)
				
			: (Type:C295($ARCH_Field_ptr->)=Is longint:K8:6)
				$ARCH_Result_txt:=String:C10($ARCH_Field_ptr->; $ARCH_Fmt_txt)
				
			: (Type:C295($ARCH_Field_ptr->)=Is integer:K8:5)
				$ARCH_Result_txt:=String:C10($ARCH_Field_ptr->; $ARCH_Fmt_txt)
				
			: (Type:C295($ARCH_Field_ptr->)=Is boolean:K8:9)
				If (($ARCH_Field_ptr->))
					$ARCH_Result_txt:="TRUE"
				Else 
					$ARCH_Result_txt:="FALSE"
				End if 
				
			: (Type:C295($ARCH_Field_ptr->)=Is date:K8:7)
				$ARCH_Result_txt:=String:C10($ARCH_Field_ptr->; Num:C11($ARCH_Fmt_txt))
				
			Else 
				$ARCH_Result_txt:="BAD FIELD TYPE"
		End case 
		
	: (Records in selection:C76([BridgeMHDNBISArchive:139])>1)
		$ARCH_Result_txt:="<<<MANYRECORDSFOUND>>>"
	Else 
		$ARCH_Result_txt:="<<<RECORDNOTFOUND>>>"
End case 

$0:=$ARCH_Result_txt