//%attributes = {"invisible":true}
//Method: InsertTabsInNBILine
//Description
// Insert Tabs in a line of NBI tape
// Parameters
// $0 : $TabbedLine_txt
// $1 : $NBILine_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/16/17, 09:35:45
	// ----------------------------------------------------
	//Created : 
	Mods_2017_11
	
	C_TEXT:C284(InsertTabsInNBILine; $0)
	C_TEXT:C284(InsertTabsInNBILine; $1)
	
End if 
//

C_TEXT:C284($0; $1)

C_TEXT:C284($TabbedLine_txt; $P_txt; $NBILine_txt)
$TabbedLine_txt:=""
$NBILine_txt:=$1
//State code
$P_txt:=Substring:C12($NBILine_txt; 1; 3)
$TabbedLine_txt:=$TabbedLine_txt+$P_txt
//Item 8 code
$P_txt:=Substring:C12($NBILine_txt; 4; 15)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt

//[Bridge MHD NBIS]Item5
$P_txt:=Substring:C12($NBILine_txt; 19; 9)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item2
$P_txt:=Substring:C12($NBILine_txt; 28; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item3
$P_txt:=Substring:C12($NBILine_txt; 30; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item4
$P_txt:=Substring:C12($NBILine_txt; 33; 5)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item6A
$P_txt:=Substring:C12($NBILine_txt; 38; 24)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item6B
$P_txt:=Substring:C12($NBILine_txt; 62; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item7
$P_txt:=Substring:C12($NBILine_txt; 63; 18)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item9
$P_txt:=Substring:C12($NBILine_txt; 81; 25)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item10
$P_txt:=Substring:C12($NBILine_txt; 106; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item11
$P_txt:=Substring:C12($NBILine_txt; 110; 7)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item12
$P_txt:=Substring:C12($NBILine_txt; 117; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item 13A
$P_txt:=Substring:C12($NBILine_txt; 118; 10)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item 13B
$P_txt:=Substring:C12($NBILine_txt; 128; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item16A
$P_txt:=Substring:C12($NBILine_txt; 130; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item16B
$P_txt:=Substring:C12($NBILine_txt; 132; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item16C
$P_txt:=Substring:C12($NBILine_txt; 134; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item17A
$P_txt:=Substring:C12($NBILine_txt; 138; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item17B
$P_txt:=Substring:C12($NBILine_txt; 141; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item17C
$P_txt:=Substring:C12($NBILine_txt; 143; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item19
$P_txt:=Substring:C12($NBILine_txt; 147; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item20
$P_txt:=Substring:C12($NBILine_txt; 150; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item21
$P_txt:=Substring:C12($NBILine_txt; 151; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item22
$P_txt:=Substring:C12($NBILine_txt; 153; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item26
$P_txt:=Substring:C12($NBILine_txt; 155; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item27
$P_txt:=Substring:C12($NBILine_txt; 157; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item28A
$P_txt:=Substring:C12($NBILine_txt; 161; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item28B
$P_txt:=Substring:C12($NBILine_txt; 163; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item29
$P_txt:=Substring:C12($NBILine_txt; 165; 6)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item30
$P_txt:=Substring:C12($NBILine_txt; 171; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item31
$P_txt:=Substring:C12($NBILine_txt; 175; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item32
$P_txt:=Substring:C12($NBILine_txt; 176; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item33
$P_txt:=Substring:C12($NBILine_txt; 180; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item34
$P_txt:=Substring:C12($NBILine_txt; 181; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item35
$P_txt:=Substring:C12($NBILine_txt; 183; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item36A
$P_txt:=Substring:C12($NBILine_txt; 184; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item36B
$P_txt:=Substring:C12($NBILine_txt; 185; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item36C
$P_txt:=Substring:C12($NBILine_txt; 186; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item36D
$P_txt:=Substring:C12($NBILine_txt; 187; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item37
$P_txt:=Substring:C12($NBILine_txt; 188; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item38
$P_txt:=Substring:C12($NBILine_txt; 189; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item39
$P_txt:=Substring:C12($NBILine_txt; 190; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item40
$P_txt:=Substring:C12($NBILine_txt; 194; 5)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item41
$P_txt:=Substring:C12($NBILine_txt; 199; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item42
$P_txt:=Substring:C12($NBILine_txt; 200; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item43
$P_txt:=Substring:C12($NBILine_txt; 202; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item44
$P_txt:=Substring:C12($NBILine_txt; 205; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item45
$P_txt:=Substring:C12($NBILine_txt; 208; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item46
$P_txt:=Substring:C12($NBILine_txt; 211; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item47
$P_txt:=Substring:C12($NBILine_txt; 215; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item48
$P_txt:=Substring:C12($NBILine_txt; 218; 5)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item49
$P_txt:=Substring:C12($NBILine_txt; 223; 6)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item50A
$P_txt:=Substring:C12($NBILine_txt; 229; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item50B
$P_txt:=Substring:C12($NBILine_txt; 232; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item51
$P_txt:=Substring:C12($NBILine_txt; 235; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item52
$P_txt:=Substring:C12($NBILine_txt; 239; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item53
$P_txt:=Substring:C12($NBILine_txt; 243; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item54A
$P_txt:=Substring:C12($NBILine_txt; 247; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item54B
$P_txt:=Substring:C12($NBILine_txt; 248; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item55A
$P_txt:=Substring:C12($NBILine_txt; 252; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item55B
$P_txt:=Substring:C12($NBILine_txt; 253; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item56
$P_txt:=Substring:C12($NBILine_txt; 256; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item58
$P_txt:=Substring:C12($NBILine_txt; 259; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item59
$P_txt:=Substring:C12($NBILine_txt; 260; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item60
$P_txt:=Substring:C12($NBILine_txt; 261; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item61
$P_txt:=Substring:C12($NBILine_txt; 262; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item62
$P_txt:=Substring:C12($NBILine_txt; 263; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item 63
$P_txt:=Substring:C12($NBILine_txt; 264; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item64
$P_txt:=Substring:C12($NBILine_txt; 265; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item 65
$P_txt:=Substring:C12($NBILine_txt; 268; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item66
$P_txt:=Substring:C12($NBILine_txt; 269; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item67
$P_txt:=Substring:C12($NBILine_txt; 272; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item68
$P_txt:=Substring:C12($NBILine_txt; 273; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item69
$P_txt:=Substring:C12($NBILine_txt; 274; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item70
$P_txt:=Substring:C12($NBILine_txt; 275; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item71
$P_txt:=Substring:C12($NBILine_txt; 276; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item72
$P_txt:=Substring:C12($NBILine_txt; 277; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item75A
$P_txt:=Substring:C12($NBILine_txt; 278; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item75B
$P_txt:=Substring:C12($NBILine_txt; 280; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item76
$P_txt:=Substring:C12($NBILine_txt; 281; 6)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item90
$P_txt:=Substring:C12($NBILine_txt; 287; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item91
$p_txt:=Substring:C12($NBILine_txt; 291; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item92AA
$P_txt:=Substring:C12($NBILine_txt; 293; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item92AB
$p_txt:=Substring:C12($NBILine_txt; 294; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item92BA
$P_txt:=Substring:C12($NBILine_txt; 296; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item92BB
$p_txt:=Substring:C12($NBILine_txt; 297; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item92CA
$P_txt:=Substring:C12($NBILine_txt; 299; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item92CB
$p_txt:=Substring:C12($NBILine_txt; 300; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item93A
$P_txt:=Substring:C12($NBILine_txt; 302; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item93B
$P_txt:=Substring:C12($NBILine_txt; 306; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item93C
$P_txt:=Substring:C12($NBILine_txt; 310; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item94
$p_txt:=Substring:C12($NBILine_txt; 314; 6)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item95
$p_txt:=Substring:C12($NBILine_txt; 320; 6)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item96
$p_txt:=Substring:C12($NBILine_txt; 326; 6)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item97
$p_txt:=Substring:C12($NBILine_txt; 332; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item98A
$P_txt:=Substring:C12($NBILine_txt; 336; 3)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item98B
$P_txt:=Substring:C12($NBILine_txt; 339; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item99
$P_txt:=Substring:C12($NBILine_txt; 341; 15)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item100
$P_txt:=Substring:C12($NBILine_txt; 356; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item101
$P_txt:=Substring:C12($NBILine_txt; 357; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item102
$P_txt:=Substring:C12($NBILine_txt; 358; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item103
$P_txt:=Substring:C12($NBILine_txt; 359; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item104
$P_txt:=Substring:C12($NBILine_txt; 360; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item 105
$P_txt:=Substring:C12($NBILine_txt; 361; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item106
$p_txt:=Substring:C12($NBILine_txt; 362; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item107
$P_txt:=Substring:C12($NBILine_txt; 366; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item108A
$P_txt:=Substring:C12($NBILine_txt; 367; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item108B
$P_txt:=Substring:C12($NBILine_txt; 368; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item108C
$P_txt:=Substring:C12($NBILine_txt; 369; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item109
$p_txt:=Substring:C12($NBILine_txt; 370; 2)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item110
$P_txt:=Substring:C12($NBILine_txt; 372; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item111
$P_txt:=Substring:C12($NBILine_txt; 373; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item112
$P_txt:=Substring:C12($NBILine_txt; 374; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item113
$P_txt:=Substring:C12($NBILine_txt; 375; 1)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item114
$p_txt:=Substring:C12($NBILine_txt; 376; 6)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item115
$p_txt:=Substring:C12($NBILine_txt; 382; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt
//[Bridge MHD NBIS]Item116
$p_txt:=Substring:C12($NBILine_txt; 386; 4)
$TabbedLine_txt:=$TabbedLine_txt+Char:C90(9)+$P_txt

$TabbedLine_txt:=$TabbedLine_txt+<>sCR

$0:=$TabbedLine_txt
//End InsertTabsInNBILine