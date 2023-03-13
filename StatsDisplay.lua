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

local Label = Instance.new("TextLabel")
Label.Name = "15875ed6218f8d05d0924dcbbb1bdd7bb40d263cee8bf3ed06f9855c04638b4e"
Label.BackgroundTransparency = 1
Label.BorderSizePixel = 0
Label.AnchorPoint = Vector2.new(1, 0)
Label.Position = UDim2.new(1, -10, 0, 10)
Label.Size = UDim2.fromOffset(200, 20)
Label.TextColor3 = Color3.new(1, 1, 1)
Label.TextSize = 20
Label.TextStrokeColor3 = Color3.fromRGB(61, 61, 61)
Label.TextStrokeTransparency = 0
Label.TextXAlignment = Enum.TextXAlignment.Right
Label.Font = Enum.Font.Cartoon
Label.Text = "Ping: 1ms"
Label.Parent = game:GetService("CoreGui").RobloxGui

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

        local Ping = "Ping: " .. math.floor(tonumber(Stats:FindFirstChild("PerformanceStats").Ping:GetValue())) .. "ms"
        local Fps = "Fps: " .. tostring(math.floor(time() - Start >= 1 and #FrameUpdateTable or #FrameUpdateTable / (time() - Start))) .. "/s"
        Label.Text = Ping .. " | " .. Fps
    end)
end)