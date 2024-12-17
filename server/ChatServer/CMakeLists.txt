cmake_minimum_required(VERSION 3.5.0)
project(ChatServer VERSION 0.1.0 LANGUAGES C CXX)

# 设置 C++ 标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 设置 vcpkg 工具链文件（如果已经全局设置了该文件，可以跳过此步骤）
set(CMAKE_TOOLCHAIN_FILE "/home/pck/tools/vcpkg/scripts/buildsystems/vcpkg.cmake" CACHE STRING "vcpkg toolchain file")

# 设置 MySQL 的头文件和库文件路径
set(MYSQL_INCLUDE_DIR "/home/pck/tools/vcpkg/installed/x64-linux/include")
set(MYSQL_LIBRARY_DIR "/home/pck/tools/vcpkg/installed/x64-linux/lib")

# 查找 Boost 库，指定所需的组件
find_package(Boost REQUIRED COMPONENTS filesystem system)

# 查找 nlohmann_json 库
find_package(nlohmann_json REQUIRED)

# 查找 jsoncpp 库
find_package(jsoncpp REQUIRED)

# 查找 hiredis 库
find_package(hiredis CONFIG REQUIRED)

# 查找 gRPC 库
find_package(gRPC REQUIRED)

# 设置 Protobuf 库的路径
set(PROTOBUF_INCLUDE_DIR "/usr/local/include")
set(PROTOBUF_LIB_DIR "/usr/local/lib")

# 设置 protoc 的路径
set(PROTOC_EXECUTABLE "/home/pck/tools/protobuf-3.21.12/bin/protoc")

# 生成的 Protobuf 文件路径
set(PROTO_FILES
    ${CMAKE_SOURCE_DIR}/message.pb.cc
    ${CMAKE_SOURCE_DIR}/message.grpc.pb.cc
)

# 输出调试信息，确保 PROTO_FILES 路径是正确的
message(STATUS "PROTO_FILES: ${PROTO_FILES}")

# 拷贝 config 文件到 build 目录
file(COPY /root/server/ChatServer/config.ini DESTINATION ${CMAKE_BINARY_DIR})

# 创建可执行文件
add_executable(ChatServer1
    AsioIOServicePool.cpp 
    CServer.cpp 
    CSession.cpp 
    ChatGrpcClient.cpp 
    ChatServer.cpp 
    ChatServiceImpl.cpp 
    ConfigMgr.cpp 
    LogicSystem.cpp 
    MsgNode.cpp 
    MysqlDao.cpp 
    MysqlMgr.cpp 
    RedisMgr.cpp 
    StatusGrpcClient.cpp 
    UserMgr.cpp
    ${PROTO_FILES}  # 添加生成的 .pb.cc 和 .grpc.pb.cc 文件
)

# 设置 MySQL 库
include_directories(${MYSQL_INCLUDE_DIR})
link_directories(${MYSQL_LIBRARY_DIR})

# 设置 Protobuf 库的头文件和链接路径
include_directories(${PROTOBUF_INCLUDE_DIR})
link_directories(${PROTOBUF_LIB_DIR})

# 设置 Boost 库的路径
set(BOOST_LIB_DIR "/usr/local/lib")  # 根据您的系统路径，Boost 库通常在这里
set(BOOST_INCLUDE_DIR "/usr/local/include")  # Boost 的头文件路径

# 设置 Boost 的 include 路径
include_directories(${BOOST_INCLUDE_DIR})
link_directories(${BOOST_LIB_DIR})

# 添加 gRPC 库到目标文件
include_directories(${VCPKG_INSTALL_DIR}/include)
link_directories(${VCPKG_INSTALL_DIR}/lib)

# 确保链接 Protobuf 和 gRPC 的库
target_link_libraries(ChatServer1
    Boost::filesystem
    Boost::system
    jsoncpp
    mysqlcppconn 
    nlohmann_json::nlohmann_json
    hiredis
    gRPC::grpc++  # gRPC
    ${PROTOBUF_LIB_DIR}/libprotobuf.so  # 手动链接 Protobuf 动态库
    ${BOOST_LIB_DIR}/libboost_filesystem.so  # 手动链接 Boost Filesystem 库
    ${BOOST_LIB_DIR}/libboost_system.so     # 手动链接 Boost System 库
)

# 启用测试支持
include(CTest)
enable_testing()

# 设置 CPack 配置
set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)










