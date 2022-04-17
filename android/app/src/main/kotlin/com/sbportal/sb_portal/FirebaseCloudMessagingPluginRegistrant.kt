package com.sbportal.sb_portal

import io.flutter.plugin.common.PluginRegistry

object FirebaseCloudMessagingPluginRegistrant {
    fun registerWith(registry: PluginRegistry) {
        if (alreadyRegisteredWith(registry)) {
            return
        }
    }

    private fun alreadyRegisteredWith(registry: PluginRegistry): Boolean {
        val key = FirebaseCloudMessagingPluginRegistrant::class.java.canonicalName
        if (registry.hasPlugin(key)) {
            return true
        }
        registry.registrarFor(key)
        return false
    }
}