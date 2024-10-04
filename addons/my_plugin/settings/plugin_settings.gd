@tool
class_name MyPluginSettings extends RefCounted

const PluginPrefixName: String = "my_plugin"
const GitRepositoryName: String = "my-plugin"

static var PluginName: String = "MyPlugin"
static var PluginProjectName: String = ProjectSettings.get_setting("application/config/name")
static var PluginBasePath: String = "res://addons/%s" % PluginPrefixName
static var PluginLocalConfigFilePath = "%s/plugin.cfg" % PluginBasePath
static var PluginSettingsBasePath: String = "%s/config/%s" % [PluginProjectName, PluginPrefixName]
static var RemoteReleasesUrl = "https://api.github.com/repos/indie-pipeline/%s/releases" % GitRepositoryName
static var PluginTemporaryDirectoryPath = OS.get_user_data_dir() + "/" + PluginPrefixName
static var PluginTemporaryReleaseUpdateDirectoryPath = "%s/update" % PluginTemporaryDirectoryPath
static var PluginTemporaryReleaseFilePath = "%s/%s.zip" % [PluginTemporaryDirectoryPath, PluginPrefixName]
static var PluginDebugDirectoryPath = "res://debug"

#region Plugin Settings
static var UpdateNotificationSetting: String = PluginSettingsBasePath + "/update_notification_enabled"
#endregion

static var DebugMode: bool = true

static func set_update_notification(enable: bool = true) -> void:
	ProjectSettings.set_setting(UpdateNotificationSetting, enable)
	ProjectSettings.add_property_info({
		"name": UpdateNotificationSetting,
		"type": typeof(enable),
	 	"value": enable,
		"hint": PROPERTY_HINT_TYPE_STRING,
		"hint_string": "Turn notifications on or off to receive alerts when new versions of the plugin are released"
	})
	ProjectSettings.save()


static func is_update_notification_enabled() -> bool:
	return ProjectSettings.get_setting(UpdateNotificationSetting, true)


static func remove_settings() -> void:
	remove_setting(UpdateNotificationSetting)


static func remove_setting(name: String) -> void:
	if ProjectSettings.has_setting(name):
		ProjectSettings.set_setting(name, null)
		ProjectSettings.save()
		
