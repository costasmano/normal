//%attributes = {"invisible":true}
//Temp_touchall 
//Touch all fields in all records of a table.
If (False:C215)
	Mods_2011_06  // CJ Miller`06/13/11, 16:52:38      ` Type all local variables for v11
	// Modified by: Costas Manousakis-(Designer)-(6/2/15 15:35:22)
	Mods_2015_06
	//  `added Check for valid field number and valid table number
End if 
C_BOOLEAN:C305($1; $vbPrompt)
C_BOOLEAN:C305($2; $vbDropIndexes)
C_BOOLEAN:C305($3; $vbEndPrompt)
C_LONGINT:C283($4; $vlTableNo)
If (Count parameters:C259>0)
	$vbPrompt:=$1
Else 
	$vbPrompt:=True:C214
End if 
If (Count parameters:C259>1)
	$vbDropIndexes:=$2
Else 
	$vbDropIndexes:=False:C215
End if 
If (Count parameters:C259>2)
	$vbEndPrompt:=$3
Else 
	$vbEndPrompt:=True:C214
End if 
If (Count parameters:C259>3)
	$vlTableNo:=$4
Else 
	$vlTableNo:=0
End if 

C_LONGINT:C283($vlTabls; $vlFlds; $vlTablNo; $vlFldNo; $i; $j; $vlRecs; $k; $vlTabSt; $vlTabEnd)
C_LONGINT:C283($vlMilliSt; $vlMilliEnd; $vlMilliStTot; $vlMilliEndTot)
C_POINTER:C301($vpFld; $vpTable)
C_BOOLEAN:C305($vbIndxd; $vbUnique)
C_TEXT:C284($vsmsg)  // Command Replaced was o_C_STRING length was 200
$vlTabls:=Get last table number:C254
$vlTabSt:=1
$vlTabEnd:=$vlTabls
If (($vlTableNo>0) & ($vlTableNo<=$vlTabls))
	$vlTabSt:=$vlTableNo
	$vlTabEnd:=$vlTableNo
End if 
$vlMilliStTot:=Milliseconds:C459
NewWindow(500; 100; 0)
For ($i; $vlTabSt; $vlTabEnd)
	If (Is table number valid:C999($i))
		$vpTable:=Table:C252($i)
		$vlRecs:=Records in table:C83($vpTable->)
		$vlFlds:=Get last field number:C255($vpTable)
		READ WRITE:C146($vpTable->)
		ARRAY INTEGER:C220($arDropIndx; 0)
		C_LONGINT:C283($vlFldType; $vlFieldLen)
		C_BOOLEAN:C305($vbIndxd; $vbUnique)
		If ($vbDropIndexes)
			For ($j; 1; $vlFlds)
				If (Is field number valid:C1000($i; $j))
					$vpFld:=Field:C253($i; $j)
					GET FIELD PROPERTIES:C258($vpFld; $vlFldType; $vlFieldLen; $vbIndxd; $vbUnique)
					If (Not:C34($vbUnique))
						If ($vbIndxd)
							SET INDEX:C344($vpFld->; False:C215)
							INSERT IN ARRAY:C227($arDropIndx; (1+Size of array:C274($arDropIndx)))
							$arDropIndx{(Size of array:C274($arDropIndx))}:=$j
						End if 
					End if 
				End if 
				
			End for 
		End if 
		$vlMilliSt:=Milliseconds:C459
		$vsmsg:=<>sCR+"Table "+String:C10($i)+" - "+Table name:C256($i)+" - Tot :"+String:C10($vlRecs)+" : "
		If ($vlRecs>0)
			ALL RECORDS:C47($vpTable->)
			FIRST RECORD:C50($vpTable->)
			For ($k; 1; $vlRecs)
				MESSAGE:C88($vsmsg+String:C10($k; "#######")+"   ")
				For ($j; 1; $vlFlds)
					If (Is field number valid:C1000($i; $j))
						$vpFld:=Field:C253($i; $j)
						GET FIELD PROPERTIES:C258($vpFld; $vlFldType; $vlFieldLen; $vbIndxd; $vbUnique)
						
						If ($vlFldType#Is subtable:K8:11)
							If ($vlFldType=Is alpha field:K8:1)
								$vpFld->:=Substring:C12($vpFld->; 1; $vlFieldLen)
							Else 
								$vpFld->:=$vpFld->
							End if 
							If (False:C215)
								C_LONGINT:C283($vlFldChk)
								$vlFldChk:=Type:C295($vpFld->)
								//If ($vlFldChk#$vlFldType)
								//MESSAGE("Table "+String($i)+" Field "+Field name($vpFld)+" record "+String($k))
								//End if 
							End if 
						End if 
					End if 
					
				End for   //field loop
				SAVE RECORD:C53($vpTable->)
				NEXT RECORD:C51($vpTable->)
			End for   //record loop
			REDUCE SELECTION:C351($vpTable->; 0)
			If (Size of array:C274($arDropIndx)>0)
				For ($j; 1; Size of array:C274($arDropIndx))
					$vpFld:=Field:C253($i; $arDropIndx{$j})
					SET INDEX:C344($vpFld->; True:C214; 100)  //optimize for query
				End for 
			End if 
			
			READ ONLY:C145($vpTable->)
		End if 
		//FLUSH CACHE
		If ($vbPrompt)
			$vlMilliEnd:=Milliseconds:C459
			$vlMilliEnd:=$vlMilliEnd-$vlMilliSt
			$vsMsg:="Done with Table "+String:C10($i)+" ["+Table name:C256($i)+"] "
			$vsMsg:=$vsMsg+" time Elapsed ="+String:C10($vlMilliEnd)+"ms. Continue?"
			CONFIRM:C162($vsMsg)
			If (OK#1)
				$i:=$vlTabls+1
			End if 
		End if   //if interactive
	End if 
	
End for   //table loop
$vlMilliEndTot:=Milliseconds:C459
$vlMilliStTot:=$vlMilliEndTot-$vlMilliStTot
If ($vbEndPrompt)
	ALERT:C41("Done at "+String:C10(Current date:C33(*))+" - "+String:C10(Current time:C178(*))+" Ellapsed "+String:C10($vlMilliEndTot))
End if 
CLOSE WINDOW:C154