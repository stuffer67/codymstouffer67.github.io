Add-Type -AssemblyName System.Windows.Forms

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Check PasswordLastSet"
$form.Size = New-Object System.Drawing.Size(350,150)
$form.StartPosition = "CenterScreen"

# Create label
$label = New-Object System.Windows.Forms.Label
$label.Text = "Enter username:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10,20)
$form.Controls.Add($label)

# Create textbox
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(120,18)
$textBox.Width = 180
$form.Controls.Add($textBox)

# Create button
$button = New-Object System.Windows.Forms.Button
$button.Text = "Get PasswordLastSet"
$button.Width = 200   # Increase width to fit the full text
$button.Height = 30   # Optional: increase height for better spacing
$button.Location = New-Object System.Drawing.Point(70,60)
$form.Controls.Add($button)
# Button click event

$button.Add_Click({
    $username = $textBox.Text
    if (-not [string]::IsNullOrWhiteSpace($username)) {
        try {
            $user = Get-ADUser -Identity $username -Properties PasswordLastSet
            if ($user) {
                [System.Windows.Forms.MessageBox]::Show("Password Last Set: $($user.PasswordLastSet)", "Result")
            } else {
                [System.Windows.Forms.MessageBox]::Show("User not found.", "Error")
            }
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Error retrieving user: $_", "Error")
        }
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please enter a username.", "Input Required")
    }
})

# Show form
$form.Topmost = $true
$form.Add_Shown({$textBox.Focus()})
[void]$form.ShowDialog()
