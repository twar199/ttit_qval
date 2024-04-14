#!/bin/bash

# Создание dummy0 интерфейса с адресом 2.2.2.2/32
ip link add dummy0 type dummy
ip addr add 2.2.2.2/32 dev dummy0
ip link set dummy0 up