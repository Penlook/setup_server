cd /tmp
rm -rf llvm
mkdir llvm
wget http://llvm.org/releases/3.3/cfe-3.3.src.tar.gz
wget http://llvm.org/releases/3.3/llvm-3.3.src.tar.gz
tar xfvz llvm-3.3.src.tar.gz
tar xfvz cfe-3.3.src.tar.gz && mv cfe-3.3.src llvm-3.3.src/tools/clang
cd llvm-3.3.src
./configure --enable-shared --enable-optimized --enable-targets=host-only
make && sudo make install
cd /tmp