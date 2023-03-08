--[> Find The Memes <]--

--// Services \\--
local Players = game:GetService("Players")

--// Variables \\--
local LocalPlayer = Players.LocalPlayer
local PalsCollected = LocalPlayer:WaitForChild("palsCollected")

local Finish = true
local CharactersCache = {}
local CharactersFolder = workspace:WaitForChild("Pals")

--// Core \\--
local function GetCharacterData()
    Finish = true

    for _, v in next, CharactersFolder:GetChildren() do
        CharactersCache[v.Name] = PalsCollected:FindFirstChild(v.Name) and true or false

        if not PalsCollected:FindFirstChild(v.Name) or not CharactersCache[v.Name] then
            Finish = false
        end
    end
end

GetCharacterData()

while not Finish do
    task.wait()

    for Name, Check in next, CharactersCache do
        if not Check then
            pcall(function()
                LocalPlayer.Character:PivotTo(CharactersFolder:FindFirstChild(Name).CFrame)
            end)
            task.wait(0.1)
        end
    end

    GetCharacterData()
end