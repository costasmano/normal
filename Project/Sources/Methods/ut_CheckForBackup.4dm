//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_CheckForBackup
// User name (OS): charlesmiller
// Date and time: 09/17/09, 12:01:42
// ----------------------------------------------------
// Description
// This method 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_OPNToSQLUpgrade  //4D Open to SQL conversion
	//Modified by: Charles Miller (8/11/10 11:42:17)
End if 
C_BOOLEAN:C305($0; BackupInProcess_b)
C_TEXT:C284(SQLQuery_txt)
BackupInProcess_b:=True:C214
C_LONGINT:C283($Count_L)

SQLQuery_txt:="SELECT {fn ut_TestForBackUp() AS BOOLEAN} FROM Preferences INTO :BackupInProcess_b;"
ON ERR CALL:C155("SQL_ERROR")  //
$Count_L:=0
Repeat 
	Begin SQL
		EXECUTE IMMEDIATE :SQLQuery_txt;
	End SQL
	
	If (BackupInProcess_b)
		$Count_L:=$Count_L+1
		DELAY PROCESS:C323(Current process:C322; 600)  // delay 10 seconds
	Else 
		$Count_L:=4
	End if 
Until (Not:C34(BackupInProcess_b) | ($Count_L>4))
//While (Not(SQL End selection))
//  `SQL LOAD RECORD(1)
//SQL LOAD RECORD(SQL All Records )
//End while 
//SQL CANCEL LOAD

$0:=BackupInProcess_b

//End ut_CheckForBackup