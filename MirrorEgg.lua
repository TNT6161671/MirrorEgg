local virus = {"RoSync", "getfenv", "function spread()", "Lag Script", "RSFfacility", "4D Being", "check.Size = check.Size + 1",
	"InfectedScript", "PSU Obfuscator", "market:PlayerOwnsAsset(v,", "lIIIllIIIIIIIIllIl", "loadstring", "local wat=", "ILIL",
	"Virus Protect", "VirusScript", "made by Studio", "luraph", "IronBrew", "SynapseXen"
}
local virusnames = {"fx", "FX", "Vaccine", "Virus", "VirusScript", "RSFfacility", "Virus Pack 4.5", "ROLF", "Snap Reducer", "4D Being", "Expire",
	"Thanks 2X", "Thanks For Using", "Mesher", "MeshLoader", "    ", " ", "  ", "   ", "OHAI", "No samurai plzzz", "C-REX", "LoaderScript"
}

-- Create Toolbar
local Toolbar = plugin:CreateToolbar("MirrorEgg")
local Button = Toolbar:CreateButton("Open", "Open", "rbxassetid://180084957")
local Opened = false

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")



-- Create Widget
local WidgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,
	false,
	false,
	300,
	300,
	300,
	300
)

local Widget = plugin:CreateDockWidgetPluginGui("MirrorEgg", WidgetInfo)
Widget.Title = "MirrorEgg"
local Main = script.Parent.Main
Main.Parent = Widget

local virusfound = 0
local versionnum = 12

-- Open/Close Widget
Button.Click:Connect(function()
	if Opened then
		Widget.Enabled = false
		Opened = false
	else
		Opened = true
		Widget.Enabled = true
	end
end)

local ScanButton = Main.ScanButton
local Template = Main.VirusFrame.Template
local VirusFrame = Main.VirusFrame
local VersionLabel = Main.VersionLabel
local VirusLabel = Main.VirusLabel
local SettingsButton = Main.SettingsButton
local SettingsFrame = Main.SettingsFrame
local RanBeforeLabelSettings = SettingsFrame.RanBeforeLabelSettings
local RemoveButton = Main.RemoveButton
local UpdateFrame = Main.UpdateFrame

VersionLabel.Text = ("Version ".. versionnum)

ScanButton.Size = (UDim2.new(0.918, 0, 0.076))
RemoveButton.Visible = false

local function CheckVersion()
		local stringver = ("".. versionnum)
		local latestver = HttpService:GetAsync("https://pastebin.com/raw/cNPzfxYW")
		if latestver == stringver then
		else
			UpdateFrame.Visible = true
		end
end

