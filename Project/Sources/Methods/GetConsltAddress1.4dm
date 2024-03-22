//%attributes = {"invisible":true}
If (False:C215)
	//GetConsltAddress1 
	Mods_2005_CM12
	// Modified by: costasmanousakis-(Designer)-(9/13/05 12:54:58) 
	Mods_2005_CM16
	// Modified by: costasmanousakis-(Designer)-(10/29/2007 11:20:48)
	Mods_2007_CM12_5302  // fix some logic errors; provide some initialization vallues when addingan address record
	// Modified by: costasmanousakis-(Designer)-(6/23/08 16:55:20)
	Mods_2008_CM_5404  //Made an adjustment in the contact name to avoid ", ,"
	Mods_2009_03  //CJM  r001   `03/06/09, 15:06:07`Upgrade from open form window to open window
End if 
C_TEXT:C284($1; $sCompanyName)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284($2; $sFunction)  // Command Replaced was o_C_STRING length was 80
C_TEXT:C284(vPrefix)  // Command Replaced was o_C_STRING length was 50

$sCompanyName:=$1
$sFunction:=Uppercase:C13($2)

//`````BEGIN: retrieve consultant address ```````````````````````````````
C_BOOLEAN:C305($bEnterAddress)
$bEnterAddress:=False:C215

QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2="@"+$sCompanyName+"@")

If (Records in selection:C76([Conslt Address:77])<1)
	CONFIRM:C162("There is no address for the consultant "+$sCompanyName+". Would you like to enter the address now?"; "Yes"; "No")
	If (Ok=1)
		C_LONGINT:C283(btnconfirm)
		btnconfirm:=0
		$bEnterAddress:=True:C214
	End if 
	
