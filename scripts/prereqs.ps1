Install-WindowsFeature -ConfigurationFilePath .\DeploymentConfigTemplate.xml -Restart

Get-Disk |
	Where-Object -FilterScript {
		$_.IsOffline -Eq $true
	} |
		ForEach-Object {
			$diskNumber = $_.Number
			write-host "Setting disk $($diskNumber) as not readonly" -ForegroundColor "Green"
			Set-Disk -Number $diskNumber -isReadOnly $false
			try {
				Get-Partition -DiskNumber $diskNumber |
					ForEach-Object {
						write-host "Removing partition $($_.PartitionNumber)" -ForegroundColor "Green"
						Remove-Partition -PartitionNumber $_.PartitionNumber -DiskNumber $diskNumber -Confirm:$false
					}
			} catch {
				write-host "Caught an exception:" -ForegroundColor "Red"
				write-host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor "Red"
				write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor "Red"
			}
			write-host -ForegroundColor "Green" "Creating D" 
			New-Partition -DiskNumber $diskNumber -UseMaximumSize -AssignDriveLetter -DriveLetter "D"
		}
