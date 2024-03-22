//%attributes = {"invisible":true}
// Method: G_ListTable
// Description
//  ` Generic method to display a window for modifying a table.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/24/06, 08:52:45
	// ----------------------------------------------------
	
	// Modified by: costasmanousakis-(Designer)-(1/17/2007 10:29:51)
	Mods_2007_CM04
	// Modified by: costasmanousakis-(Designer)-(10/25/11 15:09:07)
	Mods_2011_10
	//  `Use System parameters UserInputForms and UserOutputForms to set the input and output forms
	// Modified by: Costas Manousakis-(Designer)-(4/4/14 16:22:00)
	Mods_2014_04_bug
	//  `Launch in a separate process- avoides errors  "A Boolean argument was expected." 
	//  `Also added a repeat loop to avoid having to re start the method for different tables and a check for valid table number
	// Modified by: Costas Manousakis-(Designer)-(9/5/14 15:48:25)
	Mods_2014_09
	//  `use at  least 3/4 of the screen ht for the window.
	// Modified by: Costas Manousakis (2/22/17)
	Mods_2017_02
	//  //Add the table name in the window title
	// Modified by: Costas Manousakis-(Designer)-(10/30/17 14:55:18)
	Mods_2017_10
	//  `if output form ends in _LB assume it is a listbox and use the dialog command
	
	// Modified by: Costas Manousakis-(Designer)-(2022-09-15 18:42:59)
	Mods_2022_09_bug
	//  `correct calculation of form width/ht taking account screen width/ht
End if 
If (Count parameters:C259=0)
	C_LONGINT:C283($myPid_L)
	$myPid_L:=New process:C317("G_ListTable"; 0; "TableList"; "GO")
