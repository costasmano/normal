//%attributes = {"invisible":true}
//GP IMP_One_File
//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
//Process one tab-delimited Pontis import file.

C_TEXT:C284($BIN; $BDept; $BKey; $Town; $Month; $Day; $Year; $Leader; $Member)
C_TEXT:C284($ElemNo; $ElemEnv; $ElemQ; $PorQ)
ARRAY TEXT:C222($asCS; 5)

C_TEXT:C284($text)
C_TEXT:C284($District)  // Command Replaced was o_C_STRING length was 2
C_DATE:C307($Date)
C_LONGINT:C283($LeaderID; $MemberID; $names; $JobCode)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($ErrCode; $i; $j; $k; $iErr)  //Command Replaced was o_C_INTEGER
C_REAL:C285($Chksum)
C_BOOLEAN:C305($PrtHeader; $moved; $BadCS)
C_TIME:C306($dImportFile; $dImportRpt)
//What type of variable is a document reference?
//How do you initialize it?
//It looks like a time variable in the debugger.
$dImportFile:=$1
$dImportRpt:=$2

RECEIVE PACKET:C104($dImportFile; $BIN; <>sTab)
RECEIVE PACKET:C104($dImportFile; $BDept; <>sTab)
RECEIVE PACKET:C104($dImportFile; $BKey; <>sTab)
RECEIVE PACKET:C104($dImportFile; $Town; <>sTab)  //Included for error checking only.
RECEIVE PACKET:C104($dImportFile; $Month; <>sTab)
RECEIVE PACKET:C104($dImportFile; $Day; <>sTab)
RECEIVE PACKET:C104($dImportFile; $Year; <>sTab)
RECEIVE PACKET:C104($dImportFile; $Leader; <>sTab)
RECEIVE PACKET:C104($dImportFile; $Member; <>sCR)

//"BMS Insp. Import" $ErrCode Key
//==========================
//Bit     Value   Level   Description
//  1           1       E      BIN is not 3 characters long.
//  2           2       E      BIN is not in database.
//  3           4       E      Bridge Department Number does not match BIN.
//  4           8       E      Bridge Key Number does not match BIN.
//  5         16      W      Town Name does not match Bridge Department Number.
//  6         32       E      Invalid Inspection Date.
//  7         64       E      Could not identify Inspection Team Leader.
//  8       128      W      Team Leader is not assigned to Bridge's District.
//  9       256      W      Individual is not listed as a Team Leader.
//10       512       E      Could not identify Inspection Team Member.
//11     1024      W      Team Member is not assigned to Bridge's District.
//12     2048       E      Duplicate BIN/Inspection Date.
//13     4096       E      x
//14     8192       E      x
//15   16384       E      x
//16   32768       E      x

$ErrCode:=0

