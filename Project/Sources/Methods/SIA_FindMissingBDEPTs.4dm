//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: SIA_FindMissingBDEPTs
// Description
//  ` Find the Missing BDEPTS in a list of Bridges - Works from current selection
//  ` or from a specified town
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/27/11, 10:03:17
	
	Mods_2011_09
	// Modified by: Costas Manousakis-(Designer)-(5/4/12 14:22:23)
	Mods_2012_05
	//  `Added a while loop to repeat the search when searching for a town;  adjusted  the output
	// Modified by: Costas Manousakis-(Designer)-(2/27/15 13:47:06)
	Mods_2015_02
	//  `adjusted logic when searching in selection to look trhough the whole db not just selection. still will only go up to last bridge in list.
	//  `also display results in a listbox instead of alert showing some more information 
	// Modified by: Costas Manousakis-(Designer)-(2023-06-15 14:17:53)
	Mods_2023_06_bug
	//  `To fix bug when searching in the current list of bridges, a new methodology was created.
	//  ` implement some ORDA tools.
	//  `when searching from a selection, it will find all towns in the selection and search in each 
	//  `regardless whether all bridges for the towns are on the list.
	//  `when asked to search for a specific town, show a list of towns to select from.
	
End if 
C_TEXT:C284($param_txt)
$param_txt:=Get selected menu item parameter:C1005

C_TEXT:C284($MissingBDEPTS_txt)  // this variable is mainly for debugging -
C_LONGINT:C283($loop_L; $numMissing_L)
C_LONGINT:C283($LastNum_L)
C_LONGINT:C283($Width_l; $Height_l)

ARRAY TEXT:C222(LBGeneric_atxt; 0)
C_TEXT:C284(1_txt)
1_txt:="BDEPT"  // header in listbox shown

$MissingBDEPTS_txt:=""
$numMissing_L:=0

C_BOOLEAN:C305($BrgRW_b)
COPY NAMED SELECTION:C331([Bridge MHD NBIS:1]; "TEMPBRIDGESELECTION")
$BrgRW_b:=Read only state:C362([Bridge MHD NBIS:1])
READ ONLY:C145([Bridge MHD NBIS:1])
READ ONLY:C145([Town Data:2])
C_BOOLEAN:C305($doSelection_b)
If ($param_txt="")
	//we are called from splash screen (no parameter)
	$doSelection_b:=False:C215
Else 
	CONFIRM:C162("Search Current Selection of bridge records, or specify a Town?"; "Selection"; "Town")
	$doSelection_b:=(OK=1)
End if 

C_OBJECT:C1216($twnbridges_o)
C_COLLECTION:C1488($bdepts_c)
C_LONGINT:C283($LastNum_L; $i; $progr_L)

