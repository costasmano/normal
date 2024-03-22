//%attributes = {"invisible":true}
//Method: ut_SetUpBridgeInfoLinkTable
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	
	//----------------------------------------------------
	//User name (OS): Charles Miller
	//Date and time: 01/17/13, 11:31:02
	//----------------------------------------------------
	Mods_2013_01  //r004 ` Add use of [BridgeInfoLink] table
	//Modified by: Charles Miller (1/17/13 11:31:03)
	// Modified by: Costas Manousakis-(Designer)-(3/16/16 13:02:03)
	Mods_2016_03_bug
	//  `show progress only  if there are more than 9 records to be fixed
	//  `removed SET QUERY DEST INTO VARIABLE when fixing : the required [BridgeInfoLink] record was not being loaded
	
	// Modified by: Costas Manousakis-(Designer)-(7/24/20 19:45:53)
	Mods_2020_07_bug
	//  `changed <>LStackSize to match the one in INIT_UI_GV
	Mods_2021_04  //Reset stack size to use app version default
	//Modified by: CJ (4/8/21 16:09:56)
End if 

If (Application type:C494=4D Server:K5:6) | (Application type:C494=4D Local mode:K5:1)
	READ ONLY:C145(*)
	READ WRITE:C146([BridgeInfoLink:149])
	ALL RECORDS:C47([BridgeInfoLink:149])
	ARRAY TEXT:C222($InfoBins_atxt; 0)
	SELECTION TO ARRAY:C260([BridgeInfoLink:149]BIN:1; $InfoBins_atxt)
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "$lnfoBinSet")
	QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $InfoBins_atxt)
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	ALL RECORDS:C47([Bridge MHD NBIS:1])
	CREATE SET:C116([Bridge MHD NBIS:1]; "$BridgeSet")
	
	DIFFERENCE:C122("$BridgeSet"; "$lnfoBinSet"; "$lnfoBinSet")
	C_BOOLEAN:C305($Loaded_b)
	C_LONGINT:C283($Loop_l; $Count_l; $Interval_l; $RecordCount_l; $innerLoop_l)
	
	C_BOOLEAN:C305($SaveRecord_b)
	C_LONGINT:C283($TableNumber_l)
	C_TEXT:C284($SQL_Select_txt; $FieldName_txt)
	$TableNumber_l:=Table:C252(->[BridgeInfoLink:149])
	$SQL_Select_txt:="SELECT [BridgeInfoLink].[BIN] FROM [BridgeInfoLink] "+Char:C90(Carriage return:K15:38)
	$SQL_Select_txt:=$SQL_Select_txt+"WHERE "+Char:C90(Carriage return:K15:38)
	ARRAY TEXT:C222(PFBRIDGENOS_ATXT; 0)
	Compiler_FieldVariables($TableNumber_l)
	
	v_149_001_txt:=""
	C_TEXT:C284($Value_txt)
	$Value_txt:=""
	ARRAY POINTER:C280($Field_ptr; 0)
	For ($Loop_l; 2; Get last field number:C255($TableNumber_l))
		If (Is field number valid:C1000($TableNumber_l; $Loop_l))
			$FieldName_txt:=Field name:C257($TableNumber_l; $Loop_l)
			APPEND TO ARRAY:C911($Field_ptr; Field:C253($TableNumber_l; $Loop_l))
			$SQL_Select_txt:=$SQL_Select_txt+$Value_txt+" [BridgeInfoLink].["+$FieldName_txt+"] = :v_149_001_txt "+Char:C90(Carriage return:K15:38)
			If ($Value_txt="")
				$Value_txt:=" OR "
			End if 
		End if 
		
		
	End for 
	$SQL_Select_txt:=$SQL_Select_txt+"INTO :PFBRIDGENOS_ATXT; "
	
	Begin SQL
		execute immediate :$SQL_Select_txt;
	End SQL
	
	SET QUERY DESTINATION:C396(Into set:K19:2; "$BridgeSet")
	QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; PFBRIDGENOS_ATXT)
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	UNION:C120("$lnfoBinSet"; "$BridgeSet"; "$lnfoBinSet")
	
	
	USE SET:C118("$lnfoBinSet")
	
	$RecordCount_l:=Records in selection:C76([Bridge MHD NBIS:1])
	C_LONGINT:C283(<>LStackSize)
	<>LStackSize:=0  //1024*1024  //Increased on 23-jun-03
	
	If ($RecordCount_l>0)
		If ((Application type:C494#4D Server:K5:6) & ($RecordCount_l>=10))  //show the bar for more than 9 records
			<>ProgressPID:=StartProgress("Update Bridge Info"; "None"; "Updating Bridge Info Link Table")
			UpdateProgress(0; $RecordCount_l)  //start it
			$Interval_l:=100
		End if 
		
		For ($Loop_l; 1; $RecordCount_l)
			If ((Application type:C494#4D Server:K5:6) & ($RecordCount_l>=10))  //show the bar for more than 9 records
				If (($Loop_l%$Interval_l)=0)
					UpdateProgress($Loop_l; $RecordCount_l)
				End if 
			End if 
			$SaveRecord_b:=False:C215
			GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; $Loop_l)
			//SET QUERY DESTINATION(Into variable ;$Count_l)
			QUERY:C277([BridgeInfoLink:149]; [BridgeInfoLink:149]BIN:1=[Bridge MHD NBIS:1]BIN:3)
			//SET QUERY DESTINATION(Into current selection )
			If (Records in selection:C76([BridgeInfoLink:149])=0)
				CREATE RECORD:C68([BridgeInfoLink:149])
				[BridgeInfoLink:149]BIN:1:=[Bridge MHD NBIS:1]BIN:3
				$Loaded_b:=True:C214
				$SaveRecord_b:=True:C214
			Else 
				$Loaded_b:=ut_LoadRecord(->[BridgeInfoLink:149]; 10)
			End if 
			
			If ($Loaded_b)
				For ($innerLoop_l; 1; Size of array:C274($Field_ptr))
					If ($Field_ptr{$innerLoop_l}->#[BridgeInfoLink:149]BIN:1)
						$Field_ptr{$innerLoop_l}->:=[BridgeInfoLink:149]BIN:1
						$SaveRecord_b:=True:C214
					End if 
				End for 
				
				If ($SaveRecord_b)
					SAVE RECORD:C53([BridgeInfoLink:149])
				End if 
			End if 
		End for 
		If ((Application type:C494#4D Server:K5:6) & ($RecordCount_l>=10))  //show the bar for more than 9 records
			POST OUTSIDE CALL:C329(<>ProgressPID)
		End if 
	End if 
	UNLOAD RECORD:C212([BridgeInfoLink:149])
	ARRAY TEXT:C222(PFBRIDGENOS_ATXT; 0)
	CLEAR SET:C117("$BridgeSet")
	CLEAR SET:C117("$lnfoBinSet")
	
End if 
//End ut_SetUpBridgeInfoLinkTable