local function ScanGame()
	virusfound = 0
	VirusLabel.Text = (virusfound.. " Viruses found")
	for _, instance in pairs(VirusFrame:GetDescendants()) do
		if instance.Name == "TempCl" then
			instance:Destroy()
		end
	end
	local starttime = os.date()
	CheckVersion()
	ScanButton.Text = "Checking version.."
	wait(0.5)
	ScanButton.Text = "Scanning.."
	VirusFrame.CanvasPosition = Vector2.new(0, 0)
	pcall(function()
		ScanButton.Size = (UDim2.new(0.918, 0, 0.076))
		RemoveButton.Visible = false
		-- source scanning
		for i,v in pairs(game:GetDescendants()) do
			if v:IsA("LuaSourceContainer") then
				wait(0.0001)
				ScanButton.Text = "Scanning ".. v:GetFullName()
				for i,word in pairs(virus) do
					if v.Source:lower():find(word:lower()) then
						virusfound = virusfound + 1
						VirusLabel.Text = (virusfound.. " Viruses found")
						local tempclone = Template:Clone()
						tempclone.Visible = true
						tempclone.Name = "TempCl"
						tempclone.Parent = VirusFrame
						tempclone.NameLabel.Text = v.Name
						tempclone.ThreatLabel.Text = ("Threat: ".. word)
						
						RemoveButton.Visible = true
						ScanButton.Size = (UDim2.new(0.446, 0, 0.076))
						RemoveButton.MouseButton1Click:Connect(function()
							ScanButton.Size = (UDim2.new(0.918, 0, 0.076))
							RemoveButton.Visible = false
							v:Destroy()
							tempclone:Destroy()
						end)
						
						tempclone.OpenButton.MouseButton1Click:Connect(function()
							plugin:OpenScript(v)
						end)
						RemoveButton.MouseButton1Click:Connect(function()
							v:Destroy()
							tempclone:Destroy()
						end)
						v.AncestryChanged:Connect(function()
							tempclone:Destroy()
						end)
					end
				end
			end
		end
	end)
	
	pcall(function()
		for i,v in pairs(game:GetDescendants()) do
			if v:IsA("LuaSourceContainer") then
				wait(0.0001)
				for i,word in pairs(virusnames) do
					if v.Name == word then
						virusfound = virusfound + 1
						VirusLabel.Text = (virusfound.. " Viruses found")
						local tempclone = Template:Clone()
						tempclone.Visible = true
						tempclone.Name = "TempCl"
						tempclone.Parent = VirusFrame
						tempclone.NameLabel.Text = v.Name
						tempclone.ThreatLabel.Text = ("Threat: ".. word)
						
						RemoveButton.Visible = true
						ScanButton.Size = (UDim2.new(0.446, 0, 0.076))
						RemoveButton.MouseButton1Click:Connect(function()
							ScanButton.Size = (UDim2.new(0.918, 0, 0.076))
							RemoveButton.Visible = false
							v:Destroy()
							tempclone:Destroy()
						end)
						
						tempclone.RemoveButton.MouseButton1Click:Connect(function()
							v:Destroy()
							tempclone:Destroy()
						end)
						tempclone.OpenButton.MouseButton1Click:Connect(function()
							plugin:OpenScript(v)
						end)
						
						v.AncestryChanged:Connect(function()
							tempclone:Destroy()
						end)
					end
				end
			end
		end
		
	end)

	-- check if fe off
	ScanButton.Text = "Checking if FE is disabled.."
	if workspace.FilteringEnabled == false then
		local tempclone = Template:Clone()
		tempclone.Visible = true
		tempclone.Name = "TempCl"
		tempclone.Parent = VirusFrame
		tempclone.NameLabel.Text = "FE is disabled"
		tempclone.ThreatLabel.Text = ("Enable FilteringEnabled in Workspace")
		tempclone.RemoveButton.Text = "Fix"
		tempclone.RemoveButton:Destroy()
		tempclone.OpenButton:Destroy()
	end
	-- check if workspace name switched
	if workspace.Name == "Workspace" then
	else
		local tempclone = Template:Clone()
		tempclone.Visible = true
		tempclone.Name = "TempCl"
		tempclone.Parent = VirusFrame
		tempclone.NameLabel.Text = "Workspace name is changed"
		tempclone.ThreatLabel.Text = ("Workspace name is changed")
		tempclone.RemoveButton.Text = "Fix"
		tempclone.RemoveButton.MouseButton1Click:Connect(function()
			workspace.Name = "Workspace"
			tempclone:Destroy()
		end)
		tempclone.OpenButton:Destroy()
	end
	ScanButton.Text = "Scanning.."
	wait(0.5)
	ScanButton.Text = "Scan"
	VirusLabel.Text = (virusfound.. " Viruses found")
end


ScanButton.MouseButton1Click:Connect(function()
	ScanGame()
end)

local RanBefore = plugin:GetSetting("RanBefore")

if not RanBefore == true then
	plugin:SetSetting("RanBefore", true)
end

SettingsButton.MouseButton1Click:Connect(function()
	if SettingsFrame.Visible == false then
		SettingsFrame.Visible = true
	else
		SettingsFrame.Visible = false
	end
end)
if RanBefore == true then RanBeforeLabelSettings.Text = "RanBefore: true" else RanBeforeLabelSettings.Text = "RanBefore: false" end