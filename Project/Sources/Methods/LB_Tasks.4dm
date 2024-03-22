//%attributes = {"invisible":true}
// Method: LB_Tasks
// Description
// Do various tasks on a listbox
// Parameters
// $1 : $Task_txt ("SETWINDOWTITLE" | "SHOWALL" | "SHOWSELECTION" | "OMITSELECTION" | "CLEARHEADERS" | "QUERY" | "QUERYSELECTION"
// "ORDER" | "DESELECTALL")
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 02/26/14, 11:22:21
	// ----------------------------------------------------
	//Created : 
	Mods_2014_02
	// Modified by: Costas Manousakis-(Designer)-(9/13/16 14:18:43)
	Mods_2016_09
	//  `For Query selection make sure it is a Q in Sel by intersecting the results with the start set.
	// Modified by: Costas Manousakis-(Designer)-(4/12/18 15:19:36)
	Mods_2018_04
	//  `Fixed error in set names in "QUERYSELECTION" task
	Mods_2018_05  //Make sure [LB_QueryTable]is in read only
	//Modified by: Chuck Miller (5/8/18 14:09:22)
	// Modified by: Costas Manousakis-(Designer)-(2021-10-05T00:00:00 10:50:34)
	Mods_2021_10
	//  `add unload record 
End if 
C_LONGINT:C283($0; $Result_L)
$Result_L:=0
C_TEXT:C284($1; $Task_txt)
C_TEXT:C284($2; $LB_BaseName_txt)
$Task_txt:=$1
$LB_BaseName_txt:=$2
C_POINTER:C301($LB_Table_ptr)
C_LONGINT:C283($LB_Table_Num_L)
C_TEXT:C284($LB_FullName_txt; $LB_HiliteSet_txt; $LB_Selection_txt)
$LB_FullName_txt:=$LB_BaseName_txt+"_LB"
$LB_HiliteSet_txt:=$LB_BaseName_txt+"_HS"
LISTBOX GET TABLE SOURCE:C1014(*; $LB_FullName_txt; $LB_Table_Num_L; $LB_Selection_txt)
$LB_Table_ptr:=Table:C252($LB_Table_Num_L)
READ ONLY:C145([LB_QueryTable:147])
Case of 
		
	: ($Task_txt="SHOWALL")
		ALL RECORDS:C47($LB_Table_ptr->)
		LB_Tasks("CLEARHEADERS"; $LB_BaseName_txt)
		LB_Tasks("DESELECTALL"; $LB_BaseName_txt)
		LB_Tasks("SETWINDOWTITLE"; $LB_BaseName_txt)
		
	: ($Task_txt="SHOWSELECTION")
		If (Records in set:C195($LB_HiliteSet_txt)>0)
			USE SET:C118($LB_HiliteSet_txt)
			LB_Tasks("CLEARHEADERS"; $LB_BaseName_txt)
			LB_Tasks("DESELECTALL"; $LB_BaseName_txt)
			LB_Tasks("SETWINDOWTITLE"; $LB_BaseName_txt)
		Else 
			ALERT:C41("No Records have been Selected!")
		End if 
		
	: ($Task_txt="DELETESELECTION")
		C_LONGINT:C283($NumToDelete_L)
		$NumToDelete_L:=Records in set:C195($LB_HiliteSet_txt)
		If ($NumToDelete_L>0)
			CONFIRM:C162("You are about to delete "+String:C10($NumToDelete_L)+" records!  Are you sure you want to continue?"; "DELETE"; "Cancel")
			If (OK=1)
				USE SET:C118($LB_HiliteSet_txt)
				LB_Tasks("CLEARHEADERS"; $LB_BaseName_txt)
				LB_Tasks("DESELECTALL"; $LB_BaseName_txt)
				LB_Tasks("SETWINDOWTITLE"; $LB_BaseName_txt)
			End if 
		Else 
			ALERT:C41("No Records have been Selected!")
		End if 
		
	: ($Task_txt="OMITSELECTION")
		If (Records in set:C195($LB_HiliteSet_txt)>0)
			CREATE SET:C116($LB_Table_ptr->; "MyLocalSet")
			DIFFERENCE:C122("MyLocalSet"; $LB_HiliteSet_txt; $LB_HiliteSet_txt)
			USE SET:C118($LB_HiliteSet_txt)
			CLEAR SET:C117("MyLocalSet")
			//CLEAR SET("SelectedRecordsSet")
			LB_Tasks("CLEARHEADERS"; $LB_BaseName_txt)
			LB_Tasks("DESELECTALL"; $LB_BaseName_txt)
			LB_Tasks("SETWINDOWTITLE"; $LB_BaseName_txt)
			
		Else 
			ALERT:C41("No Records have been Selected to Omit!")
		End if 
		
	: ($Task_txt="SORT")
		ORDER BY:C49($LB_Table_ptr->)
		If (OK=1)
			LB_Tasks("CLEARHEADERS"; $LB_BaseName_txt)
			LB_Tasks("DESELECTALL"; $LB_BaseName_txt)
		End if 
		
	: ($Task_txt="QUERY")
		COPY NAMED SELECTION:C331($LB_Table_ptr->; "LBPREQUERYSELECTION")
		QUERY:C277($LB_Table_ptr->)
		
		If (OK=1)
			
			If (Records in selection:C76($LB_Table_ptr->)>0)
				LB_Tasks("CLEARHEADERS"; $LB_BaseName_txt)
				LB_Tasks("DESELECTALL"; $LB_BaseName_txt)
				LB_Tasks("SETWINDOWTITLE"; $LB_BaseName_txt)
			Else 
				ALERT:C41("No Records were found!!")
				USE NAMED SELECTION:C332("LBPREQUERYSELECTION")
			End if 
			CLEAR NAMED SELECTION:C333("LBPREQUERYSELECTION")
			UNLOAD RECORD:C212($LB_Table_ptr->)
			
		End if 
		
	: ($Task_txt="QUERYSELECTION")
		COPY NAMED SELECTION:C331($LB_Table_ptr->; "LBPREQUERYSELECTION")
		CREATE SET:C116($LB_Table_ptr->; "LBPREQUERYSELSET")
		QUERY SELECTION:C341($LB_Table_ptr->)
		
		If (OK=1)
			CREATE SET:C116($LB_Table_ptr->; "LBPOSTQUERYSELSET")
			INTERSECTION:C121("LBPREQUERYSELSET"; "LBPOSTQUERYSELSET"; "LBPOSTQUERYSELSET")
			USE SET:C118("LBPOSTQUERYSELSET")
			CLEAR SET:C117("LBPOSTQUERYSELSET")
			If (Records in selection:C76($LB_Table_ptr->)>0)
				LB_Tasks("CLEARHEADERS"; $LB_BaseName_txt)
				LB_Tasks("DESELECTALL"; $LB_BaseName_txt)
				LB_Tasks("SETWINDOWTITLE"; $LB_BaseName_txt)
			Else 
				ALERT:C41("No Records were found!!")
				USE NAMED SELECTION:C332("LBPREQUERYSELECTION")
			End if 
			
			UNLOAD RECORD:C212($LB_Table_ptr->)
			
		End if 
		CLEAR NAMED SELECTION:C333("LBPREQUERYSELECTION")
		CLEAR SET:C117("LBPREQUERYSELSET")
		
	: ($Task_txt="CLEARHEADERS")
		
		C_LONGINT:C283($numcols)
		ARRAY TEXT:C222($arrColNames_atxt; 0)
		ARRAY TEXT:C222($ColHdrNames_atxt; 0)
		ARRAY POINTER:C280($ColVars; 0)
		ARRAY POINTER:C280($HeaderVars; 0)
		ARRAY BOOLEAN:C223($colVis; 0)
		ARRAY POINTER:C280($ColStyles; 0)
		LISTBOX GET ARRAYS:C832(*; $LB_FullName_txt; $arrColNames_atxt; $ColHdrNames_atxt; $ColVars; $HeaderVars; $colVis; $ColStyles)
		
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274($HeaderVars))
			$HeaderVars{$loop_L}->:=0
		End for 
		
	: ($Task_txt="SETWINDOWTITLE")
		C_TEXT:C284($WinTitle_txt)
		$WinTitle_txt:=""
		C_LONGINT:C283($indx_L)
		$indx_L:=Find in array:C230(LB_ListBoxNames_atxt; $LB_BaseName_txt)
		
		If ($indx_L>0)
			$WinTitle_txt:=LB_WindowTitles_atxt{$indx_L}
		End if 
		
		If ($WinTitle_txt#"")
			SET WINDOW TITLE:C213($WinTitle_txt+" - Displaying ["+String:C10(Records in selection:C76($LB_Table_ptr->); "###,###,##0")+" out of "+String:C10(Records in table:C83($LB_Table_ptr->); "###,###,##0")+"] records")
		Else 
			SET WINDOW TITLE:C213("Displaying ["+String:C10(Records in selection:C76($LB_Table_ptr->); "###,###,##0")+" out of "+String:C10(Records in table:C83($LB_Table_ptr->); "###,###,##0")+"] records")
		End if 
		
	: ($Task_txt="DESELECTALL")
		CREATE EMPTY SET:C140($LB_Table_ptr->; $LB_HiliteSet_txt)
		UNLOAD RECORD:C212($LB_Table_ptr->)
		
	: ($Task_txt="ADDTOLIST")
		C_TEXT:C284($3; $WinTitle_txt)
		$WinTitle_txt:=$3
		C_TEXT:C284($4; $inputForm_txt)
		$inputForm_txt:=$4
		C_LONGINT:C283($KeyFldNum_L)
		$KeyFldNum_L:=0
		If (Count parameters:C259>4)
			C_POINTER:C301($5; $KeyFld_Ptr)
			$KeyFld_Ptr:=$5
			$KeyFldNum_L:=Field:C253($KeyFld_Ptr)
		End if 
		
		C_LONGINT:C283($indx_L)
		If (Type:C295(LB_ListBoxNames_atxt)#Text array:K8:16)
			ARRAY TEXT:C222(LB_ListBoxNames_atxt; 0)
			ARRAY TEXT:C222(LB_WindowTitles_atxt; 0)
			ARRAY TEXT:C222(LB_InputForms_atxt; 0)
			ARRAY LONGINT:C221(LB_ListBoxKeyFldNum_aL; 0)
		End if 
		$indx_L:=Find in array:C230(LB_ListBoxNames_atxt; $LB_BaseName_txt)
		If ($indx_L>0)
			LB_WindowTitles_atxt{$indx_L}:=$WinTitle_txt
		Else 
			APPEND TO ARRAY:C911(LB_ListBoxNames_atxt; $LB_BaseName_txt)
			APPEND TO ARRAY:C911(LB_WindowTitles_atxt; $WinTitle_txt)
			APPEND TO ARRAY:C911(LB_InputForms_atxt; $inputForm_txt)
			APPEND TO ARRAY:C911(LB_ListBoxKeyFldNum_aL; $KeyFldNum_L)
		End if 
		QUERY:C277([LB_QueryTable:147]; [LB_QueryTable:147]QueryName_s:1=$LB_BaseName_txt)
		
		Case of 
			: (Records in selection:C76([LB_QueryTable:147])<1)
				
				If (User in group:C338(Current user:C182; "Design Access Group"))
					CREATE RECORD:C68([LB_QueryTable:147])
					[LB_QueryTable:147]QueryName_s:1:=$LB_BaseName_txt
					[LB_QueryTable:147]TableNumber_l:3:=Table:C252($LB_Table_ptr)
					[LB_QueryTable:147]TableName_s:4:=Table name:C256($LB_Table_ptr)
					[LB_QueryTable:147]WindowTitle_s:5:=$WinTitle_txt
					Inc_Sequence("LB_QueryTable"; ->[LB_QueryTable:147]UniqueKey_l:6)
					LogNewRecord(->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0; "LB_QueryTable")
					InitChangeStack(1)
					PushChange(1; ->[LB_QueryTable:147]QueryName_s:1)
					PushChange(1; ->[LB_QueryTable:147]TableNumber_l:3)
					PushChange(1; ->[LB_QueryTable:147]TableName_s:4)
					PushChange(1; ->[LB_QueryTable:147]WindowTitle_s:5)
					FlushGrpChgs(1; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; ->[LB_QueryTable:147]UniqueKey_l:6; 0)
					
					SAVE RECORD:C53([LB_QueryTable:147])
				Else 
					ALERT:C41("Listing "+$LB_BaseName_txt+" has not been defined in the current data file!!!"+" Please contact a database administrator!!")
					
				End if 
			: (Records in selection:C76([LB_QueryTable:147])>1)
				ALERT:C41("Multiple entries found for listing "+$LB_BaseName_txt+" in the current data file!!!"+" Please contact a database administrator!!")
		End case 
		
	: ($Task_txt="DOUBLECLICK")
		C_TEXT:C284($inputForm_txt)
		$inputForm_txt:=""
		$indx_L:=Find in array:C230(LB_ListBoxNames_atxt; $LB_BaseName_txt)
		If (Records in set:C195($LB_HiliteSet_txt)>0)
			If ($indx_L>0)
				$inputForm_txt:=LB_InputForms_atxt{$indx_L}
			End if 
			If ($LB_Selection_txt#"")
				USE NAMED SELECTION:C332($LB_Selection_txt)
			End if 
			C_LONGINT:C283($LBCol_L; $LBRow_L)
			LISTBOX GET CELL POSITION:C971(*; $LB_FullName_txt; $LBCol_L; $LBRow_L)
			
			If ($LBRow_L>0)
				GOTO SELECTED RECORD:C245($LB_Table_ptr->; $LBRow_L)
				If ($inputForm_txt#"")
					FORM SET INPUT:C55($LB_Table_ptr->; $inputForm_txt)
					
					If (Read only state:C362($LB_Table_ptr->))
						READ ONLY:C145($LB_Table_ptr->)
						LOAD RECORD:C52($LB_Table_ptr->)
						DIALOG:C40($LB_Table_ptr->; $inputForm_txt)
					Else 
						C_LONGINT:C283($LoadRecResult_L)
						$LoadRecResult_L:=ut_LoadRecordInteractiveV2($LB_Table_ptr)
						Case of 
							: ($LoadRecResult_L=1)
								MODIFY RECORD:C57($LB_Table_ptr->)
								$Result_L:=1
							: ($LoadRecResult_L=2)
								READ ONLY:C145($LB_Table_ptr->)
								LOAD RECORD:C52($LB_Table_ptr->)
								DIALOG:C40($LB_Table_ptr->; $inputForm_txt)
						End case 
						
					End if 
					
					If (Selected record number:C246($LB_Table_ptr->)>0)
						LISTBOX SELECT ROW:C912(*; $LB_FullName_txt; Selected record number:C246($LB_Table_ptr->); lk replace selection:K53:1)
						OBJECT SET SCROLL POSITION:C906(*; $LB_FullName_txt; Selected record number:C246($LB_Table_ptr->))
					Else 
						//deleted a record
						ARRAY LONGINT:C221($RecordNumbers_aL; Records in selection:C76($LB_Table_ptr->))
						SELECTION TO ARRAY:C260($LB_Table_ptr->; $RecordNumbers_aL)
						C_LONGINT:C283($loop_L)
						For ($loop_L; Size of array:C274($RecordNumbers_aL); 1; -1)
							
							If ($RecordNumbers_aL{$loop_L}<=0)
								DELETE FROM ARRAY:C228($RecordNumbers_aL; $loop_L; 1)
							End if 
						End for 
						
						CREATE SELECTION FROM ARRAY:C640($LB_Table_ptr->; $RecordNumbers_aL)
						LB_Tasks("DESELECTALL"; $LB_BaseName_txt)
						LB_Tasks("SETWINDOWTITLE"; $LB_BaseName_txt)
						
					End if 
					
				Else 
					ALERT:C41("No Input Form Defined!!")
				End if 
				
			End if 
		End if 
		
	: ($Task_txt="CLICK")
		
	: (($Task_txt="SAVESELECTION") | ($Task_txt="LOADSELECTION") | ($Task_txt="ADDSELECTION") | ($Task_txt="SUBTRACTSELECTION") | ($Task_txt="INTERSECTSELECTION"))
		$Task_txt:=Replace string:C233($Task_txt; "SELECTION"; "")
		$indx_L:=Find in array:C230(LB_ListBoxNames_atxt; $LB_BaseName_txt)
		
		If ($indx_L>0)
			If (LB_ListBoxKeyFldNum_aL{$indx_L}>0)
				SETUTIL_Control($Task_txt; Field:C253(Table:C252($LB_Table_ptr); LB_ListBoxKeyFldNum_aL{$indx_L}))
			End if 
			
		End if 
		
End case 

$0:=$Result_L