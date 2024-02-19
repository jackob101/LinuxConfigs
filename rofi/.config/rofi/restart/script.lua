local restart_scripts_dir = os.getenv("HOME") .. "/.config/rofi/restart/restart_scripts/"

local restart_entries = {
  waybar = {
    name = "waybar",
    command = "killall waybar && waybar &",
  },
  portal = {
    name = "xdg portal",
    command = restart_scripts_dir .. "portal.sh &",
  },
}

local rofi_params = ""

for _, x in pairs(restart_entries) do
  rofi_params = rofi_params .. x.name .. "\n"
end

local rofi_response_handle = io.popen('echo -e "' .. rofi_params .. '" | rofi -dmenu -p testing')

if rofi_response_handle == nil then
  io.popen('notify-send -u critical Restart "rofi_handle is nil"')
  return
end

-- Clears new lines from rofi STDOUT
local rofi_response = string.gsub(rofi_response_handle:read("*a"), "\n", "")

for _, x in pairs(restart_entries) do
  if x.name == rofi_response then
    io.popen(x.command)
    io.popen('notify-send Restart "Restarted ' .. x.name .. '"')
    return
  end
end

io.popen('notify-send -u critical Restart "Selected entry does not exists in restart table"')