//Verify data.
$BIN:=ChkBIN($BIN)
$BDept:=ChkBDept($BDept)
$BKey:=Strip($BKey)
If (Length:C16($BIN)#3)
	//The BIN is supposed to be 3 characters long.  
	$ErrCode:=$ErrCode+BinErr(1)
Else 
	QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]BIN:3=$BIN)
	If (Records in selection:C76([Bridge MHD NBIS:1])=0)
		$ErrCode:=$ErrCode+BinErr(2)
	Else 
		If ([Bridge MHD NBIS:1]BDEPT:1#$BDept)
			$ErrCode:=$ErrCode+BinErr(3)
		Else 
			$District:=Get_District($BDept)
			If ($Town#Get_Town_Name($BDept))
				$ErrCode:=$ErrCode+BinErr(5)
			End if 
		End if 
		If ([Bridge MHD NBIS:1]Bridge Key:2#$BKey)
			$ErrCode:=$ErrCode+BinErr(4)
		End if 
	End if 
End if 

//Date
$Month:=ChkMonth($Month)
$Day:=ChkDay($Day)
$Year:=ChkYear($Year)
$Date:=Date:C102($Month+"/"+$Day+"/"+$Year)
If ($Date=!00-00-00!)
	$ErrCode:=$ErrCode+BinErr(6)
End if 

//Try to find the Inspection Team Leader.
$JobCode:=2
ARRAY TEXT:C222(aNames; 0)
PARSE_NAMES($Leader; ->aNames)
$LeaderID:=GetPersonID(->aNames; $JobCode; Num:C11($District))
If ($LeaderID=0)
	$ErrCode:=$ErrCode+BinErr(7)
Else 
	QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$LeaderID)
	If (([Personnel:42]Division No:7#"") & ($District[[1]]#[Personnel:42]Division No:7[[4]]))
		$ErrCode:=$ErrCode+BinErr(8)
	End if 
	If (([Personnel:42]Job Code:8#2))
		$ErrCode:=$ErrCode+BinErr(9)
	End if 
End if 

//Try to find the Inspection Team Member(s).
$JobCode:=3
ARRAY TEXT:C222(aNames; 0)
PARSE_NAMES($Member; ->aNames)
$i:=0
ARRAY INTEGER:C220($aMemberIDs; 0)
Repeat 
	//GetPersonID deletes array elements after finding an individual.
	$MemberID:=GetPersonID(->aNames; $JobCode; Num:C11($District))
	If ($MemberID>0)
		$i:=$i+1
		INSERT IN ARRAY:C227($aMemberIDs; $i)
		$aMemberIDs{$i}:=$MemberID
	End if 
	$names:=Size of array:C274(aNames)
Until ($names<=0)

If (Size of array:C274($aMemberIDs)=0)
	$ErrCode:=$ErrCode+BinErr(10)
Else 
	//Check if the first team member is in the right district.  
	QUERY:C277([Personnel:42]; [Personnel:42]Person ID:1=$aMemberIDs{1})
	If (([Personnel:42]Division No:7#"") & ($District[[1]]#[Personnel:42]Division No:7[[4]]))
		$ErrCode:=$ErrCode+BinErr(11)
	End if 
End if 

//Now create and save the inspection record.

CREATE RECORD:C68([BMS Inspections:44])
Inc_Sequence("Pontis Insp ID"; ->[BMS Inspections:44]Inspection ID:1)
[BMS Inspections:44]BIN:2:=$BIN
[BMS Inspections:44]Span Group No:3:=1
[BMS Inspections:44]Insp Date:4:=$Date
If (Check_DupInsp)
	$ErrCode:=$ErrCode+BinErr(12)
End if 
QUERY:C277([Personnel:42]; [Personnel:42]Job Code:8=1; *)  //Bridge Inspection Engineer level.
QUERY:C277([Personnel:42]; [Personnel:42]Division No:7="044"+$District[[1]])
If (Records in selection:C76([Personnel:42])=1)
	[BMS Inspections:44]DBrInspEngr:5:=[Personnel:42]Person ID:1
End if 
[BMS Inspections:44]TeamLeader:6:=$LeaderID
[BMS Inspections:44]Modified By:7:=Current user:C182
[BMS Inspections:44]DateCreated:8:=Current date:C33(*)  //+◊LDifference  `Add the difference between the server date
[BMS Inspections:44]TimeCreated:9:=Current time:C178(*)  //+◊hDifference  `Add the difference between the server time
[BMS Inspections:44]ImportErrorCode:12:=$ErrCode
SAVE RECORD:C53([BMS Inspections:44])

$i:=1
While ($i<=Size of array:C274($aMemberIDs))
	If ($aMemberIDs{$i}>0)
		CREATE RECORD:C68([BMS Field Trip:56])
		[BMS Field Trip:56]Inspection ID:1:=[BMS Inspections:44]Inspection ID:1
		[BMS Field Trip:56]Person ID:2:=$aMemberIDs{$i}
		SAVE RECORD:C53([BMS Field Trip:56])
	End if 
	$i:=$i+1
End while 


//Report any errors.
If ($ErrCode>0)
	//First, output the Bridge Header....  
	$text:=<>sCR+"BIN:'"+$BIN+"'  Dept:'"+$BDept+"'  Key:'"+$BKey+"'  Town:'"+$Town
	$text:=$text+"'  MM:'"+$Month+"'  DD:'"+$Day+"'  YY:'"+$Year
	$text:=$text+"'  Leader:'"+$Leader+"'  Member:'"+$Member+"'"+<>sCR
	SEND PACKET:C103($dImportRpt; $text)
	OUTPUT_ERRORS($dImportRpt; $ErrCode; "BMS Insp. Import")
	$PrtHeader:=False:C215
Else 
	$PrtHeader:=True:C214
End if 


//Process the Elements.

//"BMS Elem. Import" $aElemErr Key
//==========================
//Bit    Value  Level  Description
//  1          1      E     Invalid element number.
//  2          2      E     Invalid element environment.
//  3          4      E     Invalid element quantity.
//  4          8     W     Please verify element quantity.
//  5        16     W     Can't determine % or Q; assume quantities.
//  6        32      E     Too many condition states for this element.
//  7        64      E     The condition state sum is not the total quantity.
//  8      128     W     Duplicate Element/Env.; quantities moved to first one.
//  9      256      E     Quantity must be in one condition state for this element
//10      512     W     Smart flag quantity has been changed to 1.
//11    1024     W     x
//12    2048      E     x
//13    4096      E     x
//14    8192      E     x
//15  16384      E     x
//16  32768      E     x

//TRACE

ARRAY INTEGER:C220($aID; 0)
ARRAY TEXT:C222($aUnit; 0)  //Command Replaced was o_ARRAY string length was 30
ARRAY INTEGER:C220($aElNo; 0)
ARRAY INTEGER:C220($aEnv; 0)
ARRAY REAL:C219($aQ; 0)
ARRAY REAL:C219($aCS; 5; 0)
ARRAY BOOLEAN:C223($aPorQ; 0)
ARRAY INTEGER:C220($aElemErr; 0)
ARRAY INTEGER:C220($aNoCSs; 0)
ARRAY BOOLEAN:C223($aEach; 0)
ARRAY BOOLEAN:C223($aSmartFl; 0)

$j:=0
$iErr:=0
RECEIVE PACKET:C104($dImportFile; $ElemNo; <>sTab)
While (OK=1)
	RECEIVE PACKET:C104($dImportFile; $ElemEnv; <>sTab)
	RECEIVE PACKET:C104($dImportFile; $ElemQ; <>sTab)
	For ($i; 1; 5)
		RECEIVE PACKET:C104($dImportFile; $asCS{$i}; <>sTab)
	End for 
	RECEIVE PACKET:C104($dImportFile; $PorQ; <>sCR)
	
	$j:=$j+1
	INSERT IN ARRAY:C227($aID; $j)
	INSERT IN ARRAY:C227($aUnit; $j)
	INSERT IN ARRAY:C227($aElNo; $j)
	INSERT IN ARRAY:C227($aEnv; $j)
	INSERT IN ARRAY:C227($aQ; $j)
	For ($i; 1; 5)
		INSERT IN ARRAY:C227($aCS{$i}; $j)
	End for 
	INSERT IN ARRAY:C227($aPorQ; $j)
	INSERT IN ARRAY:C227($aElemErr; $j)
	INSERT IN ARRAY:C227($aNoCSs; $j)
	INSERT IN ARRAY:C227($aEach; $j)
	INSERT IN ARRAY:C227($aSmartFl; $j)
	
	//Process element number.  
	$aElNo{$j}:=Num:C11($ElemNo)
	$aElemErr{$j}:=0
	QUERY:C277([BMS Elements:47]; [BMS Elements:47]Element No:2=$aElNo{$j})
	If (Records in selection:C76([BMS Elements:47])>0)
		$aID{$j}:=[BMS Elements:47]Element ID:1
		$aUnit{$j}:=[BMS Elements:47]Units:6
		RELATE ONE:C42([BMS Elements:47]Category ID:8)
		$aNoCSs{$j}:=[BMS Categories:49]Num of CSs:7
		$aEach{$j}:=[BMS Categories:49]Record as Each:6
		$aSmartFl{$j}:=[BMS Categories:49]Smart Flag:5
	Else 
		//Set the invalid Element ID to a negative number so the
		//invalid elements will be kept separate and not added together.
		$iErr:=$iErr-1
		$aID{$j}:=$iErr
		$aElemErr{$j}:=$aElemErr{$j}+BinErr(1)
		$aNoCSs{$j}:=5
	End if 
	
	//Process  environment.  
	$aEnv{$j}:=Num:C11($ElemEnv)
	If (($aEnv{$j}<1) | ($aEnv{$j}>4))
		$aElemErr{$j}:=$aElemErr{$j}+BinErr(2)
	End if 
	
	//Process element quantity.
	Case of 
		: ((Position:C15("+"; $ElemQ)>0) | (Position:C15("*"; $ElemQ)>0) | (Position:C15("-"; $ElemQ)>0))
			$aElemErr{$j}:=$aElemErr{$j}+BinErr(3)
		: (Position:C15("/"; $ElemQ)>0)
			$ElemQ:=Substring:C12($ElemQ; Position:C15("/"; $ElemQ)+1)
			$aElemErr{$j}:=$aElemErr{$j}+BinErr(4)
	End case 
	$aQ{$j}:=Num:C11($ElemQ)
	If (($aSmartFl{$j}) & ($aQ{$j}#1))
		//Smart Flags must have quantity=1.
		$aQ{$j}:=1
		$aElemErr{$j}:=$aElemErr{$j}+BinErr(10)
	End if 
	
	//Process the Condition States.  
	//Note: The position function ignores case.  
	Case of 
		: (Position:C15("Q"; $PorQ)>0)
			//The condition states are quantities.
			$aPorQ{$j}:=False:C215
		: (Position:C15("P"; $PorQ)>0)
			//The condition states are percentages.
			$aPorQ{$j}:=True:C214
		Else 
			//Don't know which; assume quantities.      
			$aPorQ{$j}:=False:C215
			$aElemErr{$j}:=$aElemErr{$j}+BinErr(5)
	End case 
	
	$Chksum:=0
	$BadCS:=False:C215
	$k:=0
	For ($i; 1; 5)
		If ($aPorQ{$j})
			//Convert the percentage to a quantity.      
			$aCS{$i}{$j}:=$aQ{$j}*(Num:C11($asCS{$i})/100)
		Else 
			$aCS{$i}{$j}:=Num:C11($asCS{$i})
		End if 
		If (($aSmartFl{$j}) & ($aCS{$i}{$j}#1) & ($aCS{$i}{$j}#0))
			//A smart flag quantity must be zero or one.
			$aCS{$i}{$j}:=1
		End if 
		If ($aCS{$i}{$j}>0)
			//Count the number of condition states with values.      
			$k:=$k+1
		End if 
		$Chksum:=$Chksum+$aCS{$i}{$j}
		If (($aCS{$i}{$j}>0) & ($i>$aNoCSs{$j}))
			$BadCS:=True:C214
		End if 
	End for 
	
	If ($BadCS)
		$aElemErr{$j}:=$aElemErr{$j}+BinErr(6)
	End if 
	
	If (Abs:C99(($Chksum-$aQ{$j})/$aQ{$j})>0.01)
		$aElemErr{$j}:=$aElemErr{$j}+BinErr(7)
	End if 
	
	If ((($aEach{$j}) | ($aSmartFl{$j})) & ($k>1))
		//Only one CS allowed for this element.
		$aElemErr{$j}:=$aElemErr{$j}+BinErr(9)
	End if 
	
	//If the number and environment match an earlier element,
	//move the quantities to the first one (i.e., combine the quantities). 
	If ($j>1)
		//Check previous elements.
		$moved:=False:C215
		$k:=1
		While (($k<$j) & Not:C34($moved))
			If (($aID{$k}=$aID{$j}) & ($aEnv{$k}=$aEnv{$j}))
				//The element and environment match.  Combine the quantities with those
				//from the first occurence, then zero the quantities from this occurence.
				$aQ{$k}:=$aQ{$k}+$aQ{$j}
				$aQ{$j}:=0
				For ($i; 1; 5)
					$aCS{$i}{$k}:=$aCS{$i}{$k}+$aCS{$i}{$j}
					$aCS{$i}{$j}:=0
				End for 
				$aElemErr{$j}:=$aElemErr{$j}+BinErr(8)
				$moved:=True:C214
			End if 
			$k:=$k+1
		End while 
	End if 
	
	RECEIVE PACKET:C104($dImportFile; $ElemNo; <>sTab)
End while 

//TRACE

For ($j; 1; Size of array:C274($aID))
	//Create the Condition State record.  But first check to see if this
	//element was combined with an earlier duplicate.
	// Changes made 6/6/00
	// If (bitAND(BinErr (8);$aElemErr{$j})=0)
	If (BinErr(8) & $aElemErr{$j}=0)  // Changed code to work for 4D V6.5
		
		
		//This is not a duplicate Elem/Env, write it.    
		CREATE RECORD:C68([Cond Units:45])
		Inc_Sequence("Cond Unit ID"; ->[Cond Units:45]Cond Unit ID:1)
		[Cond Units:45]Inspection ID:2:=[BMS Inspections:44]Inspection ID:1
		[Cond Units:45]Element ID:3:=$aID{$j}
		[Cond Units:45]Environment:4:=$aEnv{$j}
		[Cond Units:45]Total Quantity:5:=MetricizeQ($aQ{$j}; $aUnit{$j})
		[Cond Units:45]Metric:9:=False:C215  //Store Metric Units; Display English Units.
		[Cond Units:45]Percent:6:=$aPorQ{$j}
		[Cond Units:45]ImportErrorCode:8:=$aElemErr{$j}
		For ($i; 1; 5)
			If ($i<=$aNoCSs{$j})
				a_ptr_CSfld{$i}->:=MetricizeQ($aCS{$i}{$j}; $aUnit{$j})
			Else 
				a_ptr_CSfld{$i}->:=-1
			End if 
		End for 
		SAVE RECORD:C53([Cond Units:45])
		//
		//Obsolete
		//    For ($i;1;$aNoCSs{$j})
		//      CREATE RECORD([Cond State Insp])
		//      [Cond State Insp]Cond Unit ID:=[Cond Units]Cond Unit ID
		//      [Cond State Insp]Cond State No:=$i
		//      [Cond State Insp]Amount:=MetricizeQ ($aCS{$i}{$j};$aUnit{$j})
		//      [Cond State Insp]New:=False
		//      SAVE RECORD([Cond State Insp])
		//    End for 
	End if 
	
	//Write out the Error Report if necessary.
	//Report any errors.
	
	If ($aElemErr{$j}>0)
		If ($PrtHeader)
			//The Bridge Header has not been output yet.
			$text:=<>sCR+"BIN:'"+$BIN+"'  Dept:'"+$BDept+"'  Key:'"+$BKey+"'  Town:'"+$Town
			$text:=$text+"'  MM:'"+$Month+"'  DD:'"+$Day+"'  YY:'"+$Year
			$text:=$text+"'  Leader:'"+$Leader+"'  Member:'"+$Member+"'"+<>sCR
			SEND PACKET:C103($dImportRpt; $text)
			$PrtHeader:=False:C215
		End if 
		
		//Output the header for this element and then the error descriptions.   
		$text:="Element:'"+String:C10($aElNo{$j})+"'  Environment:'"+String:C10($aEnv{$j})
		$text:=$text+"'  Quantity:'"+String:C10($aQ{$j})+"'  PorQ:'"+String:C10(Num:C11($aPorQ{$j}); "P;;Q")+"'"
		For ($i; 1; 5)
			$text:=$text+"  CS"+String:C10($i)+":'"+String:C10($aCS{$i}{$j})+"'"
		End for 
		$text:=$text+<>sCR
		SEND PACKET:C103($dImportRpt; $text)
		OUTPUT_ERRORS($dImportRpt; $aElemErr{$j}; "BMS Elem. Import")
	End if 
End for 
