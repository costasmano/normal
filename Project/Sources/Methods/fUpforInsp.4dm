//%attributes = {"invisible":true}
//fUpforInsp ($Year; $Month; $m; $leeway; $t; $Waive)
//Copyright © 1995-1996,  Albert S. Leung, All Rights Reserved.

//Determine if a bridge is due or out of frequency

//$Year - 1900..3000 year in question
//$Month - 1..12 month in question.  Month=0 takes only the year.
//$m - negative is out of frequency, 0 is what is due now.
//$leeway - positive for Out of frequency, 0 for Now.
//$t - The type of inspection:
//  `1=Routine
//  `2=Fracture Critical
//  `3=Other special
//  `4=Critical Member Inspection
//  `5=Closed Bridge Inspection
//  `6=Underwater Inspection
//  `7=code for Combined Inspection except for Underwater
//  `8=Underwater Routine
//  `9=Underwater Special member
//  `21=Tunnel All Items
//  `22=Tunnel Overhead Items
//  `23=Tunnel Special 1
//  `24=Tunnel Special 2
//  `25=Tunnel Special 3
//  `26=Tunnel Other
//  `27=Tunnel Closed
//$Waive - If true consider the [Bridge MHD NBIS]InspWaiver
If (False:C215)
	
	// Modified by: costasmanousakis-(Designer)-(4/5/2006 16:55:29)
	Mods_2006_CM04
	// Modified by: costasmanousakis-(Designer)-(11/27/07 14:57:36)
	Mods_2007_CM_5401
	// Modified by: costasmanousakis-(Designer)-(12/30/09 13:47:14)
	Mods_2009_12
	//Added Options $t
	// 8 = Regular UW inspection
	// 9 = UW Special Member inspection
	// Modified by: Costas Manousakis-(Designer)-(12/7/12 14:24:16)
	Mods_2012_12
	//  `For Routine Inspection if FHWA record set freq to 24, else use Item91
	// Modified by: Costas Manousakis-(Designer)-(1/28/13 16:48:01)
	Mods_2013_01
	//  `For UW Special member, if the UW spec memb date = !00/00/00! (ie has not had a UW Spec memb insp yet), 
	//  `use UW Routine Item93B
	// Modified by: Costas Manousakis-(Designer)-(9/11/13 11:34:31)
	Mods_2013_09
	//  `added handling of Tunnel inspections
	// Modified by: Costas Manousakis-(Designer)-(1/4/16 16:42:37)
	Mods_2016_01_bug
	//  `When  checking UW Spec memb (case 9) use the routine date if  it is after the spec memb.
	// Modified by: Costas Manousakis-(Designer)-(4/11/18 13:11:00)
	Mods_2018_04
	//  `For BRIs the default routine frequency is set to 24. for All Items tunnel insp also frequency is 24
End if 

C_LONGINT:C283($Year; $1)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283($Month; $2)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283($m; $3)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283($leeway; $4)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($Waive; $6)

C_BOOLEAN:C305($test; $0)
C_LONGINT:C283($t)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_DATE:C307($insp)
C_LONGINT:C283($freq)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($exctrl)
C_LONGINT:C283($Iyear; $Imonth; $w)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER
C_LONGINT:C283($Due; $Today0; $Today1; $Today)
C_LONGINT:C283($vlUWyrR; $vlUWmoR; $vlUWyrS; $vlUWmoS; $vlUWStR; $vlUWStS; $vlUWEndR; $vlUWEndS)  // **Replaced C_LONGINT()//Command Replaced was o_C_INTEGER

//Store parameters

$Year:=$1
$Month:=$2
$m:=$3
$leeway:=$4
$t:=$5
$Waive:=$6

$test:=False:C215
$freq:=0
//Waive the inspection?
$exctrl:=((Not:C34($Waive)) | ((Not:C34([Bridge MHD NBIS:1]InspWaiver:48)) & $Waive))
If ($t>20)
	//Tunnel inspections - load the tunnel info record
	QUERY:C277([TunnelInfo:151]; [TunnelInfo:151]BIN:1=[Bridge MHD NBIS:1]BIN:3)
