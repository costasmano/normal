//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/20/06, 22:06:05
	// ----------------------------------------------------
	// Method: INIT_UI_GV_LoadArrays
	// Description
	// Load UI arrays and optionally return them in a Blob
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_BOOLEAN:C305($ReturnBlob)
$ReturnBlob:=False:C215
Case of 
	: (Count parameters:C259=0)
	: ($1="1")  //special case to save values to a blob
		C_BLOB:C604($0; $Return_blb)
		SET BLOB SIZE:C606($Return_blb; 0)
		C_LONGINT:C283($OffSet_l)
		$OffSet_l:=0
		$ReturnBlob:=True:C214
	Else 
End case 


ARRAY TEXT:C222(<>aSIAPages; 15)  //Command Replaced was o_ARRAY string length was 25
ARRAY INTEGER:C220(<>aSIAPageNo; 15)
<>aSIAPages{1}:="Identification"
<>aSIAPages{2}:="Structure Type"
<>aSIAPages{3}:="Age and Service"
<>aSIAPages{4}:="Geometric Data"
<>aSIAPages{5}:="Navigation Data"
<>aSIAPages{6}:="Classification"
<>aSIAPages{7}:="Condition"
<>aSIAPages{8}:="Load Rating and Posting"
<>aSIAPages{9}:="Appraisal"
<>aSIAPages{10}:="Proposed Improvements"
<>aSIAPages{11}:="Inspections"
<>aSIAPages{12}:="Rating Loads"
<>aSIAPages{13}:="Field Posting"
<>aSIAPages{14}:="Bridge Specifics"
<>aSIAPages{15}:="Accessibility"
<>aSIAPageNo{1}:=1
<>aSIAPageNo{2}:=2
<>aSIAPageNo{3}:=3
<>aSIAPageNo{4}:=4
<>aSIAPageNo{5}:=5
<>aSIAPageNo{6}:=6
<>aSIAPageNo{7}:=7
<>aSIAPageNo{8}:=7
<>aSIAPageNo{9}:=8
<>aSIAPageNo{10}:=8
<>aSIAPageNo{11}:=9
<>aSIAPageNo{12}:=9
<>aSIAPageNo{13}:=10
<>aSIAPageNo{14}:=10
<>aSIAPageNo{15}:=10
If ($ReturnBlob)
	VARIABLE TO BLOB:C532(<>aSIAPages; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aSIAPageNo; $Return_blb; *)
End if 

//`BEGIN: SJH 04/21/2004 `````````````````````````````````````````````````
ARRAY TEXT:C222(<>aNBIPages; 93)  //Command Replaced was o_ARRAY string length was 25
ARRAY LONGINT:C221(<>aNBIPageNo; 93)
ARRAY POINTER:C280(<>aNBIField; 93)

