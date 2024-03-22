
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 03/28/11, 12:19:33
//----------------------------------------------------
//Method: Form Method: CloneTables
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Ugrade to v11
	//Modified by: Charles Miller (3/28/11 12:19:34)
	Mods_2017_03  //Make sure $TableNumber_l is set correctly for unique field
	//Modified by: Chuck Miller (4/4/17 17:06:35)
	Mods_2020_01  //Moved changed clone code for new datat file in to make arrays are used From BF
	//Modified by: CJ (1/14/20 11:46:37)
	
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET VISIBLE:C603(*; "AllowForCustomWhere@"; False:C215)
		ARRAY TEXT:C222(QueryTypes_as; 0)  //Command Replaced was o_ARRAY string length was 12
		ARRAY TEXT:C222(QueryTypes_as; 9)  //Command Replaced was o_ARRAY string length was 12
		QueryTypes_as{1}:="="
		QueryTypes_as{2}:=">"
		QueryTypes_as{3}:="<"
		QueryTypes_as{4}:=">="
		QueryTypes_as{5}:="<="
		QueryTypes_as{6}:="NOT ="
		QueryTypes_as{7}:="Begins with"
		QueryTypes_as{8}:="Ends with"
		QueryTypes_as{9}:="Contains"
		
		
		//Define these to be used in the object methods - 
		ARRAY POINTER:C280(FromArray_ptr; 0)
		ARRAY POINTER:C280(ToArray_ptr; 0)
		ARRAY POINTER:C280(FromArray_ptr; 4)
		ARRAY POINTER:C280(ToArray_ptr; 4)
		LISTBOX INSERT COLUMN:C829(LocalListBox_l; 1; "LocalCount_al"; LocalCount_al; "LHeader1"; LHeader1_l)
		LISTBOX INSERT COLUMN:C829(LocalListBox_l; 2; "TableNumber_al"; TableNumber_al; "LHeader2"; LHeader2_l)
		LISTBOX INSERT COLUMN:C829(LocalListBox_l; 3; "TableNames_atxt"; TableNames_atxt; "LHeader3"; LHeader3_l)
		LISTBOX INSERT COLUMN:C829(LocalListBox_l; 4; "RemoteCount_al"; RemoteCount_al; "LHeader4"; LHeader4_l)
		C_LONGINT:C283(LHeader1_l; LHeader2_l; LHeader3_l; LHeader4_l; LHeader5_l; LHeader6_l)
		
		LISTBOX SET COLUMN WIDTH:C833(LocalCount_al; 80)
		LISTBOX SET COLUMN WIDTH:C833(TableNumber_al; 55)
		LISTBOX SET COLUMN WIDTH:C833(TableNames_atxt; 230)
		LISTBOX SET COLUMN WIDTH:C833(RemoteCount_al; 80)
		OBJECT SET SCROLLBAR:C843(LocalListBox_l; False:C215; True:C214)
		FromArray_ptr{1}:=->LocalCount_al
		FromArray_ptr{2}:=->TableNames_atxt
		FromArray_ptr{3}:=->RemoteCount_al
		FromArray_ptr{4}:=->TableNumber_al
		
		ToArray_ptr{1}:=->ProcessLocalCount_al
		ToArray_ptr{2}:=->ProcessTableNames_atxt
		ToArray_ptr{3}:=->ProcessRemoteCount_al
		ToArray_ptr{4}:=->ProcessTableNumber_al
		
		//INSERT LISTBOX COLUMN(ProcessListBox_l;1;"ProcessLocalCount_al";ProcessLocalCount_al;"PHeader1";LHeader1_l)
		//INSERT LISTBOX COLUMN(ProcessListBox_l;2;"ProcessTableNumber_al";ProcessTableNumber_al;"PHeader2";LHeader2_l)
		//INSERT LISTBOX COLUMN(ProcessListBox_l;3;"TableNames_atxt";TableNames_atxt;"PHeader3";LHeader3_l)
		//INSERT LISTBOX COLUMN(ProcessListBox_l;4;"ProcessRemoteCount_al";ProcessRemoteCount_al;"PHeader4";LHeader4_l)
		//INSERT LISTBOX COLUMN(ProcessListBox_l;5;"RemoteKeyName_atxt";RemoteKeyName_atxt;"PHeader6";LHeader5_l)
		//INSERT LISTBOX COLUMN(ProcessListBox_l;6;"RemoteQueryType_atxt";RemoteQueryType_atxt;"PHeader6";LHeader6_l)
		//INSERT LISTBOX COLUMN(ProcessListBox_l;7;"RemoteKey_atxt";RemoteKey_atxt;"PHeader7";LHeader7_l)
		OBJECT SET TITLE:C194(LHeader1_l; "Local Count")
		OBJECT SET TITLE:C194(LHeader2_l; "Table #")
		OBJECT SET TITLE:C194(LHeader3_l; "Table Name")
		OBJECT SET TITLE:C194(LHeader4_l; "Remote Count")
		//BUTTON TEXT(LHeader5_l;"Key Field")
		//BUTTON TEXT(LHeader6_l;"[=, <,  >, >=, <=]")
		//BUTTON TEXT(LHeader7_l;"Key Value")
		
		
		
		LISTBOX SET COLUMN WIDTH:C833(ProcessLocalCount_al; 80)
		LISTBOX SET COLUMN WIDTH:C833(ProcessTableNumber_al; 55)
		LISTBOX SET COLUMN WIDTH:C833(TableNames_atxt; 175)
		LISTBOX SET COLUMN WIDTH:C833(ProcessRemoteCount_al; 90)
		LISTBOX SET COLUMN WIDTH:C833(RemoteKeyName_atxt; 70)
		LISTBOX SET COLUMN WIDTH:C833(RemoteQueryType_atxt; 110)
		LISTBOX SET COLUMN WIDTH:C833(RemoteKey_atxt; 100)
		
		OBJECT SET SCROLLBAR:C843(ProcessListBox_l; True:C214; True:C214)
		OBJECT SET ENTERABLE:C238(*; "ProcessLocalCount_al"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "ProcessTableNumber_al"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "TableNames_atxt"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "ProcessRemoteCount_al"; False:C215)
		OBJECT SET ENTERABLE:C238(*; "RemoteKeyName_atxt"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "RemoteQueryType_atxt"; True:C214)
		OBJECT SET ENTERABLE:C238(*; "RemoteKey_atxt"; True:C214)
		
		
		
		C_LONGINT:C283(rbReplace_l; rbUpdate_l; arbNew_l; arbOld_l; $Loop_L; $TableNumber_l; $UniqueFldNumber_l)
		
		C_TEXT:C284($Variable_txt)
		rbReplace_l:=1
		rbUpdate_l:=0
		LISTBOX SORT COLUMNS:C916(LocalListBox_l; 3; >)
		arbNew_l:=1
		arbOld_l:=0
		clone_UseBlobArrays_L:=1
		clone_UseBlobArrays_B:=True:C214
		If (FillEmptydb_L>0)
			
			If (FillEmptydb_L=1)
				$Loop_L:=Find in array:C230(TableNames_atxt; "Inspections")
				$TableNumber_l:=TableNumber_al{$Loop_L}
				LISTBOX INSERT ROWS:C913(ProcessListBox_l; 1)
				C_LONGINT:C283($InnerLoop_l)
				
				clone_ReturnKeyFldandVariable($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; False:C215)
				If ($UniqueFldNumber_l>0)
					RemoteKeyName_atxt{1}:=Field name:C257($TableNumber_l; $UniqueFldNumber_l)
				End if 
				For ($InnerLoop_l; 1; Size of array:C274(FromArray_ptr))
					ToArray_ptr{$InnerLoop_l}->{1}:=FromArray_ptr{$InnerLoop_l}->{$Loop_L}
					
				End for 
				
				LISTBOX DELETE ROWS:C914(LocalListBox_l; $Loop_L)
				
				
			Else 
				For ($Loop_L; Size of array:C274(TableNames_atxt); 1; -1)
					Case of 
						: (TableNames_atxt{$Loop_L}="Inspections")
						: (TableNames_atxt{$Loop_L}="Activity Log")
						: (TableNames_atxt{$Loop_L}="BridgeMHDNBISArchive")
						: (TableNames_atxt{$Loop_L}="Dialogs")
						: (TableNames_atxt{$Loop_L}="ElementsSafety")
						: (TableNames_atxt{$Loop_L}="LSS_Accessibility")
						: (TableNames_atxt{$Loop_L}="LSS_AccessibilityElement")
						: (TableNames_atxt{$Loop_L}="LSS_DMeter")
						: (TableNames_atxt{$Loop_L}="LSS_Element")
						: (TableNames_atxt{$Loop_L}="LSS_ElementInspection")
						: (TableNames_atxt{$Loop_L}="LSS_Inspection")
						: (TableNames_atxt{$Loop_L}="LSS_Inventory")
						: (TableNames_atxt{$Loop_L}="LSS_Photos")
						: (TableNames_atxt{$Loop_L}="LSS_refInspectionType")
						: (TableNames_atxt{$Loop_L}="LSS_refRouteDirection")
						: (TableNames_atxt{$Loop_L}="LSS_refStructureCoating")
						: (TableNames_atxt{$Loop_L}="LSS_refStructureMaterial")
						: (TableNames_atxt{$Loop_L}="LSS_refStructureTypes")
						: (TableNames_atxt{$Loop_L}="LSS_SignPanel")
						: (TableNames_atxt{$Loop_L}="LSS_TeamMembers")
						: (TableNames_atxt{$Loop_L}="LSS_TowerDistance")
						: (TableNames_atxt{$Loop_L}="LSS_UT")
						: (TableNames_atxt{$Loop_L}="LSS_UtResult")
						: (TableNames_atxt{$Loop_L}="LSS_VerticalClearance")
						: (TableNames_atxt{$Loop_L}="NBISSecondaryArchive")
						: (TableNames_atxt{$Loop_L}="ONSQLAthenticationErrors")
						: (TableNames_atxt{$Loop_L}="Owners of Data")
						: (TableNames_atxt{$Loop_L}="Pontis_Metric_Data")
						: (TableNames_atxt{$Loop_L}="SD_History")
						: (TableNames_atxt{$Loop_L}="Standard Photos")  //downloaded for each district
							
							
							
						Else 
							C_LONGINT:C283($CheckNumber_L)
							$TableNumber_l:=TableNumber_al{$Loop_L}
							//$CheckNumber_L:=$TableNumber_l%2
							C_BOOLEAN:C305($ProcessThisOne_B)
							$ProcessThisOne_B:=True:C214
							
							If ($ProcessThisOne_B)
								LISTBOX INSERT ROWS:C913(ProcessListBox_l; 1)
								C_LONGINT:C283($InnerLoop_l)
								
								clone_ReturnKeyFldandVariable($TableNumber_l; ->$UniqueFldNumber_l; ->$Variable_txt; False:C215)
								If ($UniqueFldNumber_l>0)
									RemoteKeyName_atxt{1}:=Field name:C257($TableNumber_l; $UniqueFldNumber_l)
								End if 
								For ($InnerLoop_l; 1; Size of array:C274(FromArray_ptr))
									ToArray_ptr{$InnerLoop_l}->{1}:=FromArray_ptr{$InnerLoop_l}->{$Loop_L}
									
								End for 
								
								LISTBOX DELETE ROWS:C914(LocalListBox_l; $Loop_L)
								
								
							End if 
							
					End case 
				End for 
			End if 
		End if 
End case 
//End Form Method: CloneTables

