//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/18/11, 14:24:27
//----------------------------------------------------
//Method: ut_CreateNewmethods
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (3/18/11 14:24:28)
	
	//ut_CreateNewmethods
	C_TEXT:C284($ImportFolder_txt; $DocumentName_txt; $ImportedMethds_txt; $SkippedMethdos_txt; $MethodPath_txt)
	C_LONGINT:C283($Loop_l)
	ARRAY LONGINT:C221($Properties_al; 0)
	ARRAY LONGINT:C221($Properties_al; 6)
	$Properties_al{1}:=0
	$Properties_al{2}:=0
	$Properties_al{3}:=0
	$Properties_al{4}:=0
	$Properties_al{5}:=0
	$Properties_al{6}:=0
	C_BLOB:C604($Document_blb)
	C_TEXT:C284($4DMethodFolder_txt)
	C_TEXT:C284($Error_txt)
	$Error_txt:=""
	C_LONGINT:C283($Error_l; $MethodCount_l; $ChangedCount_l; $NewCount_l; $SynchCount_l; $FnCount_l; $FailureCount_l; $NewdataFileCount_l; $ReplacedCount_l; $UtilityCount_l)
	$MethodCount_l:=0
	$ChangedCount_l:=0
	$NewCount_l:=0
	$SynchCount_l:=0
	$FnCount_l:=0
	$FailureCount_l:=0
	$NewdataFileCount_l:=0
	$ReplacedCount_l:=0
	$UtilityCount_l:=0
	$ImportedMethds_txt:=""
	$SkippedMethdos_txt:=""
	Repeat 
		$ImportFolder_txt:=Select folder:C670("Select Import Folder")
		If (OK=1)
			ARRAY TEXT:C222($NewMethods_atxt; 0)
			DOCUMENT LIST:C474($ImportFolder_txt; $NewMethods_atxt)
			For ($Loop_l; 1; Size of array:C274($NewMethods_atxt))
				$DocumentName_txt:=$NewMethods_atxt{$Loop_l}
				$DocumentName_txt:=Replace string:C233($DocumentName_txt; ".c4d"; "")
				$DocumentName_txt:=Replace string:C233($DocumentName_txt; ".txt"; "")
				$MethodCount_l:=$MethodCount_l+1
				If ($NewMethods_atxt{$Loop_l}[[1]]#".")
					
					$MethodPath_txt:=METHOD Get path:C1164(Path project method:K72:1; $DocumentName_txt)
					
					If ($MethodPath_txt="")
						$ImportedMethds_txt:=$ImportedMethds_txt+$DocumentName_txt+Char:C90(Carriage return:K15:38)
						$Properties_al{6}:=0
						$4DMethodFolder_txt:="DB Synch New"
						Case of 
							: (Position:C15("New Data File"; $ImportFolder_txt)>0)
								$4DMethodFolder_txt:="DB New Data File"
								$NewdataFileCount_l:=$NewdataFileCount_l+1
								
							: (Position:C15("Replaced"; $ImportFolder_txt)>0)
								$4DMethodFolder_txt:="v11 Replaced"
								$ReplacedCount_l:=$ReplacedCount_l+1
								
							: (Position:C15("Utilities"; $ImportFolder_txt)>0)
								$4DMethodFolder_txt:="Utilities"
								$UtilityCount_l:=$UtilityCount_l+1
								
							: (Position:C15("Changed"; $ImportFolder_txt)>0)
								$4DMethodFolder_txt:="DB Synch Mod"
								$ChangedCount_l:=$ChangedCount_l+1
								
							: (Position:C15("fn calls"; $ImportFolder_txt)>0)
								$Properties_al{6}:=1
								$4DMethodFolder_txt:="DB Synch FN"
								$FnCount_l:=$FnCount_l+1
								
							: (Position:C15("unused"; $ImportFolder_txt)>0)
								$4DMethodFolder_txt:="DB Synch Unused"
								$SynchCount_l:=$SynchCount_l+1
								
							: (Position:C15("Checked"; $ImportFolder_txt)>0)
								$4DMethodFolder_txt:="v11 Replaced"
								$SynchCount_l:=$SynchCount_l+1
								
							Else 
								$NewCount_l:=$NewCount_l+1
						End case 
						DOCUMENT TO BLOB:C525($4DMethodFolder_txt+$NewMethods_atxt{$Loop_l}; $Document_blb)
						C_TEXT:C284($Method_txt)
						$Method_txt:=BLOB to text:C555($Document_blb; UTF8 text without length:K22:17)
						METHOD SET CODE:C1194($MethodPath_txt; $Method_txt)
						
						//$Error_l:=@XX_AP Create method ($DocumentName_txt;$Properties_al;$Document_blb;$4DMethodFolder_txt)
						
					Else 
						$FailureCount_l:=$FailureCount_l+1
						$Error_txt:=$Error_txt+$DocumentName_txt+Char:C90(Carriage return:K15:38)
					End if 
				End if 
			End for 
			
		End if 
	Until (OK=0)
	C_TIME:C306($doc)
	$doc:=Create document:C266("")
	
	
	SEND PACKET:C103($Doc; Char:C90(Carriage return:K15:38)+"========="+Char:C90(Carriage return:K15:38)+"The following methods were not created succesfully"+Char:C90(Carriage return:K15:38))
	SEND PACKET:C103($Doc; $Error_txt)
	
	SEND PACKET:C103($Doc; Char:C90(Carriage return:K15:38)+"========="+Char:C90(Carriage return:K15:38)+"The following methods were created succesfully"+Char:C90(Carriage return:K15:38))
	
	SEND PACKET:C103($Doc; $ImportedMethds_txt)
	SEND PACKET:C103($Doc; Char:C90(Carriage return:K15:38)+"========="+Char:C90(Carriage return:K15:38)+"Statistics"+Char:C90(Carriage return:K15:38))
	
	$Error_txt:=Char:C90(Carriage return:K15:38)+"There were "+String:C10($MethodCount_l)+" methods created. "+Char:C90(Carriage return:K15:38)
	$Error_txt:=$Error_txt+String:C10($NewCount_l)+" in the DB Synch New folder."+Char:C90(Carriage return:K15:38)
	$Error_txt:=$Error_txt+String:C10($ReplacedCount_l)+" in the DB New Data File folder."+Char:C90(Carriage return:K15:38)
	$Error_txt:=$Error_txt+String:C10($UtilityCount_l)+" in the v11 Replaced folder."+Char:C90(Carriage return:K15:38)
	$Error_txt:=$Error_txt+String:C10($ChangedCount_l)+" in the DB Synch Mod folder."+Char:C90(Carriage return:K15:38)
	$Error_txt:=$Error_txt+String:C10($FnCount_l)+" in the DB Synch FN folder. "+Char:C90(Carriage return:K15:38)
	$Error_txt:=$Error_txt+String:C10($SynchCount_l)+" in the DB Synch Unused folder. "+Char:C90(Carriage return:K15:38)
	
	SEND PACKET:C103($Doc; $Error_txt)
	CLOSE DOCUMENT:C267($doc)
	
End if 
//End ut_CreateNewmethods