//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/30/08, 09:35:17
	// ----------------------------------------------------
	// Method: X_CleanIDResTable
	// Description
	// delete entries in the [FileIDRes Table] for an Id in a table.
	// 
	// Parameters
	// $1 : $TblNum_l : table number (long)
	// $2 : $ID_s : record ID (A80)
	// $3 : $IDType_s : LOCAL | REMOTE = whether the Id in $2 is a local id or a remote
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
End if 
C_LONGINT:C283($1; $TblNum_l)
C_TEXT:C284($2; $ID_s; $3; $IDType_s)  // Command Replaced was o_C_STRING length was 80
$TblNum_l:=$1
$ID_s:=$2
$IDType_s:=$3
Case of 
	: ($IDType_s="LOCAL")  //Clear records for a local ID
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$TblNum_l)
		QUERY SELECTION:C341([FileIDRes Table:60]; [FileIDRes Table:60]Local ID:2=$ID_s; *)
		QUERY SELECTION:C341([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4=<>Destination)
		If (Records in selection:C76([FileIDRes Table:60])>0)
			DELETE SELECTION:C66([FileIDRes Table:60])
		End if 
		
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$TblNum_l)
		QUERY SELECTION:C341([FileIDRes Table:60]; [FileIDRes Table:60]Destination ID:3=$ID_s; *)
		QUERY SELECTION:C341([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4="Here")
		If (Records in selection:C76([FileIDRes Table:60])>0)
			DELETE SELECTION:C66([FileIDRes Table:60])
		End if 
		
	: ($IDType_s="REMOTE")  //Clear records for a remote ID
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$TblNum_l)
		QUERY SELECTION:C341([FileIDRes Table:60]; [FileIDRes Table:60]Local ID:2=$ID_s; *)
		QUERY SELECTION:C341([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4="Here")
		If (Records in selection:C76([FileIDRes Table:60])>0)
			DELETE SELECTION:C66([FileIDRes Table:60])
		End if 
		QUERY:C277([FileIDRes Table:60]; [FileIDRes Table:60]File Number:1=$TblNum_l)
		QUERY SELECTION:C341([FileIDRes Table:60]; [FileIDRes Table:60]Destination ID:3=$ID_s; *)
		QUERY SELECTION:C341([FileIDRes Table:60];  & ; [FileIDRes Table:60]Destination:4=<>Destination)
		If (Records in selection:C76([FileIDRes Table:60])>0)
			DELETE SELECTION:C66([FileIDRes Table:60])
		End if 
		
End case 