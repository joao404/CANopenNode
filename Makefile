# Makefile for CANopenNode, basic compile with no CAN device.


#DRV_SRC = example
DRV_SRC =  stack/neuberger-socketCAN
STACK_SRC = stack
CANOPEN_SRC =.
APPL_SRC = app


LINK_TARGET = CO_BBB


INCLUDE_DIRS = \
	-I$(DRV_SRC) \
	-I$(STACK_SRC) \
	-I$(CANOPEN_SRC) \
	-I$(APPL_SRC)


SOURCES = \
	$(STACK_SRC)/crc16-ccitt.c \
	$(STACK_SRC)/CO_SDO.c \
	$(STACK_SRC)/CO_Emergency.c \
	$(STACK_SRC)/CO_NMT_Heartbeat.c \
	$(STACK_SRC)/CO_SYNC.c \
	$(STACK_SRC)/CO_TIME.c \
	$(STACK_SRC)/CO_PDO.c \
	$(STACK_SRC)/CO_HBconsumer.c \
	$(STACK_SRC)/CO_SDOmaster.c \
	$(STACK_SRC)/CO_LSSmaster.c \
	$(STACK_SRC)/CO_LSSslave.c \
	$(STACK_SRC)/CO_trace.c \
	$(DRV_SRC)/CO_notify_pipe.c \
	$(DRV_SRC)/CO_driver.c \
	$(APPL_SRC)/CO_OD.c \
	$(CANOPEN_SRC)/CANopen.c \
	$(APPL_SRC)/main.cpp
	#$(DRV_SRC)/eeprom.c \



DEPS := $(OBJS:.o=.d)

-include $(DEPS)

COBJS := $(SOURCES:%.c=%.o)
OBJS := $(COBJS:%.cpp=%.o)
#OBJS = $(SOURCES:%.c=%.o)
#CC = g++
CC = /home/user/BBB/compiler/gcc_arm/bin/arm-linux-gnueabihf-g++
CFLAGS = -Wall -g $(INCLUDE_DIRS)
LDFLAGS = -Wall -g 


.PHONY: all clean doc

all: clean $(LINK_TARGET)

clean:
	rm -f $(OBJS) $(LINK_TARGET) $(DEPS)

doc:
	doxygen

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

$(LINK_TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $^ -o $@
