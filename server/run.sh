#!/bin/bash

# 设置源文件路径和目标目录路径
SOURCE_FILE1="/root/server/GateServer/build/GateServer"
SOURCE_FILE2="/root/server/StatusServer/build/StatusServer"
SOURCE_FILE3="/root/server/ChatServer/build/ChatServer1"
SOURCE_FILE4="/root/server/ChatServer2/build/ChatServer2"
DEST_DIR="/root/server/Run"

# 检查目标目录是否存在，不存在则创建
if [ ! -d "$DEST_DIR" ]; then
    echo "目标目录 $DEST_DIR 不存在，创建目录..."
    mkdir -p "$DEST_DIR"
fi

# 检查文件是否存在，如果存在则删除
if [ -f "$DEST_DIR/GateServer" ]; then
    echo "文件 GateServer 存在，删除中..."
    rm -f "$DEST_DIR/GateServer"
fi

if [ -f "$DEST_DIR/StatusServer" ]; then
    echo "文件 StatusServer 存在，删除中..."
    rm -f "$DEST_DIR/StatusServer"
fi

if [ -f "$DEST_DIR/ChatServer1" ]; then
    echo "文件 ChatServer1 存在，删除中..."
    rm -f "$DEST_DIR/ChatServer1"
fi

if [ -f "$DEST_DIR/ChatServer2" ]; then
    echo "文件 ChatServer2 存在，删除中..."
    rm -f "$DEST_DIR/ChatServer2"
fi

# 拷贝文件
echo "将 $SOURCE_FILE1 拷贝到 $DEST_DIR"
cp -f "$SOURCE_FILE1" "$DEST_DIR"

echo "将 $SOURCE_FILE2 拷贝到 $DEST_DIR"
cp -f "$SOURCE_FILE2" "$DEST_DIR"

echo "将 $SOURCE_FILE3 拷贝到 $DEST_DIR"
cp -f "$SOURCE_FILE3" "$DEST_DIR"

echo "将 $SOURCE_FILE4 拷贝到 $DEST_DIR"
cp -f "$SOURCE_FILE4" "$DEST_DIR"

# 打印拷贝完成的信息
echo "拷贝完成！"

