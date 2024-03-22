//%attributes = {"invisible":true}
//Method: ut_CheckTownFolderNames
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/30/17, 15:27:46
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
End if 
//
C_TEXT:C284($TownPath_txt)
$TownPath_txt:=Select folder:C670("Select Town Folder to start")
If (OK=1)
	ARRAY TEXT:C222($TownFolders_atxt; 0)
	CLEAR VARIABLE:C89($TownFolders_atxt)
	FOLDER LIST:C473($TownPath_txt; $TownFolders_atxt)
	
	ARRAY TEXT:C222($TownPrefix_atxt; 0)
	ARRAY TEXT:C222($TownName_atxt; 0)
	
	Begin SQL
		select
		[Town Data].[BDEPT Prefix], 
		[Town Data].[Town Name]
		from 
		[Town Data]
		into
		:$TownPrefix_atxt,
		:$TownName_atxt;
		
	End SQL
	C_TEXT:C284($Errors_txt)
	C_LONGINT:C283($Loop_L; $Position_L)
	C_TEXT:C284($FinalName_txt)
	For ($Loop_L; Size of array:C274($TownFolders_atxt); 1; -1)
		$Position_L:=Find in array:C230($TownPrefix_atxt; Substring:C12($TownFolders_atxt{$Loop_L}; 1; 3)+"@")
		If ($Position_L>0)
			$FinalName_txt:=$TownPrefix_atxt{$Position_L}+" "+$TownName_atxt{$Position_L}
			If ($TownFolders_atxt{$Loop_L}=$FinalName_txt)
				DELETE FROM ARRAY:C228($TownPrefix_atxt; $Position_L; 1)
				DELETE FROM ARRAY:C228($TownName_atxt; $Position_L; 1)
				DELETE FROM ARRAY:C228($TownFolders_atxt; $Loop_L; 1)
				
				
			End if 
			
			
			
			
		End if 
		
		
	End for 
	$Errors_txt:="Mistmatch $TownFolders_atxt"+Char:C90(Carriage return:K15:38)
	SORT ARRAY:C229($TownPrefix_atxt; $TownName_atxt; >)
	For ($Loop_L; 1; Size of array:C274($TownName_atxt))
		
		$Errors_txt:=$Errors_txt+$TownPrefix_atxt{$Loop_L}+Char:C90(Tab:K15:37)+$TownName_atxt{$Loop_L}+Char:C90(Carriage return:K15:38)
		
		
	End for 
	$Errors_txt:=$Errors_txt+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+"$TownFolders_atxt remainders"+Char:C90(Carriage return:K15:38)
	SORT ARRAY:C229($TownFolders_atxt; >)
	
	For ($Loop_L; 1; Size of array:C274($TownFolders_atxt))
		
		$Errors_txt:=$Errors_txt+$TownFolders_atxt{$Loop_L}+Char:C90(Carriage return:K15:38)
		
		
	End for 
	C_TIME:C306($Doc_tm)
	
	$Doc_tm:=Create document:C266("")
	SEND PACKET:C103($Doc_tm; $Errors_txt)
	CLOSE DOCUMENT:C267($Doc_tm)
End if 

//End ut_CheckTownFolderNames