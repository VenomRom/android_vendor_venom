ifeq ($(BOARD_USES_QCOM_HARDWARE),true) include 
vendor/venom/config/BoardConfigQcom.mk
endif

include vendor/venom/config/BoardConfigSoong.mk
