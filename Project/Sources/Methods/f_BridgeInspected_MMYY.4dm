//%attributes = {}
If (False:C215)
	//f_BridgeInspected_MMYY 
	//
	//Function : Determine whether current bridge record has been inspected
	//during month of MMYYYY using SIA fields only
	//
	//Parameters
	//$1 : Integer : Month (1-12)
	//$2 : Integer : Year (1995-Current year)
	//
	//Result
	//Boolean : True / False
	
	Mods_2004_CM11
	
End if 

C_LONGINT:C283($1; $viMonth; $2; $viYear)  //Command Replaced was o_C_INTEGER
C_BOOLEAN:C305($0; $vbInspected)
C_DATE:C307($vdStartDate; $vdEndDate)

$vbInspected:=False:C215

$viMonth:=$1
$viYear:=$2
Case of 
	: (($viMonth<1) | ($viMonth>12))
		ALERT:C41("f_BridgeInspected_MMYY : Invalid month! Must be between 1 and 12")
	: (($viYear<1995) | ($viYear>Year of:C25(Current date:C33(*))))
		ALERT:C41("f_BridgeInspected_MMYY : Invalid Year! Must be between 1995 and current year!")
		
	Else 
		$vdStartDate:=Date:C102(String:C10($viMonth)+"/01/"+String:C10($viYear))
		
		If ($viMonth=12)
			$viMonth:=1
			$viYear:=$viYear+1
		Else 
			$viMonth:=$viMonth+1
		End if 
		
		$vdEndDate:=Date:C102(String:C10($viMonth)+"/01/"+String:C10($viYear))
		
		Case of 
			: ([Bridge MHD NBIS:1]Item90:161>=$vdStartDate) & ([Bridge MHD NBIS:1]Item90:161<$vdEndDate)
				$vbInspected:=True:C214
			: ([Bridge MHD NBIS:1]Item93A:169>=$vdStartDate) & ([Bridge MHD NBIS:1]Item93A:169<$vdEndDate)
				$vbInspected:=True:C214
			: ([Bridge MHD NBIS:1]Item93B:170>=$vdStartDate) & ([Bridge MHD NBIS:1]Item93B:170<$vdEndDate)
				$vbInspected:=True:C214
			: ([Bridge MHD NBIS:1]Item93C:171>=$vdStartDate) & ([Bridge MHD NBIS:1]Item93C:171<$vdEndDate)
				$vbInspected:=True:C214
			: ([Bridge MHD NBIS:1]ClosedIDate:44>=$vdStartDate) & ([Bridge MHD NBIS:1]ClosedIDate:44<$vdEndDate)
				$vbInspected:=True:C214
			: ([Bridge MHD NBIS:1]DamageInsp:47>=$vdStartDate) & ([Bridge MHD NBIS:1]DamageInsp:47<$vdEndDate)
				$vbInspected:=True:C214
			: ([Bridge MHD NBIS:1]OtherIDate:41>=$vdStartDate) & ([Bridge MHD NBIS:1]OtherIDate:41<$vdEndDate)
				$vbInspected:=True:C214
			: ([Bridge MHD NBIS:1]UWSpInspDate:214>=$vdStartDate) & ([Bridge MHD NBIS:1]UWSpInspDate:214<$vdEndDate)
				$vbInspected:=True:C214
				
		End case 
		
End case 

$0:=$vbInspected