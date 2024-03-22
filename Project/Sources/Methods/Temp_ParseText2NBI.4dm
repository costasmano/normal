//%attributes = {"invisible":true}
//proccedure: Temp_ParseText2NBI
//purpose: Parse a stream text file into a Tab-delimited file
If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(3/1/17 15:50:56)
	Mods_2017_03
	//  `use ◊SIA_LoadRtg_63_RF_txt to decide if  Load Rating s 64,66  are rating factor or MT
	// Modified by: Costas Manousakis-(Designer)-(3/13/19 15:44:11)
	Mods_2019_03_bug
	//  `give .txt ext to parsed file ; show the parsed file on exit.
End if 


C_TIME:C306($dImportFile; $dImportRpt)
C_TEXT:C284($path; $file; $text; $data)
C_TEXT:C284($BIN)  // **Replaced old C_STRING length 3
C_TEXT:C284($tBuffer; $tNBI)
C_LONGINT:C283($counter)
C_TEXT:C284($brkey)  // **Replaced old C_STRING length 15
C_TEXT:C284($sdate)  // **Replaced old C_STRING length 255
C_REAL:C285($rdata)
C_DATE:C307($ddata)

$counter:=0
$dImportFile:=Open document:C264(""; "TEXT")  //Prompt user

//21-aug-2001 : added following to create a Import report
vdImpFile:=$dImportFile
$path:=GetPath

