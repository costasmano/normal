//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method: ARCHIVE_fUpForInsp
// Description
// Copied from fUpforInsp
// 
// Parameters
// ----------------------------------------------------

If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/24/11, 11:52:45
	// First Release
	Mods_2011_10
End if 

C_LONGINT:C283($Year; $1)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Month; $2)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($m; $3)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($leeway; $4)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($Waive; $6)

C_BOOLEAN:C305($test; $0)
C_LONGINT:C283($t)  //Command Replaced was o_C_INTEGER
C_DATE:C307($insp)
C_LONGINT:C283($freq)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($exctrl)
C_LONGINT:C283($Iyear; $Imonth; $w)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283($Due; $Today0; $Today1; $Today)
C_LONGINT:C283($vlUWyrR; $vlUWmoR; $vlUWyrS; $vlUWmoS; $vlUWStR; $vlUWStS; $vlUWEndR; $vlUWEndS)  //Command Replaced was o_C_INTEGER

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
$exctrl:=((Not:C34($Waive)) | ((Not:C34([BridgeMHDNBISArchive:139]InspWaiver:48)) & $Waive))
If ($exctrl)
	Case of 
		: ($t=1)  //Routine
			$insp:=[BridgeMHDNBISArchive:139]Item90:160
			If ($insp=!00-00-00!)
				//No previous routine inspection - use year built.
				$insp:=Date:C102("1/1/"+String:C10([BridgeMHDNBISArchive:139]Item27:82))
			End if 
			$freq:=24
			$exctrl:=True:C214
		: ($t=2)  //Fracture
			$insp:=[BridgeMHDNBISArchive:139]Item93A:168
			$freq:=[BridgeMHDNBISArchive:139]Item92AB:163
			$exctrl:=[BridgeMHDNBISArchive:139]Item92AA:162
		: ($t=3)  //Other special
			$insp:=[BridgeMHDNBISArchive:139]Item93C:170
			$freq:=[BridgeMHDNBISArchive:139]Item92CB:167
			$exctrl:=[BridgeMHDNBISArchive:139]Item92CA:166
		: ($t=4)  //Critical Member Inspection
			$insp:=[BridgeMHDNBISArchive:139]OtherIDate:41
			$freq:=[BridgeMHDNBISArchive:139]OtherIFreq:43
			$exctrl:=[BridgeMHDNBISArchive:139]OtherInsp:42
		: ($t=5)  //Closed Bridge Inspection    
			$insp:=[BridgeMHDNBISArchive:139]ClosedIDate:44
			$freq:=[BridgeMHDNBISArchive:139]ClosedIFreq:46
			$exctrl:=[BridgeMHDNBISArchive:139]ClosedInsp:45
		: ($t=6)  //Underwater
			$insp:=[BridgeMHDNBISArchive:139]Item93B:169
			$freq:=[BridgeMHDNBISArchive:139]Item92BB:165
			$exctrl:=([BridgeMHDNBISArchive:139]Item92BA:164 | [BridgeMHDNBISArchive:139]UWSpInsp:209)
			If ([BridgeMHDNBISArchive:139]UWSpInsp:209)
				//All this code needed only if there a UW SpInsp is required
				If ([BridgeMHDNBISArchive:139]UWSpInspDate:211>$insp)
					$insp:=[BridgeMHDNBISArchive:139]UWSpInspDate:211
				End if 
				//need to calculate the proper UW freq
				$vlUWyrR:=Year of:C25([BridgeMHDNBISArchive:139]Item93B:169)
				$vlUWmoR:=Month of:C24([BridgeMHDNBISArchive:139]Item93B:169)
				If ([BridgeMHDNBISArchive:139]UWSpInspDate:211>[BridgeMHDNBISArchive:139]Item93B:169)
					$vlUWyrS:=Year of:C25([BridgeMHDNBISArchive:139]UWSpInspDate:211)
					$vlUWmoS:=Month of:C24([BridgeMHDNBISArchive:139]UWSpInspDate:211)
				Else 
					$vlUWyrS:=Year of:C25([BridgeMHDNBISArchive:139]Item93B:169)
					$vlUWmoS:=Month of:C24([BridgeMHDNBISArchive:139]Item93B:169)
				End if 
				$vlUWStR:=($vlUWyrR*12)+$vlUWmoR
				$vlUWStS:=($vlUWyrS*12)+$vlUWmoS
				$vlUWEndR:=$vlUWStR+$freq
				$vlUWEndS:=$vlUWStS+[BridgeMHDNBISArchive:139]UWSpInspFreq:210
				$vlUWStR:=(((Year of:C25($insp))*12)+Month of:C24($insp))
				If ($vlUWEndS>$vlUWStR)
					$freq:=MinNum(($vlUWEndR-$vlUWStR); ($vlUWEndS-$vlUWStR))
				End if 
			End if 
		: ($t=8)  //Routine Underwater 93B
			$insp:=[BridgeMHDNBISArchive:139]Item93B:169
			$freq:=[BridgeMHDNBISArchive:139]Item92BB:165
			$exctrl:=[BridgeMHDNBISArchive:139]Item92BA:164
		: ($t=9)  //Special Underwater
			$insp:=[BridgeMHDNBISArchive:139]UWSpInspDate:211
			$freq:=[BridgeMHDNBISArchive:139]UWSpInspFreq:210
			$exctrl:=[BridgeMHDNBISArchive:139]UWSpInsp:209
			
	End case 
	If ($exctrl)
		//If this is a brand new inspection other than a routine inspection start from the
		//last routine inspection date    
		If ($insp=!00-00-00!)
			$insp:=[BridgeMHDNBISArchive:139]Item90:160
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