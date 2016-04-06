# Building Caffe

DIGITS requires [NVIDIA's fork of Caffe](https://github.com/NVIDIA/caffe), which is sometimes referred to as either "NVcaffe" or "caffe-nv".

If you don't need a new version or custom build of NVcaffe, you can still use Deb packages to install the latest release.
Follow [these instructions](UbuntuInstall.md#repository-access) to gain access to the required repositories, and then use this command to install:
```sh
% sudo apt-get install caffe-nv python-caffe-nv
```

Otherwise, follow these instructions to build from source.

## Download source
```sh
% cd $HOME
% git clone --branch caffe-0.14 https://github.com/NVIDIA/caffe.git
```

The minimum required version is v0.11, but v0.14 is recommended.
See [the NVcaffe release notes](https://github.com/NVIDIA/caffe/releases) for some information about the different versions.

Set an environment variable so DIGITS knows where Caffe is installed (optional):
```sh
% export CAFFE_HOME=${HOME}/caffe
```

## Install dependencies

If you are not on Ubuntu 14.04, you can try [Caffe's installation instructions](http://caffe.berkeleyvision.org/installation.html).
If you are, simply install these aptitude packages:

```sh
% sudo apt-get install \
    libgflags-dev libgoogle-glog-dev libopencv-dev \
    libleveldb-dev libsnappy-dev liblmdb-dev libhdf5-serial-dev \
    libprotobuf-dev protobuf-compiler libatlas-base-dev \
    python-dev python-pip python-numpy gfortran
% sudo apt-get install --no-install-recommends libboost-all-dev
```

### CUDA toolkit

To install the CUDA toolkit with Deb packages, first get access to the required repositories by following [these instructions](UbuntuInstall.md#repository-access).
Then, install your toolkit (any version >= 6.5 is fine):
```sh
# If you already have a driver installed
% sudo apt-get install cuda-toolkit-7-5

# If you need a driver
% sudo apt-get install cuda-7-5
```
For more information, see [InstallCuda.md](InstallCuda.md).

### cuDNN

You can also install cuDNN 4 with a Deb package:
```sh
% sudo apt-get install libcudnn4-dev
```
Older versions of cuDNN can be found on the [cuDNN website](https://developer.nvidia.com/cudnn).
The NVcaffe [release notes](https://github.com/NVIDIA/caffe/releases) contain information about which version of cuDNN is required for different versions of NVcaffe.

### Python dependencies

These packages need to be installed:

```sh
% cd $CAFFE_HOME
% cat python/requirements.txt
```

You may be tempted to install the requirements with `pip install -r python/requirements.txt`.
Use this instead to install the packages in order and avoid errors ([see discussion here](https://github.com/BVLC/caffe/pull/1950#issuecomment-76026969)):
```sh
% cat python/requirements.txt | xargs -n1 sudo pip install
```

## Build Caffe

```sh
% cd $CAFFE_HOME
% mkdir build
% cd build
% cmake ..
% make --jobs=4
```
