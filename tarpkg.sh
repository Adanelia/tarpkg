#!/bin/bash

VERSION=0.1.0
GITHUB_REPO="<https://github.com/Adanelia/tarpkg>"
COPYRIGHT="Copyright (C) 2026 Adanelia"
LICENSE="License GPLv3"
# Options
FORCE=0

func_version() {
	if [ $LANG == "zh_CN.utf8" ]
	then
		func_version_zh
	else
		func_version_en
	fi
}

func_version_en() {
	echo "tarpkg $VERSION"
	echo $GITHUB_REPO
	echo $COPYRIGHT
	echo $LICENSE
}

func_version_zh() {
	echo "tarpkg $VERSION"
	echo $GITHUB_REPO
	echo $COPYRIGHT
	echo $LICENSE
}

func_help() {
	if [ $LANG == "zh_CN.utf8" ]
	then
		func_help_zh
	else
		func_help_en
	fi
}

func_help_en() {
    echo "Usage: $0 [OPTION...] [FILE]"
	echo "Install/Uninstall tar archive packages."
	echo
	echo "  -i,--install FILE  install a tar archive"
	echo "  -r,--remove FILE   uninstall a tar archive"
	echo "  -l,--list FILE     list contents"
	echo "  -t,--test FILE     check file existence"
	echo "  -f,--force         install/remove despite file checks failed (use with caution!)"
	echo
	echo "  -h,--help          display this help and exit"
	echo "  --version          output version information and exit"
	echo
	echo "Examples:"
	echo "  $0 -i archive.tar.gz  # Install archive.tar.gz"
	echo "  $0 -r archive.tar.gz  # Remove archive.tar.gz"
	exit 0
}

func_help_zh() {
	echo "用法：$0 [选项...] [文件]"
	echo "安装/卸载tar归档包"
	echo
	echo "  -i,--install FILE  安装一个tar归档包"
	echo "  -r,--remove FILE   卸载一个tar归档包"
	echo "  -l,--list FILE     列出内容"
	echo "  -t,--test FILE     检查文件是否存在"
	echo "  -f,--force         文件检查失败仍安装/卸载（请谨慎使用!）"
	echo
	echo "  -h,--help          显示此帮助信息并退出"
	echo "  --version          显示版本信息并退出"
	echo
	echo "Examples:"
	echo "  $0 -i archive.tar.gz  # 安装 archive.tar.gz"
	echo "  $0 -r archive.tar.gz  # 卸载 archive.tar.gz"
	exit 0
}

func_error() {
	if [ $LANG == "zh_CN.utf8" ]
	then
		func_error_zh
	else
		func_error_en
	fi
}

func_error_en() {
	echo "ERROR: Unknown Option" $*
	echo "Type '$0 --help' for more information."
	exit 2
}

func_error_zh() {
	echo "错误：未知选项" $*
	echo "输入'$0 --help'获取更多信息。"
	exit 2
}

# List
func_list() {
	local LIST=$(tar -tf $1)
	if [ $? -ne 0 ]
	then
		exit 0
	fi
	echo $LIST
}

# Test
func_test() {
	func_test_install $1
	func_test_remove $1
}

# Test install
func_test_install() {
	echo "Checking whether files exist..."
	local LIST=$(func_list $1)
	local FOUND=0
	for FILE in $LIST
	do
		if [ ! -d /$FILE ] && [ -e /$FILE ]
		then
			echo "/$FILE exists!"
			FOUND=1
		fi
	done
	return $FOUND
}

# Test remove
func_test_remove() {
	echo "Checking whether files removed..."
	local LIST=$(func_list $1)
	local NOT_FOUND=0
	for FILE in $LIST
	do
		if [ ! -d /$FILE ] && [ ! -e /$FILE ]
		then
			echo "/$FILE not found!"
			NOT_FOUND=1
		fi
	done
	return $NOT_FOUND
}

# Install
func_install() {
	func_test_install $1
	if [ $? -eq 1 ] && [ $FORCE -eq 0 ]
	then
		echo "Abort!"
		return 1
	fi
	echo "Installing..."
	# Unpack
	tar --no-same-owner -xaf $1 -C /
	if [ $? -eq 0 ]
	then
		echo "Complete!"
		return 0
	fi
}

# Uninstall
func_remove() {
	func_test_remove $1
	if [ $? -eq 1 ] && [ $FORCE -eq 0 ]
	then
		echo "Abort!"
		return 1
	fi
	echo "Removing..."
	# Remove
	local LIST=$(func_list $1)
	for FILE in $LIST
	do
		if [ ! -d /$FILE ] && [ -e /$FILE ]
		then
			# echo "rm /$FILE"
			rm /$FILE
		fi
	done
	if [ $? -eq 0 ]
	then
		echo "Complete!"
		return 0
	fi
}

# Print help if no args
if [ $# -eq 0 ]
then
	func_help
fi

# Parse args
while [ $# -gt 0 ]
do
	# echo $*

	case $1 in
		--version)
			func_version
			;;
		-h|--help)
			func_help
			;;
		-t|--test)
			func_test $2
			shift
			;;
		-l|--list)
			func_list $2
			shift
			;;
		-i|--install)
			func_install $2
			shift
			;;
		-r|--remove)
			func_remove $2
			shift
			;;
		-f|--force)
			echo "Enable force mode!"
			FORCE=1
			;;
		*)
			func_error $*
			;;
	esac

	shift
done
