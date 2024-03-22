//%attributes = {"invisible":true}
//Method: SR_ut_AddColumnsToStatusRpt
//Description
//  ` Add new colums to table [Status Report]
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 03/13/13, 13:29:31
	// ----------------------------------------------------
	//Created : 
	Mods_2013_03
End if 
//
If (User in group:C338(Current user:C182; "Design Access Group"))
	C_LONGINT:C283($numFlds_L; $loop_L; $Tbl_L)
	$numFlds_L:=Get last field number:C255(->[Status Report:69])
	$Tbl_L:=Table:C252(->[Status Report:69])
	C_BOOLEAN:C305($FoundFld_b; $AddFlds_b)
	$AddFlds_b:=False:C215
	$FoundFld_b:=False:C215
	For ($loop_L; 1; $numFlds_L)
		If (Field name:C257($Tbl_L; $loop_L)="S_D1_Area")
			$loop_L:=$numFlds_L
			$FoundFld_b:=True:C214
		End if 
		
	End for 
	
	If (Not:C34($FoundFld_b))
		CONFIRM:C162("Do you want to create the new fields?")
		
		If (OK=1)
			$AddFlds_b:=True:C214
		End if 
		
	Else 
		ALERT:C41("Fields have already been defined!")
	End if 
	
	If ($AddFlds_b)
		C_TEXT:C284($Sql_txt; $Sql1_txt)
		ARRAY TEXT:C222($root_atxt; 0)
		APPEND TO ARRAY:C911($root_atxt; "S")
		APPEND TO ARRAY:C911($root_atxt; "T")
		
		C_LONGINT:C283($loop_L; $d_L)
		$Sql_txt:=""
		C_TEXT:C284($linef_txt)
		$linef_txt:="] REAL , "+Char:C90(13)
		For ($loop_L; 1; Size of array:C274($root_atxt))
			
			For ($d_L; 1; 6)
				$Sql1_txt:="ALTER TABLE [Status Report] ADD ["+$root_atxt{$loop_L}+"_D"+String:C10($d_L)+"_Area] REAL ;"
				Begin SQL
					EXECUTE IMMEDIATE :$Sql1_txt ; 
				End SQL
				
				$Sql1_txt:="ALTER TABLE [Status Report] ADD ["+$root_atxt{$loop_L}+"_D"+String:C10($d_L)+"_SD_Area] REAL ;"
				Begin SQL
					EXECUTE IMMEDIATE :$Sql1_txt ; 
				End SQL
				$Sql1_txt:="ALTER TABLE [Status Report] ADD ["+$root_atxt{$loop_L}+"_D"+String:C10($d_L)+"_NHS_Area] REAL ;"
				Begin SQL
					EXECUTE IMMEDIATE :$Sql1_txt ; 
				End SQL
				
				$Sql1_txt:="ALTER TABLE [Status Report] ADD ["+$root_atxt{$loop_L}+"_D"+String:C10($d_L)+"_NHS_SD_Area] REAL ;"
				Begin SQL
					EXECUTE IMMEDIATE :$Sql1_txt ; 
				End SQL
				
			End for 
			
		End for 
		
		ARRAY TEXT:C222($root_atxt; 0)
		APPEND TO ARRAY:C911($root_atxt; "MDC")
		APPEND TO ARRAY:C911($root_atxt; "DEM")
		APPEND TO ARRAY:C911($root_atxt; "MBTA")
		APPEND TO ARRAY:C911($root_atxt; "MTA")
		APPEND TO ARRAY:C911($root_atxt; "MPA")
		APPEND TO ARRAY:C911($root_atxt; "DNR")
		For ($loop_L; 1; Size of array:C274($root_atxt))
			
			$Sql1_txt:="ALTER TABLE [Status Report] ADD ["+$root_atxt{$loop_L}+"_Area] REAL ;"
			Begin SQL
				EXECUTE IMMEDIATE :$Sql1_txt ; 
			End SQL
			
			$Sql1_txt:="ALTER TABLE [Status Report] ADD ["+$root_atxt{$loop_L}+"_SD_Area] REAL ;"
			Begin SQL
				EXECUTE IMMEDIATE :$Sql1_txt ; 
			End SQL
			$Sql1_txt:="ALTER TABLE [Status Report] ADD ["+$root_atxt{$loop_L}+"_NHS_Area] REAL ;"
			Begin SQL
				EXECUTE IMMEDIATE :$Sql1_txt ; 
			End SQL
			
			$Sql1_txt:="ALTER TABLE [Status Report] ADD ["+$root_atxt{$loop_L}+"_NHS_SD_Area] REAL ;"
			Begin SQL
				EXECUTE IMMEDIATE :$Sql1_txt ; 
			End SQL
			
		End for 
		
		ALERT:C41("Finished Creating New Fields")
	End if 
	
End if 

//End SR_ut_AddColumnsToStatusRpt