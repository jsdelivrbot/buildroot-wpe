WPEFRAMEWORK_COMPOSITOR_VERSION = 81f855956d4c78e37304e4eec12c80e22ef25f9a
WPEFRAMEWORK_COMPOSITOR_SITE_METHOD = git
WPEFRAMEWORK_COMPOSITOR_SITE = git@github.com:Metrological/webbridge.git
WPEFRAMEWORK_COMPOSITOR_INSTALL_STAGING = YES
WPEFRAMEWORK_COMPOSITOR_DEPENDENCIES = wpeframework

WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_COMPOSITOR_VERSION}

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
#WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DCMAKE_CXX_FLAGS='-g -Og'
endif

ifeq ($(BR2_PACKAGE_WESTEROS),y)
WPEFRAMEWORK_COMPOSITOR_DEPENDENCIES += westeros
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_IMPLEMENTATION=Wayland
else ifeq  ($(BR2_PACKAGE_BCM_REFSW),y)
WPEFRAMEWORK_COMPOSITOR_DEPENDENCIES += bcm-refsw
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_IMPLEMENTATION=Nexus
else
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_IMPLEMENTATION=Stub
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_OUTOFPROCESS),y)
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_OUTOFPROCESS=true
else
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_OUTOFPROCESS=false
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_SERVICE_EXTERNAL),y)
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_SERVICE=external
else
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_SERVICE=internal
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_VIRTUALINPUT),y)
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_VIRTUALINPUT=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_DEBUG),y)
WPEFRAMEWORK_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_AUTOTRACE),y)
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_AUTOTRACE=ON
endif

ifeq ($(BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_IRNEXUS),y)
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_IRNEXUS_MODE=${BR2_PACKAGE_WPEFRAMEWORK_REMOTECONTROL_IRNEXUS_MODE}
endif

WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_HARDWAREREADY=${BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_HARDWAREREADY}
WPEFRAMEWORK_COMPOSITOR_CONF_OPTS += -DWPEFRAMEWORK_PLUGIN_COMPOSITOR_SYSTEM=${BR2_PACKAGE_WPEFRAMEWORK_COMPOSITOR_SYSTEM}

define WPEFRAMEWORK_COMPOSITOR_POST_TARGET_REMOVE_HEADERS
    rm -rf $(TARGET_DIR)/usr/include/WPEFramework
endef

ifneq ($(BR2_PACKAGE_WPEFRAMEWORK_INSTALL_HEADERS),y)
WPEFRAMEWORK_COMPOSITOR_POST_INSTALL_TARGET_HOOKS += WPEFRAMEWORK_COMPOSITOR_POST_TARGET_REMOVE_HEADERS
endif

$(eval $(cmake-package))