If ($doSelection_b)
	//CONFIRM("The search will look only at the current list! If the current list does not include all records for the towns listed, the search results will be incorrect!";"Continue";"Cancel")
	
	CONFIRM:C162("The search will look scan all towns listed on the current list, regardless if all related bridges are listed!"; "Continue"; "Cancel")
	
	If (OK=1)
		
		If (Records in selection:C76([Bridge MHD NBIS:1])>0)
			$progr_L:=Progress New
			Progress SET TITLE($progr_L; "Scanning for missing BDEPTs")
			Progress SET PROGRESS($progr_L; -1; "Scanning.."; True:C214)
			
			//SHORT_MESSAGE ("Scanning for missing BDEPTs...")
			ARRAY TEXT:C222($ListOfBDEPTS_atxt; Records in selection:C76([Bridge MHD NBIS:1]))
			SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BDEPT:1; $ListOfBDEPTS_atxt)
			SORT ARRAY:C229($ListOfBDEPTS_atxt)
			C_TEXT:C284($StartBDEPT_txt; $EndBDEPT_txt; $StartTWNPart_txt; $EndTWNPart_txt)
			ARRAY TEXT:C222($Twnparts_atxt; 0)
			APPEND TO ARRAY:C911($Twnparts_atxt; Substring:C12($ListOfBDEPTS_atxt{1}; 1; 3))
			Progress SET PROGRESS($progr_L; -1; " Finding Towns...")
			
			For ($loop_L; 2; Size of array:C274($ListOfBDEPTS_atxt))
				If (Substring:C12($ListOfBDEPTS_atxt{$loop_L}; 1; 3)#$Twnparts_atxt{Size of array:C274($Twnparts_atxt)})
					APPEND TO ARRAY:C911($Twnparts_atxt; Substring:C12($ListOfBDEPTS_atxt{$loop_L}; 1; 3))
				End if 
			End for 
			For ($loop_L; 1; Size of array:C274($Twnparts_atxt))
				//scan for the town found in the first bdept
				QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$Twnparts_atxt{$loop_L})
				Progress SET PROGRESS($progr_L; -1; "Town : "+[Town Data:2]Town Name:1+" ("+$Twnparts_atxt{$loop_L}+")")
				
				$twnbridges_o:=ds:C1482["Bridge MHD NBIS"].query("BDEPT = :1"; $Twnparts_atxt{$loop_L}+"@").orderBy("BDEPT asc")
				C_COLLECTION:C1488($bdepts_c)
				$bdepts_c:=$twnbridges_o.BDEPT
				APPEND TO ARRAY:C911(LBGeneric_atxt; ($Twnparts_atxt{$loop_L}+" ("+[Town Data:2]Town Name:1+") last BDEPT : "+$bdepts_c[$bdepts_c.length-1]))
				$LastNum_L:=Num:C11(Substring:C12($bdepts_c[$bdepts_c.length-1]; 4))
				For ($i; 1; $LastNum_L)
					If ($bdepts_c.indexOf($Twnparts_atxt{$loop_L}+String:C10($i; "000"))<0)
						$numMissing_L:=$numMissing_L+1
						$MissingBDEPTS_txt:=$MissingBDEPTS_txt+"\n"+($Twnparts_atxt{$loop_L}+String:C10($i; "000"))
						APPEND TO ARRAY:C911(LBGeneric_atxt; $Twnparts_atxt{$loop_L}+String:C10($i; "000"))
					End if 
				End for 
				
			End for 
			
			Progress QUIT($progr_L)
			//CLOSE WINDOW
			If (Size of array:C274(LBGeneric_atxt)>0)
				//ut_BigAlert ($MissingBDEPTS_txt)
				//ALERT("Missing BDEPTS are ("+String(Size of array(LBGeneric_atxt))+") : "+$MissingBDEPTS_txt)
				FORM GET PROPERTIES:C674("OneArrayLB"; $Width_l; $Height_l)
				ut_OpenNewWindow($Width_l; $Height_l; 0; Plain window:K34:13; "Missing BDEPTs = "+String:C10($numMissing_L); "ut_CloseCancel")
				DIALOG:C40("OneArrayLB")
				CLOSE WINDOW:C154
			Else 
				ALERT:C41("There are no missing BDEPTS in the list of bridges ")
			End if 
		Else 
			ALERT:C41("A selection of at least one bridge is needed!")
		End if 
		
	End if 
	