$file:=$path+"Parsed Records.txt"
$dImportRpt:=Create document:C266($file)
NewWindow(360; 40; 0; 4; "Parsing")
//Header
$text:="Item 8"
//$text:=$text+◊sTAB+"BIN"
$text:=$text+<>sTAB+"Item5"
$text:=$text+<>sTAB+"Item2"
$text:=$text+<>sTAB+"Item3"
$text:=$text+<>sTAB+"Item4"
$text:=$text+<>sTAB+"Item6A"
$text:=$text+<>sTAB+"Item6B"
$text:=$text+<>sTAB+"Item7"
$text:=$text+<>sTAB+"Item9"
$text:=$text+<>sTAB+"Item10"
$text:=$text+<>sTAB+"Item11"
$text:=$text+<>sTAB+"Item12"
$text:=$text+<>sTAB+"Item13A"
$text:=$text+<>sTAB+"Item13B"
$text:=$text+<>sTAB+"Item16A"
$text:=$text+<>sTAB+"Item16B"
$text:=$text+<>sTAB+"Item16C"
$text:=$text+<>sTAB+"Item17A"
$text:=$text+<>sTAB+"Item17B"
$text:=$text+<>sTAB+"Item17C"
$text:=$text+<>sTAB+"Item19"
$text:=$text+<>sTAB+"Item20"
$text:=$text+<>sTAB+"Item21"
$text:=$text+<>sTAB+"Item22"
$text:=$text+<>sTAB+"Item26"
$text:=$text+<>sTAB+"Item27"
$text:=$text+<>sTAB+"Item28A"
$text:=$text+<>sTAB+"Item28B"
$text:=$text+<>sTAB+"Item29"
$text:=$text+<>sTAB+"Item30"
$text:=$text+<>sTAB+"Item31"
$text:=$text+<>sTAB+"Item32"
$text:=$text+<>sTAB+"Item33"
$text:=$text+<>sTAB+"Item34"
$text:=$text+<>sTAB+"Item35"
$text:=$text+<>sTAB+"Item36A"
$text:=$text+<>sTAB+"Item36B"
$text:=$text+<>sTAB+"Item36C"
$text:=$text+<>sTAB+"Item36D"
$text:=$text+<>sTAB+"Item37"
$text:=$text+<>sTAB+"Item38"
$text:=$text+<>sTAB+"Item39"
$text:=$text+<>sTAB+"Item40"
$text:=$text+<>sTAB+"Item41"
$text:=$text+<>sTAB+"Item42"
$text:=$text+<>sTAB+"Item43"
$text:=$text+<>sTAB+"Item44"
$text:=$text+<>sTAB+"Item45"
$text:=$text+<>sTAB+"Item46"
$text:=$text+<>sTAB+"Item47"
$text:=$text+<>sTAB+"Item48"
$text:=$text+<>sTAB+"Item49"
$text:=$text+<>sTAB+"Item50A"
$text:=$text+<>sTAB+"Item50B"
$text:=$text+<>sTAB+"Item51"
$text:=$text+<>sTAB+"Item52"
$text:=$text+<>sTAB+"Item53"
$text:=$text+<>sTAB+"Item54A"
$text:=$text+<>sTAB+"Item54B"
$text:=$text+<>sTAB+"Item55A"
$text:=$text+<>sTAB+"Item55B"
$text:=$text+<>sTAB+"Item56"
$text:=$text+<>sTAB+"Item58"
$text:=$text+<>sTAB+"Item59"
$text:=$text+<>sTAB+"Item60"
$text:=$text+<>sTAB+"Item61"
$text:=$text+<>sTAB+"Item62"
$text:=$text+<>sTAB+"Item63"
$text:=$text+<>sTAB+"Item64"
$text:=$text+<>sTAB+"Item65"
$text:=$text+<>sTAB+"Item66"
$text:=$text+<>sTAB+"Item67"
$text:=$text+<>sTAB+"Item68"
$text:=$text+<>sTAB+"Item69"
$text:=$text+<>sTAB+"Item70"
$text:=$text+<>sTAB+"Item71"
$text:=$text+<>sTAB+"Item72"
$text:=$text+<>sTAB+"Item75A"
$text:=$text+<>sTAB+"Item75B"
$text:=$text+<>sTAB+"Item76"
$text:=$text+<>sTAB+"Item90"
$text:=$text+<>sTAB+"Item91"
$text:=$text+<>sTAB+"Item92AA"
$text:=$text+<>sTAB+"Item92AB"
$text:=$text+<>sTAB+"Item92BA"
$text:=$text+<>sTAB+"Item92BB"
$text:=$text+<>sTAB+"Item92CA"
$text:=$text+<>sTAB+"Item92CB"
$text:=$text+<>sTAB+"Item93A"
$text:=$text+<>sTAB+"Item93B"
$text:=$text+<>sTAB+"Item93C"
$text:=$text+<>sTAB+"Item94"
$text:=$text+<>sTAB+"Item95"
$text:=$text+<>sTAB+"Item96"
$text:=$text+<>sTAB+"Item97"
$text:=$text+<>sTAB+"Item98A"
$text:=$text+<>sTAB+"Item98B"
$text:=$text+<>sTAB+"Item99"
$text:=$text+<>sTAB+"Item100"
$text:=$text+<>sTAB+"Item101"
$text:=$text+<>sTAB+"Item102"
$text:=$text+<>sTAB+"Item103"
$text:=$text+<>sTAB+"Item104"
$text:=$text+<>sTAB+"Item105"
$text:=$text+<>sTAB+"Item106"
$text:=$text+<>sTAB+"Item107"
$text:=$text+<>sTAB+"Item108A"
$text:=$text+<>sTAB+"Item108B"
$text:=$text+<>sTAB+"Item108C"
$text:=$text+<>sTAB+"Item109"
$text:=$text+<>sTAB+"Item110"
$text:=$text+<>sTAB+"Item111"
$text:=$text+<>sTAB+"Item112"
$text:=$text+<>sTAB+"Item113"
$text:=$text+<>sTAB+"Item114"
$text:=$text+<>sTAB+"Item115"
$text:=$text+<>sTAB+"Item116"
$text:=$text+<>sTAB+"AASHTO SR"
SEND PACKET:C103($dImportRpt; $text+<>sCR)
//end of 21-aug-2001
C_LONGINT:C283($vlfilesize; $vlRecsize; $vlNumRecords; $vlRecNum)
$vlfilesize:=Get document size:C479($dImportFile)
$vlRecNum:=0
//read in the first record
RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
$vlRecsize:=Length:C16($tBuffer)+1
$vlNumRecords:=Int:C8($vlfilesize/$vlRecsize)
ALERT:C41("Approximately "+String:C10($vlNumRecords)+" records are in the input file.")
$tNBI:=$tBuffer
// 2-10-2000 : CM - Line removed
//RECEIVE PACKET($dImportFile;$tBuffer;1)  `read in line feed character
While (Ok=1)
	$vlRecNum:=$vlRecNum+1
	// 2-10-2000 : CM
	// Modification to account for CRLF or just CR records
	If (Substring:C12($tNBI; 1; 1)=<>sLF)
		//if 1st char is a LF then skip it    
		$tNBI:=Substring:C12($tNBI; 2)
	End if 
	
	$brkey:=Substring:C12($tNBI; 4; 15)
	$text:=$brkey
	$bin:=Substring:C12($brkey; 7; 3)
	//$text:=$text+◊sTAB+$bin
	GOTO XY:C161(1; 1)  // 2-10-2000 : CM 
	MESSAGE:C88("Parsing record "+$brkey+" - "+String:C10($vlRecNum; "000000")+" of "+String:C10($vlNumRecords; "000000")+"    ")
	$data:=Substring:C12($tNBI; 19; 9)
	$text:=$text+<>sTAB+$data  //Item5
	$data:=Substring:C12($tNBI; 28; 2)
	$text:=$text+<>sTAB+$data  //Item2
	$data:=Substring:C12($tNBI; 30; 3)
	$text:=$text+<>sTAB+$data  //Item3
	$data:=Substring:C12($tNBI; 33; 5)
	$text:=$text+<>sTAB+$data  //Item4
	$data:=Substring:C12($tNBI; 38; 24)
	$text:=$text+<>sTAB+$data  //Item6A
	$data:=Substring:C12($tNBI; 62; 1)
	$text:=$text+<>sTAB+$data  //Item6B
	$data:=Substring:C12($tNBI; 63; 18)
	$text:=$text+<>sTAB+$data  //Item7
	$data:=Substring:C12($tNBI; 81; 25)
	$text:=$text+<>sTAB+$data  //Item9
	$rdata:=Num:C11(Substring:C12($tNBI; 106; 4))/100
	$text:=$text+<>sTAB+String:C10($rdata)  //Item10
	$rdata:=Num:C11(Substring:C12($tNBI; 110; 7))/1000
	$text:=$text+<>sTAB+String:C10($rdata)  //Item11
	$data:=Substring:C12($tNBI; 117; 1)
	$text:=$text+<>sTAB+$data  //Item12
	$data:=Substring:C12($tNBI; 118; 10)
	$text:=$text+<>sTAB+$data  //Item13A
	$data:=Substring:C12($tNBI; 128; 2)
	$text:=$text+<>sTAB+$data  //Item13B
	$rdata:=Num:C11(Substring:C12($tNBI; 130; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item16A
	$rdata:=Num:C11(Substring:C12($tNBI; 132; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item16B
	$rdata:=Num:C11(Substring:C12($tNBI; 134; 4))/100
	$text:=$text+<>sTAB+String:C10($rdata)  //Item16C
	$rdata:=Num:C11(Substring:C12($tNBI; 138; 3))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item17A
	$rdata:=Num:C11(Substring:C12($tNBI; 141; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item17B
	$rdata:=Num:C11(Substring:C12($tNBI; 143; 4))/100
	$text:=$text+<>sTAB+String:C10($rdata)  //Item17C
	$rdata:=Num:C11(Substring:C12($tNBI; 147; 3))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item19
	$data:=Substring:C12($tNBI; 150; 1)
	$text:=$text+<>sTAB+$data  //Item20
	$data:=Substring:C12($tNBI; 151; 2)
	$text:=$text+<>sTAB+$data  //Item21
	$data:=Substring:C12($tNBI; 153; 2)
	$text:=$text+<>sTAB+$data  //Item22
	$data:=Substring:C12($tNBI; 155; 2)
	$text:=$text+<>sTAB+$data  //Item26
	$rdata:=Num:C11(Substring:C12($tNBI; 157; 4))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item27
	$rdata:=Num:C11(Substring:C12($tNBI; 161; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item28A
	$rdata:=Num:C11(Substring:C12($tNBI; 163; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item28B
	$rdata:=Num:C11(Substring:C12($tNBI; 165; 6))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item29
	$rdata:=Num:C11(Substring:C12($tNBI; 171; 4))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item30
	$data:=Substring:C12($tNBI; 175; 1)
	$text:=$text+<>sTAB+$data  //Item31
	$rdata:=Num:C11(Substring:C12($tNBI; 176; 4))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item32
	$data:=Substring:C12($tNBI; 180; 1)
	$text:=$text+<>sTAB+$data  //Item33
	$rdata:=Num:C11(Substring:C12($tNBI; 181; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item34
	$data:=Substring:C12($tNBI; 183; 1)
	$text:=$text+<>sTAB+$data  //Item35
	$data:=Substring:C12($tNBI; 184; 1)
	$text:=$text+<>sTAB+$data  //Item36A
	$data:=Substring:C12($tNBI; 185; 1)
	$text:=$text+<>sTAB+$data  //Item36B
	$data:=Substring:C12($tNBI; 186; 1)
	$text:=$text+<>sTAB+$data  //Item36C
	$data:=Substring:C12($tNBI; 187; 1)
	$text:=$text+<>sTAB+$data  //Item36D
	$data:=Substring:C12($tNBI; 188; 1)
	$text:=$text+<>sTAB+$data  //Item37
	$data:=Substring:C12($tNBI; 189; 1)
	$text:=$text+<>sTAB+$data  //Item38
	$rdata:=Num:C11(Substring:C12($tNBI; 190; 4))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item39
	$rdata:=Num:C11(Substring:C12($tNBI; 194; 5))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item40
	$data:=Substring:C12($tNBI; 199; 1)
	$text:=$text+<>sTAB+$data  //Item41
	$data:=Substring:C12($tNBI; 200; 2)
	$text:=$text+<>sTAB+$data  //Item42
	$data:=Substring:C12($tNBI; 202; 3)
	$text:=$text+<>sTAB+$data  //Item43
	$data:=Substring:C12($tNBI; 205; 3)
	$text:=$text+<>sTAB+$data  //Item44
	$rdata:=Num:C11(Substring:C12($tNBI; 208; 3))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item45
	$rdata:=Num:C11(Substring:C12($tNBI; 211; 4))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item46
	$rdata:=Num:C11(Substring:C12($tNBI; 215; 3))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item47
	$rdata:=Num:C11(Substring:C12($tNBI; 218; 5))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item48
	$rdata:=Num:C11(Substring:C12($tNBI; 223; 6))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item49
	$rdata:=Num:C11(Substring:C12($tNBI; 229; 3))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item50A
	$rdata:=Num:C11(Substring:C12($tNBI; 232; 3))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item50B
	$rdata:=Num:C11(Substring:C12($tNBI; 235; 4))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item51
	$rdata:=Num:C11(Substring:C12($tNBI; 239; 4))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item52
	$rdata:=Num:C11(Substring:C12($tNBI; 243; 4))/100
	$text:=$text+<>sTAB+String:C10($rdata)  //Item53
	$data:=Substring:C12($tNBI; 247; 1)
	$text:=$text+<>sTAB+$data  //Item54A
	$rdata:=Num:C11(Substring:C12($tNBI; 248; 4))/100
	$text:=$text+<>sTAB+String:C10($rdata)  //Item54B
	$data:=Substring:C12($tNBI; 252; 1)
	$text:=$text+<>sTAB+$data  //Item55A
	$rdata:=Num:C11(Substring:C12($tNBI; 253; 3))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item55B
	$rdata:=Num:C11(Substring:C12($tNBI; 256; 3))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item56
	$data:=Substring:C12($tNBI; 259; 1)
	$text:=$text+<>sTAB+$data  //Item58
	$data:=Substring:C12($tNBI; 260; 1)
	$text:=$text+<>sTAB+$data  //Item59
	$data:=Substring:C12($tNBI; 261; 1)
	$text:=$text+<>sTAB+$data  //Item60
	$data:=Substring:C12($tNBI; 262; 1)
	$text:=$text+<>sTAB+$data  //Item61
	$data:=Substring:C12($tNBI; 263; 1)
	$text:=$text+<>sTAB+$data  //Item62
	$data:=Substring:C12($tNBI; 264; 1)
	$text:=$text+<>sTAB+$data  //Item63
	
	If (Position:C15($data; <>SIA_LoadRtg_63_RF_txt)>0)
		$rdata:=Num:C11(Substring:C12($tNBI; 265; 3))/100
	Else 
		$rdata:=Num:C11(Substring:C12($tNBI; 265; 3))/10
	End if 
	
	$text:=$text+<>sTAB+String:C10($rdata)  //Item64
	$data:=Substring:C12($tNBI; 268; 1)
	$text:=$text+<>sTAB+$data  //Item65
	If (Position:C15($data; <>SIA_LoadRtg_63_RF_txt)>0)
		$rdata:=Num:C11(Substring:C12($tNBI; 269; 3))/100
	Else 
		$rdata:=Num:C11(Substring:C12($tNBI; 269; 3))/10
	End if 
	
	$text:=$text+<>sTAB+String:C10($rdata)  //Item66
	$data:=Substring:C12($tNBI; 272; 1)
	$text:=$text+<>sTAB+$data  //Item67
	$data:=Substring:C12($tNBI; 273; 1)
	$text:=$text+<>sTAB+$data  //Item68
	$data:=Substring:C12($tNBI; 274; 1)
	$text:=$text+<>sTAB+$data  //Item69
	$data:=Substring:C12($tNBI; 275; 1)
	$text:=$text+<>sTAB+$data  //Item70
	$data:=Substring:C12($tNBI; 276; 1)
	$text:=$text+<>sTAB+$data  //Item71
	$data:=Substring:C12($tNBI; 277; 1)
	$text:=$text+<>sTAB+$data  //Item72
	$data:=Substring:C12($tNBI; 278; 2)
	$text:=$text+<>sTAB+$data  //Item75A
	$data:=Substring:C12($tNBI; 280; 1)
	$text:=$text+<>sTAB+$data  //Item75B
	$rdata:=Num:C11(Substring:C12($tNBI; 281; 6))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item76
	$sdate:=Substring:C12($tNBI; 287; 4)
	If (Num:C11(Substring:C12($sdate; 3; 2))<50)
		$sdate:=Insert string:C231($sdate; "/01/20"; 3)  //Y2000 problem
	Else 
		$sdate:=Insert string:C231($sdate; "/01/19"; 3)
	End if 
	$ddata:=Date:C102($sdate)
	$text:=$text+<>sTAB+String:C10($ddata)  //Item90
	$rdata:=Num:C11(Substring:C12($tNBI; 291; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item91
	$data:=Substring:C12($tNBI; 293; 1)
	$text:=$text+<>sTAB+$data  //Item92AA
	$rdata:=Num:C11(Substring:C12($tNBI; 294; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item92AB
	$data:=Substring:C12($tNBI; 296; 1)
	$text:=$text+<>sTAB+$data  //Item92BA
	$rdata:=Num:C11(Substring:C12($tNBI; 297; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item92BB
	$data:=Substring:C12($tNBI; 299; 1)
	$text:=$text+<>sTAB+$data  //Item92CA
	$rdata:=Num:C11(Substring:C12($tNBI; 300; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item92CB
	$sdate:=Substring:C12($tNBI; 302; 4)
	//      10-10-2000 : CM following line changed
	// If (Num(Substring($sdate;2;2))<50)
	If (Num:C11(Substring:C12($sdate; 3; 2))<50)
		$sdate:=Insert string:C231($sdate; "/01/20"; 3)  //Y2000 problem
	Else 
		$sdate:=Insert string:C231($sdate; "/01/19"; 3)
	End if 
	$ddata:=Date:C102($sdate)
	$text:=$text+<>sTAB+String:C10($ddata)  //Item93A
	$sdate:=Substring:C12($tNBI; 306; 4)
	//      10-10-2000 : CM following line changed
	// If (Num(Substring($sdate;2;2))<50)
	If (Num:C11(Substring:C12($sdate; 3; 2))<50)
		$sdate:=Insert string:C231($sdate; "/01/20"; 3)  //Y2000 problem
	Else 
		$sdate:=Insert string:C231($sdate; "/01/19"; 3)
	End if 
	$ddata:=Date:C102($sdate)
	$text:=$text+<>sTAB+String:C10($ddata)  //Item93B
	$sdate:=Substring:C12($tNBI; 310; 4)
	//      10-10-2000 : CM following line changed
	// If (Num(Substring($sdate;2;2))<50)
	If (Num:C11(Substring:C12($sdate; 3; 2))<50)
		$sdate:=Insert string:C231($sdate; "/01/20"; 3)  //Y2000 problem
	Else 
		$sdate:=Insert string:C231($sdate; "/01/19"; 3)
	End if 
	$ddata:=Date:C102($sdate)
	$text:=$text+<>sTAB+String:C10($ddata)  //Item93C
	$rdata:=Num:C11(Substring:C12($tNBI; 314; 6))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item94
	$rdata:=Num:C11(Substring:C12($tNBI; 320; 6))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item95
	$rdata:=Num:C11(Substring:C12($tNBI; 326; 6))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item96
	$rdata:=Num:C11(Substring:C12($tNBI; 332; 4))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item97
	$data:=Substring:C12($tNBI; 336; 3)
	$text:=$text+<>sTAB+$data  //Item98A
	$data:=Substring:C12($tNBI; 339; 2)
	$text:=$text+<>sTAB+$data  //Item98B
	$data:=Substring:C12($tNBI; 341; 15)
	$text:=$text+<>sTAB+$data  //Item99
	$data:=Substring:C12($tNBI; 356; 1)
	$text:=$text+<>sTAB+$data  //Item100
	$data:=Substring:C12($tNBI; 357; 1)
	$text:=$text+<>sTAB+$data  //Item101
	$data:=Substring:C12($tNBI; 358; 1)
	$text:=$text+<>sTAB+$data  //Item102
	$data:=Substring:C12($tNBI; 359; 1)
	$text:=$text+<>sTAB+$data  //Item103
	$data:=Substring:C12($tNBI; 360; 1)
	$text:=$text+<>sTAB+$data  //Item104
	$data:=Substring:C12($tNBI; 361; 1)
	$text:=$text+<>sTAB+$data  //Item105
	$rdata:=Num:C11(Substring:C12($tNBI; 362; 4))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item106
	$data:=Substring:C12($tNBI; 366; 1)
	$text:=$text+<>sTAB+$data  //Item107
	$data:=Substring:C12($tNBI; 367; 1)
	$text:=$text+<>sTAB+$data  //Item108A
	$data:=Substring:C12($tNBI; 368; 1)
	$text:=$text+<>sTAB+$data  //Item108B
	$data:=Substring:C12($tNBI; 369; 1)
	$text:=$text+<>sTAB+$data  //Item108C
	$rdata:=Num:C11(Substring:C12($tNBI; 370; 2))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item109
	$data:=Substring:C12($tNBI; 372; 1)
	$text:=$text+<>sTAB+$data  //Item110
	$data:=Substring:C12($tNBI; 373; 1)
	$text:=$text+<>sTAB+$data  //Item111
	$data:=Substring:C12($tNBI; 374; 1)
	$text:=$text+<>sTAB+$data  //Item112
	$data:=Substring:C12($tNBI; 375; 1)
	$text:=$text+<>sTAB+$data  //Item113
	$rdata:=Num:C11(Substring:C12($tNBI; 376; 6))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item114
	$rdata:=Num:C11(Substring:C12($tNBI; 382; 4))
	$text:=$text+<>sTAB+String:C10($rdata)  //Item115
	$rdata:=Num:C11(Substring:C12($tNBI; 386; 4))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //Item116
	$rdata:=Num:C11(Substring:C12($tNBI; 429; 4))/10
	$text:=$text+<>sTAB+String:C10($rdata)  //AASHTO SR
	//$FHWA Select:=False
	//$AASHTO:=AASHTO_SuffRat 
	//$StructDef:=(bDeficient  & bFuncObsCheck  & ($AASHTO<80))
	//$FunctObs:=(bObsolete  & bFuncObsCheck  & ($AASHTO<80))
	//$OnSystem:=bOnSystem 
	//$InspResp:="FED"
	//$FHWARecord:=False
	SEND PACKET:C103($dImportRpt; ($text+<>sCR))
	//read in a record-this must follow
	RECEIVE PACKET:C104($dImportFile; $tBuffer; <>sCR)
	$tNBI:=$tBuffer
	//  2-10-2000 : CM - Line removed
	//RECEIVE PACKET($dImportFile;$tBuffer;1)  `read in line feed character for a DOS
End while 

CLOSE DOCUMENT:C267($dImportFile)
CLOSE DOCUMENT:C267($dImportRpt)  //21-aug-2001 : added to close report

SHOW ON DISK:C922($file)