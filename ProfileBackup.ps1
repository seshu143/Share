﻿<#
    .NOTES
    --------------------------------------------------------------------------------
     Form Code generated by:  SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.167
     Generated on:       	  11/1/2019 3:52 PM
     Generated by:      	  Alan Newingham
    --------------------------------------------------------------------------------
    .DESCRIPTION
        GUI script generated by PowerShell Studio 2019
#>
function Show-gddgfhdfghgfdh_psf {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formProfileBackup = New-Object 'System.Windows.Forms.Form'
	$statusbar1 = New-Object 'System.Windows.Forms.StatusBar'
	$buttonCopyLogsToClipboard = New-Object 'System.Windows.Forms.Button'
	$labelByAlanNewingham = New-Object 'System.Windows.Forms.Label'
	$labelLog = New-Object 'System.Windows.Forms.Label'
	$labelCheckDirectoryYouWan = New-Object 'System.Windows.Forms.Label'
	$Info = New-Object 'System.Windows.Forms.GroupBox'
	$labelenvUserName = New-Object 'System.Windows.Forms.Label'
	$labelOSInstallDate = New-Object 'System.Windows.Forms.Label'
	$labelenvCOMPUTERNAME = New-Object 'System.Windows.Forms.Label'
	$labelAuthenticatedUser = New-Object 'System.Windows.Forms.Label'
	$labelInstDate = New-Object 'System.Windows.Forms.Label'
	$labelWindowsUser = New-Object 'System.Windows.Forms.Label'
	$label1 = New-Object 'System.Windows.Forms.Label'
	$labelDeviceName = New-Object 'System.Windows.Forms.Label'
	$labelProfileBackup007 = New-Object 'System.Windows.Forms.Label'
	$buttonDisplayInstalledProg = New-Object 'System.Windows.Forms.Button'
	$buttonDisplayCustomInvento = New-Object 'System.Windows.Forms.Button'
	$buttonDisplayAllInstalledP = New-Object 'System.Windows.Forms.Button'
	$buttonInitiateTheBackupPro = New-Object 'System.Windows.Forms.Button'
	$progressbar1 = New-Object 'System.Windows.Forms.ProgressBar'
	$groupbox3 = New-Object 'System.Windows.Forms.GroupBox'
	$checkboxOneDrive = New-Object 'System.Windows.Forms.CheckBox'
	$checkboxCustomDirectory = New-Object 'System.Windows.Forms.CheckBox'
	$textbox7 = New-Object 'System.Windows.Forms.TextBox'
	$checkboxQuickparts = New-Object 'System.Windows.Forms.CheckBox'
	$checkboxBrowsers = New-Object 'System.Windows.Forms.CheckBox'
	$checkboxVideos = New-Object 'System.Windows.Forms.CheckBox'
	$checkboxPictures = New-Object 'System.Windows.Forms.CheckBox'
	$checkboxDocuments = New-Object 'System.Windows.Forms.CheckBox'
	$checkboxDownloads = New-Object 'System.Windows.Forms.CheckBox'
	$checkboxDesktop = New-Object 'System.Windows.Forms.CheckBox'
	$groupbox2 = New-Object 'System.Windows.Forms.GroupBox'
	$textbox1 = New-Object 'System.Windows.Forms.TextBox'
	$textbox2 = New-Object 'System.Windows.Forms.TextBox'
	$labelFromLocation = New-Object 'System.Windows.Forms.Label'
	$labelToLocation = New-Object 'System.Windows.Forms.Label'
	$richtextbox1 = New-Object 'System.Windows.Forms.RichTextBox'
	$tooltip1 = New-Object 'System.Windows.Forms.ToolTip'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$formProfileBackup_Load={
		#TODO: Initialize Form Controls here
		
	}
	
	
	#Begin Region - Automatic System Information Gathering
	#shortened my information gathering script to this as it was taking the script too long to load on startup. 
	
	$CurrentUserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
	[string]$ComputerName = $env:computername
	$Computer = $ComputerName
	$LoggedOnUser = (Get-WmiObject win32_computersystem -ComputerName $Computer).Username
	$InstDate = (Get-CimInstance Win32_OperatingSystem).InstallDate
	#End Region - Automatic System Information Gathering
	
	# Setting up Speech
	# Need to load the System.Speech assembly
	Add-Type -AssemblyName System.speech
	
	# Now we create the SpeechSynthesizer object.
	$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
	
	# Setting voice
	$speak.SelectVoice('Microsoft Zira Desktop')
	
	function Get-ApplicationEvents
	{
		#I wanted a good method to quickly backup event logs.
		$source = $Texbox1.Text
		$dest = $Textbox2.Text
		$cn = $env:Computername
		$path = "$dest\Desktop\$cn\Logs\"
		#Eventlogs
		
		# Config
		$logFileName = "Application" # Add Name of the Logfile (System, Application, etc)
			
		# do not edit
		$exportFileName = $logFileName + ".evt"
		$logFile = Get-WmiObject Win32_NTEventlogFile | Where-Object { $_.logfilename -eq $logFileName }
		$logFile.backupeventlog($path + $exportFileName)
		Remove-Variable source
		Remove-Variable cn
		Remove-Variable dest
		Remove-Variable path
		Remove-Variable exportFileName
		Remove-Variable logFileName
		Remove-Variable logFile
	}
	
	function Get-SystemEvents
	{
		#I wanted a good method to quickly backup event logs.
		$source = $Texbox1.Text
		$dest = $Textbox2.Text
		$cn = $env:Computername
		$path = "$dest\Desktop\$cn\Logs\"
		#Eventlogs
		
		# Config
		$logFileName = "System" # Add Name of the Logfile (System, Application, etc)
		
		# do not edit
		$exportFileName = $logFileName + ".evt"
		$logFile = Get-WmiObject Win32_NTEventlogFile | Where-Object { $_.logfilename -eq $logFileName }
		$logFile.backupeventlog($path + $exportFileName)
		Remove-Variable source
		Remove-Variable cn
		Remove-Variable dest
		Remove-Variable path
		Remove-Variable exportFileName
		Remove-Variable logFileName
		Remove-Variable logFile
	}
	
	function Get-Excel
	{
		$source = $Texbox1.Text
		$dest = $Textbox2.Text
		$cn = $env:Computername
		$now = get-date
		$path = "$dest\Desktop\$cn\Logs\"
		
		cd $path;
		
		$csvs = Get-ChildItem .\* -Include *.csv
		$y = $csvs.Count
		$richtextbox1.Text += "I have detected the following CSV files: ($y)`n"
		$speak.Speak("There are a total of $y seeessvee files. Just a moment. Consolidating data.")
		foreach ($csv in $csvs)
		{
			$richtextbox1.Text += $csv.Name
		}
		$outputfilename = "$dest\Desktop\$cn\Logs\$cn-combined-data.xlsx"
		$speak.Speak("Crating $outputfilename.")
		$richtextbox1.Text += "`nCreating: $outputfilename`n"
		
		$excelapp = new-object -comobject Excel.Application
		$excelapp.sheetsInNewWorkbook = $csvs.Count
		$xlsx = $excelapp.Workbooks.Add()
		$sheet = 1
		
		foreach ($csv in $csvs)
		{
			$row = 1
			$column = 1
			$worksheet = $xlsx.Worksheets.Item($sheet)
			$worksheet.Name = $csv.Name
			$file = (Get-Content $csv)
			foreach ($line in $file)
			{
				$linecontents = $line -split ',(?!\s*\w+")'
				foreach ($cell in $linecontents)
				{
					$worksheet.Cells.Item($row, $column) = $cell
					$column++
				}
				$column = 1
				$row++
			}
			$sheet++
		}
		$output = "$dest\Desktop\$cn\Logs\Combined-data.xlsx"
		$xlsx.SaveAs($output)
		$excelapp.quit()
	
		Remove-Variable outputfilename
		Remove-Variable sheet
		Remove-Variable csvs
		Remove-Variable linecontents
		Remove-Variable worksheet
		Remove-Variable file
		Remove-Variable line
		Remove-Variable csv
		Remove-Variable column
		Remove-Variable row
		Remove-Variable path
		Remove-Variable output
	}
	
	function Get-PSInventory
	{
		
		$source = $texbox1.Text
		$dest = $textbox2.Text
		$Path = $textbox2.Text
		$cn = $env:Computername
		$el_c = @()
		$now = get-date
		Set-Variable -Name EventAgeDays -Value 7
		$startdate = $now.adddays(-$EventAgeDays)
		
		$Path = $Path + "\Desktop\" + $cn + "\Logs\"
		If (!(test-path $path))
		{
			New-Item -ItemType Directory -Force -Path $path
		}
		#This is setup as an array for multiple systems, dumbed down this portion of the script to flow correctly.
		Set-Variable -Name ExportFolder -Value "$Path\Desktop\$cn\Logs\$now"
		$ExportFile = $ExportFolder + "el" + $now.ToString("yyyy-MM-dd---hh-mm-ss") + ".csv"
		Get-PSDrive | Export-CSV "$Path\PSDrive.csv" -NoTypeInfo
		Get-CimInstance -Class Win32_LogicalDisk | Export-CSV "$Path\LogicalDisk.csv" -NoTypeInfo
		Get-CimInstance -Class Win32_NetworkConnection | Export-CSV "$Path\NetworkConnectedDrives.csv" -NoTypeInfo
		Get-PSDrive -PSProvider FileSystem | Export-CSV "$Path\ConnectedDrives.csv" -NoTypeInfo
		Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, ServicePackMajorVersion, OSArchitecture, CSName, WindowsDirectory | Export-CSV "$Path\OSInfo.csv" -NoTypeInfo
		Get-Ciminstance -classname win32_bios -computername $env:COMPUTERNAME | format-list serialnumber | Export-CSV "$Path\BIOS.csv" -NoTypeInfo
		Get-NetIPConfiguration -Detailed | Export-CSV "$Path\IPConfig.csv" -NoTypeInfo
		Get-LocalGroupMember -Group "Administrators" | Export-CSV "$Path\AdminAccounts.csv" -NoTypeInfo
		$obj = New-Object psobject -Property @{ ComputerName = $env:COMPUTERNAME }
		$obj | Export-Csv -Path $Path\ComputerName.csv -Encoding UTF8 -NoTypeInformation
		Get-NetFirewallRule -PolicyStore ActiveStore | Export-CSV "$Path\Firewall.csv" -NoTypeInfo
		Get-ApplicationEvents
		Get-SystemEvents
		Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Export-CSV "$Path\InstalledApplications.csv" -NoTypeInfo
		Get-Process | Export-CSV "$Path\Processes.csv" -NoTypeInfo
		Get-Service | Export-CSV "$Path\Services.csv" -NoTypeInfo
		Get-Excel
		$richtextbox1.Text += "Completed Running PSInventory.`n"
		$speak.Speak("Completed Running PSInventory. You can find all of the information located at $dest\Desktop\$cn\Logs The filename is Combined-data.xlsx")
		#Time to clean up this mess.
		Remove-Variable ExportFile
		Remove-Variable ExportFolder
		Remove-Variable now
		Remove-Variable cn
		Remove-Variable dest
		Remove-Variable source
		#More housekeeping
		$deleteallotherdatanow = "E:\Logs\Desktop\DB-8BQR2W2\Logs\*"
		Remove-Item -Recurse -Path $deleteallotherdatanow -Exclude Application.evt, System.evt, Combined-data.xlsx -Force
	}
	
	
	function backupDirectory
	{
			$source = $textbox1.Text
			$dest = $textbox2.Text
			$richtextbox1.Text = "Initializing Backup Proceedure...`n"
			$richtextbox1.Text += "#############################################################################################################"
			$richtextbox1.Text += "`n`nPlease check the log file for verification of file transfers. Located: $source\desktop\backuplog.txt.`n`n"
			$richtextbox1.Text += "#############################################################################################################"
			$speak.Speak("Initializing backup proceedure. Please wait a moment while I count the directories and files.")
			$becauseAricIsAB = "{0:N2} GB" -f ((Get-ChildItem $source -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1GB)
			$recursiveObjectCount = Get-ChildItem -path $source -Recurse | Measure-Object | %{ $_.Count }
			$recursiveObjectCountDirectory = Get-ChildItem -path $source -Recurse -Directory | Measure-Object | %{ $_.Count }
			$recursiveObjectCountFile = Get-ChildItem -path $source -Recurse -File | Measure-Object | %{ $_.Count }
			$speak.Speak("There are a total of $recursiveObjectCount objects in this profile. With a size of $becauseAricIsAB")
			$richtextbox1.Text += "`nThere are a total of $recursiveObjectCount objects in this profile. With a size of $becauseAricIsAB."
			$speak.Speak("Out of the $recursiveObjectCount objects in this profile there are a total of $recursiveObjectCountDirectory directories.")
			$richtextbox1.Text += "`nOut of the $recursiveObjectCount objects in this profile there are a total of $recursiveObjectCountDirectory directories."
			$speak.Speak("Out of the $recursiveObjectCount objects in this profile there are a total of $recursiveObjectCountFile Files.")
			$richtextbox1.Text += "`nOut of the $recursiveObjectCount objects in this profile there are a total of $recursiveObjectCountFile Files."
		    $speak.Speak("This will take some time.")
		
		If (Test-Path $source)
		{
			If ($checkboxDesktop.Checked)
			{
				$ProgressBar1.Value = "15"
				$speak.Speak("`nBacking up the Desktop Directory")
				$richtextbox1.Text += "`nInitializing Desktop Directory Backup."
				Robocopy $source\Desktop $dest\Desktop *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$richtextbox1.Text += "`nDesktop directory backed up successfully."
				$speak.Speak("The Desktop directory completed backing up. Continuing backup.")
				$richtextbox1.Text += "`n#############`n"
				$ProgressBar1.Value = "30"
			}
			If ($checkboxDocuments.Checked)
			{
				$richtextbox1.Text += "`nInitializing Documents Directory Backup."
				$speak.Speak("Backing up the Documents Directory")
				Robocopy $source\Documents $dest\Documents *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$richtextbox1.Text += "`nDocuments directory backed up successfully."
				$speak.Speak("The Documents directory completed backing up. Continuing backup.")
				$richtextbox1.Text += "`n#############`n"
				$ProgressBar1.Value = "45"
			}
			If ($checkboxDownloads.Checked)
			{
				$richtextbox1.Text += "`nInitializing Downloads Directory Backup."
				$speak.Speak("Backing up the Downloads Directory")
				Robocopy $source\Downloads $dest\Downloads *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$richtextbox1.Text += "`nDownloads directory backed up successfully."
				$speak.Speak("The Downloads directory completed backing up. Continuing backup.")
				$richtextbox1.Text += "`n#############`n"
				$ProgressBar1.Value = "57"
			}
			If ($checkboxBrowsers.Checked)
			{
				$richtextbox1.Text += "`nInitializing Browser data backup. We are closing the browsers now."
				$speak.Speak("Backing up the browser data. We are closing the browsers now.")
						
				#Find and close Firefox browser
				$firefox = Get-Process firefox -ErrorAction SilentlyContinue
				if ($firefox)
				{
					$speak.Speak("Firefox was found running, closing the application gracefully.")
					# try gracefully first
					$firefox.CloseMainWindow()
					# kill after five seconds
					Sleep 5
					if (!$firefox.HasExited)
					{
						$speak.Speak("Firefox did not shut down gracefully, forcing the application closed now.")
						$firefox | Stop-Process -Force
					}
				}
				Remove-Variable firefox
				
				#Find and close Chrome browser
				$chrome = Get-Process chrome -ErrorAction SilentlyContinue
				if ($chrome)
				{
					$speak.Speak("Chrome was found running, closing the application gracefully.")
					# try gracefully first
					$chrome.CloseMainWindow()
					# kill after five seconds
					Sleep 5
					if (!$chrome.HasExited)
					{
						$speak.Speak("Chrome was found running, closing.")
						$chrome | Stop-Process -Force
					}
				}
				Remove-Variable chrome
				
				#Find and close Internet Explorer
				$ie = Get-Process iexplore -ErrorAction SilentlyContinue
				if ($ie)
				{
					$speak.Speak("eye E was found running, closing the application gracefully.")
					# try gracefully first
					$ie.CloseMainWindow()
					# kill after five seconds
					Sleep 5
					if (!$ie.HasExited)
					{
						$speak.Speak("eye E was found running, closing.")
						$ie | Stop-Process -Force
					}
				}
				Remove-Variable ie
				
				
				
				$richtextbox1.Text += "`nInitializing IE Favorites Backup."
				$richtextbox1.Text += "`nIf you have not closed the browser windows you need to do so now."
				$richtextbox1.Text += "`nFailure to close the browser windows will halt the backup until they are closed."
				Robocopy $source\Favorites $dest\Favorites *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$ProgressBar1.Value = "60"
				$richtextbox1.Text += "`nInitializing Chrome Bookmarks Backup."
				Robocopy $source\AppData\Local\Google $dest\AppData\Local\Google *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$ProgressBar1.Value = "63"
				$richtextbox1.Text += "`nInitializing Firefox Bookmarks Backup."
				Robocopy $source\AppData\Roaming\Mozilla\Firefox\Profiles $dest\AppData\Roaming\Mozilla\Firefox\Profiles *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$richtextbox1.Text += "`nIE, FireFox, and Chrome Bookmark directories backed up successfully."
				$speak.Speak("The Eye E, Fire Fox and Chrome Bookmarks directories completed backing up. Continuing backup.")
				$richtextbox1.Text += "`n#############`n"
				$ProgressBar1.Value = "65"
			}
			If ($checkboxPictures.Checked)
			{
				$richtextbox1.Text += "`nInitializing Pictures Directory Backup."
				$speak.Speak("Backing up the Pictures Directory")
				Robocopy $source\Pictures $dest\Pictures *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$richtextbox1.Text += "`nPictures directory backed up successfully."
				$speak.Speak("The Pictures directory completed backing up. Continuing backup.")
				$richtextbox1.Text += "`n###################`n"
				$ProgressBar1.Value = "75"
			}
			If ($checkboxVideos.Checked)
			{
				$richtextbox1.Text += "`nInitializing Video Directory Backup."
				$speak.Speak("Backing up the Video Directory")
				Robocopy $source\Videos $dest\Videos *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$richtextbox1.Text += "`nVideos directory backed up successfully."
				$speak.Speak("The Videos directory completed backing up. Continuing backup.")
				$richtextbox1.Text += "`n#############`n"
				$ProgressBar1.Value = "80"
			}
			If ($checkboxQuickparts.Checked)
			{
				$richtextbox1.Text += "`nInitializing Signature Directory Backup."
				Robocopy "$source\application data\microsoft\templates" "$dest\application data\microsoft\templates" *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$richtextbox1.Text += "`nQuickParts directory backed up successfully."
				$speak.Speak("The Microsoft QuickParts completed backing up. Continuing backup.")
				$richtextbox1.Text += "`n#############`n"
				$ProgressBar1.Value = "90"
			}
			If ($checkboxCustomDirectory.Checked)
			{
				$source = $textbox7.Text
				$richtextbox1.Text += "`nInitializing Custom Directory Backup."
				$richtextbox1.Text += "`nBacking up directory $textbox7.Text."
				Robocopy $source $dest\Custom_Directory_Backup *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$richtextbox1.Text += "`nCustom directory backed up successfully."
				$speak.Speak("The custom backup directory completed backing up. Continuing backup.")
				$richtextbox1.Text += "`n#############`n"
				$ProgressBar1.Value = "93"
			}
			If ($checkboxOneDrive.Checked)
			{
				$richtextbox1.Text += "`nInitializing OneDrive Directory Backup."
				Robocopy $source\OneDrive - Embry-Riddle Aeronautical University $dest\OneDrive - Embry-Riddle Aeronautical University.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
				$richtextbox1.Text += "`nOneDrive directory backed up successfully."
				$speak.Speak("The OneDrive, directory completed backing up. 95 percent complete")
				$richtextbox1.Text += "`n#############`n"
				$ProgressBar1.Value = "95"
			}
			$richtextbox1.Text += "`nInitializing Adobe Signature/Security Directory Backup."
			Robocopy $source\AppData\Roaming\Adobe\Acrobat\DC\Security $dest\AppData\Roaming\Adobe\Acrobat\DC\Security *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
			$richtextbox1.Text += "`nAdobe signature/security directory backed up successfully."
			$richtextbox1.Text += "`n#############`n"
			$speak.Speak("The Adobe signature file completed backing up.")
			$richtextbox1.Text += "`nInitializing OneDrive-Not-Yet-Syncd-Files Directory Backup."
			$richtextbox1.Text += "`nOneDrive-Not-Yet-Syncd-Files directory backed up successfully."
			$speak.Speak("OneDrive Not Yet Sinked Files directory backed up successfully.")
			$richtextbox1.Text += "`n#############`n"
			$richtextbox1.Text += "`nInitializing Outlook Signature Directory Backup."
			Robocopy $source\application data\microsoft\signatures $dest\application data\microsoft\signatures *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
			$richtextbox1.Text += "`nOutlook signature backed up successfully."
			$speak.Speak("The Outlook signaturecompleted backing up. 96 percent complete")
			$richtextbox1.Text += "`n#############`n"
			$ProgressBar1.Value = "96"
			#Outlook 2016 Settings Export
			cmd /c "REG EXPORT 'HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook' '$dest\Outlook16-config.reg' /y"
			#Outlook 2013 Settings Export
			cmd /c "REG EXPORT 'HKEY_CURRENT_USER\​Software\​Microsoft\​Office\​15.0\​Outlook' '$dest\Outlook13-config.reg' /y"
			$richtextbox1.Text += "`nOutlook configuration backed up to $dest\Outlook-config.reg."
			$speak.Speak("Outlook configuration backed up to $dest\Outlook-config.reg. 97 percent complete")
			$richtextbox1.Text += "`n#############`n"
			$ProgressBar1.Value = "97"
			Robocopy $source\AppData\Local\Microsoft\Outlook $dest\AppData\Local\Microsoft\Outlook *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
			$richtextbox1.Text += "`nOutlook settings backed up to $dest\AppData\Local\Microsoft\Outlook."
			$speak.Speak("Outlook settings backed up. 98 percent complete.")
			#The Ribbon and QAT settings in Outlook 2010, Outlook 2013 and Outlook 2016 are stored in officeUI-files in the following folder
			Robocopy $source\AppData\Local\Microsoft\Office $dest\AppData\Local\Microsoft\Office *.* /E /ZB /J /LOG+:$source\desktop\backuplog.txt
			$richtextbox1.Text += "`nThe Ribbon and QAT settings in Outlook have been backed up."
			$speak.Speak("The Ribbon and QAT settings in Outlook have been backed up. 99 percent complete.")
			$ProgressBar1.Value = "100"
			$richtextbox1.Text += "`nPlease check the log file for verification of file transfers. Located: $source\desktop\backuplog.txt."
			$speak.Speak("All selected directories completed backing up. ")
			$result = [System.Windows.Forms.MessageBox]::Show('This Operation Completed Successfully!', 'Warning', 'OK', 'Warning')
			$result		
		}
		Else
		{
			$speak.Speak("No joy. I was unable to locate the directory you specified. Please check your path and try again.")
			$result = [System.Windows.Forms.MessageBox]::Show('Unable to reach souce location!', 'Warning', 'YesNo', 'Warning')
			$result
		}
	}
	
	
	$buttonInitiateTheBackupPro_Click={
		backupDirectory
	}
	
	$buttonDisplayInstalledProg_Click={
		Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Out-GridView
	}
	
	$buttonDisplayAllInstalledP_Click={
		control printers
	}
	
	$buttonDisplayCustomInvento_Click={
		Get-PSInventory
	}
	
	
	$buttonCopyLogsToClipboard_Click={
		#TODO: Place custom script here
		$copyText = $richtextbox1.Text
		
		[System.Windows.Forms.Clipboard]::SetText($copyText)
		
		if ([System.Windows.Forms.Clipboard]::ContainsText() -AND
			[System.Windows.Forms.Clipboard]::GetText() -eq $copyText)
		{
			$statusbar1.Text = "Copied to clipboard."
			$statusbar1.Visible = $true
			Start-Sleep -Seconds 2
			$statusbar1.Visible = $false
		}
	}
	
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formProfileBackup.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonCopyLogsToClipboard.remove_Click($buttonCopyLogsToClipboard_Click)
			$buttonDisplayInstalledProg.remove_Click($buttonDisplayInstalledProg_Click)
			$buttonDisplayCustomInvento.remove_Click($buttonDisplayCustomInvento_Click)
			$buttonDisplayAllInstalledP.remove_Click($buttonDisplayAllInstalledP_Click)
			$buttonInitiateTheBackupPro.remove_Click($buttonInitiateTheBackupPro_Click)
			$formProfileBackup.remove_Load($formProfileBackup_Load)
			$formProfileBackup.remove_Load($Form_StateCorrection_Load)
			$formProfileBackup.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formProfileBackup.SuspendLayout()
	$Info.SuspendLayout()
	$groupbox3.SuspendLayout()
	$groupbox2.SuspendLayout()
	#
	# formProfileBackup
	#
	$formProfileBackup.Controls.Add($statusbar1)
	$formProfileBackup.Controls.Add($buttonCopyLogsToClipboard)
	$formProfileBackup.Controls.Add($labelByAlanNewingham)
	$formProfileBackup.Controls.Add($labelLog)
	$formProfileBackup.Controls.Add($labelCheckDirectoryYouWan)
	$formProfileBackup.Controls.Add($Info)
	$formProfileBackup.Controls.Add($labelProfileBackup007)
	$formProfileBackup.Controls.Add($buttonDisplayInstalledProg)
	$formProfileBackup.Controls.Add($buttonDisplayCustomInvento)
	$formProfileBackup.Controls.Add($buttonDisplayAllInstalledP)
	$formProfileBackup.Controls.Add($buttonInitiateTheBackupPro)
	$formProfileBackup.Controls.Add($progressbar1)
	$formProfileBackup.Controls.Add($groupbox3)
	$formProfileBackup.Controls.Add($groupbox2)
	$formProfileBackup.Controls.Add($richtextbox1)
	$formProfileBackup.AutoScaleDimensions = '6, 13'
	$formProfileBackup.AutoScaleMode = 'Font'
	$formProfileBackup.ClientSize = '705, 557'
	$formProfileBackup.Name = 'formProfileBackup'
	$formProfileBackup.Text = 'Profile Backup '
	$formProfileBackup.add_Load($formProfileBackup_Load)
	#
	# statusbar1
	#
	$statusbar1.Location = '0, 535'
	$statusbar1.Name = 'statusbar1'
	$statusbar1.Size = '705, 22'
	$statusbar1.TabIndex = 50
	$statusbar1.Text = 'statusbar1'
	#
	# buttonCopyLogsToClipboard
	#
	$buttonCopyLogsToClipboard.Location = '97, 503'
	$buttonCopyLogsToClipboard.Name = 'buttonCopyLogsToClipboard'
	$buttonCopyLogsToClipboard.Size = '157, 23'
	$buttonCopyLogsToClipboard.TabIndex = 49
	$buttonCopyLogsToClipboard.Text = 'Copy Logs to Clipboard'
	$buttonCopyLogsToClipboard.UseCompatibleTextRendering = $True
	$buttonCopyLogsToClipboard.UseVisualStyleBackColor = $True
	$buttonCopyLogsToClipboard.add_Click($buttonCopyLogsToClipboard_Click)
	#
	# labelByAlanNewingham
	#
	$labelByAlanNewingham.AutoSize = $True
	$labelByAlanNewingham.Location = '588, 9'
	$labelByAlanNewingham.Name = 'labelByAlanNewingham'
	$labelByAlanNewingham.Size = '106, 17'
	$labelByAlanNewingham.TabIndex = 48
	$labelByAlanNewingham.Text = 'By Alan Newingham'
	$labelByAlanNewingham.UseCompatibleTextRendering = $True
	#
	# labelLog
	#
	$labelLog.AutoSize = $True
	$labelLog.Location = '276, 34'
	$labelLog.Name = 'labelLog'
	$labelLog.Size = '26, 17'
	$labelLog.TabIndex = 47
	$labelLog.Text = 'Log:'
	$labelLog.UseCompatibleTextRendering = $True
	#
	# labelCheckDirectoryYouWan
	#
	$labelCheckDirectoryYouWan.AutoSize = $True
	$labelCheckDirectoryYouWan.Location = '270, 54'
	$labelCheckDirectoryYouWan.Name = 'labelCheckDirectoryYouWan'
	$labelCheckDirectoryYouWan.Size = '0, 16'
	$labelCheckDirectoryYouWan.TabIndex = 46
	$labelCheckDirectoryYouWan.UseCompatibleTextRendering = $True
	#
	# Info
	#
	$Info.Controls.Add($labelenvUserName)
	$Info.Controls.Add($labelOSInstallDate)
	$Info.Controls.Add($labelenvCOMPUTERNAME)
	$Info.Controls.Add($labelAuthenticatedUser)
	$Info.Controls.Add($labelInstDate)
	$Info.Controls.Add($labelWindowsUser)
	$Info.Controls.Add($label1)
	$Info.Controls.Add($labelDeviceName)
	$Info.Location = '9, 314'
	$Info.Name = 'Info'
	$Info.Size = '245, 100'
	$Info.TabIndex = 44
	$Info.TabStop = $False
	$Info.Text = 'Information'
	$Info.UseCompatibleTextRendering = $True
	#
	# labelenvUserName
	#
	$labelenvUserName.AutoSize = $True
	$labelenvUserName.Location = '119, 57'
	$labelenvUserName.Name = 'labelenvUserName'
	$labelenvUserName.Size = '86, 17'
	$labelenvUserName.TabIndex = 36
	$labelenvUserName.Text = "$env:UserName"
	$labelenvUserName.UseCompatibleTextRendering = $True
	#
	# labelOSInstallDate
	#
	$labelOSInstallDate.AutoSize = $True
	$labelOSInstallDate.Location = '30, 74'
	$labelOSInstallDate.Name = 'labelOSInstallDate'
	$labelOSInstallDate.Size = '83, 17'
	$labelOSInstallDate.TabIndex = 43
	$labelOSInstallDate.Text = 'OS Install Date:'
	$labelOSInstallDate.UseCompatibleTextRendering = $True
	#
	# labelenvCOMPUTERNAME
	#
	$labelenvCOMPUTERNAME.AutoSize = $True
	$labelenvCOMPUTERNAME.Location = '119, 40'
	$labelenvCOMPUTERNAME.Name = 'labelenvCOMPUTERNAME'
	$labelenvCOMPUTERNAME.Size = '87, 17'
	$labelenvCOMPUTERNAME.TabIndex = 35
	$labelenvCOMPUTERNAME.Text = "$LoggedOnUser"
	$labelenvCOMPUTERNAME.UseCompatibleTextRendering = $True
	#
	# labelAuthenticatedUser
	#
	$labelAuthenticatedUser.AutoSize = $True
	$labelAuthenticatedUser.Location = '9, 57'
	$labelAuthenticatedUser.Name = 'labelAuthenticatedUser'
	$labelAuthenticatedUser.Size = '104, 17'
	$labelAuthenticatedUser.TabIndex = 42
	$labelAuthenticatedUser.Text = 'Authenticated User:'
	$labelAuthenticatedUser.UseCompatibleTextRendering = $True
	#
	# labelInstDate
	#
	$labelInstDate.AutoSize = $True
	$labelInstDate.Location = '119, 74'
	$labelInstDate.Name = 'labelInstDate'
	$labelInstDate.Size = '53, 17'
	$labelInstDate.TabIndex = 37
	$labelInstDate.Text = "$InstDate"
	$labelInstDate.UseCompatibleTextRendering = $True
	#
	# labelWindowsUser
	#
	$labelWindowsUser.AutoSize = $True
	$labelWindowsUser.Location = '33, 40'
	$labelWindowsUser.Name = 'labelWindowsUser'
	$labelWindowsUser.Size = '80, 17'
	$labelWindowsUser.TabIndex = 41
	$labelWindowsUser.Text = 'Windows User:'
	$labelWindowsUser.UseCompatibleTextRendering = $True
	#
	# label1
	#
	$label1.AutoSize = $True
	$label1.Location = '119, 23'
	$label1.Name = 'label1'
	$label1.Size = '112, 17'
	$label1.TabIndex = 39
	$label1.Text = "$env:ComputerName"
	$label1.UseCompatibleTextRendering = $True
	#
	# labelDeviceName
	#
	$labelDeviceName.AutoSize = $True
	$labelDeviceName.Location = '39, 22'
	$labelDeviceName.Name = 'labelDeviceName'
	$labelDeviceName.Size = '75, 17'
	$labelDeviceName.TabIndex = 40
	$labelDeviceName.Text = 'Device Name:'
	$labelDeviceName.UseCompatibleTextRendering = $True
	#
	# labelProfileBackup007
	#
	$labelProfileBackup007.AutoSize = $True
	$labelProfileBackup007.Location = '300, 9'
	$labelProfileBackup007.Name = 'labelProfileBackup007'
	$labelProfileBackup007.Size = '105, 17'
	$labelProfileBackup007.TabIndex = 38
	$labelProfileBackup007.Text = 'Profile Backup 0.0.7'
	$labelProfileBackup007.UseCompatibleTextRendering = $True
	#
	# buttonDisplayInstalledProg
	#
	$buttonDisplayInstalledProg.Location = '97, 483'
	$buttonDisplayInstalledProg.Name = 'buttonDisplayInstalledProg'
	$buttonDisplayInstalledProg.Size = '157, 23'
	$buttonDisplayInstalledProg.TabIndex = 34
	$buttonDisplayInstalledProg.Text = 'Display Installed Programs'
	$buttonDisplayInstalledProg.UseCompatibleTextRendering = $True
	$buttonDisplayInstalledProg.UseVisualStyleBackColor = $True
	$buttonDisplayInstalledProg.add_Click($buttonDisplayInstalledProg_Click)
	#
	# buttonDisplayCustomInvento
	#
	$buttonDisplayCustomInvento.Location = '97, 441'
	$buttonDisplayCustomInvento.Name = 'buttonDisplayCustomInvento'
	$buttonDisplayCustomInvento.Size = '157, 23'
	$buttonDisplayCustomInvento.TabIndex = 33
	$buttonDisplayCustomInvento.Text = 'Display Custom Inventory'
	$buttonDisplayCustomInvento.UseCompatibleTextRendering = $True
	$buttonDisplayCustomInvento.UseVisualStyleBackColor = $True
	$buttonDisplayCustomInvento.add_Click($buttonDisplayCustomInvento_Click)
	#
	# buttonDisplayAllInstalledP
	#
	$buttonDisplayAllInstalledP.Location = '97, 463'
	$buttonDisplayAllInstalledP.Name = 'buttonDisplayAllInstalledP'
	$buttonDisplayAllInstalledP.Size = '157, 23'
	$buttonDisplayAllInstalledP.TabIndex = 32
	$buttonDisplayAllInstalledP.Text = 'Display all Installed Printers'
	$buttonDisplayAllInstalledP.UseCompatibleTextRendering = $True
	$buttonDisplayAllInstalledP.UseVisualStyleBackColor = $True
	$buttonDisplayAllInstalledP.add_Click($buttonDisplayAllInstalledP_Click)
	#
	# buttonInitiateTheBackupPro
	#
	$buttonInitiateTheBackupPro.Location = '97, 419'
	$buttonInitiateTheBackupPro.Name = 'buttonInitiateTheBackupPro'
	$buttonInitiateTheBackupPro.Size = '157, 25'
	$buttonInitiateTheBackupPro.TabIndex = 31
	$buttonInitiateTheBackupPro.Text = 'Initiate the Backup Process'
	$buttonInitiateTheBackupPro.UseCompatibleTextRendering = $True
	$buttonInitiateTheBackupPro.UseVisualStyleBackColor = $True
	$buttonInitiateTheBackupPro.add_Click($buttonInitiateTheBackupPro_Click)
	#
	# progressbar1
	#
	$progressbar1.Location = '276, 503'
	$progressbar1.Name = 'progressbar1'
	$progressbar1.Size = '431, 32'
	$progressbar1.TabIndex = 30
	#
	# groupbox3
	#
	$groupbox3.Controls.Add($checkboxOneDrive)
	$groupbox3.Controls.Add($checkboxCustomDirectory)
	$groupbox3.Controls.Add($textbox7)
	$groupbox3.Controls.Add($checkboxQuickparts)
	$groupbox3.Controls.Add($checkboxBrowsers)
	$groupbox3.Controls.Add($checkboxVideos)
	$groupbox3.Controls.Add($checkboxPictures)
	$groupbox3.Controls.Add($checkboxDocuments)
	$groupbox3.Controls.Add($checkboxDownloads)
	$groupbox3.Controls.Add($checkboxDesktop)
	$groupbox3.Location = '9, 109'
	$groupbox3.Name = 'groupbox3'
	$groupbox3.Size = '246, 199'
	$groupbox3.TabIndex = 29
	$groupbox3.TabStop = $False
	$groupbox3.Text = 'Directories'
	$groupbox3.UseCompatibleTextRendering = $True
	#
	# checkboxOneDrive
	#
	$checkboxOneDrive.Location = '6, 153'
	$checkboxOneDrive.Name = 'checkboxOneDrive'
	$checkboxOneDrive.Size = '104, 24'
	$checkboxOneDrive.TabIndex = 37
	$checkboxOneDrive.Text = 'OneDrive'
	$checkboxOneDrive.UseCompatibleTextRendering = $True
	$checkboxOneDrive.UseVisualStyleBackColor = $True
	#
	# checkboxCustomDirectory
	#
	$checkboxCustomDirectory.Location = '6, 172'
	$checkboxCustomDirectory.Name = 'checkboxCustomDirectory'
	$checkboxCustomDirectory.Size = '122, 24'
	$checkboxCustomDirectory.TabIndex = 36
	$checkboxCustomDirectory.Text = 'Custom Directory'
	$checkboxCustomDirectory.UseCompatibleTextRendering = $True
	$checkboxCustomDirectory.UseVisualStyleBackColor = $True
	#
	# textbox7
	#
	$textbox7.Location = '134, 172'
	$textbox7.Name = 'textbox7'
	$textbox7.Size = '100, 20'
	$textbox7.TabIndex = 35
	#
	# checkboxQuickparts
	#
	$checkboxQuickparts.Location = '6, 76'
	$checkboxQuickparts.Name = 'checkboxQuickparts'
	$checkboxQuickparts.Size = '109, 24'
	$checkboxQuickparts.TabIndex = 34
	$checkboxQuickparts.Text = 'Quickparts'
	$checkboxQuickparts.UseCompatibleTextRendering = $True
	$checkboxQuickparts.UseVisualStyleBackColor = $True
	#
	# checkboxBrowsers
	#
	$checkboxBrowsers.Location = '6, 134'
	$checkboxBrowsers.Name = 'checkboxBrowsers'
	$checkboxBrowsers.Size = '104, 24'
	$checkboxBrowsers.TabIndex = 33
	$checkboxBrowsers.Text = 'Browsers'
	$checkboxBrowsers.UseCompatibleTextRendering = $True
	$checkboxBrowsers.UseVisualStyleBackColor = $True
	#
	# checkboxVideos
	#
	$checkboxVideos.Location = '6, 57'
	$checkboxVideos.Name = 'checkboxVideos'
	$checkboxVideos.Size = '104, 24'
	$checkboxVideos.TabIndex = 32
	$checkboxVideos.Text = 'Videos'
	$checkboxVideos.UseCompatibleTextRendering = $True
	$checkboxVideos.UseVisualStyleBackColor = $True
	#
	# checkboxPictures
	#
	$checkboxPictures.Location = '6, 115'
	$checkboxPictures.Name = 'checkboxPictures'
	$checkboxPictures.Size = '104, 24'
	$checkboxPictures.TabIndex = 31
	$checkboxPictures.Text = 'Pictures'
	$checkboxPictures.UseCompatibleTextRendering = $True
	$checkboxPictures.UseVisualStyleBackColor = $True
	#
	# checkboxDocuments
	#
	$checkboxDocuments.Location = '6, 96'
	$checkboxDocuments.Name = 'checkboxDocuments'
	$checkboxDocuments.Size = '104, 24'
	$checkboxDocuments.TabIndex = 30
	$checkboxDocuments.Text = 'Documents'
	$checkboxDocuments.UseCompatibleTextRendering = $True
	$checkboxDocuments.UseVisualStyleBackColor = $True
	#
	# checkboxDownloads
	#
	$checkboxDownloads.Location = '6, 38'
	$checkboxDownloads.Name = 'checkboxDownloads'
	$checkboxDownloads.Size = '104, 24'
	$checkboxDownloads.TabIndex = 29
	$checkboxDownloads.Text = 'Downloads'
	$checkboxDownloads.UseCompatibleTextRendering = $True
	$checkboxDownloads.UseVisualStyleBackColor = $True
	#
	# checkboxDesktop
	#
	$checkboxDesktop.Location = '6, 19'
	$checkboxDesktop.Name = 'checkboxDesktop'
	$checkboxDesktop.Size = '104, 27'
	$checkboxDesktop.TabIndex = 28
	$checkboxDesktop.Text = 'Desktop'
	$checkboxDesktop.UseCompatibleTextRendering = $True
	$checkboxDesktop.UseVisualStyleBackColor = $True
	#
	# groupbox2
	#
	$groupbox2.Controls.Add($textbox1)
	$groupbox2.Controls.Add($textbox2)
	$groupbox2.Controls.Add($labelFromLocation)
	$groupbox2.Controls.Add($labelToLocation)
	$groupbox2.Location = '9, 27'
	$groupbox2.Name = 'groupbox2'
	$groupbox2.Size = '245, 76'
	$groupbox2.TabIndex = 28
	$groupbox2.TabStop = $False
	$groupbox2.Text = 'Locations'
	$groupbox2.UseCompatibleTextRendering = $True
	#
	# textbox1
	#
	$textbox1.Location = '102, 19'
	$textbox1.Name = 'textbox1'
	$textbox1.Size = '128, 20'
	$textbox1.TabIndex = 1
	#
	# textbox2
	#
	$textbox2.Location = '102, 45'
	$textbox2.Name = 'textbox2'
	$textbox2.Size = '128, 20'
	$textbox2.TabIndex = 2
	#
	# labelFromLocation
	#
	$labelFromLocation.AutoSize = $True
	$labelFromLocation.Location = '7, 22'
	$labelFromLocation.Name = 'labelFromLocation'
	$labelFromLocation.Size = '77, 17'
	$labelFromLocation.TabIndex = 11
	$labelFromLocation.Text = 'From Location'
	$labelFromLocation.UseCompatibleTextRendering = $True
	#
	# labelToLocation
	#
	$labelToLocation.AutoSize = $True
	$labelToLocation.Location = '7, 48'
	$labelToLocation.Name = 'labelToLocation'
	$labelToLocation.Size = '63, 17'
	$labelToLocation.TabIndex = 12
	$labelToLocation.Text = 'To Location'
	$labelToLocation.UseCompatibleTextRendering = $True
	#
	# richtextbox1
	#
	$richtextbox1.Location = '276, 54'
	$richtextbox1.Name = 'richtextbox1'
	$richtextbox1.Size = '431, 453'
	$richtextbox1.TabIndex = 7
	$richtextbox1.Text = ''
	#
	# tooltip1
	#
	$groupbox2.ResumeLayout()
	$groupbox3.ResumeLayout()
	$Info.ResumeLayout()
	$formProfileBackup.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formProfileBackup.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formProfileBackup.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formProfileBackup.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $formProfileBackup.ShowDialog()

} #End Function

#Call the form
Show-gddgfhdfghgfdh_psf | Out-Null
