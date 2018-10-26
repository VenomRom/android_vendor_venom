# Copyright (C) 2018 Project dotOS
# Copyright (C) 2018 VenomRom Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#VenomRom Versioning _

VENOM_MOD_VERSION = Alpha


ifndef VENOM_BUILD_TYPE
    VENOM_BUILD_TYPE := UNOFFICIAL
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(VENOM_OFFICIAL), true)
   LIST = $(shell curl -s https://raw.githubusercontent.com/VenomRom/android_vendor_venom/pie/venom.devices)
   FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
      VENOM_BUILD_TYPE := OFFICIAL
      
    endif
    ifneq ($(IS_OFFICIAL), true)
       VENOM_BUILD_TYPE := UNOFFICIAL
       $(error Device is not official "$(FOUND)")
    endif

PRODUCT_GENERIC_PROPERTIES += \
    persist.ota.romname=$(TARGET_PRODUCT) \
    persist.ota.version=$(shell date +%Y%m%d) \

persist.ota.manifest=https://raw.githubusercontent.com/VenomRom/ota/pie/$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3).xml
endif

TARGET_PRODUCT_SHORT := $(subst venom_,,$(CUSTOM_BUILD))

VENOM_VERSION := VenomRom-$(VENOM_MOD_VERSION)-$(CURRENT_DEVICE)-$(VENOM_BUILD_TYPE)-$(shell date -u +%Y%m%d)

VENOM_FINGERPRINT := VenomRom/$(VENOM_MOD_VERSION)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%Y%m%d)

PRODUCT_GENERIC_PROPERTIES += \
  ro.venom.version=$(VENOM_VERSION) \
  ro.venom.releasetype=$(VENOM_BUILD_TYPE) \
  ro.modversion=$(VENOM_MOD_VERSION)

VENOM_DISPLAY_VERSION := VenomRom-$(VENOM_MOD_VERSION)-$(VENOM_BUILD_TYPE)

PRODUCT_GENERIC_PROPERTIES += \
  ro.venom.display.version=$(VENOM_DISPLAY_VERSION)\
  ro.venom.fingerprint=$(EXTENDED_FINGERPRINT)
