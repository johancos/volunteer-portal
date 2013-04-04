package au.org.ala.volunteer

import java.lang.reflect.Modifier


class SettingController {

    def settingsService
    def emailService

    def index() {

        def settings = []
        def values = [:]
        def fields = SettingDefinition.class.declaredFields
        fields.each {
            if (Modifier.isStatic(it.modifiers)) {
                if (it.getType().isAssignableFrom(SettingDefinition)) {
                    def settingDef = it.get(null) as SettingDefinition
                    if (settingDef) {
                        settings << settingDef
                        def value = settingsService.getSetting(settingDef)
                        values[settingDef] = value
                    }
                }
            }
        }

        [settings: settings, values: values]

    }

    def editSetting() {
        def key = params.settingKey

        if (!key) {
            redirect(action:'index')
            return
        }

        SettingDefinition settingDefinition = getSettingDefByKey(key)
        def currentValue = settingDefinition ? settingsService.getSetting(settingDefinition) : null

        [settingDefinition: settingDefinition, currentValue: currentValue]
    }

    def saveSetting() {
        def key = params.settingKey as String
        def value = params.settingValue as String

        SettingDefinition settingDefinition = getSettingDefByKey(key)
        if (settingDefinition && value) {
            settingsService.setSetting(key, value)
            flash.message= "Setting '${key}' set to '${value}'"
        } else {
            flash.message= "Save setting failed! Either the setting key or value was missing/null"
        }

        redirect(action:'index')

    }

    private static SettingDefinition getSettingDefByKey(String key) {
        def fields = SettingDefinition.class.declaredFields

        for (def field : fields) {
            if (Modifier.isStatic(field.modifiers)) {
                if (field.getType().isAssignableFrom(SettingDefinition)) {
                    def settingDef = field.get(null) as SettingDefinition
                    if (settingDef) {
                        if (settingDef.key == key) {
                            return settingDef
                        }
                    }
                }
            }
        }
        return null
    }

    def sendTestEmail() {
        def to = params.to

        if (to) {
            emailService.sendMail(to,"Test message from the BVP", "This is a test message form the ALA Biodiversity Volunteer Portal.")
            flash.message = "Sent a test message to '${to}'"
        }
        redirect(action:'index')
    }
}