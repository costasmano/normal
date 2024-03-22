// This is a hack for 32-bit web areas on High Sierra. Controls in the
// web area become unresponsive after the web area window loses focus and then
// regains it. It's a bug that 4D says is Apple's fault.  By opening another web area
// (in this case a tiny 1 pixel by 1 pixel web area) window and then immediately closing
// it, the problem is avoided.
//
// You probably don't need this if you're running in 64-bit, at least according
// to what 4D told us. We discovered this little workaround on our own, since we
// make pretty extensive use of web areas.

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ACCEPT:C269
		
End case 