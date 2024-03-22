//%attributes = {"invisible":true}
//Method: UTL_CreatePathDocument
//
//============================================================================
//== DESCRIPTION
//Create a Server Path Connection Document (aka Login Key File)
//$1 - $Path_To_Document
//$2 - $ServerPath - See below
//$3 - $Username
//$4 - $Password - Null string for "without password"
//$5 - $NC_ID - Network Component #
//$6 - $Deliver_For_Mac_OS
//Note: The ServerPath has the following format by inspection
//    IP Address (TCP)
//    IP Address {,} Port (TCP)
//    Database Name {tab} Server Machine "Name" (TCP)
//    Server Machine Name {:} NC Published Name {@} Appletalk Zone (ADSP)
//
C_TEXT:C284($Method_Name)  // Command Replaced was o_C_STRING length was 45
$Method_Name:="UTL_CreatePathDocument"
//----------------------------------------------------------------------------
//-- REVISION HISTORY
C_BOOLEAN:C305(<>Create_CWA)  // Apr 28, 2000 - Charles Albrecht
C_BOOLEAN:C305(<>Modify_CWA)  // Apr 30, 2000 - charlesa@pobox.com
//-- Apr 30, 2000 - Submitted to 4D NUG/4D Zine
//-- Jun 13, 2000 - Corrected NC field byte ordering
//============================================================================
//-- PARAMETER DECLARATIONS
C_TEXT:C284($1; $Path_To_Document)
$Path_To_Document:=$1
C_TEXT:C284($2; $ServerPath)  // Command Replaced was o_C_STRING length was 81
$ServerPath:=$2
C_TEXT:C284($3; $Username)  // Command Replaced was o_C_STRING length was 31
$Username:=$3
C_TEXT:C284($4; $Password)  // Command Replaced was o_C_STRING length was 31
$Password:=$4
C_LONGINT:C283($5; $NC_ID)  //Command Replaced was o_C_INTEGER
$NC_ID:=$5
C_BOOLEAN:C305($6; $Deliver_For_Mac_OS)
$Deliver_For_Mac_OS:=$6
//----------------------------------------------------------------------------
//-- CONSTANT DECLARATIONS
//<>Null_String is a string defined elsewhere as ""
//----------------------------------------------------------------------------
//-- LOCAL DECLARATIONS
C_LONGINT:C283($Offset)
C_BLOB:C604($FinalContents)
C_BLOB:C604($TempStorage)
//----------------------------------------------------------------------------
//-- PROCESS DECLARATIONS
//
//----------------------------------------------------------------------------
//-- HIDDEN METHOD CALLS
If (False:C215)
	//Hidden procedures (et al.) for Insider
End if 
//============================================================================
//-- Code Block
//
If ($Password="")
	$Password:="*"*0x000E  //convention used by 4D for "without password"
End if 

//present "save" dialog if an empty document path is passed.
CLOSE DOCUMENT:C267(Create document:C266($Path_To_Document))
$Path_To_Document:=Document

If ($Path_To_Document#"")
	SET BLOB SIZE:C606($FinalContents; 0x0094; 0x0000)
	
	//server 'location' - Pascal String @ 0x00 (length < 82)
	$Offset:=0x0000
	SET BLOB SIZE:C606($TempStorage; 0x0000)
	TEXT TO BLOB:C554($ServerPath; $TempStorage; Mac Pascal string:K22:8)
	COPY BLOB:C558($TempStorage; $FinalContents; 0x0000; $Offset; BLOB size:C605($TempStorage))
	
	//username - Pascal String @ 0x52 (length < 32)
	$Offset:=0x0052
	SET BLOB SIZE:C606($TempStorage; 0x0000)
	TEXT TO BLOB:C554($Username; $TempStorage; Mac Pascal string:K22:8)
	COPY BLOB:C558($TempStorage; $FinalContents; 0x0000; $Offset; BLOB size:C605($TempStorage))
	
	//password - Pascal String @ 0x72 (length < 32)
	$Offset:=0x0072
	SET BLOB SIZE:C606($TempStorage; 0x0000)
	TEXT TO BLOB:C554($Password; $TempStorage; Mac Pascal string:K22:8)
	COPY BLOB:C558($TempStorage; $FinalContents; 0x0000; $Offset; BLOB size:C605($TempStorage))
	
	//network component - Integer @ 0x92
	$Offset:=0x0092
	SET BLOB SIZE:C606($TempStorage; 0x0000)
	If ($Deliver_For_Mac_OS)
		INTEGER TO BLOB:C548($NC_ID; $TempStorage; Macintosh byte ordering:K22:2)
	Else 
		INTEGER TO BLOB:C548($NC_ID; $TempStorage; PC byte ordering:K22:3)
	End if 
	COPY BLOB:C558($TempStorage; $FinalContents; 0x0000; $Offset; BLOB size:C605($TempStorage))
	
	BLOB TO DOCUMENT:C526($Path_To_Document; $FinalContents)
	If ($Deliver_For_Mac_OS)
		//_ O _SET DOCUMENT CREATOR($Path_To_Document;"4D+6")
		//_ O _SET DOCUMENT TYPE($Path_To_Document;"paTH")
	Else 
		//_ O _SET DOCUMENT TYPE($Path_To_Document;"PTH")
	End if 
	
End if 
//
//----------------------------------------------------------------------------
//
//__END__