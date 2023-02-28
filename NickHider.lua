repeat
    task.wait()
until game:IsLoaded()

--// Services \\--
local Players = game:GetService("Players")

--// Variables \\--
local LocalPlayer = Players.LocalPlayer

local Settings = {
    ["0"] = {
        ["Name"] = "Error_999",
        ["UserId"] = "1"
    },
    ["4520749081"] = {
        ["Name"] = "NoobDino",
        ["UserId"] = "991117111"
    },
    ["6381829480"] = {
        ["Name"] = "NoobDino",
        ["UserId"] = "991117111"
    },
    ["5931540094"] = {
        ["Name"] = "NoobDino",
        ["UserId"] = "991117111"
    }
}

--// Core \\--
function HideNick(Object)
    local Setting = Settings[tostring(game.PlaceId)] or Settings["0"]
    
    local function Process(_Object, Property)
        _Object[Property] = _Object[Property]:gsub(LocalPlayer.Name, Setting["Name"])
        _Object[Property] = _Object[Property]:gsub(LocalPlayer.DisplayName, Setting["Name"])
        _Object[Property] = _Object[Property]:gsub(LocalPlayer.UserId, Setting["UserId"])
    end

    if Object:IsA("TextLabel") or Object:IsA("TextButton") then
        Process(Object, "Text")

        Object:GetPropertyChangedSignal("Text"):connect(function()
            Process(Object, "Text")
        end)
    end
    if Object:IsA("ImageLabel") then
        Process(Object, "Image")

        Object:GetPropertyChangedSignal("Image"):connect(function()
            Process(Object, "Image")
        end)
    end
end

for _, v in pairs(game:GetDescendants()) do
    HideNick(v)
end

game.DescendantAdded:Connect(HideNick)