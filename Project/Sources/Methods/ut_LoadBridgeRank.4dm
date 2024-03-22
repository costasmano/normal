//%attributes = {"invisible":true}
// Method: ut_LoadBridgeRank
// Description
// Load Bridge Rank from a text file- input from a spreadsheet maintained by F. Rastegari
// Text file is a tab-delimited file with two columns <BIN><tab><Rank>
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 05/12/08, 11:44:36
	// ----------------------------------------------------
	
	Mods_2008_CM_5403
	// Modified by: costasmanousakis-(Designer)-(11/23/10 11:53:03)
	Mods_2010_11
	//  `Added Alert at the end to adjust parameter BRG_RANKINGDATE in Parameters table
	// Modified by: Costas Manousakis-(Designer)-(12/21/12 10:49:35)
	Mods_2012_12
	//  `Added saving of calc or load date in parameters table under parameter BRG_RANKINGDATE instead of showing the Alert
	// Modified by: Costas Manousakis-(Designer)-(5/19/14 16:40:56)
	Mods_2014_05
	//  `use BrgRank_UpdSysParam
End if 
If ((User in group:C338(<>CurrentUser_Name; "BridgeRankEdit")) | (<>CurrentUser_Name="Designer"))
	C_TIME:C306($InputFile_file)
	$InputFile_file:=Open document:C264(""; "TEXT"; Read mode:K24:5)
	If (OK=1)
		ARRAY TEXT:C222($CurrBins_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY INTEGER:C220($CurrRank_ai; 0)
		ARRAY TEXT:C222($NewBins_as; 9000)  //Command Replaced was o_ARRAY string length was 3
		ARRAY INTEGER:C220($NewRank_ai; 9000)
		C_POINTER:C301($BINFld_ptr; $RankFld_ptr)
		C_TEXT:C284($InputBin_s)  // Command Replaced was o_C_STRING length was 3
		C_LONGINT:C283($NewRank_i)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($k; $TabSpot_L; $Lines_L; $BinReset_L; $BINSet_L; $BINSame_L; $i)
		C_BOOLEAN:C305($Continue_b; $LastLine_b; $LogChanges_b)
		CONFIRM:C162("Log the changes so that they get transfered to Districts?"; "Log"; "No Log")
		$LogChanges_b:=(OK=1)
		$BINFld_ptr:=->[Bridge MHD NBIS:1]BIN:3
		$RankFld_ptr:=->[Bridge MHD NBIS:1]Rank:6
		$Continue_b:=True:C214
		$LastLine_b:=False:C215
		$Lines_L:=0
		$BinReset_L:=0
		$BINSet_L:=0
		$BINSame_L:=0
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Rank:6>0)
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $CurrBins_as; [Bridge MHD NBIS:1]Rank:6; $CurrRank_ai)
		SORT ARRAY:C229($CurrRank_ai; $CurrBins_as)
		C_TEXT:C284($T_Buffer)
		
		//start the bar
		C_OBJECT:C1216($progress_o)
		$progress_o:=ProgressNew("Loading Bridge rank"; 3; False:C215; " bridge record"; 3)
		UpdateProgressNew($progress_o; 1)
		
		RECEIVE PACKET:C104($InputFile_file; $T_Buffer; <>sCR)
		Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Reading File..")
		
		While ($Continue_b)
			$T_Buffer:=Replace string:C233($T_Buffer; <>sLF; "")
			$TabSpot_L:=Position:C15(<>sTAB; $T_Buffer)
			If ($TabSpot_L>0)
				$InputBin_s:=Substring:C12($T_Buffer; 1; ($TabSpot_L-1))
				$NewRank_i:=Num:C11(Substring:C12($T_Buffer; ($TabSpot_L+1)))
				If ($NewRank_i>0)
					$Lines_L:=$Lines_L+1
					$NewBins_as{$Lines_L}:=$InputBin_s
					$NewRank_ai{$Lines_L}:=$NewRank_i
				End if 
			End if 
			RECEIVE PACKET:C104($InputFile_file; $T_Buffer; <>sCR)
			If ((OK=1) | (Length:C16($T_Buffer)>0))
			Else 
				$Continue_b:=False:C215
			End if 
			
		End while 
		CLOSE DOCUMENT:C267($InputFile_file)
		
		ARRAY TEXT:C222($NewBins_as; $Lines_L)  //Command Replaced was o_ARRAY string length was 3
		ARRAY INTEGER:C220($NewRank_ai; $Lines_L)
		SORT ARRAY:C229($NewRank_ai; $NewBins_as; >)
		
		Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Updating Rank...")
		UpdateProgressNew($progress_o; 2)
		//start a new bar
		C_OBJECT:C1216($binProgress_o)
		$binProgress_o:=ProgressNew("Updating BINS"; $Lines_L; False:C215; " Bin record"; 3)
		
		For ($i; 1; $Lines_L)
			//update progress
			UpdateProgressNew($binProgress_o; $i)
			QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$NewBins_as{$i})
			If (Records in selection:C76([Bridge MHD NBIS:1])=1)
				GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; 1)
				LOAD RECORD:C52([Bridge MHD NBIS:1])
				If ([Bridge MHD NBIS:1]Rank:6=$NewRank_ai{$i})
					$BINSame_L:=$BINSame_L+1
				Else 
					If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
						[Bridge MHD NBIS:1]Rank:6:=$NewRank_ai{$i}
						If ($LogChanges_b)
							LogChanges($RankFld_ptr; $BINFld_ptr; $BINFld_ptr; $BINFld_ptr; 0)
						End if 
						SAVE RECORD:C53([Bridge MHD NBIS:1])
						$BINSet_L:=$BINSet_L+1
						UNLOAD RECORD:C212([Bridge MHD NBIS:1])
					Else 
						ALERT:C41("Could not Update the new Rank for BIN "+$CurrBins_as{$k})
						$Continue_b:=False:C215
					End if 
				End if 
			Else 
				ALERT:C41("Entered BIN "+$NewBins_as{$i}+" not found in the DB!")
			End if 
			
		End for 
		//quit progress
		Progress QUIT(OB Get:C1224($binProgress_o; "progress"; Is longint:K8:6))
		
		Progress SET MESSAGE(OB Get:C1224($progress_o; "progress"; Is longint:K8:6); "Cleaning up previous Rank...")
		UpdateProgressNew($progress_o; 3)
		
		$binProgress_o:=ProgressNew("Updating BINS"; Size of array:C274($CurrBins_as); False:C215; " Bin record"; 3)
		
		For ($i; 1; Size of array:C274($CurrBins_as))
			UpdateProgressNew($binProgress_o; $i)
			$k:=Find in array:C230($NewBins_as; $CurrBins_as{$i})
			If ($k>0)
				//Already done
			Else 
				//need to clear it
				QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$CurrBins_as{$i})
				GOTO SELECTED RECORD:C245([Bridge MHD NBIS:1]; 1)
				If (ut_LoadRecordInteractive(->[Bridge MHD NBIS:1]))
					[Bridge MHD NBIS:1]Rank:6:=0
					If ($LogChanges_b)
						LogChanges($RankFld_ptr; $BINFld_ptr; $BINFld_ptr; $BINFld_ptr; 0)
					End if 
					SAVE RECORD:C53([Bridge MHD NBIS:1])
					$BinReset_L:=$BinReset_L+1
					UNLOAD RECORD:C212([Bridge MHD NBIS:1])
				Else 
					ALERT:C41("Could not Reset the Rank for BIN "+$CurrBins_as{$i})
					$Continue_b:=False:C215
				End if 
			End if 
			
		End for 
		//quit progress
		Progress QUIT(OB Get:C1224($binProgress_o; "progress"; Is longint:K8:6))
		
		//quit overall progress
		Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
		
		$T_Buffer:="Read "+String:C10($Lines_L)+" lines!  Updated "+String:C10($BINSet_L)+" records! Found "
		$T_Buffer:=$T_Buffer+String:C10($BINSame_L)+"  same records! Reset "+String:C10($BinReset_L)+" records!"
		ALERT:C41($T_Buffer)
		ARRAY TEXT:C222($CurrBins_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY INTEGER:C220($CurrRank_ai; 0)
		ARRAY TEXT:C222($NewBins_as; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY INTEGER:C220($NewRank_ai; 0)
		//ALERT("REMEMBER TO UPDATE PARAMETER BRG_RANKINGDATE IN TABLE PARAMETERS!!")
		
		BrgRank_UpdSysParam
	End if 
End if 