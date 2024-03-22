//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/11/10, 14:16:30
//----------------------------------------------------
//Method: ut_SQLReturnINSActRecords
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 14:16:32)
	// Modified by: Charles Miller-(Designer)-(7/6/12 16:55:33)
	Mods_2012_07
	//  `Added READ ONLY (*) at the  start
	
End if 
READ ONLY:C145(*)

C_TEXT:C284($1; $2; $UserName_txt; $Destination_txt)
C_LONGINT:C283($0; $Size_l)

$Destination_txt:=$1
$UserName_txt:=$2

SET QUERY DESTINATION:C396(Into set:K19:2; "Set1")
Case of 
	: ($Destination_txt="")
		//non district query
		QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=-1; *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=1)
	: ($Destination_txt="ALL")  //
		QUERY:C277([Activity Log:59]; [Activity Log:59]RefID:28>0)
		
	Else 
		$Destination_txt:="District "+$1+" BMS"
		QUERY:C277([Activity Log:59]; [Activity Log:59]Status:9=-1; *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]FileID Local:24=1; *)
		QUERY:C277([Activity Log:59];  | ; [Activity Log:59]Destination:1=$Destination_txt)
End case 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
USE SET:C118("Set1")

RELATE MANY SELECTION:C340([Owners of Data:62]RefID:1)

//then query that selection for owners

RELATE ONE SELECTION:C349([Owners of Data:62]; [Activity Log:59])

CREATE SET:C116([Activity Log:59]; "Set2")

CREATE EMPTY SET:C140([Activity Log:59]; "FinalSet")

DIFFERENCE:C122("Set1"; "Set2"; "FinalSet")

USE SET:C118("FinalSet")
CLEAR SET:C117("Set1")
CLEAR SET:C117("Set2")
CLEAR SET:C117("FinalSet")
ARRAY LONGINT:C221($ActivityKeys_al; 0)
C_LONGINT:C283($Size_l)

ARRAY LONGINT:C221($Table_numbers_al; 0)

APPEND TO ARRAY:C911($Table_numbers_al; Table:C252(->[Inspections:27]))
APPEND TO ARRAY:C911($Table_numbers_al; Table:C252(->[Combined Inspections:90]))
APPEND TO ARRAY:C911($Table_numbers_al; Table:C252(->[BMS Inspections:44]))
APPEND TO ARRAY:C911($Table_numbers_al; Table:C252(->[Field Trip:43]))
APPEND TO ARRAY:C911($Table_numbers_al; Table:C252(->[Standard Photos:36]))
APPEND TO ARRAY:C911($Table_numbers_al; Table:C252(->[ElementsSafety:29]))
APPEND TO ARRAY:C911($Table_numbers_al; Table:C252(->[BMS Field Trip:56]))
APPEND TO ARRAY:C911($Table_numbers_al; Table:C252(->[Cond Units:45]))

QUERY SELECTION WITH ARRAY:C1050([Activity Log:59]FileID Local:24; $Table_numbers_al)


QUERY SELECTION:C341([Activity Log:59]; [Activity Log:59]Activity Type:3="NRC")

$Size_l:=Records in selection:C76([Activity Log:59])

$0:=$Size_l
//End ut_SQLReturnINSActRecords