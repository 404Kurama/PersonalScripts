repeat
    task.wait()
until game:IsLoaded()

--// Services \\--
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

--// Core \\--
if game:GetService("CoreGui").RobloxGui:FindFirstChild("15875ed6218f8d05d0924dcbbb1bdd7bb40d263cee8bf3ed06f9855c04638b4e") then
    game:GetService("CoreGui").RobloxGui:FindFirstChild("15875ed6218f8d05d0924dcbbb1bdd7bb40d263cee8bf3ed06f9855c04638b4e"):Destroy()
end

if game:GetService("CoreGui").RobloxGui:FindFirstChild("05b9fe6f356a4c18032b9e75760cf8637fa2ba253f45326291e3c53718efa55f") then
    game:GetService("CoreGui").RobloxGui:FindFirstChild("05b9fe6f356a4c18032b9e75760cf8637fa2ba253f45326291e3c53718efa55f"):Destroy()
end

local PingLabel = Instance.new("TextLabel")
PingLabel.Name = "15875ed6218f8d05d0924dcbbb1bdd7bb40d263cee8bf3ed06f9855c04638b4e"
PingLabel.BackgroundTransparency = 1
PingLabel.BorderSizePixel = 0
PingLabel.Position = UDim2.fromOffset(15, 0)
PingLabel.Size = UDim2.fromOffset(200, 20)
PingLabel.TextColor3 = Color3.new(1, 1, 1)
PingLabel.TextSize = 20
PingLabel.TextStrokeColor3 = Color3.fromRGB(61, 61, 61)
PingLabel.TextStrokeTransparency = 0
PingLabel.TextXAlignment = Enum.TextXAlignment.Left
PingLabel.Font = Enum.Font.Cartoon
PingLabel.Text = "Ping: 1ms"
PingLabel.Parent = game:GetService("CoreGui").RobloxGui

local FpsLabel = PingLabel:Clone()
FpsLabel.Name = "05b9fe6f356a4c18032b9e75760cf8637fa2ba253f45326291e3c53718efa55f"
FpsLabel.Position = UDim2.fromOffset(15, 20)
FpsLabel.Text = "Fps: 1/s"
FpsLabel.Parent = game:GetService("CoreGui").RobloxGui

task.spawn(function()
    RunService.RenderStepped:Connect(function()
        task.wait(1)
        PingLabel.Text = "Ping: " .. math.floor(tonumber(Stats:FindFirstChild("PerformanceStats").Ping:GetValue())) .. "ms"
    end)
end)

-- https://devforum.roblox.com/t/get-client-fps-trough-a-script/282631/14
local LastIteration, Start
local FrameUpdateTable = {}

Start = time()
task.spawn(function()
    RunService.Heartbeat:Connect(function()
        LastIteration = time()

        for Index = #FrameUpdateTable, 1, -1 do
            FrameUpdateTable[Index + 1] = FrameUpdateTable[Index] >= LastIteration - 1 and FrameUpdateTable[Index] or nil
        end

        FrameUpdateTable[1] = LastIteration
        FpsLabel.Text = "Fps: " .. tostring(math.floor(time() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (time() - Start))) .. "/s"
    end)
end)