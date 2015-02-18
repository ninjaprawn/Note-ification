TARGET = iphone:clang::7.0

ARCHS = armv7 armv7s arm64

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Noteification
Noteification_FILES = Noteification.mm
Noteification_INSTALL_PATH = /Library/PreferenceBundles
Noteification_FRAMEWORKS = UIKit
Noteification_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Noteification.plist$(ECHO_END)