<>aNBIField{1}:=->[Bridge MHD NBIS:1]Item2:60
<>aNBIField{2}:=->[Bridge MHD NBIS:1]Item3:61
<>aNBIField{3}:=->[Bridge MHD NBIS:1]Item4:62
<>aNBIField{4}:=->[Bridge MHD NBIS:1]Item5:59
<>aNBIField{5}:=->v6Descr  //[Bridge MHD NBIS]Item6A
<>aNBIField{6}:=->v7Descr  //[Bridge MHD NBIS]Item7
<>aNBIField{7}:=->[Bridge MHD NBIS:1]Item8:206
<>aNBIField{8}:=->[Bridge MHD NBIS:1]Item9:66
<>aNBIField{9}:=->[Bridge MHD NBIS:1]Item10:102
<>aNBIField{10}:=->[Bridge MHD NBIS:1]Item16A:68
<>aNBIField{11}:=->[Bridge MHD NBIS:1]Item12:196
<>aNBIField{12}:=->[Bridge MHD NBIS:1]Item 13A:197
<>aNBIField{13}:=->[Bridge MHD NBIS:1]Item16A:68
<>aNBIField{14}:=->[Bridge MHD NBIS:1]Item17A:70
<>aNBIField{15}:=->[Bridge MHD NBIS:1]Item19:91
<>aNBIField{16}:=->[Bridge MHD NBIS:1]Item20:126
<>aNBIField{17}:=->[Bridge MHD NBIS:1]Item21:127
<>aNBIField{18}:=->[Bridge MHD NBIS:1]Item22:128
<>aNBIField{19}:=->[Bridge MHD NBIS:1]Item26:120
<>aNBIField{20}:=->[Bridge MHD NBIS:1]Item27:83
<>aNBIField{21}:=->[Bridge MHD NBIS:1]Item28A:86
<>aNBIField{22}:=->[Bridge MHD NBIS:1]Item29:88
<>aNBIField{23}:=->[Bridge MHD NBIS:1]Item30:89
<>aNBIField{24}:=->[Bridge MHD NBIS:1]Item31:135
<>aNBIField{25}:=->[Bridge MHD NBIS:1]Item32:98
<>aNBIField{26}:=->[Bridge MHD NBIS:1]Item33:99
<>aNBIField{27}:=->[Bridge MHD NBIS:1]Item34:100
<>aNBIField{28}:=->[Bridge MHD NBIS:1]Item35:101
<>aNBIField{29}:=->[Bridge MHD NBIS:1]Item36A:147
<>aNBIField{30}:=->[Bridge MHD NBIS:1]Item37:129
<>aNBIField{31}:=->[Bridge MHD NBIS:1]Item38:113
<>aNBIField{32}:=->[Bridge MHD NBIS:1]Item39:115
<>aNBIField{33}:=->[Bridge MHD NBIS:1]Item40:117
<>aNBIField{34}:=->[Bridge MHD NBIS:1]Item41:141
<>aNBIField{35}:=->[Bridge MHD NBIS:1]Item42:85
<>aNBIField{36}:=->[Bridge MHD NBIS:1]Item43:75
<>aNBIField{37}:=->[Bridge MHD NBIS:1]Item44:76
<>aNBIField{38}:=->[Bridge MHD NBIS:1]Item45:77
<>aNBIField{39}:=->[Bridge MHD NBIS:1]Item46:78
<>aNBIField{40}:=->[Bridge MHD NBIS:1]Item47:104
<>aNBIField{41}:=->[Bridge MHD NBIS:1]Item48:92
<>aNBIField{42}:=->[Bridge MHD NBIS:1]Item49:93
<>aNBIField{43}:=->[Bridge MHD NBIS:1]Item50A:94
<>aNBIField{44}:=->[Bridge MHD NBIS:1]Item51:96
<>aNBIField{45}:=->[Bridge MHD NBIS:1]Item52:97
<>aNBIField{46}:=->[Bridge MHD NBIS:1]Item53:105
<>aNBIField{47}:=->[Bridge MHD NBIS:1]Item54B:108
<>aNBIField{48}:=->[Bridge MHD NBIS:1]Item55B:111
<>aNBIField{49}:=->[Bridge MHD NBIS:1]Item56:112
<>aNBIField{50}:=->[Bridge MHD NBIS:1]Item58:130
<>aNBIField{51}:=->[Bridge MHD NBIS:1]Item59:131
<>aNBIField{52}:=->[Bridge MHD NBIS:1]Item60:132
<>aNBIField{53}:=->[Bridge MHD NBIS:1]Item61:133
<>aNBIField{54}:=->[Bridge MHD NBIS:1]Item62:134
<>aNBIField{55}:=->[Bridge MHD NBIS:1]Item 63:199
<>aNBIField{56}:=->[Bridge MHD NBIS:1]Item64:137
<>aNBIField{57}:=->[Bridge MHD NBIS:1]Item 65:200
<>aNBIField{58}:=->[Bridge MHD NBIS:1]Item66:139
<>aNBIField{59}:=->[Bridge MHD NBIS:1]Item67:142
<>aNBIField{60}:=->[Bridge MHD NBIS:1]Item68:143
<>aNBIField{61}:=->[Bridge MHD NBIS:1]Item69:144
<>aNBIField{62}:=->[Bridge MHD NBIS:1]Item70:140
<>aNBIField{63}:=->[Bridge MHD NBIS:1]Item71:145
<>aNBIField{64}:=->[Bridge MHD NBIS:1]Item72:146
<>aNBIField{65}:=->[Bridge MHD NBIS:1]Item75A:152
<>aNBIField{66}:=->[Bridge MHD NBIS:1]Item76:154
<>aNBIField{67}:=->[Bridge MHD NBIS:1]Item90:161
<>aNBIField{68}:=->[Bridge MHD NBIS:1]Item91:162
<>aNBIField{69}:=->[Bridge MHD NBIS:1]Item92AB:164
<>aNBIField{70}:=->[Bridge MHD NBIS:1]Item93A:169
<>aNBIField{71}:=->[Bridge MHD NBIS:1]Item94:155
<>aNBIField{72}:=->[Bridge MHD NBIS:1]Item95:156
<>aNBIField{73}:=->[Bridge MHD NBIS:1]Item96:157
<>aNBIField{74}:=->[Bridge MHD NBIS:1]Item97:158
<>aNBIField{75}:=->[Bridge MHD NBIS:1]Item98A:72
<>aNBIField{76}:=->[Bridge MHD NBIS:1]Item99:74
<>aNBIField{77}:=->[Bridge MHD NBIS:1]Item100:121
<>aNBIField{78}:=->[Bridge MHD NBIS:1]Item101:122
<>aNBIField{79}:=->[Bridge MHD NBIS:1]Item102:123
<>aNBIField{80}:=->[Bridge MHD NBIS:1]Item103:124
<>aNBIField{81}:=->[Bridge MHD NBIS:1]Item104:119
<>aNBIField{82}:=->[Bridge MHD NBIS:1]Item 105:201
<>aNBIField{83}:=->[Bridge MHD NBIS:1]Item106:84
<>aNBIField{84}:=->[Bridge MHD NBIS:1]Item107:79
<>aNBIField{85}:=->[Bridge MHD NBIS:1]Item108A:80
<>aNBIField{86}:=->[Bridge MHD NBIS:1]Item109:90
<>aNBIField{87}:=->[Bridge MHD NBIS:1]Item110:125
<>aNBIField{88}:=->[Bridge MHD NBIS:1]Item111:114
<>aNBIField{89}:=->[Bridge MHD NBIS:1]Item112:118
<>aNBIField{90}:=->[Bridge MHD NBIS:1]Item113:151
<>aNBIField{91}:=->[Bridge MHD NBIS:1]Item114:159
<>aNBIField{92}:=->[Bridge MHD NBIS:1]Item115:160
<>aNBIField{93}:=->[Bridge MHD NBIS:1]Item116:116

