# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Hide PowerShell Console
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)

#Word Array
$SeedWords = @('Acute', 'Admit', 'Alarm', 'Album', 'Alive', 
'Aloof', 'Amber', 'Angle', 'Arise', 'Asset', 
'Basil', 'Beard', 'Bench', 'Bland', 'Blank', 
'Brain', 'Brand', 'Cable', 'Carry', 'Cause', 
'Chair', 'Chart', 'Cheat', 'Cheek', 'Chest', 
'Chord', 'Class', 'Clean', 'Clear', 'Clerk', 
'Close', 'Count', 'Crash', 'Dirty', 'Disco', 
'Donor', 'Drain', 'Drill', 'Dusty', 'Eject', 
'Elbow', 'Elect', 'Fairy', 'Faith', 'Ferry', 
'Fibre', 'Field', 'Fight', 'First', 'Flash', 
'FlexBandit', 'Fling', 'Flour', 'Flush', 'Frame', 
'Fresh', 'Glove', 'Grain', 'Grant', 'Great', 
'Green', 'Guide', 'Gaunt', 'Hobby', 'Hyper', 
'Ideal', 'Jewel', 'Juice', 'Kneel', 'Leave', 
'Light', 'Linen', 'Liver', 'Lobby', 'March', 
'Mason', 'Means', 'Misty', 'Model', 'Month', 
'Nerve', 'Night', 'Noble', 'Noise', 'Novel', 
'Onion', 'Other', 'Panel', 'Pasta', 'Piano', 
'Pitch', 'Plead', 'Pride', 'Prize', 'Proof', 
'Ranch', 'Ready', 'Ridge', 'Robot', 'Rugby', 
'Rumor', 'Scene', 'Share', 'Shark', 'Shift', 
'Shock', 'Short', 'Shout', 'Sight', 'Skate', 
'Slide', 'Slime', 'Slump', 'Smell', 'Snail', 
'Speed', 'Spell', 'Spine', 'Spoil', 'Stain', 
'Steel', 'Straw', 'Stuff', 'Style', 'Sugar', 
'Sweat', 'Sweep', 'Swell', 'Teach', 'Tempt', 
'Terms', 'Theme', 'Touch', 'Tough', 'Trace', 
'Tract', 'Tread', 'Treat', 'Trial', 'Troop', 
'Trunk', 'Trust', 'Utter', 'Vague', 'Visit', 
'Visor', 'Waist', 'Widen', 'World', 'Wound')

$SeedSymbols = @('!' ,'#' ,'$' ,'%' ,'&' ,'*', '?') 

$Form                           = New-Object system.Windows.Forms.Form
$Form.ClientSize                = '400,150'
$Form.text                      = "BPG"
$Form.TopMost                   = $false
$Form.FormBorderStyle           = 'Fixed3D'
$Form.MaximizeBox               = $false


$Button                         = New-Object system.Windows.Forms.Button
$Button.text                    = "Generate"
$Button.width                   = 100
$Button.height                  = 40
$Button.location                = New-Object System.Drawing.Point(15, 95)
$Button.Font                    = 'Microsoft Sans Serif,10'

$PasswordOutput                 = New-Object system.Windows.Forms.TextBox
$PasswordOutput.multiline       = $false
$PasswordOutput.width           = 200
$PasswordOutput.height          = 20
$PasswordOutput.location        = New-Object System.Drawing.Point(100,40)
$PasswordOutput.Font            = 'Microsoft Sans Serif,10'
$PasswordOutput.ReadOnly        = $true

$PasswordLabel                  = New-Object system.Windows.Forms.Label
$PasswordLabel.text             = "Password"
$PasswordLabel.AutoSize         = $true
$PasswordLabel.width            = 25
$PasswordLabel.height           = 10
$PasswordLabel.location         = New-Object System.Drawing.Point(100,20)
$PasswordLabel.Font             = 'Microsoft Sans Serif,10'

$FlexBandit                     = New-Object system.Windows.Forms.Label
$FlexBandit.text                = "(flex)(bandit)"
$FlexBandit.AutoSize            = $true
$FlexBandit.width               = 25
$FlexBandit.height              = 10
$FlexBandit.location            = New-Object System.Drawing.Point(305,119)
$FlexBandit.Font                = 'Microsoft Sans Serif,10'
$FlexBandit.Visible             = $false

$Button.Add_Click(
{
 $GendWord = Get-Random -InputObject $SeedWords 
 $Digit1 = Get-Random -Minimum 0 -Maximum 9
 $Digit2 = Get-Random -Minimum 0 -Maximum 9
 $GendSymbol = Get-Random -InputObject $SeedSymbols 
 $GendPassword = $GendWord + "$Digit1" + "$Digit2" + $GendSymbol
 $PasswordOutput.Text = $GendPassword

 if($GendWord -eq 'FlexBandit'){
  $FlexBandit.Visible           = $true
 }
 else {
  $FlexBandit.Visible           = $false
 }
}
)

$Form.controls.AddRange(@($Button,$PasswordOutput,$PasswordLabel,$FlexBandit))

# Display the form
[void]$Form.ShowDialog()
