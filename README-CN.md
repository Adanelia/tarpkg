# tarpkg

> [en](README.md) | 中文

- [功能](#功能)
- [安装](#安装)
- [使用方法](#使用方法)
- [重要注意事项](#重要注意事项)
- [许可证](#许可证)

------

tarpkg 是一个用于安装和卸载 tar 格式软件包的包管理器。

## 功能

- 从 tar 归档安装软件包
- 卸载已安装的包
- 支持各种tar压缩格式，包括 gz, xz, bz, zst 等
- 安装/卸载前验证文件是否存在
- 强制模式，用于绕过文件检查（请谨慎使用）

## 安装

```sh
git clone https://github.com/Adanelia/tarpkg.git && cd tarpkg
chmod +x tarpkg.sh
```
可以直接运行 `./tarpkg.sh` 。

或者安装到 `PATH` 。
```sh
# 用户PATH
cp tarpkg.sh ~/.local/bin/tarpkg
# 或系统PATH
sudo cp tarpkg.sh /usr/local/bin/tarpkg
```
这样可以在任何地方执行 `tarpkg` 。

## 使用方法

### 安装一个包：

```sh
tarpkg -i example.tar.gz
```

### 卸载一个包：

```sh
tarpkg -r example.tar.gz
```

### 列出包内容：

```sh
tarpkg -l example.tar.gz
```

### 测试包：

```sh
tarpkg -t example.tar.gz
```

### 强制操作：

```sh
tarpkg -f -i example.tar.gz
tarpkg -f -r example.tar.gz
```

## 重要注意事项

- 必要时使用 `sudo`
- tar 包必须包含与系统目录结构匹配的文件路径（例如：`usr/local/bin/example`）
- 文件被直接安装到系统根目录（`/`）
- 包管理器会在安装前检查现有文件
- 仅在确定要覆盖现有文件时才使用强制选项

## 许可证

GPLv3