<>aNBIPages{1}:="Item 2"
<>aNBIPages{2}:="Item 3"
<>aNBIPages{3}:="Item 4"
<>aNBIPages{4}:="Item 5"
<>aNBIPages{5}:="Item 6"
<>aNBIPages{6}:="Item 7"
<>aNBIPages{7}:="Item 8"
<>aNBIPages{8}:="Item 9"
<>aNBIPages{9}:="Item 10"
<>aNBIPages{10}:="Item 11"
<>aNBIPages{11}:="Item 12"
<>aNBIPages{12}:="Item 13"
<>aNBIPages{13}:="Item 16"
<>aNBIPages{14}:="Item 17"
<>aNBIPages{15}:="Item 19"
<>aNBIPages{16}:="Item 20"
<>aNBIPages{17}:="Item 21"
<>aNBIPages{18}:="Item 22"
<>aNBIPages{19}:="Item 26"
<>aNBIPages{20}:="Item 27"
<>aNBIPages{21}:="Item 28"
<>aNBIPages{22}:="Item 29"
<>aNBIPages{23}:="Item 30"
<>aNBIPages{24}:="Item 31"
<>aNBIPages{25}:="Item 32"
<>aNBIPages{26}:="Item 33"
<>aNBIPages{27}:="Item 34"
<>aNBIPages{28}:="Item 35"
<>aNBIPages{29}:="Item 36"
<>aNBIPages{30}:="Item 37"
<>aNBIPages{31}:="Item 38"
<>aNBIPages{32}:="Item 39"
<>aNBIPages{33}:="Item 40"
<>aNBIPages{34}:="Item 41"
<>aNBIPages{35}:="Item 42"
<>aNBIPages{36}:="Item 43"
<>aNBIPages{37}:="Item 44"
<>aNBIPages{38}:="Item 45"
<>aNBIPages{39}:="Item 46"
<>aNBIPages{40}:="Item 47"
<>aNBIPages{41}:="Item 48"
<>aNBIPages{42}:="Item 49"
<>aNBIPages{43}:="Item 50"
<>aNBIPages{44}:="Item 51"
<>aNBIPages{45}:="Item 52"
<>aNBIPages{46}:="Item 53"
<>aNBIPages{47}:="Item 54"
<>aNBIPages{48}:="Item 55"
<>aNBIPages{49}:="Item 56"
<>aNBIPages{50}:="Item 58"
<>aNBIPages{51}:="Item 59"
<>aNBIPages{52}:="Item 60"
<>aNBIPages{53}:="Item 61"
<>aNBIPages{54}:="Item 62"
<>aNBIPages{55}:="Item 63"
<>aNBIPages{56}:="Item 64"
<>aNBIPages{57}:="Item 65"
<>aNBIPages{58}:="Item 66"
<>aNBIPages{59}:="Item 67"
<>aNBIPages{60}:="Item 68"
<>aNBIPages{61}:="Item 69"
<>aNBIPages{62}:="Item 70"
<>aNBIPages{63}:="Item 71"
<>aNBIPages{64}:="Item 72"
<>aNBIPages{65}:="Item 75"
<>aNBIPages{66}:="Item 76"
<>aNBIPages{67}:="Item 90"
<>aNBIPages{68}:="Item 91"
<>aNBIPages{69}:="Item 92"
<>aNBIPages{70}:="Item 93"
<>aNBIPages{71}:="Item 94"
<>aNBIPages{72}:="Item 95"
<>aNBIPages{73}:="Item 96"
<>aNBIPages{74}:="Item 97"
<>aNBIPages{75}:="Item 98"
<>aNBIPages{76}:="Item 99"
<>aNBIPages{77}:="Item 100"
<>aNBIPages{78}:="Item 101"
<>aNBIPages{79}:="Item 102"
<>aNBIPages{80}:="Item 103"
<>aNBIPages{81}:="Item 104"
<>aNBIPages{82}:="Item 105"
<>aNBIPages{83}:="Item 106"
<>aNBIPages{84}:="Item 107"
<>aNBIPages{85}:="Item 108"
<>aNBIPages{86}:="Item 109"
<>aNBIPages{87}:="Item 110"
<>aNBIPages{88}:="Item 111"
<>aNBIPages{89}:="Item 112"
<>aNBIPages{90}:="Item 113"
<>aNBIPages{91}:="Item 114"
<>aNBIPages{92}:="Item 115"
<>aNBIPages{93}:="Item 116"

