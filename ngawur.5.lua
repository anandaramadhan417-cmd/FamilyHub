-- main_gag2_ui.lua - Grow A Garden 2 boot
-- 1) AntiAFK early (sebelum state) - skip loading screen + hide teleport prompt
-- 2) STATE inline dulu, HTTP fallback
-- 3) Module optional gagal tidak stop boot

----------------------------------------------------------------
-- SERVICES / BOOT GUARD
----------------------------------------------------------------
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LP = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
pcall(function() LP:WaitForChild("PlayerGui", 8) end)

local G = (getgenv and getgenv()) or _G

local BOOT_NAME = "GROW A GARDEN 2 V1"
local BOOT_RETRY = 3
local RETRY_DELAY = 2
local STATE_RETRY = 2
local STATE_RETRY_DELAY = 2
local DEBUG = (G.__GAG2_MAIN_DEBUG == true) or (_G.__GAG2_MAIN_DEBUG == true)

local function debuglog(...)
    if not DEBUG then return end
    warn("[" .. BOOT_NAME .. "][DEBUG]", ...)
end

local function warnlog(...)
    warn("[" .. BOOT_NAME .. "]", ...)
end

local function failBoot(msg)
    G.__GROWAGARDEN2_RUNNING = false
    G.__GAG2_READY = false
    _G.__GAG2_READY = false
    error("[" .. BOOT_NAME .. "] " .. tostring(msg), 0)
end

if G.__GROWAGARDEN2_RUNNING and G.__GAG2_READY then
    return true
end

G.__GROWAGARDEN2_RUNNING = true
G.__GAG2_READY = false
_G.__GAG2_READY = false

----------------------------------------------------------------
-- MODULE CONFIG (GAG2_* inline — panel replace saat serve)
----------------------------------------------------------------
local MODULE_DEFS = {
    { key = "MainUI",          name = "NodeHubNeonUI",    factory = function() -- NodeHubNeonUI.lua
-- UI Style B: Kuning - Hitam, Neon Glow, Sidebar kiri, Floating
-- Dibungkus jadi module "MainUI" supaya tab main & sub tab bisa di-file terpisah.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")
local TextService  = game:GetService("TextService") 

-- =========================
-- COLOR & STYLE CONFIG
-- =========================
local COLOR_BG        = Color3.fromRGB(5, 5, 5)
local COLOR_PANEL     = Color3.fromRGB(10, 10, 10)
local COLOR_PANEL_ALT = Color3.fromRGB(15, 15, 15)
local COLOR_YELLOW    = Color3.fromRGB(255, 211, 0) -- #FFD300
local COLOR_WHITE     = Color3.fromRGB(255, 255, 255)
local COLOR_GRAY_TEXT = Color3.fromRGB(180, 180, 180)

-- Row label color themes (use via ApplyRowLabelStyle / labelStyle on row helpers)
local ROW_LABEL_THEMES = {
    default = { color = COLOR_GRAY_TEXT, font = Enum.Font.Gotham, size = 12 },
    accent  = { color = COLOR_YELLOW, font = Enum.Font.GothamMedium, size = 12 },
    target  = { color = Color3.fromRGB(255, 200, 90), font = Enum.Font.GothamMedium, size = 12 },
    age     = { color = Color3.fromRGB(120, 210, 255), font = Enum.Font.GothamMedium, size = 12 },
    kg      = { color = Color3.fromRGB(130, 255, 175), font = Enum.Font.GothamMedium, size = 12 },
    filter  = { color = Color3.fromRGB(195, 155, 255), font = Enum.Font.GothamMedium, size = 12 },
    type    = { color = Color3.fromRGB(255, 145, 200), font = Enum.Font.GothamMedium, size = 12 },
    mode    = { color = Color3.fromRGB(255, 220, 110), font = Enum.Font.GothamMedium, size = 12 },
    list    = { color = Color3.fromRGB(170, 220, 255), font = Enum.Font.GothamMedium, size = 12 },
    info    = { color = Color3.fromRGB(145, 150, 160), font = Enum.Font.Gotham, size = 11 },
    section = { color = COLOR_YELLOW, font = Enum.Font.GothamBold, size = 11 },
    toggle  = { color = Color3.fromRGB(210, 210, 215), font = Enum.Font.GothamMedium, size = 12 },
}

local function applyRowLabelStyle(label, styleKeyOrOpts)
    if not label or not label:IsA("TextLabel") then
        return label
    end

    local cfg = ROW_LABEL_THEMES.default
    if type(styleKeyOrOpts) == "string" then
        cfg = ROW_LABEL_THEMES[styleKeyOrOpts] or ROW_LABEL_THEMES.default
    elseif type(styleKeyOrOpts) == "table" then
        cfg = styleKeyOrOpts... (2 MB left)
