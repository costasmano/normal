//%attributes = {"invisible":true}
If (False:C215)
	//procedure: MHD_InitSIAObj
	//by: Albert Leung
	//date: 12/11/97
	//purpose: init the array containing the object names for SIA  
End if 

ARRAY TEXT:C222(<>aObjectName; 156)  //Command Replaced was o_ARRAY string length was 15
ARRAY LONGINT:C221(<>aFieldNum; 156)
C_LONGINT:C283(<>MaxSIAFlds)
<>MaxSIAFlds:=156
C_LONGINT:C283($i)

<>aObjectName{1}:="a_sBDEPT"
<>aObjectName{2}:="a_sBridgeKey"
<>aObjectName{3}:="a_sBIN"
<>aObjectName{4}:="a_bFHWASel"
<>aObjectName{5}:="a_rAASHTO"
<>aObjectName{6}:="a_dPostD"
<>aObjectName{7}:="a_sPostSt"
<>aObjectName{8}:="a_iPost2ax"
<>aObjectName{9}:="a_iPost3ax"
<>aObjectName{10}:="a_iPost5ax"
<>aObjectName{11}:="a_iOprH20"
<>aObjectName{12}:="a_iOprType3"
<>aObjectName{13}:="a_iOpr3S2"
<>aObjectName{14}:="a_iOprHS"
<>aObjectName{15}:="a_iInvH20"
<>aObjectName{16}:="a_iInvType3"
<>aObjectName{17}:="a_iInv3S2"
<>aObjectName{18}:="a_iInvHS"
<>aObjectName{19}:="a_bAntiMiss"
<>aObjectName{20}:="a_bAcrow"
<>aObjectName{21}:="a_sBrName"
<>aObjectName{22}:="a_bBucket"
<>aObjectName{23}:="a_bLadder"
<>aObjectName{24}:="a_bBoat"
<>aObjectName{25}:="a_bWader"
<>aObjectName{26}:="a_bInsp50"
<>aObjectName{27}:="a_bRigging"
<>aObjectName{28}:="a_bStaging"
<>aObjectName{29}:="a_bTraffic"
<>aObjectName{30}:="a_bRRFlag"
<>aObjectName{31}:="a_bPolice"
<>aObjectName{32}:="a_iInspHRS"
<>aObjectName{33}:="a_dCritDate"
<>aObjectName{34}:="a_bCritInsp"
<>aObjectName{35}:="a_sCritFreq"
<>aObjectName{36}:="a_dClsedDate"
<>aObjectName{37}:="a_bClseInsp"
<>aObjectName{38}:="a_iClseFreq"
<>aObjectName{39}:="a_dDamage"
<>aObjectName{40}:="a_sItem5"
<>aObjectName{41}:="a_sItem2"
<>aObjectName{42}:="a_sItem3"
<>aObjectName{43}:="a_sItem4"
<>aObjectName{44}:="a_sItem6A"
<>aObjectName{45}:="a_sItem7"
<>aObjectName{46}:="a_sItem9"
<>aObjectName{47}:="a_rItem11"
<>aObjectName{48}:="a_iItem16A"
<>aObjectName{49}:="a_iItem16B"
<>aObjectName{50}:="a_rItem16C"
<>aObjectName{51}:="a_iItem17A"
<>aObjectName{52}:="a_iItem17B"
<>aObjectName{53}:="a_rItem17C"
<>aObjectName{54}:="a_sItem98A"
<>aObjectName{55}:="a_sItem98B"
<>aObjectName{56}:="a_sItem99"
<>aObjectName{57}:="a_sItem43"
<>aObjectName{58}:="a_sItem44"
<>aObjectName{59}:="a_iItem45"
<>aObjectName{60}:="a_iItem46"
<>aObjectName{61}:="a_sItem107"
<>aObjectName{62}:="a_sItem108A"
<>aObjectName{63}:="a_sItem108B"
<>aObjectName{64}:="a_sItem108C"
<>aObjectName{65}:="a_iItem27"
<>aObjectName{66}:="a_iItem106"
<>aObjectName{67}:="a_sItem42"
<>aObjectName{68}:="a_iItem28A"
<>aObjectName{69}:="a_iItem28B"
<>aObjectName{70}:="a_LItem29"
<>aObjectName{71}:="a_iItem30"
<>aObjectName{72}:="a_iItem109"
<>aObjectName{73}:="a_iItem19"
<>aObjectName{74}:="a_rItem48"
<>aObjectName{75}:="a_rItem49"
<>aObjectName{76}:="a_rItem50A"
<>aObjectName{77}:="a_rItem50B"
<>aObjectName{78}:="a_rItem51"
<>aObjectName{79}:="a_rItem52"
<>aObjectName{80}:="a_rItem32"
<>aObjectName{81}:="a_sItem33"
<>aObjectName{82}:="a_iItem34"
<>aObjectName{83}:="a_bItem35"
<>aObjectName{84}:="a_rItem10"
<>aObjectName{85}:="a_rItem47"
<>aObjectName{86}:="a_rItem53"
<>aObjectName{87}:="a_sItem54A"
<>aObjectName{88}:="a_rItem54B"
<>aObjectName{89}:="a_sItem55A"
<>aObjectName{90}:="a_rItem55B"
<>aObjectName{91}:="a_rItem56"
<>aObjectName{92}:="a_sItem38"
<>aObjectName{93}:="a_sItem111"
<>aObjectName{94}:="a_rItem39"
<>aObjectName{95}:="a_rItem116"
<>aObjectName{96}:="a_rItem40"
<>aObjectName{97}:="a_bItem112"
<>aObjectName{98}:="a_bItem104"
<>aObjectName{99}:="a_sItem26"
<>aObjectName{100}:="a_sItem100"
<>aObjectName{101}:="a_sItem101"
<>aObjectName{102}:="a_sItem102"
<>aObjectName{103}:="a_bItem103"
<>aObjectName{104}:="a_bItem110"
<>aObjectName{105}:="a_sItem20"
<>aObjectName{106}:="a_sItem21"
<>aObjectName{107}:="a_sItem22"
<>aObjectName{108}:="a_sItem37"
<>aObjectName{109}:="a_sItem58"
<>aObjectName{110}:="a_sItem59"
<>aObjectName{111}:="a_sItem60"
<>aObjectName{112}:="a_sItem61"
<>aObjectName{113}:="a_sItem62"
<>aObjectName{114}:="a_sItem31"
<>aObjectName{115}:="a_rItem64"
<>aObjectName{116}:="a_rItem66"
<>aObjectName{117}:="a_sItem70"
<>aObjectName{118}:="a_sItem41"
<>aObjectName{119}:="a_sItem67"
<>aObjectName{120}:="a_sItem68"
<>aObjectName{121}:="a_sItem69"
<>aObjectName{122}:="a_sItem71"
<>aObjectName{123}:="a_sItem72"
<>aObjectName{124}:="a_sItem36A"
<>aObjectName{125}:="a_sItem36B"
<>aObjectName{126}:="a_sItem36C"
<>aObjectName{127}:="a_sItem36D"
<>aObjectName{128}:="a_sItem113"
<>aObjectName{129}:="a_sItem75A"
<>aObjectName{130}:="a_sItem75B"
<>aObjectName{131}:="a_rItem76"
<>aObjectName{132}:="a_LItem94"
<>aObjectName{133}:="a_LItem95"
<>aObjectName{134}:="a_LItem96"
<>aObjectName{135}:="a_iItem97"
<>aObjectName{136}:="a_LItem114"
<>aObjectName{137}:="a_iItem115"
<>aObjectName{138}:="a_dItem90"
<>aObjectName{139}:="a_iItem91"
<>aObjectName{140}:="a_bItem92AA"
<>aObjectName{141}:="a_iItem92AB"
<>aObjectName{142}:="a_bItem92BA"
<>aObjectName{143}:="a_iItem92BB"
<>aObjectName{144}:="a_bItem92CA"
<>aObjectName{145}:="a_iItem92CB"
<>aObjectName{146}:="a_dItem93A"
<>aObjectName{147}:="a_dItem93B"
<>aObjectName{148}:="a_dItem93C"
<>aObjectName{149}:="a_sTownName"
<>aObjectName{150}:="a_bItem12"
<>aObjectName{151}:="a_sItem13A"
<>aObjectName{152}:="a_sItem13B"
<>aObjectName{153}:="a_sItem63"
<>aObjectName{154}:="a_sItem65"
<>aObjectName{155}:="a_sItem105"
<>aObjectName{156}:="a_sJntless"

