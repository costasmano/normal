//%attributes = {"invisible":true}
// Method: popup_MenuFromTablePtr - all menu levels
// --- Create a Dynamic popup menu with Related One fields & get user's selection
// INPUT1: Pointer - table of origination
// OUTPUT:  Pointer - to a User selected field
// ----------------------------------------------------
// --- params passed from this method to itself
// INPUT2: Pointer - table to build this level's menu for
// INPUT3: Pointer - array of menuRefs to eventually clear, add this menu to it
// INPUT4: menuref - attach this level's menu to this higher level menu
// INPUT5: Pointer - array of Table Pointers to prevent a table loop
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 08/28/17, 17:38:49
	// ----------------------------------------------------
	//Created : Copied from 4D Today
	Mods_2017_08
	
	//
	
	// ----------- Sample Calling Method ----------- //
	//C_POINTER($fieldPtr)
	//$fieldPtr:=popup_MenuFromTablePtr (->[Table_2])
	//If (Not(Nil($fieldPtr)))
	//ALERT(Field name($fieldPtr))
	//End if
	// ----------- Sample Calling Method ----------- //
	
	
	C_POINTER:C301(popup_MenuFromTablePtr; $0; $1; $2; $3; $5)
	C_TEXT:C284(popup_MenuFromTablePtr; $4)
	
End if 

C_POINTER:C301($0; $tableOrigPtr; $1; $tableWorkPtr; $2; $3; $aMenuPtr; $aTableNumPtr)
C_LONGINT:C283($tableNum; $oneF; $oneT; $size; $fType; $fLength; $tn; $fn; $i)
C_TEXT:C284($passedMenu; $4; $newMenu; $fieldName; $ans)
C_BOOLEAN:C305($go; $topLevel)
If (Count parameters:C259>0)
	
	$tableOrigPtr:=$1
	If (Count parameters:C259=1)
		ARRAY LONGINT:C221($aTableNum; 0)
		$aTableNumPtr:=(->$aTableNum)
		$tableWorkPtr:=$1
		$tableNum:=Table:C252($tableWorkPtr)
		ARRAY TEXT:C222($aMenus; 0)
		$aMenuPtr:=(->$aMenus)
		$passedMenu:=Create menu:C408
		$go:=True:C214
		$topLevel:=True:C214
	Else 
		$tableWorkPtr:=$2
		$tableNum:=Table:C252($tableWorkPtr)
		$aMenuPtr:=$3
		$passedMenu:=$4
		$aTableNumPtr:=$5
		$go:=(Find in array:C230($aTableNumPtr->; $tableNum)=-1)  // - check for circular refs
		$topLevel:=False:C215
	End if 
	
	APPEND TO ARRAY:C911($aMenuPtr->; $passedMenu)
	
	If ($go)
		GET FIELD TITLES:C804($tableWorkPtr->; $afT; $afN)  // omits invisibles
		$size:=Size of array:C274($afN)
		SORT ARRAY:C229($afT; $afN)
		
		For ($i; 1; $size)
			
			GET RELATION PROPERTIES:C686($tableNum; $afN{$i}; $oneT; $oneF)
			$fieldName:=Field name:C257($tableNum; $afN{$i})
			
			If ($oneT=0)
				APPEND MENU ITEM:C411($passedMenu; $fieldName)
				SET MENU ITEM PARAMETER:C1004($passedMenu; -1; String:C10($tableNum)+" "+String:C10($afN{$i}))
				
			Else 
				// in case the relation does not use UUID, it may be useable in the list
				GET FIELD PROPERTIES:C258($tableNum; $afN{$i}; $fType; $fLength)
				If ($fType#0) | ($fLength#0)
					APPEND MENU ITEM:C411($passedMenu; $fieldName)
					SET MENU ITEM PARAMETER:C1004($passedMenu; -1; String:C10($tableNum)+" "+String:C10($afN{$i}))
				End if 
				
				APPEND TO ARRAY:C911($aTableNumPtr->; Table:C252($tableOrigPtr))
				
				$newMenu:=Create menu:C408
				popup_MenuFromTablePtr($tableOrigPtr; Table:C252($oneT); $aMenuPtr; $newMenu; $aTableNumPtr)
				APPEND MENU ITEM:C411($passedMenu; "["+Table name:C256($oneT)+"]"; $newMenu)
				SET MENU ITEM PARAMETER:C1004($passedMenu; -1; String:C10($tableNum)+" "+String:C10($afN{$i}))
				
			End if 
			
		End for 
		
		If ($topLevel)
			
			$ans:=Dynamic pop up menu:C1006($passedMenu)
			
			For ($i; 1; Size of array:C274($aMenus))
				RELEASE MENU:C978($aMenus{$i})
			End for 
			
			If ($ans#"")
				ARRAY TEXT:C222($aWords; 0)
				GET TEXT KEYWORDS:C1141($ans; $aWords)
				$tn:=Num:C11($aWords{1})
				$fn:=Num:C11($aWords{2})
				$0:=Field:C253($tn; $fn)
			End if 
			
		End if 
		
	End if 
	
End if 
//End popup_MenuFromTablePtr