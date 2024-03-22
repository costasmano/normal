//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/30/06, 17:35:56
	// ----------------------------------------------------
	// Method: ut_RetrieveTableArrDoc
	// Description
	// 
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(10/7/08 09:34:28)
	Mods_2008_CM_5404
	//check the number of tables in the stored file does is less than the actual number. 
	// Modified by: costasmanousakis-(Designer)-(10/12/10 09:07:02)
	Mods_2010_10
	//  `Added the * param at the end of the SET FIELD TITLES and SET TABLE TITLES so that they appear
	//  `sorted in the formula editors also
	Mods_2011_06  // CJ Miller`06/14/11, 11:06:35      ` Type all local variables for v1
End if 

C_BOOLEAN:C305($UseFile_b)
C_BLOB:C604(vBLobDocArrays)
C_TEXT:C284($Filename)

$UseFile_b:=False:C215
$Filename:="InitTableSortOrder.txt"
$UseFile_b:=ut_LoadBlobArrDoc($Filename)
C_LONGINT:C283($nTables; $i)
If ($UseFile_b=True:C214)
	
	C_LONGINT:C283($BlobOffSet_l)
	$nTables:=Get last table number:C254
	ARRAY TEXT:C222($asTableName; 0)  //Command Replaced was o_ARRAY string length was 31
	ARRAY INTEGER:C220($aiTableNumber; 0)
	
	C_BOOLEAN:C305($authUserConsRtg; $authUserConsInsp; $bShowTable)
	$authUserConsRtg:=(User in group:C338(Current user:C182; "Conslt Rating - ReadOnly") | User in group:C338(Current user:C182; "Conslt Rating - ReadWrite"))
	$authUserConsInsp:=$authUserConsRtg  //they are both the same.
	For ($i; 1; $nTables)
		If (Is table number valid:C999($i))
			ARRAY TEXT:C222($asFieldNames; 0)  //Command Replaced was o_ARRAY string length was 31
			ARRAY INTEGER:C220($aiFieldNums; 0)
			BLOB TO VARIABLE:C533(vBlobDocArrays; $asFieldNames; $BlobOffSet_l)
			BLOB TO VARIABLE:C533(vBlobDocArrays; $aiFieldNums; $BlobOffSet_l)
			SET FIELD TITLES:C602(Table:C252($i)->; $asFieldNames; $aiFieldNums; *)
		Else 
			
		End if 
		// UpdateProgress ($i;$nTables)
	End for 
	
	BLOB TO VARIABLE:C533(vBlobDocArrays; $asTableName; $BlobOffSet_l)
	BLOB TO VARIABLE:C533(vBlobDocArrays; $aiTableNumber; $BlobOffSet_l)
	
	For ($i; $nTables; 1; -1)
		$bShowTable:=True:C214
		If ($i<=Size of array:C274($asTableName))  //Mods_2008_CM_5404
			Case of 
				: ($asTableName{$i}="Conslt Rating Cost")
					$bShowTable:=$authUserConsRtg
				: ($asTableName{$i}="Cons Inspection Cost")
					$bShowTable:=$authUserConsInsp
			End case 
			
		End if 
		
		If (Not:C34($bShowTable))
			DELETE FROM ARRAY:C228($asTableName; $i)
			DELETE FROM ARRAY:C228($aiTableNumber; $i)
		End if 
		
	End for 
	
	SET TABLE TITLES:C601($asTableName; $aiTableNumber; *)
	
Else 
	G_SortTable_new
End if 

SET BLOB SIZE:C606(vBlobDocArrays; 0)