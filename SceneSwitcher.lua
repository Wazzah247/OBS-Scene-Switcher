obs = obslua

scene_a_name = ""
scene_b_name = ""
mode = "toggle"
hotkey_id = obs.OBS_INVALID_HOTKEY_ID

----------------------------------------------------------
-- Switch Scene Helper
----------------------------------------------------------
function set_scene(name)
    local target = obs.obs_get_source_by_name(name)
    if target ~= nil then
        obs.obs_frontend_set_current_scene(target)
        obs.obs_source_release(target)
    end
end

----------------------------------------------------------
-- Hotkey Logic
----------------------------------------------------------
function handle_hotkey(pressed)

    if mode == "toggle" then
        if not pressed then return end

        local current = obs.obs_frontend_get_current_scene()
        if current == nil then return end

        local current_name = obs.obs_source_get_name(current)

        if current_name == scene_a_name then
            set_scene(scene_b_name)
        else
            set_scene(scene_a_name)
        end

        obs.obs_source_release(current)

    elseif mode == "hold" then
        if pressed then
            set_scene(scene_b_name)
        else
            set_scene(scene_a_name)
        end
    end
end

----------------------------------------------------------
-- UI Properties
----------------------------------------------------------
function script_properties()
    local props = obs.obs_properties_create()

    local scenes = obs.obs_frontend_get_scenes()

    local p1 = obs.obs_properties_add_list(
        props, "scene_a", "Scene A",
        obs.OBS_COMBO_TYPE_LIST,
        obs.OBS_COMBO_FORMAT_STRING)

    local p2 = obs.obs_properties_add_list(
        props, "scene_b", "Scene B",
        obs.OBS_COMBO_TYPE_LIST,
        obs.OBS_COMBO_FORMAT_STRING)

    for _, scene in ipairs(scenes) do
        local name = obs.obs_source_get_name(scene)
        obs.obs_property_list_add_string(p1, name, name)
        obs.obs_property_list_add_string(p2, name, name)
    end

    obs.source_list_release(scenes)

    -- Mode dropdown
    local mode_list = obs.obs_properties_add_list(
        props, "mode", "Mode",
        obs.OBS_COMBO_TYPE_LIST,
        obs.OBS_COMBO_FORMAT_STRING)

    obs.obs_property_list_add_string(mode_list, "Toggle (Press Once)", "toggle")
    obs.obs_property_list_add_string(mode_list, "Hold (While Pressed)", "hold")

    return props
end

----------------------------------------------------------
-- Settings Update
----------------------------------------------------------
function script_update(settings)
    scene_a_name = obs.obs_data_get_string(settings, "scene_a")
    scene_b_name = obs.obs_data_get_string(settings, "scene_b")
    mode = obs.obs_data_get_string(settings, "mode")
end

----------------------------------------------------------
-- Hotkey Registration
----------------------------------------------------------
function script_load(settings)
    hotkey_id = obs.obs_hotkey_register_frontend(
        "scene_swap_hotkey",
        "Scene Swap (Toggle / Hold)",
        handle_hotkey
    )

    local hotkey_data = obs.obs_data_get_array(settings, "scene_swap_hotkey")
    obs.obs_hotkey_load(hotkey_id, hotkey_data)
    obs.obs_data_array_release(hotkey_data)
end

function script_save(settings)
    local hotkey_data = obs.obs_hotkey_save(hotkey_id)
    obs.obs_data_set_array(settings, "scene_swap_hotkey", hotkey_data)
    obs.obs_data_array_release(hotkey_data)
end

----------------------------------------------------------
function script_description()
    return "Swap between two scenes with Toggle or Hold mode."
end
