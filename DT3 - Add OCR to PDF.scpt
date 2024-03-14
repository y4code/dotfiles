-- Script for DEVONthink 3
-- Run OCRmyPDF on PDFs without OCR
-- Requires https://github.com/jbarlow83/OCRmyPDF to be installed e.g. with brew

on performSmartRule(theRecords)
	tell application id "DNtp"
		set strExportPath to "PATH=/usr/local/bin:$PATH "
		set intRecordsCount to count of theRecords
		show progress indicator "Adding OCR to PDF..." steps intRecordsCount
		repeat with theRecord in theRecords
			try
				step progress indicator filename of theRecord as string
				set strRecordPath to quoted form of (path of theRecord as string)
				set strCmd to strExportPath & "ocrmypdf --skip-text -l fra --rotate-pages --deskew --clean" & space & strRecordPath & space & strRecordPath
				do shell script strCmd
			on error error_message number error_number
				set tags of theRecord to (tags of theRecord) & "ocr_error"
				if the error_number is not -128 then display notification error_message with title "Error with OCR" subtitle (filename of theRecord as string)
			end try
		end repeat
		hide progress indicator
	end tell
end performSmartRule