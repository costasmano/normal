//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/14/06, 09:36:59
	// ----------------------------------------------------
	// Method: INSP_DWNLD_TmMembers
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2007_CM03
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/27/10 15:37:06)
End if 
C_BOOLEAN:C305($0)
$0:=True:C214
SQL_Select:="SELECT [Person ID] FROM [Field Trip] WHERE [InspID] = :RemoteInspID_L"
ARRAY LONGINT:C221(PersonIDs_al; 0)
ON ERR CALL:C155("SQL_ERROR")
SQL EXECUTE:C820(SQL_Select; PersonIDs_al)
While (Not:C34(SQL End selection:C821))
	SQL LOAD RECORD:C822(SQL all records:K49:10)
End while 
SQL CANCEL LOAD:C824
ON ERR CALL:C155("4D_Errors")
C_LONGINT:C283($NumRecs_L; INSP_LocalInspID_L; INSP_RemoteChildID_L; $i)

If ((Size of array:C274(PersonIDs_al)>0) & (Not:C34(SQLError_b)))
	$NumRecs_L:=Size of array:C274(PersonIDs_al)
	ut_Message("DownLoading "+String:C10($NumRecs_L)+" TeamMembers.."+<>sCR)
	For ($i; 1; $NumRecs_L)
		ut_Message(String:C10($i)+"...")
		CREATE RECORD:C68([Field Trip:43])
		[Field Trip:43]InspID:1:=INSP_LocalInspID_L
		[Field Trip:43]Person ID:2:=Num:C11(aDblLookUpDest(Table:C252(->[Personnel:42]); String:C10(PersonIDs_al{$i}); "Here"; "MHD BMS"))
		SAVE RECORD:C53([Field Trip:43])
		LogNewRecord(->[Inspections:27]InspID:2; ->[Field Trip:43]InspID:1; ->[Field Trip:43]Person ID:2; 3; ""; ->[Personnel:42]Person ID:1)
		
	End for 
	ut_Message(<>sCR)
	
End if 

Case of 
	: (SQLError_b)
		$0:=False:C215
	: (4DError_b)
		$0:=False:C215
	Else 
		$0:=True:C214
End case 