Else 
	C_BOOLEAN:C305($RepeatSearch_b)
	$RepeatSearch_b:=True:C214
	C_TEXT:C284($TownBdept3_txt; $TownName_txt)
	C_OBJECT:C1216($townData_o)
	C_COLLECTION:C1488($prefix_c; $townname_c)
	
	$townData_o:=ds:C1482["Town Data"].all().orderBy("BDEPT Prefix asc")
	ARRAY TEXT:C222($prefix_atxt; 0)
	ARRAY TEXT:C222($townnames_atxt; 0)
	$prefix_c:=$townData_o["BDEPT Prefix"]
	$townname_c:=$townData_o["Town Name"]
	COLLECTION TO ARRAY:C1562($townname_c; $townnames_atxt)
	COLLECTION TO ARRAY:C1562($prefix_c; $prefix_atxt)
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Size of array:C274($townnames_atxt))
		$townnames_atxt{$loop_L}:=$prefix_atxt{$loop_L}+" : "+$townnames_atxt{$loop_L}
	End for 
	C_LONGINT:C283($townpick_L)
	While ($RepeatSearch_b)
		ARRAY TEXT:C222(LBGeneric_atxt; 0)  // reset the array
		
		$townpick_L:=G_PickFromList(->$townnames_atxt; "Select a town")
		
		If ($townpick_L>0)
			$TownBdept3_txt:=$prefix_atxt{$townpick_L}
		End if 
		
		If ((OK=1) & ($TownBdept3_txt#""))
			$MissingBDEPTS_txt:=""
			$twnbridges_o:=ds:C1482["Bridge MHD NBIS"].query("BDEPT = :1"; $TownBdept3_txt+"@").orderBy("BDEPT asc")
			
			If ($twnbridges_o.length>0)
				$bdepts_c:=$twnbridges_o.BDEPT
				$LastNum_L:=Num:C11(Substring:C12($bdepts_c[$bdepts_c.length-1]; 4))
				$progr_L:=Progress New
				QUERY:C277([Town Data:2]; [Town Data:2]BDEPT Prefix:2=$TownBdept3_txt)
				$TownBdept3_txt:=[Town Data:2]BDEPT Prefix:2
				$TownName_txt:=[Town Data:2]Town Name:1
				Progress SET TITLE($progr_L; "Scanning for missing BDEPTs in "+$TownName_txt+" ("+$TownBdept3_txt+")")
				Progress SET PROGRESS($progr_L; -1; "Scanning.."; True:C214)
				
				For ($i; 1; $LastNum_L)
					If ($bdepts_c.indexOf($TownBdept3_txt+String:C10($i; "000"))<0)
						$numMissing_L:=$numMissing_L+1
						$MissingBDEPTS_txt:=$MissingBDEPTS_txt+"\n"+($TownBdept3_txt+String:C10($i; "000"))
						APPEND TO ARRAY:C911(LBGeneric_atxt; $TownBdept3_txt+String:C10($i; "000"))
					End if 
				End for 
				Progress QUIT($progr_L)
			Else 
				ALERT:C41("There are no Bridges starting with "+$TownBdept3_txt)
			End if 
			
			If ($MissingBDEPTS_txt#"")
				$MissingBDEPTS_txt:="Missing BDEPTS for "+$TownBdept3_txt+" ("+$TownName_txt+") are ("+String:C10($numMissing_L)+") : "+$MissingBDEPTS_txt
				$MissingBDEPTS_txt:=$MissingBDEPTS_txt+"."+Char:C90(13)+"Last used number is "+String:C10($LastNum_L)
				//ALERT($MissingBDEPTS_txt)
				FORM GET PROPERTIES:C674("OneArrayLB"; $Width_l; $Height_l)
				ut_OpenNewWindow($Width_l; $Height_l; 0; Plain window:K34:13; "Missing BDEPTs for "+$TownBdept3_txt+" ("+$TownName_txt+") = "+String:C10($numMissing_L); "ut_CloseCancel")
				DIALOG:C40("OneArrayLB")
				CLOSE WINDOW:C154
			Else 
				$MissingBDEPTS_txt:="There are no missing BDEPTS in the list of bridges for "+$TownBdept3_txt+" ("+$TownName_txt
				$MissingBDEPTS_txt:=$MissingBDEPTS_txt+")."+Char:C90(13)+"Last used number is "+String:C10($LastNum_L)
				$MissingBDEPTS_txt:=$MissingBDEPTS_txt+"."+Char:C90(13)+"Next available number is "+String:C10($LastNum_L+1)
				ALERT:C41($MissingBDEPTS_txt)
			End if 
			
		End if 
		CONFIRM:C162("Search For Another Town or Done?"; "Another"; "DONE")
		$RepeatSearch_b:=(OK=1)
	End while 
	
End if 

ARRAY TEXT:C222(LBGeneric_atxt; 0)  // clear the array

If (Not:C34($BrgRW_b))
	READ WRITE:C146([Bridge MHD NBIS:1])
End if 

USE NAMED SELECTION:C332("TEMPBRIDGESELECTION")
CLEAR NAMED SELECTION:C333("TEMPBRIDGESELECTION")