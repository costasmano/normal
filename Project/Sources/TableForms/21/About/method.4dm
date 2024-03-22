If (False:C215)
	//[Dialogs];"About" 
	// Modified by: costasmanousakis (4/21/09)
	Mods_2009_04
	//Use Application file when runtime volume license
	// Modified by: Costas Manousakis-(Designer)-(12/26/12 14:03:47)
	Mods_2012_12
	//  `Added variable $sdbAccessMode;
	//  `Moved all on Load code from objects to this form method.
	//  `Re-Arranged objects
	// Modified by: Costas Manousakis-(Designer)-(4/1/19 17:44:55)
	Mods_2019_04
	//  `replaced details with a text object "AppDetails"; use Set obj title; removed process vars
	// Modified by: Costas Manousakis-(Designer)-(2022-03-21T00:00:00 14:49:22)
	Mods_2022_03
	//  `replaced details with a scrollable form variable; get connection info from the Database folder
	// Modified by: Costas Manousakis-(Designer)-(2022-10-19 10:15:22)
	Mods_2022_10
	//  `added the data file path
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($sdbStructureName; $sdbAccessMode; $ConnectTo; $sVersionN; $sdbDate; $sdbUser)
		$sVersionN:="MADOT BMS v"+<>Version
		$sdbDate:="Date taken from server "+String:C10(<>dbDate)
		$sdbUser:="User logged in : "+Current user:C182+" on "+Current machine:C483
		If (Application type:C494=4D Volume desktop:K5:2)
			$sdbStructureName:=Application file:C491
		Else 
			$sdbStructureName:=Structure file:C489
		End if 
		If (Application type:C494#4D Remote mode:K5:5)
			$sdbStructureName:=Substring:C12($sdbStructureName; (1+Length:C16(GetPath($sdbStructureName))))
		End if 
		$sdbStructureName:="Structure file : "+$sdbStructureName+"\nData : "+Data file:C490
		$ConnectTo:=""
		Case of 
			: (Application type:C494=4D Remote mode:K5:5)
				$sdbAccessMode:="Client"
				C_TEXT:C284($dbfolder; $lastPart_txt)
				$dbfolder:=Get 4D folder:C485(Database folder:K5:14)
				ARRAY TEXT:C222($dbfolderparts_atxt; 0)
				ut_NewTextToArray($dbfolder; ->$dbfolderparts_atxt; Folder separator:K24:12)
				$lastPart_txt:=$dbfolderparts_atxt{Size of array:C274($dbfolderparts_atxt)}  // the db name, IP, port , and session number are here
				ARRAY TEXT:C222($infoParts_atxt; 0)
				ut_NewTextToArray($lastPart_txt; ->$infoParts_atxt; "_")
				C_TEXT:C284($sessionnumber_txt; $port_txt; $IP_txt; $connectionName_txt)
				C_LONGINT:C283($numParts_L)
				$numParts_L:=Size of array:C274($infoParts_atxt)
				$sessionnumber_txt:=$infoParts_atxt{$numParts_L}  //last part is session number
				$port_txt:=$infoParts_atxt{$numParts_L-1}  // second to last is the port
				//check if element before the port is numeric
				C_LONGINT:C283($connectionNameEnd_L)
				If (bIsNumeric($infoParts_atxt{$numParts_L-2}))
					$IP_txt:=$infoParts_atxt{$numParts_L-5}+"."+$infoParts_atxt{$numParts_L-4}+"."+$infoParts_atxt{$numParts_L-3}+"."+$infoParts_atxt{$numParts_L-2}
					$connectionNameEnd_L:=6
				Else 
					$IP_txt:=$infoParts_atxt{$numParts_L-2}
					$connectionNameEnd_L:=3
				End if 
				$ConnectTo:="Connected to server at : "+$IP_txt+":"+$port_txt
				If (User in group:C338(Current user:C182; "Design Access Group"))
					$connectionName_txt:=$infoParts_atxt{1}
					C_LONGINT:C283($i)
					For ($i; 2; (Size of array:C274($infoParts_atxt)-$connectionNameEnd_L))
						$connectionName_txt:=$connectionName_txt+"_"+$infoParts_atxt{$i}
					End for 
					$ConnectTo:=$ConnectTo+"\r"+"Connection DB name ["+$connectionName_txt+"]\r"+\
						"Server local IP :"+G_GetServerTCP
				End if 
				
			: (Application type:C494=4D Local mode:K5:1)
				$sdbAccessMode:="Local"
				$ConnectTo:="Structure : "+GetPath(Structure file:C489)
			: (Application type:C494=4D Server:K5:6)
				$sdbAccessMode:="Server"
			: (Application type:C494=4D Volume desktop:K5:2)
				$sdbAccessMode:="Standalone App"
				$ConnectTo:="Structure : "+GetPath(Application file:C491)
		End case 
		
		If (Is compiled mode:C492(*))
			$sdbAccessMode:="Compiled "+$sdbAccessMode
		Else 
			$sdbAccessMode:="Interpreted "+$sdbAccessMode
		End if 
		
		$sdbAccessMode:="DB Access mode : "+$sdbAccessMode+Char:C90(13)+$ConnectTo
		C_TEXT:C284($appDetails_txt)
		$appDetails_txt:=$sVersionN+"\n"+\
			$sdbUser+"\n"+\
			$sdbStructureName+"\n"+\
			$sdbAccessMode
		
		C_POINTER:C301($var)
		$var:=OBJECT Get pointer:C1124(Object named:K67:5; "AppDetailsVar")
		$var->:=$appDetails_txt
End case 