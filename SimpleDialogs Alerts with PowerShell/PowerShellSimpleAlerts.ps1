If ($MyInvocation.MyCommand.CommandType -eq "ExternalScript") {
    $ScriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
} Else {
    $ScriptPath = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
}

[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')               | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework')              | Out-Null
[System.Reflection.Assembly]::LoadFrom($ScriptPath + '\assembly\MahApps.Metro.dll')     | Out-Null
[System.Reflection.Assembly]::LoadFrom($ScriptPath + '\assembly\SimpleDialogs.dll')     | Out-Null

function LoadXml ($filename){
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

$XamlMainWindow=LoadXml($ScriptPath + "\PowerShellSimpleAlertsGUI.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)

### AUTOFIND ALL CONTROLS ###
$XAMLMainWindow.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]")  | ForEach-Object { 
	New-Variable -Name $_.Name -Value $Form.FindName($_.Name) -Force 
}

$btnMessage.Add_Click({
	$Alert = [SimpleDialogs.Controls.MessageDialog]::new()
	$Alert.MessageSeverity = "Information"
	$Alert.Title = "Title Here"
	#$Alert.DialogWidth = "400"
	#$Alert.DialogHeight = "200"
	$Alert.FontSize = "12"
	$Alert.FontWeight = "Bold"
	$Alert.ShowFirstButton  = $True
	$Alert.ShowSecondButton = $True
	$Alert.ShowThirdButton = $False
	$Alert.TitleForeground = "White"		
	$Alert.Message = "Message Here"

	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Alert)
})

$btnInput.Add_Click({
	$Alert = [SimpleDialogs.Controls.InputDialog]::new()
	$Alert.SecondsToAutoClose = 5
	#$Alert.Text = "Text"
	$Alert.Description = "Label Text"	
	$Alert.Title = "Title Here"
	$Alert.Watermark = "Watermark Text" 
	$Alert.ShowFirstButton  = $True
	$Alert.ShowSecondButton = $True
	$Alert.TitleForeground = "White"	
	
	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Alert)
})

$btnProgress.Add_Click({
	$Alert = [SimpleDialogs.Controls.ProgressDialog]::new()			
	$Alert.Message = "Please wait..."
	$Alert.Title = "Working..."
	$Alert.TitleForeground = "White"		
	
	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Alert)
})

$btnSuccess.Add_Click({
	$Alert = [SimpleDialogs.Controls.MessageDialog]::new()
	$Alert.MessageSeverity = "Success"
	$Alert.Title = "Title Here"
	$Alert.ShowFirstButton  = $True
	$Alert.ShowSecondButton = $True
	$Alert.TitleForeground = "White"		
	$Alert.Message = "Message Here"

	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Alert)
})

$btnCritical.Add_Click({
	$Alert = [SimpleDialogs.Controls.MessageDialog]::new()
	$Alert.MessageSeverity = "Critical"
	$Alert.Title = "Title Here"
	$Alert.ShowFirstButton  = $True
	$Alert.ShowSecondButton = $True
	$Alert.TitleForeground = "White"		
	$Alert.Message = "Message Here"

	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Alert)
})

$btnError.Add_Click({
	$Alert = [SimpleDialogs.Controls.MessageDialog]::new()
	$Alert.MessageSeverity = "Error"
	$Alert.Title = "Title Here"
	$Alert.ShowFirstButton  = $True
	$Alert.ShowSecondButton = $True
	$Alert.TitleForeground = "White"		
	$Alert.Message = "Message Here"

	[SimpleDialogs.DialogManager]::ShowDialogAsync($Form, $Alert)
})

$Form.ShowDialog() | Out-Null
