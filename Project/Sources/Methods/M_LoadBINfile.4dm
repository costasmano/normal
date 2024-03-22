//%attributes = {"invisible":true}
If (False:C215)
	//procedure : M_LoadBINfile
	//purpose : Select BIN records from a text file containing a list of BINS
	//date created : 3/9/2000  CM
	//
	// Modified
	//    10-10-2000 : CM
	//     -Added Dialog ListType and changed method to using SETS and arrays to 
	//       search for the records from the file
	
	Mods_2005_CM05
	// Modified by: costasmanousakis-(Designer)-(1/9/2007 12:21:55)
	Mods_2007_CM01
	// Modified by: costasmanousakis-(Designer)-(9/13/2007 16:57:46)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(4/4/08 17:00:33)
	Mods_2008_CM_5403  //Apply sort
	Mods_2009_03  //CJM  r001   `03/06/09, 12:57:17`Upgrade from open form window to open window
	Mods_2011_06  // CJ Miller`06/13/11, 16:40:55      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(8/16/13 17:42:00)
	Mods_2013_08
	//  `Open file in Read mode
End if 

C_TIME:C306($dImportFile)
C_TEXT:C284($BIN)  // Command Replaced was o_C_STRING length was 40
C_TEXT:C284($tBuffer; $vType; $vHeader)
C_LONGINT:C283($acounter; $vHeadCheck)

C_LONGINT:C283($vlMaxLength)  //Command Replaced was o_C_INTEGER

ARRAY TEXT:C222($asBINS; 5000)  //Command Replaced was o_ARRAY string length was 40

C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
C_TEXT:C284($Title_txt)
FORM GET PROPERTIES:C674([Dialogs:21]; "ListType"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
//$FormWindow:=Open form window([Dialogs];"ListType")
DIALOG:C40([Dialogs:21]; "ListType")
CLOSE WINDOW:C154($Win_l)
If (Ok=1)
	Case of 
		: (BinButton=1)
			$vType:="BIN"
			$vHeader:="BIN"
			$vlMaxLength:=3
		: (BdeptButton=1)
			$vType:="Bridge Number"
			$vHeader:="BDEPT"
			$vlMaxLength:=6
		: (BrkeyButton=1)
			$vType:="Item 8"
			$vHeader:="ITEM8"
			$vlMaxLength:=15
		: (BrTownButton=1)
			$vType:="TownName"
			$vHeader:="TownName"
			$vlMaxLength:=39
	End case 
	
	$vHeadCheck:=HeaderRecord
	
	CREATE SET:C116([Bridge MHD NBIS:1]; "TempSet1")
	
	$dImportFile:=Open document:C264(""; ""; Read mode:K24:5)  //prompt user for input file
	If (OK=1)
		//initialize variables
		$BIN:=""
		$acounter:=1
		
		// skip 1st line if a header
		If ($vHeadCheck=1)
			RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
		End if 
		
		SET CURSOR:C469(4)
		
		While (Ok=1)
			RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
			If (Substring:C12($tBuffer; 1; 1)=<>sLF)
				//if 1st char is a LF then skip it    
				$tBuffer:=Substring:C12($tBuffer; 2)
			End if 
			//exclude blank lines
			If ($tBuffer#"")
				//MESSAGE(" tBuffer "+$tBuffer)
				$BIN:=Substring:C12($tBuffer; 1; $vlMaxLength)
				If ($acounter<5000)
					If ($vType="TownName")
						$asBINS{$acounter}:=f_TrimStr($BIN; True:C214; True:C214)
					Else 
						$asBINS{$acounter}:=$BIN+"@"
					End if 
					$acounter:=$acounter+1
				Else 
					$acounter:=$acounter+1
				End if 
				
			End if 
		End while 
		
		SET CURSOR:C469(0)
		
		//close the input file
		CLOSE DOCUMENT:C267($dImportFile)
		If ($acounter>5000)
			ALERT:C41("Number of "+$vType+"s found in text file  exceeds 5000"+<>sCR+"Only first 5000 will be searched for.")
		Else 
			ALERT:C41(" Searching for "+String:C10($acounter-1)+" "+$vType+"s")
		End if 
		$acounter:=$acounter-1
		SET CURSOR:C469(4)
		
		// load query into a temp set
		SET QUERY DESTINATION:C396(Into set:K19:2; "TempSet2")
		Case of 
			: (BinButton=1)
				QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BIN:3; $asBINS)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
			: (BdeptButton=1)
				QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]BDEPT:1; $asBINS)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
			: (BrkeyButton=1)
				QUERY WITH ARRAY:C644([Bridge MHD NBIS:1]Item8:206; $asBINS)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
			: (BrTownButton=1)
				C_LONGINT:C283($RecordsFound)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				CREATE EMPTY SET:C140([Bridge MHD NBIS:1]; "TempSet2")
				C_LONGINT:C283($i; $NumRecs)
				For ($i; 1; $acounter)
					$NumRecs:=SIA_SearchByTown($asBINS{$i})
					Case of 
						: ($NumRecs<0)
							ALERT:C41("Bad / Unknown town name :"+$asBINS{$i})
						: ($NumRecs>0)
							CREATE SET:C116([Bridge MHD NBIS:1]; "FOUNDTWNBRIDGES")
							UNION:C120("TempSet2"; "FOUNDTWNBRIDGES"; "TempSet2")
							CLEAR SET:C117("FOUNDTWNBRIDGES")
					End case 
				End for 
				
		End case 
		//reset the query destination  
		
		INTERSECTION:C121("TempSet1"; "TempSet2"; "ResultSet")
		
		USE SET:C118("ResultSet")
		
		SET CURSOR:C469(0)
		C_TEXT:C284(GEN_SORTLISTCMD_txt)
		If (GEN_SORTLISTCMD_txt#"")
			EXECUTE FORMULA:C63(GEN_SORTLISTCMD_txt)
		End if 
		
		//reset the window title
		RegionTitle
		
		CLEAR SET:C117("TempSet1")
		CLEAR SET:C117("TempSet2")
		CLEAR SET:C117("ResultSet")
	End if 
End if 