End if 
If ($exctrl)
	Case of 
		: (($t=1) | ($t=21))  //Routine or All Items Tunnel
			$insp:=[Bridge MHD NBIS:1]Item90:161
			If ($insp=!00-00-00!)
				//No previous routine inspection - use year built.
				$insp:=Date:C102("1/1/"+String:C10([Bridge MHD NBIS:1]Item27:83))
			End if 
			
			Case of 
				: ([Bridge MHD NBIS:1]FHWARecord:174)
					$freq:=24
				: ($t=21)
					$freq:=24
				: ([Bridge MHD NBIS:1]Item8 BridgeCat:207="BRI")
					$freq:=24
				Else 
					$freq:=[Bridge MHD NBIS:1]Item91:162
			End case 
			
			$exctrl:=True:C214
			
		: ($t=2)  //Fracture
			$insp:=[Bridge MHD NBIS:1]Item93A:169
			$freq:=[Bridge MHD NBIS:1]Item92AB:164
			$exctrl:=[Bridge MHD NBIS:1]Item92AA:163
		: ($t=3)  //Critical Member Inspection
			$insp:=[Bridge MHD NBIS:1]Item93C:171
			$freq:=[Bridge MHD NBIS:1]Item92CB:168
			$exctrl:=[Bridge MHD NBIS:1]Item92CA:167
		: ($t=4)  //Other special
			$insp:=[Bridge MHD NBIS:1]OtherIDate:41
			$freq:=[Bridge MHD NBIS:1]OtherIFreq:43
			$exctrl:=[Bridge MHD NBIS:1]OtherInsp:42
		: ($t=5)  //Closed Bridge Inspection    
			$insp:=[Bridge MHD NBIS:1]ClosedIDate:44
			$freq:=[Bridge MHD NBIS:1]ClosedIFreq:46
			$exctrl:=[Bridge MHD NBIS:1]ClosedInsp:45
		: ($t=6)  //Underwater
			$insp:=[Bridge MHD NBIS:1]Item93B:170
			$freq:=[Bridge MHD NBIS:1]Item92BB:166
			$exctrl:=([Bridge MHD NBIS:1]Item92BA:165 | [Bridge MHD NBIS:1]UWSpInsp:212)
			If ([Bridge MHD NBIS:1]UWSpInsp:212)
				//All this code needed only if there a UW SpInsp is required
				If ([Bridge MHD NBIS:1]UWSpInspDate:214>$insp)
					$insp:=[Bridge MHD NBIS:1]UWSpInspDate:214
				End if 
				//need to calculate the proper UW freq
				$vlUWyrR:=Year of:C25([Bridge MHD NBIS:1]Item93B:170)
				$vlUWmoR:=Month of:C24([Bridge MHD NBIS:1]Item93B:170)
				If ([Bridge MHD NBIS:1]UWSpInspDate:214>[Bridge MHD NBIS:1]Item93B:170)
					$vlUWyrS:=Year of:C25([Bridge MHD NBIS:1]UWSpInspDate:214)
					$vlUWmoS:=Month of:C24([Bridge MHD NBIS:1]UWSpInspDate:214)
				Else 
					$vlUWyrS:=Year of:C25([Bridge MHD NBIS:1]Item93B:170)
					$vlUWmoS:=Month of:C24([Bridge MHD NBIS:1]Item93B:170)
				End if 
				$vlUWStR:=($vlUWyrR*12)+$vlUWmoR
				$vlUWStS:=($vlUWyrS*12)+$vlUWmoS
				$vlUWEndR:=$vlUWStR+$freq
				$vlUWEndS:=$vlUWStS+[Bridge MHD NBIS:1]UWSpInspFreq:213
				$vlUWStR:=(((Year of:C25($insp))*12)+Month of:C24($insp))
				If ($vlUWEndS>$vlUWStR)
					$freq:=MinNum(($vlUWEndR-$vlUWStR); ($vlUWEndS-$vlUWStR))
				End if 
			End if 
		: ($t=8)  //Routine Underwater 93B
			$insp:=[Bridge MHD NBIS:1]Item93B:170
			$freq:=[Bridge MHD NBIS:1]Item92BB:166
			$exctrl:=[Bridge MHD NBIS:1]Item92BA:165
		: ($t=9)  //Special Underwater
			$insp:=[Bridge MHD NBIS:1]UWSpInspDate:214
			If ($insp=!00-00-00!)
				$insp:=[Bridge MHD NBIS:1]Item93B:170
			End if 
			If ($insp<[Bridge MHD NBIS:1]Item93B:170)  // added 2016-01-04  !!!!!
				$insp:=[Bridge MHD NBIS:1]Item93B:170
			End if 
			$freq:=[Bridge MHD NBIS:1]UWSpInspFreq:213
			$exctrl:=[Bridge MHD NBIS:1]UWSpInsp:212
		: ($t=22)  //Tunnel Overhead Items
			$insp:=[TunnelInfo:151]OverHeadInspDate_d:22
			$freq:=[TunnelInfo:151]OverHeadInspFreq_i:23
			$exctrl:=($freq>0)
			If ($insp=!00-00-00!)  //if there is nothing here assume that the overhead was coded in 93C, 92C
				$insp:=[Bridge MHD NBIS:1]Item93C:171
				$freq:=[Bridge MHD NBIS:1]Item92CB:168
				$exctrl:=($freq>0)
			End if 
		: ($t=23)  //Tunnel Special1
			$insp:=[TunnelInfo:151]SpecialInsp1Date_d:24
			$freq:=[TunnelInfo:151]SpecialInsp1Freq_i:25
			$exctrl:=($freq>0)
			
		: ($t=24)  //Tunnel Special 2
			$insp:=[TunnelInfo:151]SpecialInsp2Date_d:26
			$freq:=[TunnelInfo:151]SpecialInsp2Freq_i:27
			$exctrl:=($freq>0)
			
		: ($t=25)  //Tunnel Special 3
			$insp:=[TunnelInfo:151]SpecialInsp3Date_d:28
			$freq:=[TunnelInfo:151]SpecialInsp3Freq_i:29
			$exctrl:=($freq>0)
			
		: ($t=26)  //Tunnel Other
			$insp:=[Bridge MHD NBIS:1]OtherIDate:41
			$freq:=[Bridge MHD NBIS:1]OtherIFreq:43
			$exctrl:=($freq>0)
			
		: ($t=27)  //Tunnel Closed
			$insp:=[Bridge MHD NBIS:1]ClosedIDate:44
			$freq:=[Bridge MHD NBIS:1]ClosedIFreq:46
			$exctrl:=($freq>0)
			
	End case 
	If ($exctrl)
		//If this is a brand new inspection other than a routine inspection start from the
		//last routine inspection date    
		If ($insp=!00-00-00!)
			$insp:=[Bridge MHD NBIS:1]Item90:161
		End if 
		$Iyear:=Year of:C25($insp)
		$Imonth:=Month of:C24($insp)
		$exctrl:=(($Iyear>0) & ($Imonth>0) & ($freq>0))  //Cannot allow 0's here!
		If ($exctrl)
			Case of 
				: ($m<0)  //out of frequency
					$w:=-$leeway
				: ($m=0)  //due now
					$w:=0
			End case 
			If ($Month#0)  //Due on exact month and year
				$Due:=($Iyear*12)+$Imonth+$freq
				$Today:=($Year*12)+$Month+$w
			Else   //Due in given year
				$Due:=($Iyear*12)+$Imonth+$freq
				$Today0:=($Year*12)+1
				$Today1:=($Year+1)*12
			End if 
			Case of 
				: ($m<0)  //Is it out of frequency?
					If ($Due<=$Today)
						$test:=True:C214
					End if 
				: ($m=0)  //Is it due Now?
					If ($Due=$Today)
						$test:=True:C214
					End if 
			End case 
			$exctrl:=(($m=0) & (Not:C34($test)))  //process only if not Out of frequency case
			If ($exctrl)
				//Have to cycle through inspection dates and look into the future
				If ($Month=0)  //Inspection falling in a given year
					While ($Due<=$Today1)  //Look into the future
						If ($Due>=$Today0)
							$test:=True:C214
						End if 
						$Due:=$Due+$freq
					End while 
					If (Not:C34($test))
						While ($Due>=$Today0)
							If ($Due<=$Today1)
								$test:=True:C214
							End if 
							$Due:=$Due-$freq
						End while 
					End if 
				Else   //Look into the future for a specific date the inspection falls on
					While ($Due<=$Today)
						If ($Due=$Today)
							$test:=True:C214
						End if 
						$Due:=$Due+$freq
					End while 
					If (Not:C34($test))  //Look into the past for a specific date the inspection falls on
						While ($Due>=$Today)
							If ($Due=$Today)
								$test:=True:C214
							End if 
							$Due:=$Due-$freq
						End while 
					End if 
				End if 
			End if 
		End if 
	End if 
End if 
$0:=$test  //Return true or false