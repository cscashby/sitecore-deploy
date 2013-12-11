# -- Install IIS and necessary prerequisites (defined in ..\configs\DeploymentConfigTemplate.xml)
# Install-WindowsFeature -ConfigurationFilePath ..\configs\DeploymentConfigTemplate.xml -Restart

# -- We're probably on a performance cloud server, which starts with an offline disk; initialise it and partition as D:
#Get-Disk |
#	Where-Object -FilterScript {
#		$_.IsOffline -Eq $true
#	} |
#		ForEach-Object {
#			$diskNumber = $_.Number
#			write-host "Setting disk $($diskNumber) as not readonly" -ForegroundColor "Green"
#			Set-Disk -Number $diskNumber -IsReadOnly $false
#           write-host "Setting disk $($diskNumber) as online" -ForegroundColor "Green"
#			Set-Disk -Number $diskNumber -IsOffline $false			
#           try {
#				Get-Partition -DiskNumber $diskNumber |
#					ForEach-Object {
#						write-host "Removing partition $($_.PartitionNumber)" -ForegroundColor "Green"
#						Remove-Partition -PartitionNumber $_.PartitionNumber -DiskNumber $diskNumber -Confirm:$false
#					}
#			} catch {
#				write-host "Caught an exception:" -ForegroundColor "Red"
#				write-host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor "Red"
#				write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor "Red"
#			}
#			write-host -ForegroundColor "Green" "Creating D in $($diskNumber)" 
#			New-Partition -DiskNumber $diskNumber -UseMaximumSize -DriveLetter D
#		}

Import-Module WebAdministration
