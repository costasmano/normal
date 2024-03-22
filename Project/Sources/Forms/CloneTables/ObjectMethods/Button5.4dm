
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/28/11, 16:09:58
//----------------------------------------------------
//Method: Object Method: CloneTables.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
End if 
C_BLOB:C604($TablesToBeCloned_blb)
SET BLOB SIZE:C606($TablesToBeCloned_blb; 0)
VARIABLE TO BLOB:C532(ProcessTableNumber_al; $TablesToBeCloned_blb; *)
VARIABLE TO BLOB:C532(ProcessTableNames_atxt; $TablesToBeCloned_blb; *)
VARIABLE TO BLOB:C532(RemoteKeyName_atxt; $TablesToBeCloned_blb; *)
VARIABLE TO BLOB:C532(RemoteQueryType_atxt; $TablesToBeCloned_blb; *)
VARIABLE TO BLOB:C532(RemoteKey_atxt; $TablesToBeCloned_blb; *)
VARIABLE TO BLOB:C532(RemoteCustomQuery_atxt; $TablesToBeCloned_blb; *)
VARIABLE TO BLOB:C532(RemoteType_al; $TablesToBeCloned_blb; *)
C_TIME:C306($Doc)

$Doc:=Create document:C266("")
CLOSE DOCUMENT:C267($doc)
BLOB TO DOCUMENT:C526(Document; $TablesToBeCloned_blb)



//End Object Method: CloneTables.Button1

