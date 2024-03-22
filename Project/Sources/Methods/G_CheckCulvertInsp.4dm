//%attributes = {"invisible":true}
//G_CheckCulvertInsp 
//Data consistency check for Culvert inspection
//Parameters 
// $0 : $msgs
If (False:C215)
	Mods_2005_CM06
	// Modified by: costasmanousakis-(Designer)-(10/12/2005 12:59:40)
	Mods_2005_CM17
	// Modified by: costasmanousakis-(Designer)-(5/22/2007 15:44:23)
	Mods_2007_CM10
	// Modified by: costasmanousakis-(Designer)-(12/17/07 09:53:11)
	Mods_2007_CM_5401
	//  `Combine Selection to array commands
	// Modified by: Costas Manousakis-(Designer)-(3/26/15 12:50:41)
	Mods_2015_03
	//  `use new method PON_NewBrMElementCheck
	
End if 

C_TEXT:C284($0)

C_TEXT:C284($msgs)
$msgs:=""
If ([Inspections:27]Item 43:140="")
	$msgs:=$msgs+"Item 43 not completed!"
	$msgs:=$msgs+" Use Struct Type button to get Item 43 from the SI&A"+<>sCR
Else 
	If ([Inspections:27]Item 43:140#[Bridge MHD NBIS:1]Item43:75)
		$msgs:=$msgs+"Item 43 not in sync with SIA Item 43!"
		$msgs:=$msgs+" Use Struct Type button to get Item 43 from the SI&A"+<>sCR
	End if 
End if 
If ([Inspections:27]Item 107:141="")
	$msgs:=$msgs+"Item 107 not completed!"
	$msgs:=$msgs+" Use Struct Type button to get Item 107 from the SI&A"+<>sCR
Else 
	If ([Inspections:27]Item 107:141#[Bridge MHD NBIS:1]Item107:79)
		$msgs:=$msgs+"Item 107 not in sync with SIA Item 107!"
		$msgs:=$msgs+" Use Struct Type button to get Item 107 from the SI&A"+<>sCR
	End if 
End if 
If (([Inspections:27]Item 41:77="") | ([Inspections:27]Item 41:77="N"))
	$msgs:=$msgs+"Item 41 not completed!"+<>sCR
End if 
If (([Inspections:27]Item 62:113="") | ([Inspections:27]Item 62:113="N"))
	$msgs:=$msgs+"Item 62 not completed!"+<>sCR
End if 
If (([Bridge MHD NBIS:1]Item6A:63="WATER@") & (([Inspections:27]Item 61:82="") | ([Inspections:27]Item 61:82="N")))
	$msgs:=$msgs+"Item 61 not completed for Bridge Over Water!"+<>sCR
End if 
If (([Bridge MHD NBIS:1]Item6A:63="WATER@") & (([Inspections:27]Item 61 Cur:159="") | ([Inspections:27]Item 61 Cur:159="N")))
	$msgs:=$msgs+"Item 61 For Current Report not completed for Bridge Over Water!"+<>sCR
End if 
If ([Inspections:27]Agency:156="")
	$msgs:=$msgs+"Inspecting Agency has not been selected!"+<>sCR
End if 
If ([Inspections:27]TeamLeader:4=0)
	$msgs:=$msgs+"Team Leader has not been selected!"+<>sCR
End if 
If (BLOB size:C605([Inspections:27]OrientationText:204)=0)
	$msgs:=$msgs+"Bridge Orientation text has not been entered!"+<>sCR
End if 
If ((([Inspections:27]CollisionDamSup:13#"N") & ([Inspections:27]CollisionDamSup:13#"")) & ([Inspections:27]CollisionSuper:98=""))
	$msgs:=$msgs+"There is Collision Damage in Structure but there is no explanation!"+<>sCR
End if 
If ((([Inspections:27]LoadVibration:15#"N") & ([Inspections:27]LoadVibration:15#"R") & ([Inspections:27]LoadVibration:15#"")) & ([Inspections:27]LoadVibSuper:100=""))
	$msgs:=$msgs+"There is Excessive Load Vibration in Structure but there is no explanation!"+<>sCR
End if 
If ((([Inspections:27]Scour:20#"N") & ([Inspections:27]Scour:20#"")) & ([Inspections:27]ScourTxt:103=""))
	$msgs:=$msgs+"There is Scour but there is no explanation!"+<>sCR
End if 
If (([Inspections:27]UnderMining:19) & ([Inspections:27]UnderminingTxt:102=""))
	$msgs:=$msgs+"There is Undermining in SubStructure but there is no explanation!"+<>sCR
End if 

//check for Image descriptions
C_LONGINT:C283($viNumImages; $i)  //Command Replaced was o_C_INTEGER
$viNumImages:=Records in selection:C76([Standard Photos:36])
If ($viNumImages>0)
	ARRAY TEXT:C222($atDescr; 0)
	ARRAY TEXT:C222($asPicType; 0)  //Command Replaced was o_ARRAY string length was 2
	ARRAY INTEGER:C220($aiSeqNum; 0)
	C_TEXT:C284($vtDescr)
	C_TEXT:C284(testphototype)  // Command Replaced was o_C_STRING length was 2//temp var for photo type
	SELECTION TO ARRAY:C260([Standard Photos:36]Description:2; $atDescr; [Standard Photos:36]PictType:5; $asPicType; [Standard Photos:36]SeqNum:6; $aiSeqNum)
	For ($i; 1; $viNumImages)
		//remove spaces, tabs, LFs and CRs    
		$vtDescr:=Replace string:C233($atDescr{$i}; " "; "")
		$vtDescr:=Replace string:C233($vtDescr; Char:C90(9); "")
		$vtDescr:=Replace string:C233($vtDescr; Char:C90(10); "")
		$vtDescr:=Replace string:C233($vtDescr; Char:C90(13); "")
		If (Length:C16($vtDescr)=0)
			testphototype:=$asPicType{$i}
			$msgs:=$msgs+"Image type "+Get_Description(->aPictType; ->aPictCode; ->testphototype)+" , Sequence number "+String:C10($aiSeqNum{$i})+" has no description!"+<>sCR
		End if 
		
	End for 
	
End if 

$msgs:=$msgs+PON_NewBrMElementCheck

$0:=$msgs
$msgs:=""