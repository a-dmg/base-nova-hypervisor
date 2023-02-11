
override CC_OLEVEL := -Os
CC_OPT += -std=gnu++17 -fdata-sections -ffreestanding -ffunction-sections \
          -fomit-frame-pointer -fno-asynchronous-unwind-tables \
          -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-pic \
          -fdiagnostics-color=auto -fno-stack-protector -freg-struct-return \
          -freorder-blocks -fvisibility-inlines-hidden -fno-pie

# kernel memory: 28M minimum dynamic or 10 pro mill of the system memory
#CC_OPT += -DCONFIG_MEMORY_DYN_MIN=0x1c00000 \
#          -DCONFIG_MEMORY_DYN_PER_MILL=10


# TODO: Enable this
#FLAGS	+= $(call check,-fcf-protection=$(CFP))

CC_WARN	+= -Wall -Wextra -Wcast-align -Wcast-qual -Wconversion \
           -Wdisabled-optimization -Wformat=2 -Wmissing-format-attribute \
           -Wmissing-noreturn -Wpacked -Wpointer-arith -Wredundant-decls \
           -Wshadow -Wwrite-strings -Wctor-dtor-privacy -Wno-non-virtual-dtor \
           -Wold-style-cast -Woverloaded-virtual -Wsign-promo -Wlogical-op \
           -Wstrict-null-sentinel -Wstrict-overflow=5 -Wsuggest-override \
           -Wvolatile-register-var -Wzero-as-null-pointer-constant

#CC_CXX_WARN_STRICT = -Wextra -Werror
CC_CXX_WARN_STRICT = 

INC_DIR += $(NOVA_SRC_DIR)/inc
SRC_CC  += $(sort $(notdir $(wildcard $(NOVA_SRC_DIR)/src/*.cpp)))

vpath %.cpp $(NOVA_SRC_DIR)/src