Else 
	//at least one address entry was found
	If (Records in selection:C76([Conslt Address:77])>=1)
		
		Case of 
			: ($sFunction="RATING")
				QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Rating:19=True:C214)
			: ($sFunction="INSPECTION")
				QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Insp:20=True:C214)
			: ($sFunction="DESIGN")
				QUERY SELECTION:C341([Conslt Address:77]; [Conslt Address:77]Func_Design:21=True:C214)
		End case 
		
		//found exact match        
		If (Records in selection:C76([Conslt Address:77])=1)
			If ([Conslt Address:77]ContactPrefix:6="")
				vPrefix:="Mr."
			Else 
				vPrefix:=[Conslt Address:77]ContactPrefix:6
				If (Substring:C12(vPrefix; Length:C16(vPrefix); 1)#".")
					vPrefix:=vPrefix+"."
				End if 
			End if 
			
			vLastName:=[Conslt Address:77]ContactLName:4
			If ([Conslt Address:77]ContactMName:5="")
				vContactName:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
			Else 
				vContactName:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactMName:5+" "+[Conslt Address:77]ContactLName:4
			End if 
			
			If ([Conslt Address:77]ContactTitle:7#"")
				vContactName:=vContactName+", "+[Conslt Address:77]ContactTitle:7
				vContactName:=Replace string:C233(vContactName; ", ,"; ",")
			End if 
			If (([Conslt Address:77]Street2:9="") | (Replace string:C233([Conslt Address:77]Street2:9; " "; "")=""))
				vAddress1:=[Conslt Address:77]Street1:8
			Else 
				vAddress1:=[Conslt Address:77]Street1:8+<>sCR+[Conslt Address:77]Street2:9
			End if 
			vAddress2:=[Conslt Address:77]City:10+", "+[Conslt Address:77]State:11+" "+[Conslt Address:77]Zip:12
		Else 
			QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltName:2="@"+$sCompanyName+"@")
			C_LONGINT:C283($numRecs)  //Command Replaced was o_C_INTEGER
			C_LONGINT:C283($i; $j)  //Command Replaced was o_C_INTEGER
			C_TEXT:C284($AddressAll; $Function)  // Command Replaced was o_C_STRING length was 100
			$numRecs:=(Records in selection:C76([Conslt Address:77]))
			ARRAY TEXT:C222(asComboItem; $numRecs)  //Command Replaced was o_ARRAY string length was 250
			ARRAY TEXT:C222($asLastName; $numRecs)  //Command Replaced was o_ARRAY string length was 100
			ARRAY TEXT:C222($asContactName; $numRecs)  //Command Replaced was o_ARRAY string length was 100
			ARRAY TEXT:C222($asAddress1; $numRecs)  //Command Replaced was o_ARRAY string length was 100
			ARRAY TEXT:C222($asAddress2; $numRecs)  //Command Replaced was o_ARRAY string length was 100
			ARRAY TEXT:C222($asPrefix; $numRecs)  //Command Replaced was o_ARRAY string length was 100
			ARRAY LONGINT:C221($aLAddressID; $numRecs)
			
			For ($i; 1; $numRecs)
				$aLAddressID{$i}:=[Conslt Address:77]ConsltAddressID:1
				If ([Conslt Address:77]ContactPrefix:6="")
					$asPrefix{$i}:="Mr."
				Else 
					$asPrefix{$i}:=[Conslt Address:77]ContactPrefix:6
					If (Substring:C12($asPrefix{$i}; Length:C16($asPrefix{$i}); 1)#".")
						$asPrefix{$i}:=$asPrefix{$i}+"."
					End if 
				End if 
				
				$Function:=""
				$asLastName{$i}:=[Conslt Address:77]ContactLName:4
				If ([Conslt Address:77]ContactMName:5="")
					$asContactName{$i}:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
				Else 
					$asContactName{$i}:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactMName:5+" "+[Conslt Address:77]ContactLName:4
				End if 
				If ([Conslt Address:77]ContactTitle:7#"")
					$asContactName{$i}:=$asContactName{$i}+", "+[Conslt Address:77]ContactTitle:7
				End if 
				If (([Conslt Address:77]Street2:9="") | (Replace string:C233([Conslt Address:77]Street2:9; " "; "")=""))
					$asAddress1{$i}:=[Conslt Address:77]Street1:8
				Else 
					$asAddress1{$i}:=[Conslt Address:77]Street1:8+<>sCR+[Conslt Address:77]Street2:9
				End if 
				
				$asAddress2{$i}:=[Conslt Address:77]City:10+", "+[Conslt Address:77]State:11+" "+[Conslt Address:77]Zip:12
				If ([Conslt Address:77]Func_Rating:19=True:C214)
					$Function:="Rating "
				End if 
				If ([Conslt Address:77]Func_Insp:20=True:C214)
					$Function:=$Function+" Inspection "
				End if 
				$Function:="(Function: "+$Function+")"
				$AddressAll:=$asAddress1{$i}+", "+$asAddress2{$i}
				asComboItem{$i}:=$asContactName{$i}+" "+$Function+" "+$AddressAll
				NEXT RECORD:C51([Conslt Address:77])
			End for 
			
			C_LONGINT:C283(btnconfirm)
			btnconfirm:=0
			CENTER_WINDOW(480; 250)
			DIALOG:C40([Dialogs:21]; "ConsltAddressDialog")
			CLOSE WINDOW:C154
			If (ok=1)
				//use existing address            
				//define the values for the letter template here
				$j:=asComboItem
				vPrefix:=$asPrefix{$j}
				vLastName:=$asLastName{$j}
				vContactName:=$asContactName{$j}
				vAddress1:=$asAddress1{$j}
				vAddress2:=$asAddress2{$j}
			Else   //create new address            
				$bEnterAddress:=True:C214
			End if 
		End if   //If (Records in selection([Conslt Address])=1)
	End if   //If (Records in selection([Conslt Address])>=1)
End if   //If (Records in selection([Conslt Address])<1)

If ($bEnterAddress=True:C214)
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	FORM GET PROPERTIES:C674([Conslt Address:77]; "Conslt Address In"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	$Win_l:=ut_OpenNewWindow($Width_l; $Height_l; 0; Plain form window:K39:10; $Title_txt; "ut_CloseCancel")
	//$window:=Open form window([Conslt Address];"Conslt Address In")
	FORM SET INPUT:C55([Conslt Address:77]; "Conslt Address In")
	
	If (btnconfirm=0)
		C_LONGINT:C283(ConsltNameID_L)
		C_TEXT:C284(ConsltNameFunct_s)  // Command Replaced was o_C_STRING length was 3
		QUERY:C277([Conslt_Name:127]; [Conslt_Name:127]ConsultantName_s:2=$sCompanyName)
		If (Records in selection:C76([Conslt_Name:127])>0)
			ConsltNameID_L:=[Conslt_Name:127]ConsultantNameID_l:1
		Else 
			ConsltNameID_L:=0
		End if 
		ConsltNameFunct_s:="DES"
		ADD RECORD:C56([Conslt Address:77])
		ConsltNameFunct:=""
		ConsltNameID_L:=0
		
	Else 
		$j:=asComboItem
		READ WRITE:C146([Conslt Address:77])
		QUERY:C277([Conslt Address:77]; [Conslt Address:77]ConsltAddressID:1=$aLAddressID{$j})
		MODIFY RECORD:C57([Conslt Address:77])
	End if 
	
	vPrefix:=[Conslt Address:77]ContactPrefix:6
	vLastName:=[Conslt Address:77]ContactLName:4
	If ([Conslt Address:77]ContactMName:5="")
		vContactName:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactLName:4
	Else 
		vContactName:=[Conslt Address:77]ContactFName:3+" "+[Conslt Address:77]ContactMName:5+" "+[Conslt Address:77]ContactLName:4
	End if 
	If (([Conslt Address:77]Street2:9="") | (Replace string:C233([Conslt Address:77]Street2:9; " "; "")=""))
		vAddress1:=[Conslt Address:77]Street1:8
	Else 
		vAddress1:=[Conslt Address:77]Street1:8+<>sCR+[Conslt Address:77]Street2:9
	End if 
	
	vAddress2:=[Conslt Address:77]City:10+", "+[Conslt Address:77]State:11+" "+[Conslt Address:77]Zip:12
	CLOSE WINDOW:C154($Win_l)
	UNLOAD RECORD:C212([Conslt Address:77])
End if 