--[[
$$$$$$$\                                                 $$$$$$\              $$\                     $$$$$$$\  $$\                     
$$  __$$\                                               $$  __$$\             $$ |                    $$  __$$\ $$ |                    
$$ |  $$ | $$$$$$\   $$$$$$\   $$$$$$\   $$$$$$$\       $$ /  $$ |$$\   $$\ $$$$$$\    $$$$$$\        $$ |  $$ |$$ | $$$$$$\  $$\   $$\ 
$$ |  $$ |$$  __$$\ $$  __$$\ $$  __$$\ $$  _____|      $$$$$$$$ |$$ |  $$ |\_$$  _|  $$  __$$\       $$$$$$$  |$$ | \____$$\ $$ |  $$ |
$$ |  $$ |$$ /  $$ |$$ /  $$ |$$ |  \__|\$$$$$$\        $$  __$$ |$$ |  $$ |  $$ |    $$ /  $$ |      $$  ____/ $$ | $$$$$$$ |$$ |  $$ |
$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |       \____$$\       $$ |  $$ |$$ |  $$ |  $$ |$$\ $$ |  $$ |      $$ |      $$ |$$  __$$ |$$ |  $$ |
$$$$$$$  |\$$$$$$  |\$$$$$$  |$$ |      $$$$$$$  |      $$ |  $$ |\$$$$$$  |  \$$$$  |\$$$$$$  |      $$ |      $$ |\$$$$$$$ |\$$$$$$$ |
\_______/  \______/  \______/ \__|      \_______/       \__|  \__| \______/    \____/  \______/       \__|      \__| \_______| \____$$ |
                                                                                                                              $$\   $$ |
                                                                                                                              \$$$$$$  |
                                                                                                                               \______/
]]--

--[ [X] > Made By Kurama#0521 < [X] ]--
--[ [O] >  Thanks To Geodude  < [O] ]--

--// Services \\--
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")

--// Variables \\--
local GameData = ReplicatedStorage.GameData

local LocalPlayer = Players.LocalPlayer

local Settings = {
    ["EnterRooms"] = false,
    ["AutoBuy"] = true
}

--// Core \\--
local Api = {
    ["Settings"] = Settings
}

for _, v in next, getconnections(LocalPlayer.Idled) do
    pcall(function()
        v.Disable(v)
    end)
    pcall(function()
        v.Disconnect(v)
    end)
end

if workspace:FindFirstChild("Path") then
    workspace.Path:Destroy()
end

local PathFolder = Instance.new("Folder")
PathFolder.Name = "Path"
PathFolder.Parent = workspace

repeat
    task.wait()
until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")

function Api.CreateVisualWaypoints(Waypoints)
    for _, Waypoint in next, Waypoints do
        local Part = Instance.new("Part")
        Part.Shape = Enum.PartType.Ball
        Part.Size = Vector3.new(1, 1, 1)
        Part.Position = Waypoint.Position
        Part.Material = Enum.Material.SmoothPlastic
        Part.Anchored = true
        Part.CanCollide = false
        Part.Parent = PathFolder
    end
end

function Api.MoveTo(Destination)
    local Character = LocalPlayer.Character
    local Humanoid = Character:FindFirstChild("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    local Path = PathfindingService:CreatePath({
        ["WaypointSpacing"] = 1,
        ["AgentRadius"] = 0.5,
        ["AgentCanJump"] = false
    })

    Path:ComputeAsync(HumanoidRootPart.Position - Vector3.new(0, 3, 0), Destination.Position)

    if Path.Status ~= Enum.PathStatus.NoPath then
        PathFolder:ClearAllChildren()

        local Waypoints = Path:GetWaypoints()

        Api.CreateVisualWaypoints(Waypoints)

        for _, Waypoint in next, Waypoints do
            if not HumanoidRootPart.Anchored then
                Humanoid:MoveTo(Waypoint.Position)
                Humanoid.MoveToFinished:Wait()
            end
        end
    end
end

if game.PlaceId == 6516141723 then
    for _, Elevator in next, workspace.Lobby.LobbyElevators:GetChildren() do
        
    end
end