#!/bin/bash

# 启动 VarityServer
echo "启动 VarityServer..."
cd /root/server/VarifyServer
npm run serve &
VARIFY_SERVER_PID=$!
echo "VarifyServer 启动成功，PID: $VARIFY_SERVER_PID"

# 等待 10 秒
echo "等待 10 秒..."
sleep 10

#切换到其他目录运行其他的服务
cd /root/server/Run

# 启动 GateServer
echo "启动 GateServer..."
./GateServer &
GATE_SERVER_PID=$!
echo "GateServer 启动成功，PID: $GATE_SERVER_PID"

# 等待 12 秒
echo "等待 12 秒..."
sleep 12

# 启动 StatusServer
echo "启动 StatusServer..."
./StatusServer &
STATUS_SERVER_PID=$!
echo "StatusServer 启动成功，PID: $STATUS_SERVER_PID"

# 等待 10 秒
echo "等待 10 秒..."
sleep 10

# 启动 ChatServer1
echo "启动 ChatServer1..."
./ChatServer1 &
CHAT_SERVER1_PID=$!
echo "ChatServer1 启动成功，PID: $CHAT_SERVER1_PID"

# 等待 10 秒
echo "等待 10 秒..."
sleep 10

# 启动 ChatServer2
echo "启动 ChatServer2..."
./ChatServer2 &
CHAT_SERVER2_PID=$!
echo "ChatServer2 启动成功，PID: $CHAT_SERVER2_PID"

# 打印所有启动的进程 PID
echo "所有服务已启动："
echo "GateServer PID: $GATE_SERVER_PID"
echo "StatusServer PID: $STATUS_SERVER_PID"
echo "ChatServer1 PID: $CHAT_SERVER1_PID"
echo "ChatServer2 PID: $CHAT_SERVER2_PID"
echo "VarifyServer PID: $VARIFY_SERVER_PID"

