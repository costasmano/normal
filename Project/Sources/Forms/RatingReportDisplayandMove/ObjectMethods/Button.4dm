//Method: RatingReportDisplayandMove.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 11/16/17, 13:52:28
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11  //Add code to allow for moving/copying rating reports to directory structure
	//Modified by: Chuck Miller (11/16/17 16:22:20)
End if 
//
C_TEXT:C284($QueryBy_txt)
C_LONGINT:C283($Position_L)
ARRAY TEXT:C222($DropDownValues_atxt; 0)
$QueryBy_txt:=" "+Char:C90(1)
Begin SQL
	select 
	[TableOfLists].[ListValue_s], 
	[TableOfLists].[ListSequence_l] 
	from 
	[TableOfLists]
	where
	[TableOfLists].[ListName_s] = 'RatingReportSuffix'
	ORDER BY 2 ASC
	into 
	:$DropDownValues_atxt;
	
	
End SQL
C_LONGINT:C283($Loop_L; $Selection_L)
For ($Loop_L; 1; Size of array:C274($DropDownValues_atxt))  //build for pop up array
	$QueryBy_txt:=$QueryBy_txt+$DropDownValues_atxt{$Loop_L}+Char:C90(1)
End for 
$Selection_L:=Pop up menu:C542($QueryBy_txt)
If ($Selection_L>0)
	C_TEXT:C284($NewFileName_txt)
	$NewFileName_txt:=OBJECT Get title:C1068(*; "FileName")
	OBJECT SET TITLE:C194(*; "SuffixValue"; $DropDownValues_atxt{$Selection_L})
	For ($Loop_L; 2; Size of array:C274($DropDownValues_atxt))
		$Position_L:=Position:C15($DropDownValues_atxt{$Loop_L}; $NewFileName_txt)
		If ($Position_L>0)
			$NewFileName_txt:=Replace string:C233($NewFileName_txt; "_"+$DropDownValues_atxt{$Loop_L}; "")
		End if 
	End for 
	Case of 
		: ($Selection_L=1)
			
		: ($Selection_L>1)
			$NewFileName_txt:=$NewFileName_txt+"_"+$DropDownValues_atxt{$Selection_L}
	End case 
	OBJECT SET TITLE:C194(*; "FileName"; $NewFileName_txt)
End if 
//End RatingReportDisplayandMove.Button