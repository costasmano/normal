//%attributes = {"invisible":true,"publishedWeb":true}
// Method: Text_toURL
// Description
//   `converts Text to URL Chars
// Parameters
// $0 : $return_txt
// $1 : $input_txt
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/19/11, 08:47:30
	
	Mods_2011_09
	// Modified by: Costas Manousakis-(Designer)-(2023-09-07 18:14:25)
	Mods_2023_09
	//  `use code from  https://kb.4d.com/assetid=79062 
	//  `Made method available in 4D Tags
End if 

//Text_toURL

C_TEXT:C284($1; $0; $return; $text; $char)
C_LONGINT:C283($i)

$text:=$1
$return:=""

If (False:C215)
	
	For ($i; 1; Length:C16($text))
		$char:=Substring:C12($text; $i; 1)
		Case of 
			: (Character code:C91($char)=0)
				$return:=$return+"%00"
			: (Character code:C91($char)=1)
				$return:=$return+"%01"
			: (Character code:C91($char)=2)
				$return:=$return+"%02"
			: (Character code:C91($char)=3)
				$return:=$return+"%03"
			: (Character code:C91($char)=4)
				$return:=$return+"%04"
			: (Character code:C91($char)=5)
				$return:=$return+"%05"
			: (Character code:C91($char)=6)
				$return:=$return+"%06"
			: (Character code:C91($char)=7)
				$return:=$return+"%07"
			: (Character code:C91($char)=8)
				$return:=$return+"%08"
			: (Character code:C91($char)=9)
				$return:=$return+"%09"
			: (Character code:C91($char)=10)
				$return:=$return+"%0A"
			: (Character code:C91($char)=11)
				$return:=$return+"%0B"
			: (Character code:C91($char)=12)
				$return:=$return+"%0C"
			: (Character code:C91($char)=13)
				$return:=$return+"%0D"
			: (Character code:C91($char)=14)
				$return:=$return+"%0E"
			: (Character code:C91($char)=15)
				$return:=$return+"%0F"
			: (Character code:C91($char)=16)
				$return:=$return+"%10"
			: (Character code:C91($char)=17)
				$return:=$return+"%11"
			: (Character code:C91($char)=18)
				$return:=$return+"%12"
			: (Character code:C91($char)=19)
				$return:=$return+"%13"
			: (Character code:C91($char)=20)
				$return:=$return+"%14"
			: (Character code:C91($char)=21)
				$return:=$return+"%15"
			: (Character code:C91($char)=22)
				$return:=$return+"%16"
			: (Character code:C91($char)=23)
				$return:=$return+"%17"
			: (Character code:C91($char)=24)
				$return:=$return+"%18"
			: (Character code:C91($char)=25)
				$return:=$return+"%19"
			: (Character code:C91($char)=26)
				$return:=$return+"%1A"
			: (Character code:C91($char)=27)
				$return:=$return+"%1B"
			: (Character code:C91($char)=28)
				$return:=$return+"%1C"
			: (Character code:C91($char)=29)
				$return:=$return+"%1D"
			: (Character code:C91($char)=30)
				$return:=$return+"%1E"
			: (Character code:C91($char)=31)
				$return:=$return+"%1F"
			: (Character code:C91($char)=32)
				$return:=$return+"%20"
			: (Character code:C91($char)=33)
				$return:=$return+"%21"
			: (Character code:C91($char)=34)
				$return:=$return+"%22"
			: (Character code:C91($char)=35)
				$return:=$return+"%23"
			: (Character code:C91($char)=36)
				$return:=$return+"%24"
			: (Character code:C91($char)=37)
				$return:=$return+"%25"
			: (Character code:C91($char)=38)
				$return:=$return+"%26"
			: (Character code:C91($char)=39)
				$return:=$return+"%27"
			: (Character code:C91($char)=40)
				$return:=$return+"%28"
			: (Character code:C91($char)=41)
				$return:=$return+"%29"
			: (Character code:C91($char)=42)
				$return:=$return+"%2A"
			: (Character code:C91($char)=43)
				$return:=$return+"%2B"
			: (Character code:C91($char)=44)
				$return:=$return+"%2C"
			: (Character code:C91($char)=45)
				$return:=$return+"%2D"
			: (Character code:C91($char)=46)
				$return:=$return+"%2E"
			: (Character code:C91($char)=47)
				$return:=$return+"%2F"
			: (Character code:C91($char)=58)
				$return:=$return+"%3A"
			: (Character code:C91($char)=59)
				$return:=$return+"%3B"
			: (Character code:C91($char)=60)
				$return:=$return+"%3C"
			: (Character code:C91($char)=61)
				$return:=$return+"%3D"
			: (Character code:C91($char)=62)
				$return:=$return+"%3E"
			: (Character code:C91($char)=63)
				$return:=$return+"%3F"
			: (Character code:C91($char)=64)
				$return:=$return+"%40"
			: (Character code:C91($char)=91)
				$return:=$return+"%5B"
			: (Character code:C91($char)=92)
				$return:=$return+"%5C"
			: (Character code:C91($char)=93)
				$return:=$return+"%5D"
			: (Character code:C91($char)=94)
				$return:=$return+"%5E"
			: (Character code:C91($char)=95)
				$return:=$return+"%5F"
			: (Character code:C91($char)=96)
				$return:=$return+"%60"
			: (Character code:C91($char)=123)
				$return:=$return+"%7B"
			: (Character code:C91($char)=124)
				$return:=$return+"%7C"
			: (Character code:C91($char)=125)
				$return:=$return+"%7D"
			: (Character code:C91($char)=126)
				$return:=$return+"%7E"
			: (Character code:C91($char)=127)
				$return:=$return+"%7F"
			: (Character code:C91($char)=128)
				$return:=$return+"%80"
			: (Character code:C91($char)=129)
				$return:=$return+"%81"
			: (Character code:C91($char)=130)
				$return:=$return+"%82"
			: (Character code:C91($char)=131)
				$return:=$return+"%83"
			: (Character code:C91($char)=132)
				$return:=$return+"%84"
			: (Character code:C91($char)=133)
				$return:=$return+"%85"
			: (Character code:C91($char)=134)
				$return:=$return+"%86"
			: (Character code:C91($char)=135)
				$return:=$return+"%87"
			: (Character code:C91($char)=136)
				$return:=$return+"%88"
			: (Character code:C91($char)=137)
				$return:=$return+"%89"
			: (Character code:C91($char)=138)
				$return:=$return+"%8A"
			: (Character code:C91($char)=139)
				$return:=$return+"%8B"
			: (Character code:C91($char)=140)
				$return:=$return+"%8C"
			: (Character code:C91($char)=141)
				$return:=$return+"%8D"
			: (Character code:C91($char)=142)
				$return:=$return+"%8E"
			: (Character code:C91($char)=143)
				$return:=$return+"%8F"
			: (Character code:C91($char)=144)
				$return:=$return+"%90"
			: (Character code:C91($char)=145)
				$return:=$return+"%91"
			: (Character code:C91($char)=146)
				$return:=$return+"%92"
			: (Character code:C91($char)=147)
				$return:=$return+"%93"
			: (Character code:C91($char)=148)
				$return:=$return+"%94"
			: (Character code:C91($char)=149)
				$return:=$return+"%95"
			: (Character code:C91($char)=150)
				$return:=$return+"%96"
			: (Character code:C91($char)=151)
				$return:=$return+"%97"
			: (Character code:C91($char)=152)
				$return:=$return+"%98"
			: (Character code:C91($char)=153)
				$return:=$return+"%99"
			: (Character code:C91($char)=154)
				$return:=$return+"%9A"
			: (Character code:C91($char)=155)
				$return:=$return+"%9B"
			: (Character code:C91($char)=156)
				$return:=$return+"%9C"
			: (Character code:C91($char)=157)
				$return:=$return+"%9D"
			: (Character code:C91($char)=158)
				$return:=$return+"%9E"
			: (Character code:C91($char)=159)
				$return:=$return+"%9F"
			: (Character code:C91($char)=160)
				$return:=$return+"%A0"
			: (Character code:C91($char)=161)
				$return:=$return+"%A1"
			: (Character code:C91($char)=162)
				$return:=$return+"%A2"
			: (Character code:C91($char)=163)
				$return:=$return+"%A3"
			: (Character code:C91($char)=164)
				$return:=$return+"%A4"
			: (Character code:C91($char)=165)
				$return:=$return+"%A5"
			: (Character code:C91($char)=166)
				$return:=$return+"%A6"
			: (Character code:C91($char)=167)
				$return:=$return+"%A7"
			: (Character code:C91($char)=168)
				$return:=$return+"%A8"
			: (Character code:C91($char)=169)
				$return:=$return+"%A9"
			: (Character code:C91($char)=170)
				$return:=$return+"%AA"
			: (Character code:C91($char)=171)
				$return:=$return+"%AB"
			: (Character code:C91($char)=172)
				$return:=$return+"%AC"
			: (Character code:C91($char)=173)
				$return:=$return+"%AD"
			: (Character code:C91($char)=174)
				$return:=$return+"%AE"
			: (Character code:C91($char)=175)
				$return:=$return+"%AF"
			: (Character code:C91($char)=176)
				$return:=$return+"%B0"
			: (Character code:C91($char)=177)
				$return:=$return+"%B1"
			: (Character code:C91($char)=178)
				$return:=$return+"%B2"
			: (Character code:C91($char)=179)
				$return:=$return+"%B3"
			: (Character code:C91($char)=180)
				$return:=$return+"%B4"
			: (Character code:C91($char)=181)
				$return:=$return+"%B5"
			: (Character code:C91($char)=182)
				$return:=$return+"%B6"
			: (Character code:C91($char)=183)
				$return:=$return+"%B7"
			: (Character code:C91($char)=184)
				$return:=$return+"%B8"
			: (Character code:C91($char)=185)
				$return:=$return+"%B9"
			: (Character code:C91($char)=186)
				$return:=$return+"%BA"
			: (Character code:C91($char)=187)
				$return:=$return+"%BB"
			: (Character code:C91($char)=188)
				$return:=$return+"%BC"
			: (Character code:C91($char)=189)
				$return:=$return+"%BD"
			: (Character code:C91($char)=190)
				$return:=$return+"%BE"
			: (Character code:C91($char)=191)
				$return:=$return+"%BF"
			: (Character code:C91($char)=192)
				$return:=$return+"%C0"
			: (Character code:C91($char)=193)
				$return:=$return+"%C1"
			: (Character code:C91($char)=194)
				$return:=$return+"%C2"
			: (Character code:C91($char)=195)
				$return:=$return+"%C3"
			: (Character code:C91($char)=196)
				$return:=$return+"%C4"
			: (Character code:C91($char)=197)
				$return:=$return+"%C5"
			: (Character code:C91($char)=198)
				$return:=$return+"%C6"
			: (Character code:C91($char)=199)
				$return:=$return+"%C7"
			: (Character code:C91($char)=200)
				$return:=$return+"%C8"
			: (Character code:C91($char)=201)
				$return:=$return+"%C9"
			: (Character code:C91($char)=202)
				$return:=$return+"%CA"
			: (Character code:C91($char)=203)
				$return:=$return+"%CB"
			: (Character code:C91($char)=204)
				$return:=$return+"%CC"
			: (Character code:C91($char)=205)
				$return:=$return+"%CD"
			: (Character code:C91($char)=206)
				$return:=$return+"%CE"
			: (Character code:C91($char)=207)
				$return:=$return+"%CF"
			: (Character code:C91($char)=208)
				$return:=$return+"%D0"
			: (Character code:C91($char)=209)
				$return:=$return+"%D1"
			: (Character code:C91($char)=210)
				$return:=$return+"%D2"
			: (Character code:C91($char)=211)
				$return:=$return+"%D3"
			: (Character code:C91($char)=212)
				$return:=$return+"%D4"
			: (Character code:C91($char)=213)
				$return:=$return+"%D5"
			: (Character code:C91($char)=214)
				$return:=$return+"%D6"
			: (Character code:C91($char)=215)
				$return:=$return+"%D7"
			: (Character code:C91($char)=216)
				$return:=$return+"%D8"
			: (Character code:C91($char)=217)
				$return:=$return+"%D9"
			: (Character code:C91($char)=218)
				$return:=$return+"%DA"
			: (Character code:C91($char)=219)
				$return:=$return+"%DB"
			: (Character code:C91($char)=220)
				$return:=$return+"%DC"
			: (Character code:C91($char)=221)
				$return:=$return+"%DD"
			: (Character code:C91($char)=222)
				$return:=$return+"%DE"
			: (Character code:C91($char)=223)
				$return:=$return+"%DF"
			: (Character code:C91($char)=224)
				$return:=$return+"%E0"
			: (Character code:C91($char)=225)
				$return:=$return+"%E1"
			: (Character code:C91($char)=226)
				$return:=$return+"%E2"
			: (Character code:C91($char)=227)
				$return:=$return+"%E3"
			: (Character code:C91($char)=228)
				$return:=$return+"%E4"
			: (Character code:C91($char)=229)
				$return:=$return+"%E5"
			: (Character code:C91($char)=230)
				$return:=$return+"%E6"
			: (Character code:C91($char)=231)
				$return:=$return+"%E7"
			: (Character code:C91($char)=232)
				$return:=$return+"%E8"
			: (Character code:C91($char)=233)
				$return:=$return+"%E9"
			: (Character code:C91($char)=234)
				$return:=$return+"%EA"
			: (Character code:C91($char)=235)
				$return:=$return+"%EB"
			: (Character code:C91($char)=236)
				$return:=$return+"%EC"
			: (Character code:C91($char)=237)
				$return:=$return+"%ED"
			: (Character code:C91($char)=238)
				$return:=$return+"%EE"
			: (Character code:C91($char)=239)
				$return:=$return+"%EF"
			: (Character code:C91($char)=240)
				$return:=$return+"%F0"
			: (Character code:C91($char)=241)
				$return:=$return+"%F1"
			: (Character code:C91($char)=242)
				$return:=$return+"%F2"
			: (Character code:C91($char)=243)
				$return:=$return+"%F3"
			: (Character code:C91($char)=244)
				$return:=$return+"%F4"
			: (Character code:C91($char)=245)
				$return:=$return+"%F5"
			: (Character code:C91($char)=246)
				$return:=$return+"%F6"
			: (Character code:C91($char)=247)
				$return:=$return+"%F7"
			: (Character code:C91($char)=248)
				$return:=$return+"%F8"
			: (Character code:C91($char)=249)
				$return:=$return+"%F9"
			: (Character code:C91($char)=250)
				$return:=$return+"%FA"
			: (Character code:C91($char)=251)
				$return:=$return+"%FB"
			: (Character code:C91($char)=252)
				$return:=$return+"%FC"
			: (Character code:C91($char)=253)
				$return:=$return+"%FD"
			: (Character code:C91($char)=254)
				$return:=$return+"%FE"
			: (Character code:C91($char)=255)
				$return:=$return+"%FF"
				
			Else 
				$return:=$return+$char
		End case 
	End for 
Else 
	
	C_LONGINT:C283($length; $i; $j; $code)
	$length:=Length:C16($text)
	C_BLOB:C604($data)
	C_TEXT:C284($char; $hex)
	C_BOOLEAN:C305($shouldEscape)
	
	For ($i; 1; $length)
		$char:=Substring:C12($text; $i; 1)
		$code:=Character code:C91($char)
		$shouldEscape:=False:C215
		
		Case of 
			: ($code=45)
			: ($code=46)
			: ($code>47) & ($code<58)
			: ($code>63) & ($code<91)
			: ($code=95)
			: ($code>96) & ($code<123)
			: ($code=126)
			Else 
				$shouldEscape:=True:C214
		End case 
		
		If ($shouldEscape)
			//CONVERT FROM TEXT($char;"utf-8";$data)
			//For ($j;0;BLOB size($data)-1)
			//$hex:=String($data{$j};"&x")
			//$return:=$return+"%"+Substring($hex;Length($hex)-1)
			//End for 
			$return:=$return+" "
		Else 
			$return:=$return+$char
		End if 
	End for 
	
End if 
$0:=$return