Else 
	C_TEXT:C284($1)
	C_LONGINT:C283($numTables; $i; $selectedTbl)
	C_POINTER:C301($TblPtr)
	$numTables:=Get last table number:C254
	ARRAY POINTER:C280($TablePtr_aptr; $numTables)
	ARRAY TEXT:C222(PickTableName_as; $numTables)  //Command Replaced was o_ARRAY string length was 32
	For ($i; 1; $numTables)
		
		If (Is table number valid:C999($i))
			$TablePtr_aptr{$i}:=Table:C252($i)
			PickTableName_as{$i}:=Table name:C256($i)
		End if 
		
	End for 
	SORT ARRAY:C229(PickTableName_as; $TablePtr_aptr)
	C_BOOLEAN:C305($Done_b)
	$Done_b:=False:C215
	Repeat 
		$selectedTbl:=G_PickFromList(->PickTableName_as; "Hold Shift key to choose forms")
		If ($selectedTbl>0)
			
			$TblPtr:=$TablePtr_aptr{$selectedTbl}
			If (Not:C34(Shift down:C543))
				C_TEXT:C284($userforms_txt)
				ARRAY TEXT:C222($TableForms_atxt; 0)
				FORM GET NAMES:C1167($TblPtr->; $TableForms_atxt)
				$userforms_txt:=ut_GetSysParameter("UserInputForms")
				ARRAY TEXT:C222($InputForms_atxt; 0)
				ut_TextToArray($userforms_txt; ->$InputForms_atxt; Char:C90(13))
				$userforms_txt:=ut_GetSysParameter("UserOutputForms")
				ARRAY TEXT:C222($OutputForms_atxt; 0)
				ut_TextToArray($userforms_txt; ->$OutputForms_atxt; Char:C90(13))
				C_TEXT:C284($inpForm_txt; $outForm_txt; $Tablename_txt)
				$inpForm_txt:="Input"
				$outForm_txt:="Output"
				$Tablename_txt:="["+Table name:C256($TblPtr)+"];"
				C_LONGINT:C283($formindx_L)
				$formindx_L:=Find in array:C230($InputForms_atxt; ($Tablename_txt+"@"))
				If ($formindx_L>0)
					$inpForm_txt:=$InputForms_atxt{$formindx_L}
					$inpForm_txt:=Replace string:C233($inpForm_txt; $Tablename_txt; "")
					$inpForm_txt:=Replace string:C233($inpForm_txt; <>sQu; "")
				End if 
				If (Find in array:C230($TableForms_atxt; $inpForm_txt)<=0)
					//form not found!
					ALERT:C41("Input Form "+$inpForm_txt+" Not found! Specify another input form in "+\
						"system parameter UserInputForms for table ["+Table name:C256($TblPtr)+"]")
				End if 
				$formindx_L:=Find in array:C230($OutputForms_atxt; ($Tablename_txt+"@"))
				If ($formindx_L>0)
					$outForm_txt:=$OutputForms_atxt{$formindx_L}
					$outForm_txt:=Replace string:C233($outForm_txt; $Tablename_txt; "")
					$outForm_txt:=Replace string:C233($outForm_txt; <>sQu; "")
				End if 
				If (Find in array:C230($TableForms_atxt; $outForm_txt)<=0)
					//form not found!
					ALERT:C41("Output Form "+$outForm_txt+" Not found! Specify another output form in "+\
						"system parameter UserOutputForms for table ["+Table name:C256($TblPtr)+"]")
				End if 
				
			Else 
				ARRAY TEXT:C222($InputForms_atxt; 0)
				FORM GET NAMES:C1167($TblPtr->; $InputForms_atxt)
				C_LONGINT:C283($choice)
				$choice:=Find in array:C230($InputForms_atxt; "@input@")
				If ($choice>0)
					$InputForms_atxt{0}:=$InputForms_atxt{$choice}
				End if 
				C_TEXT:C284($menu_txt)
				$choice:=G_PickFromList(->$InputForms_atxt; "input form ["+$InputForms_atxt{0}+"]")
				If ($choice<0)
					$choice:=0
				End if 
				$inpForm_txt:=$InputForms_atxt{$choice}
				If ($choice>0)
					DELETE FROM ARRAY:C228($InputForms_atxt; $choice)
				End if 
				$choice:=Find in array:C230($InputForms_atxt; "@output@")
				If ($choice>0)
					$InputForms_atxt{0}:=$InputForms_atxt{$choice}
				End if 
				$choice:=G_PickFromList(->$InputForms_atxt; "output form ["+$InputForms_atxt{0}+"]")
				If ($choice<0)
					$choice:=0
				End if 
				$outForm_txt:=$InputForms_atxt{$choice}
				
			End if 
			
			FORM SET INPUT:C55($TblPtr->; $inpForm_txt)
			FORM SET OUTPUT:C54($TblPtr->; $outForm_txt)
			C_LONGINT:C283($InpW; $inpH; $outW; $outH; $MaxW; $MaxH; $screenHt; $screenWt)
			$screenWt:=3*(Screen width:C187\4)
			$screenHt:=3*(Screen height:C188\4)
			FORM GET PROPERTIES:C674($TblPtr->; $inpForm_txt; $InpW; $inpH)
			FORM GET PROPERTIES:C674($TblPtr->; $outForm_txt; $outW; $outH)
			SET MENU BAR:C67(3)  //MODS_2007_CM04
			If (($InpW>0) & ($outW>0))  //both forms exist..
				$MaxW:=MinNum(MaxNum($InpW; $outW); $screenWt)
				$MaxH:=MinNum(MaxNum($outH; $inpH); $screenHt)
				ALL RECORDS:C47($TblPtr->)
				NewWindow($MaxW; $MaxH; 0; Plain window:K34:13; "Table ["+Table name:C256($TblPtr)+"]")
				
				If ($outForm_txt="@_LB")
					//indicates a listbox - use Dialog
					DIALOG:C40($TblPtr->; $outForm_txt)
				Else 
					//normal 4D output form use mod selection
					//ON ERR CALL("4D_Errors")
					MODIFY SELECTION:C204($TblPtr->)
				End if 
				
				//ON ERR CALL("")
				CLOSE WINDOW:C154
			Else 
				ALERT:C41("There is no Input and/or Output forms available for table "+Table name:C256($TblPtr))
			End if 
			
		End if 
		CONFIRM:C162("Select another table or Exit?"; "Another"; "Exit")
		$Done_b:=(OK=0)
	Until ($Done_b)
	
End if 