For ($i; 1; 5)
	<>aFieldNum{$i}:=$i
End for 
For ($i; 6; 10)
	<>aFieldNum{$i}:=$i+1
End for 
For ($i; 11; 18)
	<>aFieldNum{$i}:=$i+4
End for 
<>aFieldNum{19}:=26
For ($i; 20; 39)
	<>aFieldNum{$i}:=$i+8
End for 
For ($i; 40; 44)
	<>aFieldNum{$i}:=$i+19
End for 
For ($i; 45; 49)
	<>aFieldNum{$i}:=$i+20
End for 
<>aFieldNum{50}:=109
For ($i; 51; 52)
	<>aFieldNum{$i}:=$i+19
End for 
<>aFieldNum{53}:=136
For ($i; 54; 84)
	<>aFieldNum{$i}:=$i+18
End for 
<>aFieldNum{85}:=104
<>aFieldNum{86}:=105
<>aFieldNum{87}:=107
<>aFieldNum{88}:=108
For ($i; 89; 114)
	<>aFieldNum{$i}:=$i+21
End for 
<>aFieldNum{115}:=137
For ($i; 116; 148)
	<>aFieldNum{$i}:=$i+23
End for 
<>aFieldNum{149}:=175
For ($i; 150; 156)
	<>aFieldNum{$i}:=$i+46
End for 