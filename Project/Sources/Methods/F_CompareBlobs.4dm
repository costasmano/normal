//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/31/06, 10:24:59
	// ----------------------------------------------------
	// Method: F_CompareBlobs
	// Description
	// Compare two blobs , return TRUE/FALSE if equal or not
	// Copied from posting in NUG by David Dancy
	// 
	// Parameters
	// ----------------------------------------------------
	Mods_2006_CM03
End if 
C_BOOLEAN:C305($0; $BLOBsAreEqual_b)
C_BLOB:C604($1; $baseBLOB_x)
C_BLOB:C604($2; $comparisonBLOB_x)

$baseBLOB_x:=$1
$comparisonBLOB_x:=$2

$BLOBsAreEqual_b:=False:C215

Case of 
		//both BLOBs empty: they are "equal"
	: ((BLOB size:C605($baseBLOB_x)=0) & (BLOB size:C605($comparisonBLOB_x)=0))
		$BLOBsAreEqual_b:=True:C214
		
		//only one BLOB empty: they can't be equal (this test may be redundant)
	: ((BLOB size:C605($baseBLOB_x)=0) | (BLOB size:C605($comparisonBLOB_x)=0))
		$BLOBsAreEqual_b:=False:C215
		
		//both non-empty but not the same size: they can't be equal
	: (BLOB size:C605($baseBLOB_x)#BLOB size:C605($comparisonBLOB_x))
		$BLOBsAreEqual_b:=False:C215
		
	Else 
		// Do a byte-by-byte comparison.
		C_LONGINT:C283($length)
		C_LONGINT:C283($index)
		
		$length:=BLOB size:C605($baseBLOB_x)
		$index:=1  // BLOBs are not empty
		
		$BLOBsAreEqual_b:=True:C214  //assume success
		//TRACE
		For ($index; 0; $length-1)
			If ($baseBLOB_x{$index}#$comparisonBLOB_x{$index})
				$BLOBsAreEqual_b:=False:C215
				$index:=$length+1  //bomb out of the loop
			End if 
		End for 
		
End case 
SET BLOB SIZE:C606($baseBLOB_x; 0)
SET BLOB SIZE:C606($comparisonBLOB_x; 0)
$0:=$BLOBsAreEqual_b