<>aNBIPageNo{1}:=1
<>aNBIPageNo{2}:=1
<>aNBIPageNo{3}:=1
<>aNBIPageNo{4}:=1
<>aNBIPageNo{5}:=1
<>aNBIPageNo{6}:=1
<>aNBIPageNo{7}:=1
<>aNBIPageNo{8}:=1
<>aNBIPageNo{9}:=4
<>aNBIPageNo{10}:=1
<>aNBIPageNo{11}:=1
<>aNBIPageNo{12}:=1
<>aNBIPageNo{13}:=1
<>aNBIPageNo{14}:=1
<>aNBIPageNo{15}:=3
<>aNBIPageNo{16}:=6
<>aNBIPageNo{17}:=6
<>aNBIPageNo{18}:=6
<>aNBIPageNo{19}:=6
<>aNBIPageNo{20}:=3
<>aNBIPageNo{21}:=3
<>aNBIPageNo{22}:=3
<>aNBIPageNo{23}:=3
<>aNBIPageNo{24}:=7
<>aNBIPageNo{25}:=4
<>aNBIPageNo{26}:=4
<>aNBIPageNo{27}:=4
<>aNBIPageNo{28}:=4
<>aNBIPageNo{29}:=8
<>aNBIPageNo{30}:=6
<>aNBIPageNo{31}:=5
<>aNBIPageNo{32}:=5
<>aNBIPageNo{33}:=5
<>aNBIPageNo{34}:=7
<>aNBIPageNo{35}:=3
<>aNBIPageNo{36}:=2
<>aNBIPageNo{37}:=2
<>aNBIPageNo{38}:=2
<>aNBIPageNo{39}:=2
<>aNBIPageNo{40}:=4
<>aNBIPageNo{41}:=4
<>aNBIPageNo{42}:=4
<>aNBIPageNo{43}:=4
<>aNBIPageNo{44}:=4
<>aNBIPageNo{45}:=4
<>aNBIPageNo{46}:=4
<>aNBIPageNo{47}:=4
<>aNBIPageNo{48}:=4
<>aNBIPageNo{49}:=4
<>aNBIPageNo{50}:=7
<>aNBIPageNo{51}:=7
<>aNBIPageNo{52}:=7
<>aNBIPageNo{53}:=7
<>aNBIPageNo{54}:=7
<>aNBIPageNo{55}:=7
<>aNBIPageNo{56}:=7
<>aNBIPageNo{57}:=7
<>aNBIPageNo{58}:=7
<>aNBIPageNo{59}:=8
<>aNBIPageNo{60}:=8
<>aNBIPageNo{61}:=8
<>aNBIPageNo{62}:=7
<>aNBIPageNo{63}:=8
<>aNBIPageNo{64}:=8
<>aNBIPageNo{65}:=8
<>aNBIPageNo{66}:=8
<>aNBIPageNo{67}:=9
<>aNBIPageNo{68}:=9
<>aNBIPageNo{69}:=9
<>aNBIPageNo{70}:=9
<>aNBIPageNo{71}:=8
<>aNBIPageNo{72}:=8
<>aNBIPageNo{73}:=8
<>aNBIPageNo{74}:=8
<>aNBIPageNo{75}:=1
<>aNBIPageNo{76}:=1
<>aNBIPageNo{77}:=6
<>aNBIPageNo{78}:=6
<>aNBIPageNo{79}:=6
<>aNBIPageNo{80}:=6
<>aNBIPageNo{81}:=6
<>aNBIPageNo{82}:=6
<>aNBIPageNo{83}:=3
<>aNBIPageNo{84}:=2
<>aNBIPageNo{85}:=2
<>aNBIPageNo{86}:=3
<>aNBIPageNo{87}:=6
<>aNBIPageNo{88}:=5
<>aNBIPageNo{89}:=6
<>aNBIPageNo{90}:=8
<>aNBIPageNo{91}:=8
<>aNBIPageNo{92}:=8
<>aNBIPageNo{93}:=5
//`END: SJH 04/21/2004 `````````````````````````````````````````````````````
C_LONGINT:C283($i; $vt; $vFldno)
C_TEXT:C284($vName_s)
If ($ReturnBlob)
	ARRAY INTEGER:C220($arrFldNos; 93)
	For ($i; 1; 93)
		RESOLVE POINTER:C394(<>aNBIField{$i}; $vName_s; $vt; $vFldno)
		If ($vFldno>0)
			$arrFldNos{$i}:=$vFldno
		End if 
	End for 
	VARIABLE TO BLOB:C532($arrFldNos; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aNBIPages; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aNBIPageNo; $Return_blb; *)
