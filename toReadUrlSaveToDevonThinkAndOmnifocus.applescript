on run argv
	set theQuery to item 1 of argv
	# create object to read
	set toReadLink to theQuery
	tell application "DEVONthink Pro"
		set usedDB to get database with uuid "F0A0912E-F68C-4222-8C62-CEC0C1D85857"
		log "usedDB: " & name of usedDB as string
		tell usedDB
			set usedInbox to parent named "Inbox"
			log "usedInbox: " & name of usedInbox as string
			set toReadUrl to create record with {name:toReadLink, type:bookmark, URL:toReadLink} in usedInbox
			
			synchronize record toReadUrl
			set u to reference URL of toReadUrl as string
		end tell
	end tell
	
	# create todolist
	
	tell application "OmniFocus"
		set defaultDoc to document named "OmniFocus"
		log "document:" & name of defaultDoc as string
		tell defaultDoc
			set todoAction to {name:toReadLink, note:u}
			tell the first item of (folders where name is "0 now")
				set folderMatch to the first item of (projects where name is "TOREAD")
				make new task at folderMatch with properties todoAction
			end tell
		end tell
		synchronize defaultDoc
	end tell
end run