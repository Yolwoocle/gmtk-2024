local util = require "util"
local Class = require "class"
local discordRPC, discordAppId
local import_success
if pcall(function()
	discordRPC = require("lib.discordRPC.discordRPC")
	discordAppId = require("lib.discordRPC.applicationId")
end) then
	import_success = true
else
	import_success = false
end

-- Thanks to https://github.com/pfirsich/lua-discordRPC/tree/master?tab=readme-ov-file
-- And also https://github.com/discord/discord-rpc/ 
-- WARNING: Discord-RPC has been deprecated for a few years now, eventually migrate to Discord GameSDK:
-- https://discord.com/developers/docs/developer-tools/game-sdk
-- Lua binding: https://github.com/yutotakano/mpvcord 

local DiscordPresence = Class:inherit()

--[[
	`state`          string (max length: 127)
	`details`        string (max length: 127)
	`startTimestamp` integer (52 bit, signed)
	`endTimestamp`   integer (52 bit, signed)
	`largeImageKey`  string (max length: 31)
	`largeImageText` string (max length: 127)
	`smallImageKey`  string (max length: 31)
	`smallImageText` string (max length: 127)
	`partyId`        string (max length: 127)
	`partySize`      integer (32 bit, signed)
	`partyMax`       integer (32 bit, signed)
	`matchSecret`    string (max length: 127)
	`joinSecret`     string (max length: 127)
	`spectateSecret` string (max length: 127)
	`instance`       integer (8 bit, signed)
]]

function DiscordPresence:init()
	self.is_enabled = import_success

	if not self.is_enabled then
		print("DiscordRPC: error during import")
		return
	end

	local now = os.time(os.date("*t"))
	self.presence = {
        startTimestamp = now,
		largeImageKey = "gmtklogo",
		largeImageText = "GMTK Game Jam 2024",
    }
	self.next_presence_update = 0

	discordRPC.initialize(discordAppId, true)
end

function DiscordPresence:update(dt)
	if not self.is_enabled then
		return
	end

	self.presence.state = "Super game"
	self.presence.details = "Details"

	if self.next_presence_update < love.timer.getTime() then
        discordRPC.updatePresence(self.presence)
        self.next_presence_update = love.timer.getTime() + 3.0
    end
    discordRPC.runCallbacks()
end

function DiscordPresence:quit()
	discordRPC.shutdown()
end

function DiscordPresence:ready(user_id, username, discriminator, avatar)
	print(string.format("Discord RPC: ready (user_id %s, username %s, discriminator %s, avatar %s)", user_id, username, discriminator, avatar))
end

function DiscordPresence:disconnected(error_code, message)
    print(string.format("Discord: disconnected (error_code %d: %s)", error_code, message))
end

function DiscordPresence.errored(error_code, message)
    print(string.format("Discord: error (error_code %d: %s)", error_code, message))
end

local discord_instance = DiscordPresence:new()

if not import_success then
	return discord_instance
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DiscordRPC Callbacks
-------------------------------------------------------------------------------------------------------------------------------------------------------------

function discordRPC.ready(userId, username, discriminator, avatar)
    discord_instance:ready(userId, username, discriminator, avatar)
end

function discordRPC.disconnected(errorCode, message)
	discord_instance:disconnected(errorCode, message)
end

function discordRPC.errored(errorCode, message)
	discord_instance:errored(errorCode, message)
end

return discord_instance