End if 

MHD_InitSIAObj

If ($ReturnBlob)
	VARIABLE TO BLOB:C532(<>aObjectName; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>aFieldNum; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>MaxSIAFlds; $Return_blb; *)
End if 

//To speed up the EZ Search diaolog, setup and store the field arrays
//for file 1, [Bridge MHD NBIS], which has the most fields.
//Declare the array to store the field names
ARRAY TEXT:C222(<>asFields; 0)  //Command Replaced was o_ARRAY string length was 19
//Declare the array to store pointers to the fields
ARRAY POINTER:C280(<>apFlds; 0)
//Declare the array to store the field types
ARRAY TEXT:C222(<>asFldTypes; 0)  //Command Replaced was o_ARRAY string length was 8
FieldsToArray(Table:C252(1); -><>asFields; -><>apFlds; False:C215; False:C215; -><>asFldTypes)
SORT ARRAY:C229(<>asFields; <>apFlds; <>asFldTypes)

If ($ReturnBlob)
	ARRAY INTEGER:C220($arrFldNos; Size of array:C274(<>apFlds))
	For ($i; 1; Size of array:C274(<>apFlds))
		$arrFldNos{$i}:=Field:C253(<>apFlds{$i})
	End for 
	VARIABLE TO BLOB:C532(<>asFields; $Return_blb; *)
	VARIABLE TO BLOB:C532($arrFldNos; $Return_blb; *)
	VARIABLE TO BLOB:C532(<>asFldTypes; $Return_blb; *)
	$0:=$Return_blb
	SET BLOB SIZE:C606($Return_blb; 0)
End if 